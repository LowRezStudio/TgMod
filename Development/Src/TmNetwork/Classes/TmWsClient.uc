// High-level RFC 6455 WebSocket client.
//
// States: Disconnected -> Connecting (TCP) -> Handshaking (HTTP upgrade) ->
// Open -> Closing -> Closed. Sends before Open and operations in the wrong
// state are rejected with OnError, never crash.
//
// Reassembly: control frames may interleave between fragments of a
// fragmented data message; continuation opcodes append to the pending
// message which is delivered when its FIN arrives.
class TmWsClient extends Object;

enum EWsState {
    WSS_Disconnected,
    WSS_Connecting,
    WSS_Handshaking,
    WSS_Open,
    WSS_Closing,
    WSS_Closed
};

// Opcodes (mirrored from TmWsFrame; consts aren't addressable cross-class)
const OP_CONTINUATION = 0;
const OP_TEXT = 1;
const OP_BINARY = 2;
const OP_CLOSE = 8;
const OP_PING = 9;
const OP_PONG = 10;

// Frame parser outcomes (mirrored from TmWsFrameParser)
const FRM_NEED_MORE = 0;
const FRM_FRAME = 1;
const FRM_ERROR = 2;

const MAX_MESSAGE_BYTES = 4194304; // reassembled message cap

const WS_CLOSE_NORMAL = 1000;
const WS_CLOSE_GOING_AWAY = 1001;
const WS_CLOSE_PROTOCOL_ERROR = 1002;
const WS_CLOSE_UNSUPPORTED = 1003;
const WS_CLOSE_INVALID_PAYLOAD = 1007;
const WS_CLOSE_POLICY = 1008;
const WS_CLOSE_TOO_BIG = 1009;
const WS_CLOSE_INTERNAL = 1011;

var EWsState WsState;
var TmTcpConnection Conn;
var TmWsFrameParser Parser;
var Actor SpawnAnchor;     // actor the TcpLink spawns on (set by Setup)

// Handshake
var string Url;
var string Host;
var int Port;
var string Path;
var string WsKey;
var string ExpectedAccept;
var TmByteBuffer RecvBuf;   // handshake bytes until upgrade completes

// Fragmentation reassembly
var bool bInFragmented;
var int FragOpcode;         // original data opcode (TEXT/BINARY)
var TmByteBuffer FragBuf;

var int CloseCode;          // code sent/received for the current close
var string CloseReason;
var bool bCloseSent;
var bool bRemoteClosed;
var int MaxMessageBytes;

delegate OnConnected();
delegate OnMessage(string Text, TmByteBuffer Binary, bool bIsText);
delegate OnError(string Reason);
delegate OnClosed(bool bWasClean, int Code, string Reason);

function Setup(Actor SpawnOwner) {
    SpawnAnchor = SpawnOwner;
    if (Parser == none) {
        Parser = new class'TmWsFrameParser';
    }
    Parser.Reset();
    if (RecvBuf == none) {
        RecvBuf = new class'TmByteBuffer';
    }
    RecvBuf.Reset();
    if (FragBuf == none) {
        FragBuf = new class'TmByteBuffer';
    }
    FragBuf.Reset();
    MaxMessageBytes = MAX_MESSAGE_BYTES;
    WsState = WSS_Disconnected;
}

// ws://host[:port]/path. Async: OnConnected/OnError fire later.
function bool Connect(string InUrl, optional TmHttpHeaders ExtraHeaders) {
    local TmUrl U;

    if (WsState != WSS_Disconnected && WsState != WSS_Closed) {
        FireError("Connect: socket is not closed (state " $ string(WsState) $ ")");
        return false;
    }
    if (SpawnAnchor == none) {
        FireError("Connect: not set up — call Setup(Actor) first");
        return false;
    }
    U = class'TmUrl'.static.FromString(InUrl);
    if (U == none || U.Scheme != "ws") {
        FireError("Connect: only ws:// URLs are supported ('" $ InUrl $ "')");
        return false;
    }

    Url = InUrl;
    Host = U.Host;
    Port = U.Port;
    Path = U.Path;

    WsState = WSS_Connecting;
    Conn = SpawnAnchor.Spawn(class'TmTcpConnection');
    if (Conn == none) {
        WsState = WSS_Disconnected;
        FireError("Connect: failed to spawn TCP connection actor");
        return false;
    }
    Conn.Setup();
    Conn.OnConnected = OnTransportConnected;
    Conn.OnReceive = OnTransportReceive;
    Conn.OnClosed = OnTransportClosed;
    Conn.OnError = OnTransportError;

    if (!Conn.Connect(Host, Port)) {
        // OnError already routed; make the state terminal regardless.
        if (WsState != WSS_Closed) {
            EnterClosed(false, "Connect failed");
        }
        return false;
    }
    return true;
}

