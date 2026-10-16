// One HTTP/1.1 request/response exchange over a TmTcpConnection.
//
// Layering: TmHttpClient owns URLs, connection reuse, and callback fan-out;
// this class owns the wire protocol — request serialization, incremental
// response parsing across receives, chunked decoding, and timeouts. Errors
// arrive through the Fail path with Response.bFailed set; US has no
// exceptions, so there is no throw equivalent here.
class TmHttpRequest extends Object;

const MAX_HEADER_BYTES = 32768;  // response head limit
const MAX_BODY_BYTES = 4194304;  // response body limit (4 MB)
const MAX_CHUNK_SIZE = 8388608;  // single chunk limit
const TCP_CHUNK = 240;           // send in <255-byte pieces (native cap)

enum EHttpParseState {
    HPS_StatusLine,
    HPS_Headers,
    HPS_Body,
    HPS_Done
};

var TmTcpConnection Conn;
var TmHttpResponse Response;
var string Method;
var string Path;          // path+query, resolved by the client
var TmHttpHeaders Headers;
var TmByteBuffer Body;    // request body; may be none

// Parser state
var EHttpParseState ParseState;
var int ChunkBytesRemaining;
var bool bChunked;            // Transfer-Encoding: chunked
var bool bReadingChunkSize;
var bool bInTrailers;        // past the 0-size chunk, skipping trailers
var bool bHeadSeen;
var bool bCloseAfterBody;     // read-until-close mode
var TmByteBuffer ParseBuf;    // unconsumed receive bytes

delegate OnFinished(TmHttpResponse R); // never none when fired; R = parsed response or failure shell

function bool Send(TmTcpConnection InConn, string InMethod, string InPath,
                   TmHttpHeaders InHeaders, TmByteBuffer InBody, float TimeoutSeconds) {
    Conn = InConn;
    Method = InMethod;
    Path = InPath;
    Headers = InHeaders;
    Body = InBody;

    Response = new class'TmHttpResponse';
    Response.Reset();
    ParseBuf = new class'TmByteBuffer';
    ParseState = HPS_StatusLine;
    bHeadSeen = false;
    bCloseAfterBody = false;
    bReadingChunkSize = false;
    bInTrailers = false;
    ChunkBytesRemaining = 0;

    if (Conn != none) {
        Conn.OnReceive = Receive;
        Conn.OnClosed = OnConnClosed;
        Conn.OnError = OnConnError;
        Conn.SetDeadline(TimeoutSeconds);
    }

    if (!WriteRequestHead()) {
        Fail("Send failed while writing request head");
        return false;
    }
    WriteRequestBody();
    return true;
}

// --- Request serialization ---

function bool WriteRequestHead() {
    local string Head;
    local int i;

    if (Conn == none) {
        return false; // no transport attached; nothing to write to
    }
    Head = Method @ Path @ "HTTP/1.1" $ "\r\n";
    Head = Head $ "Host: " $ Conn.HostHeader $ "\r\n";
    if (Headers != none) {
        for (i = 0; i < Headers.Names.Length; i++) {
            Head = Head $ Headers.Names[i] $ ": " $ Headers.Values[i] $ "\r\n";
        }
    }
    if (Body != none && Body.Length > 0 && (Headers == none || !Headers.Has("Content-Length"))) {
        Head = Head $ "Content-Length: " $ string(Body.Length) $ "\r\n";
    }
    Head = Head $ "\r\n";
    return SendTextChunked(Head);
}

function WriteRequestBody() {
    local int Offset, N;

    if (Body == none) {
        return;
    }
    Offset = 0;
    while (Offset < Body.Length) {
        N = Body.Length - Offset;
        if (N > TCP_CHUNK) {
            N = TCP_CHUNK;
        }
        if (!SendTextChunked(Body.ToStringAt(Offset, N))) {
            Fail("Send failed while writing body");
            return;
        }
        Offset += N;
    }
}