// --- Handshake ---

function OnTransportConnected() {
    local string Req;

    if (WsState != WSS_Connecting) {
        return;
    }
    WsState = WSS_Handshaking;

    WsKey = class'TmWsHandshake'.static.MakeKey(ExpectedAccept);
    Req = class'TmWsHandshake'.static.BuildRequest(Conn.HostHeader, Path, WsKey, none);
    if (!SendRawText(Req)) {
        FailConnection("Handshake send failed");
    }
}

// Transport hands us its whole buffer; move it into ours (emptying the
// connection's) and process according to phase.
function OnTransportReceive(TmByteBuffer Bytes) {
    if (!RecvBuf.AppendBuffer(Bytes)) {
        FailConnection("Handshake/frame buffer overflow");
        return;
    }
    if (WsState == WSS_Handshaking) {
        TryFinishHandshake();
    } else if (WsState == WSS_Open || WsState == WSS_Closing) {
        ProcessFrames();
    }
}

function TryFinishHandshake() {
    local int HeadEnd;
    local TmHttpResponse Head;
    local string Problem;

    HeadEnd = FindDoubleCrlf();
    if (HeadEnd == -1) {
        if (RecvBuf.Length > 32768) {
            FailConnection("Handshake response too large");
        }
        return;
    }

    Head = new class'TmHttpResponse';
    Head.Reset();
    if (!ParseHead(Head, HeadEnd)) {
        return; // ParseHead reported the failure
    }
    Problem = class'TmWsHandshake'.static.ValidateResponse(Head, ExpectedAccept);
    if (Len(Problem) > 0) {
        FailConnection(Problem);
        return;
    }

    // HeadEnd is the CR of the blank line; eat it plus its LF. Any bytes
    // after that are the first frames and stay in RecvBuf.
    RecvBuf.Consume(HeadEnd + 2);
    WsState = WSS_Open;
    OnConnected();
    ProcessFrames();
}

// Parses "HTTP/1.1 101 ...\r\nHeader: v\r\n...\r\n\r\n" from RecvBuf[0..HeadEnd).
function bool ParseHead(TmHttpResponse Head, int HeadEnd) {
    local int Pos, Eol, Colon;
    local string Line;

    Pos = 0;
    Eol = FindCrlfAt(Pos);
    if (Eol == -1) {
        FailConnection("Malformed handshake: no status line");
        return false;
    }
    Line = RecvBuf.ToStringAt(0, Eol);
    if (Left(Line, 5) != "HTTP/") {
        FailConnection("Malformed handshake status line: '" $ Line $ "'");
        return false;
    }
    Head.StatusCode = int(Mid(Line, 9, 3));
    Pos = Eol + 2;

    while (Pos < HeadEnd) {
        Eol = FindCrlfAt(Pos);
        if (Eol == -1) {
            break;
        }
        if (Eol == Pos) {
            break; // blank line
        }
        Line = RecvBuf.ToStringAt(Pos, Eol - Pos);
        Colon = InStr(Line, ":");
        if (Colon > 0) {
            Head.Headers.Add(TrimStr(Left(Line, Colon)), TrimStr(Mid(Line, Colon + 1)));
        }
        Pos = Eol + 2;
    }
    return true;
}

// --- Frame pump ---

function ProcessFrames() {
    local int Offset;
    local int Res;

    Offset = 0;
    while (true) {
        Res = Parser.Advance(RecvBuf, Offset);
        if (Res == FRM_NEED_MORE) {
            break;
        }
        if (Res == FRM_ERROR) {
            FailConnection("Frame error: " $ Parser.ErrorMessage);
            return;
        }

        HandleFrame();
        if (WsState != WSS_Open && WsState != WSS_Closing) {
            return; // closed while handling
        }
        Offset += Parser.TotalLen;
    }
    RecvBuf.Consume(Offset);
}

// Handles one complete unmasked frame whose payload sits at
// Parser.PayloadOffset (already absolute in RecvBuf).
function HandleFrame() {
    local int Op;

    Op = Parser.Opcode;

    // Control frames (opcode >= 8): FIN must be set, length <= 125.
    if (Op >= OP_CLOSE) {
        if (!Parser.bFin) {
            FailConnection("Fragmented control frame");
            return;
        }
        if (Parser.PayloadLen > 125) {
            FailConnection("Control frame payload exceeds 125 bytes");
            return;
        }
        HandleControl(Op, Parser.PayloadOffset);
        return;
    }

    // Data frames
    if (Op == OP_TEXT || Op == OP_BINARY) {
        if (bInFragmented) {
            FailConnection("New data frame inside a fragmented message");
            return;
        }
        if (Parser.bFin) {
            Deliver(Op, Parser.PayloadOffset, Parser.PayloadLen);
        } else {
            StartFragment(Op);
        }
    } else if (Op == OP_CONTINUATION) {
        if (!bInFragmented) {
            FailConnection("Continuation frame with no message in progress");
            return;
        }
        if (FragBuf.Length + Parser.PayloadLen > MaxMessageBytes) {
            FailConnection("Message exceeds " $ string(MaxMessageBytes) $ " bytes");
            return;
        }
        FragBuf.AppendRange(RecvBuf, Parser.PayloadOffset, Parser.PayloadLen);
        if (Parser.bFin) {
            Deliver(FragOpcode, -1, FragBuf.Length);
            bInFragmented = false;
            FragBuf.Reset();
        }
    } else {
        FailConnection("Unsupported data opcode " $ string(Op));
    }
}

function HandleControl(int Op, int Offset) {
    local int Code;
    local TmByteBuffer Payload;

    if (Op == OP_PING) {
        // Pong with the ping's payload.
        Payload = SlicePayload(Offset);
        SendFrame(OP_PONG, Payload);
        return;
    }
    if (Op == OP_PONG) {
        return; // liveness bookkeeping only
    }
    if (Op == OP_CLOSE) {
        bRemoteClosed = true;
        if (Parser.PayloadLen >= 2) {
            Code = (int(RecvBuf.Get(Offset)) << 8) | int(RecvBuf.Get(Offset + 1));
            CloseReason = RecvBuf.ToStringAt(Offset + 2, Parser.PayloadLen - 2);
        } else {
            Code = WS_CLOSE_NORMAL;
            CloseReason = "";
        }
        CloseCode = Code;
        if (!bCloseSent) {
            // Echo the close; the socket is done either way.
            SendCloseFrame(Code, CloseReason);
        }
        if (Conn != none) {
            Conn.SetDeadline(0.0);
            Conn.Disconnect(); // fires OnTransportClosed, which no-ops on Closed state
            Conn = none; // drop the pending-destroy ref; the Closed event still routes via the delegate
        }
        EnterClosed(true, "Close received");
    }
}

// --- Fragment reassembly ---

function StartFragment(int Op) {
    FragBuf.Reset();
    bInFragmented = true;
    FragOpcode = Op;
    FragBuf.AppendRange(RecvBuf, Parser.PayloadOffset, Parser.PayloadLen);
}