// Raw send in <255-byte pieces (SendText takes strings, capped by the
// engine's internal buffer). Returns false on the first failed send.
function bool SendTextChunked(string Text) {
    local int Offset, N, Sent;

    if (Conn == none) {
        return false;
    }
    Offset = 0;
    while (Offset < Len(Text)) {
        N = Len(Text) - Offset;
        if (N > TCP_CHUNK) {
            N = TCP_CHUNK;
        }
        Sent = Conn.SendText(Mid(Text, Offset, N));
        if (Sent <= 0) {
            return false;
        }
        Offset += Sent;
    }
    return true;
}

// --- Receive path ---

// Conn passes its whole receive buffer; drain it into ours (AppendBuffer
// empties the source), then parse what we can and Consume() the accepted
// prefix. Unparsed bytes stay for the next receive.
function Receive(TmByteBuffer Bytes) {
    if (!ParseBuf.AppendBuffer(Bytes)) {
        Fail("Response buffer overflow");
        return;
    }
    ParseBuffer();
}

function ParseBuffer() {
    local int Consumed;

    do {
        Consumed = 0;
        switch (ParseState) {
            case HPS_StatusLine:
                Consumed = TryParseStatusLine();
                break;
            case HPS_Headers:
                Consumed = TryParseHeaders();
                break;
            case HPS_Body:
                Consumed = TryParseBody();
                break;
            case HPS_Done:
                return;
        }
        if (Consumed > 0) {
            ParseBuf.Consume(Consumed);
        }
    } until (Consumed == 0 || ParseState == HPS_Done);
}

// "HTTP/1.1 200 OK\r\n" — returns bytes consumed, 0 when more needed.
function int TryParseStatusLine() {
    local int Eol;
    local string Line;
    local int Sp1, Sp2;
    local string StatusStr;

    if (ParseBuf.Length > MAX_HEADER_BYTES) {
        Fail("Response status line too long");
        return 0;
    }
    Eol = FindCrlf(0);
    if (Eol == -1) {
        return 0;
    }
    Line = ParseBuf.ToStringAt(0, Eol);
    if (Left(Line, 5) != "HTTP/") {
        Fail("Malformed status line: '" $ Line $ "'");
        return 0;
    }
    Response.HttpVersion = Left(Line, 8);
    Sp1 = InStr(Line, " ");
    Sp2 = InStr(Mid(Line, Sp1 + 1), " ");
    if (Sp1 < 0 || Sp2 < 0) {
        // tolerate "HTTP/1.1 200" with no reason phrase
        StatusStr = Mid(Line, Sp1 + 1);
        Response.ReasonPhrase = "";
    } else {
        StatusStr = Mid(Line, Sp1 + 1, Sp2);
        Response.ReasonPhrase = Mid(Line, Sp1 + 1 + Sp2 + 1);
    }
    Response.StatusCode = int(StatusStr);
    if (Response.StatusCode <= 0) {
        Fail("Malformed status code in: '" $ Line $ "'");
        return 0;
    }

    ParseState = HPS_Headers;
    return Eol + 2;
}

// Header lines until blank CRLF. Returns consumed bytes, 0 = need more.
function int TryParseHeaders() {
    local int Eol;
    local string Line;
    local int Colon;
    local string HeaderName, Value;

    if (ParseBuf.Length > MAX_HEADER_BYTES) {
        Fail("Response headers too large");
        return 0;
    }
    Eol = FindCrlf(0);
    if (Eol == -1) {
        return 0;
    }
    if (Eol == 0) {
        ParseState = HPS_Body;
        OnHeadComplete();
        return 2;
    }

    Line = ParseBuf.ToStringAt(0, Eol);
    Colon = InStr(Line, ":");
    if (Colon <= 0) {
        Fail("Malformed header line: '" $ Line $ "'");
        return 0;
    }
    HeaderName = Trim(Left(Line, Colon));
    Value = Trim(Mid(Line, Colon + 1));
    Response.Headers.Add(HeaderName, Value);
    return Eol + 2;
}

// Returns consumed bytes; 0 = need more input (or terminal).
function int TryParseBody() {
    local int ContentLen;

    if (!bHeadSeen) {
        return 0;
    }

    if (bChunked) {
        return TryParseChunkedBody();
    }

    if (bCloseAfterBody) {
        // Everything that arrives is body until the server closes; the
        // connection-close handler finishes the response.
        Response.Body.AppendBuffer(ParseBuf);
        ParseBuf.Reset();
        return 0;
    }

    ContentLen = Response.ContentLength;
    if (ContentLen <= 0) {
        FinishResponse();
        return 0;
    }
    if (ParseBuf.Length >= ContentLen) {
        Response.Body.AppendRange(ParseBuf, 0, ContentLen);
        ParseBuf.Consume(ContentLen);
        FinishResponse();
        return 0;
    }
    return 0;
}