// Delivers a data message. For fragmented messages Src is FragBuf (Offset
// -1); for single frames it's RecvBuf at Offset.
function Deliver(int Op, int Offset, int Count) {
    local TmByteBuffer Src;
    local int Start;

    if (Offset >= 0) {
        Src = RecvBuf;
        Start = Offset;
    } else {
        Src = FragBuf;
        Start = 0;
        Count = Src.Length;
    }
    if (Op == OP_TEXT) {
        // Text payloads must be valid UTF-8 per RFC; UE3 strings are
        // UCS-2/UTF-16. Byte->Chr widening is exact only for ASCII; see the
        // encoding limitation notes at the top of this file.
        OnMessage(Src.ToStringAt(Start, Count), none, true);
    } else {
        OnMessage("", SliceToBuffer(Src, Start, Count), false);
    }
}

function TmByteBuffer SlicePayload(int Offset) {
    return SliceToBuffer(RecvBuf, Offset, Parser.PayloadLen);
}

function TmByteBuffer SliceToBuffer(TmByteBuffer Src, int Offset, int Count) {
    local TmByteBuffer Out;

    Out = new class'TmByteBuffer';
    Out.AppendRange(Src, Offset, Count);
    return Out;
}

// --- Sending ---

function bool SendText(string Text) {
    local TmByteBuffer Payload;

    if (!RequireOpen("SendText")) {
        return false;
    }
    Payload = new class'TmByteBuffer';
    Payload.AppendString(Text);
    return SendFrame(OP_TEXT, Payload);
}

function bool SendBinary(TmByteBuffer Payload) {
    if (!RequireOpen("SendBinary")) {
        return false;
    }
    return SendFrame(OP_BINARY, Payload);
}

function bool SendPing() {
    return RequireOpen("SendPing") && SendFrame(OP_PING, none);
}

function bool SendPong() {
    return RequireOpen("SendPong") && SendFrame(OP_PONG, none);
}

// RFC close: 1000 + optional reason. Sends a close frame and waits for the
// peer's echo (or a timeout via the transport deadline).
function bool Close(optional int Code = WS_CLOSE_NORMAL, optional string Reason) {
    if (WsState != WSS_Open) {
        FireError("Close: socket is not open");
        return false;
    }
    WsState = WSS_Closing;
    SendCloseFrame(Code, Reason);
    Conn.SetDeadline(5.0);
    return true;
}

function SendCloseFrame(int Code, string Reason) {
    local TmByteBuffer Payload;
    local string TrimmedReason;

    bCloseSent = true;
    TrimmedReason = Reason;
    if (Len(TrimmedReason) > 123) {
        TrimmedReason = Left(TrimmedReason, 123);
    }
    Payload = new class'TmByteBuffer';
    Payload.AppendByte(byte((Code >> 8) & 0xff));
    Payload.AppendByte(byte(Code & 0xff));
    Payload.AppendString(TrimmedReason);
    SendFrame(OP_CLOSE, Payload);
}

// Encodes and writes one masked frame.
function bool SendFrame(int Op, TmByteBuffer Payload) {
    local TmByteBuffer Wire;
    local int Count;
    local int Offset;
    local int N;
    local byte ChunkBytes[255];

    if (WsState != WSS_Open && Op != OP_CLOSE) {
        FireError("SendFrame: not open (state " $ string(WsState) $ ")");
        return false;
    }

    Count = 0;
    if (Payload != none) {
        Count = Payload.Length;
    }
    Wire = new class'TmByteBuffer';
    if (!class'TmWsFrame'.static.EncodeClientFrame(Op, true, Payload, 0, Count, Wire)) {
        FireError("Frame payload exceeds limit");
        return false;
    }

    // SendBinary takes byte[255] chunks; bounce through a static array.
    Offset = 0;
    while (Offset < Wire.Length) {
        N = Wire.Length - Offset;
        if (N > 255) {
            N = 255;
        }
        N = Wire.CopyToStatic(Offset, ChunkBytes, N);
        if (Conn.SendBinary(N, ChunkBytes) <= 0 && N > 0) {
            FireError("Socket send failed");
            return false;
        }
        Offset += N;
    }
    Wire.Shrink();
    return true;
}

// Handshake request is text; goes out before Open.
function bool SendRawText(string Text) {
    local int Sent;

    Sent = Conn.SendText(Text);
    if (Sent <= 0) {
        return false;
    }
    // Long heads are rare; loop for the remainder.
    while (Sent < Len(Text)) {
        Text = Mid(Text, Sent);
        Sent = Conn.SendText(Text);
        if (Sent <= 0) {
            return false;
        }
    }
    return true;
}