// Chunked: alternate size lines and data runs until a 0-size chunk, then
// an optional trailer section terminated by a blank CRLF line.
function int TryParseChunkedBody() {
    local int Consumed;

    while (ParseState == HPS_Body) {
        if (bInTrailers) {
            Consumed = FindCrlf(0);
            if (Consumed == -1) {
                if (ParseBuf.Length > MAX_HEADER_BYTES) {
                    Fail("Trailer section too large");
                }
                return 0;
            }
            if (Consumed == 0) {
                ParseBuf.Consume(2); // blank line: end of trailers
                FinishResponse();
                return 0;
            }
            ParseBuf.Consume(Consumed + 2); // trailer header: contents unused
        } else if (bReadingChunkSize) {
            Consumed = TryParseChunkSize();
            if (Consumed == 0) {
                return 0;
            }
            ParseBuf.Consume(Consumed);
        } else if (ChunkBytesRemaining > 0) {
            Consumed = TryParseChunkData();
            if (Consumed == 0) {
                return 0;
            }
            ParseBuf.Consume(Consumed);
            if (ChunkBytesRemaining == 0) {
                // Data run complete; its CRLF terminator must follow before
                // the next size line.
                if (ParseBuf.Length < 2) {
                    return 0;
                }
                if (ParseBuf.Data[0] != 13 || ParseBuf.Data[1] != 10) {
                    Fail("Malformed chunk framing: expected CRLF after chunk data");
                    return 0;
                }
                ParseBuf.Consume(2);
                bReadingChunkSize = true;
            }
        } else {
            Fail("Chunked parser in invalid state");
            return 0;
        }
    }
    return 0;
}

// "SIZE[;ext]\r\n" — returns consumed bytes, 0 = need more.
function int TryParseChunkSize() {
    local int Eol;
    local string Line;
    local int Semi;
    local string HexPart;
    local int Size;

    if (ParseBuf.Length > MAX_HEADER_BYTES) {
        Fail("Chunk size line too long");
        return 0;
    }
    Eol = FindCrlf(0);
    if (Eol == -1) {
        return 0;
    }
    Line = ParseBuf.ToStringAt(0, Eol);
    Semi = InStr(Line, ";");
    if (Semi != -1) {
        HexPart = Left(Line, Semi); // chunk extensions ignored
    } else {
        HexPart = Line;
    }
    Size = ParseHex(Trim(HexPart));
    if (Size < 0) {
        Fail("Malformed chunk size '" $ HexPart $ "'");
        return 0;
    }
    if (Size > MAX_CHUNK_SIZE) {
        Fail("Chunk too large");
        return 0;
    }

    ChunkBytesRemaining = Size;
    bReadingChunkSize = false;
    if (Size == 0) {
        bInTrailers = true; // 0-size chunk: trailer section (or blank line) next
    }
    return Eol + 2;
}

// Copies min(ChunkBytesRemaining, available) data bytes into the body.
function int TryParseChunkData() {
    local int N;

    N = ParseBuf.Length;
    if (N == 0) {
        return 0;
    }
    if (N > ChunkBytesRemaining) {
        N = ChunkBytesRemaining;
    }
    if (Response.Body.Length + N > MAX_BODY_BYTES) {
        Fail("Response body too large");
        return 0;
    }
    Response.Body.AppendRange(ParseBuf, 0, N);
    ChunkBytesRemaining -= N;
    return N;
}

// (Trailer skipping lives inline in TryParseChunkedBody's bInTrailers arm.)