// --- Teardown ---

function FailConnection(string Reason) {
    `LogWarn('TmNetwork', "WS " $ Url $ ": " $ Reason);
    FireError(Reason);
    EnterClosed(false, Reason);
    if (Conn != none) {
        Conn.Disconnect();
        Conn = none;
    }
}

function EnterClosed(bool bWasClean, string Reason) {
    if (WsState == WSS_Closed) {
        return; // close is terminal and fires OnClosed exactly once
    }
    WsState = WSS_Closed;
    OnClosed(bWasClean, CloseCode, Reason);
}

// Connection died under us.
function OnTransportClosed(bool bWasClean, string Reason) {
    if (WsState == WSS_Open || WsState == WSS_Closing) {
        EnterClosed(bWasClean && bCloseSent && bRemoteClosed, "Connection closed" @ Reason);
    } else if (WsState == WSS_Connecting || WsState == WSS_Handshaking) {
        FireError("Connection closed during handshake");
        EnterClosed(false, "Connection closed during handshake");
    }
    Conn = none;
}

function OnTransportError(string Reason) {
    if (WsState == WSS_Open || WsState == WSS_Closing) {
        FailConnection("Transport error: " $ Reason);
    } else {
        FireError(Reason);
        EnterClosed(false, Reason);
    }
    Conn = none;
}

// Drop without a close handshake.
function Abort() {
    if (Conn != none) {
        Conn.Disconnect();
        Conn = none;
    }
    EnterClosed(false, "Aborted");
}

function bool RequireOpen(string Op) {
    if (WsState != WSS_Open) {
        FireError(Op $ ": WebSocket is not open (state " $ string(WsState) $ ")");
        return false;
    }
    return true;
}

function FireError(string Reason) {
    `LogWarn('TmNetwork', "WS: " $ Reason);
    OnError(Reason);
}

// --- Small helpers ---

// Index of CRLF starting at or after Pos in RecvBuf; -1 when absent.
// Iterative: hostile input can carry thousands of bare CRs, which would
// overflow the script stack as recursion (same fix as TmHttpRequest.FindCrlf).
function int FindCrlfAt(int Pos) {
    local int At;

    At = Pos;
    while (true) {
        At = RecvBuf.IndexOf(13, At);
        if (At == -1 || At + 1 >= RecvBuf.Length) {
            return -1;
        }
        if (RecvBuf.Data[At + 1] == 10) {
            return At;
        }
        At = At + 1;
    }
}

// CRLFCRLF: end of the handshake head. Returns the index of the first CR
// of the blank line, i.e. head length excluding the terminator.
function int FindDoubleCrlf() {
    local int At;

    At = 0;
    while (true) {
        At = RecvBuf.IndexOf(10, At);
        if (At == -1) {
            return -1;
        }
        // Pattern is \r\n\r\n with the first \n at At: we need At >= 1 for
        // the leading CR and At + 2 <= Length - 1 for the trailing CRLF.
        // At + 2 == Length - 1 (head ends exactly at the buffer end) is a
        // full match — a server that sends the head and then waits for
        // client frames leaves the buffer in exactly that state.
        if (At < 1 || At + 2 >= RecvBuf.Length) {
            if (At + 2 >= RecvBuf.Length) {
                return -1; // can't complete without more bytes
            }
            At++;
            continue;
        }
        if (RecvBuf.Data[At - 1] == 13 && RecvBuf.Data[At + 1] == 13 && RecvBuf.Data[At + 2] == 10) {
            return At + 1; // index of the final CRLF's CR
        }
        At++;
    }
}

static function string TrimStr(string S) {
    local int Start, End;

    Start = 0;
    End = Len(S) - 1;
    while (Start <= End && Mid(S, Start, 1) == " ") {
        Start++;
    }
    while (End >= Start && Mid(S, End, 1) == " ") {
        End--;
    }
    return Mid(S, Start, End - Start + 1);
}