function OnHeadComplete() {
    local string TE;

    bHeadSeen = true;
    Response.ContentLength = -1;
    if (Response.Headers.Has("Content-Length")) {
        Response.ContentLength = int(Trim(Response.Headers.Get("Content-Length")));
    }

    TE = Locs(Response.Headers.Get("Transfer-Encoding"));
    if (InStr(TE, "chunked") != -1) {
        bChunked = true;
        bReadingChunkSize = true;
        return;
    }

    // No body for HEAD or the bodyless statuses regardless of headers.
    if (Method ~= "HEAD" || Response.StatusCode == 204 || Response.StatusCode == 304) {
        FinishResponse();
        return;
    }

    if (Response.ContentLength > MAX_BODY_BYTES) {
        Fail("Response body too large");
        return;
    }
    if (Response.ContentLength > 0) {
        return; // Content-Length body; TryParseBody waits for the bytes
    }

    // No length markers at all: per RFC 7230 3.3.3 the body runs until the
    // server closes the connection. The connection deadline guards against
    // a server that never closes — the timeout fails the request cleanly.
    bCloseAfterBody = true;
}

function FinishResponse() {
    if (Response.bFinished) {
        return;
    }
    ParseState = HPS_Done;
    Response.bFinished = true;
    DetachConn();
    OnFinished(Response);
}

function Fail(string Reason) {
    if (Conn != none) {
        Conn.SetDeadline(0.0);
    }
    ParseState = HPS_Done;
    if (Response != none && !Response.bFinished) {
        Response.bFinished = true;
        Response.bFailed = true;
        Response.ErrorMessage = Reason;
        Response.StatusCode = 0;
        `LogWarn('TmNetwork', "HTTP " $ Method $ " " $ Path $ ": " $ Reason);
        DetachConn();
        OnFinished(Response);
    }
}

// Unhooks our delegates from the connection; safe with Conn == none
// (tests drive the parser without a transport).
function DetachConn() {
    if (Conn != none) {
        Conn.SetDeadline(0.0);
        Conn.OnReceive = none;
        Conn.OnClosed = none;
        Conn.OnError = none;
    }
}

// --- Connection event adapters ---

function OnConnClosed(bool bWasClean, string Reason) {
    if (ParseState == HPS_Done) {
        return; // already delivered
    }
    if (bCloseAfterBody && bHeadSeen) {
        Response.Body.AppendBuffer(ParseBuf);
        ParseBuf.Reset();
        FinishResponse();
        return;
    }
    Fail("Connection closed before response completed (" $ Reason $ ")");
}

function OnConnError(string Reason) {
    Fail("Connection error: " $ Reason);
}

// --- Parsing helpers ---

// Index of the first "\r\n" at or after Start; -1 when absent. Lone CR
// keeps scanning (a bare CR alone is never a line terminator here).
// Iterative: hostile input can carry thousands of bare CRs, which would
// overflow the script stack as recursion.
function int FindCrlf(int Start) {
    local int At;

    At = Start;
    while (true) {
        At = ParseBuf.IndexOf(13, At);
        if (At == -1) {
            return -1;
        }
        if (At + 1 >= ParseBuf.Length) {
            return -1; // CR at the very end: wait for the LF
        }
        if (ParseBuf.Data[At + 1] == 10) {
            return At;
        }
        At = At + 1;
    }
}

static function string Trim(string S) {
    local int Start, End;

    Start = 0;
    End = Len(S) - 1;
    while (Start <= End && IsSpaceChar(Mid(S, Start, 1))) {
        Start++;
    }
    while (End >= Start && IsSpaceChar(Mid(S, End, 1))) {
        End--;
    }
    return Mid(S, Start, End - Start + 1);
}

static function bool IsSpaceChar(string C) {
    return C == " " || C == Chr(9);
}

// Hex string -> int, -1 on malformed. Accepts an optional "0x" prefix.
static function int ParseHex(string S) {
    local int i, V, Digit, A;

    S = Locs(Trim(S));
    if (Left(S, 2) == "0X") {
        S = Mid(S, 2);
    }
    if (Len(S) == 0 || Len(S) > 7) {
        return -1; // keep V*16 inside int range
    }
    V = 0;
    for (i = 0; i < Len(S); i++) {
        A = Asc(Mid(S, i, 1));
        if (A >= 48 && A <= 57) {
            Digit = A - 48;
        } else if (A >= 65 && A <= 70) {
            Digit = A - 55;
        } else {
            return -1;
        }
        V = V * 16 + Digit;
    }
    return V;
}

defaultproperties
{
}
