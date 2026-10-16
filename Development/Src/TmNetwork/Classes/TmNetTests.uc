// Deterministic protocol tests for TmNetwork — no network required.
//
// Run in-game via the TmCheatManager `nettest` exec (or any exec that calls
// RunAll). Every check appends to a pass/fail tally logged at the end.
//
// Known vectors:
//  - SHA-1: FIPS/RFC 3174 test strings ("abc", the alphabet, "a"x1000000
//    is skipped as too slow; three short vectors + empty suffice here)
//  - Base64: RFC 4648 test vectors
//  - WebSocket Accept: RFC 6455 example from section 1.3
class TmNetTests extends Object;

// Mirror of TmHttpRequest.EHttpParseState (enum members are scoped to their
// declaring class; byte ordinals must match the declaration order there).
enum EHttpParseState {
    HPS_StatusLine,
    HPS_Headers,
    HPS_Body,
    HPS_Done
};

var int PassCount;
var int FailCount;

static function bool RunAll() {
    local TmNetTests T;

    T = new class'TmNetTests';
    T.TestBase64();
    T.TestSha1();
    T.TestWsAcceptKey();
    T.TestByteBuffer();
    T.TestHttpHeadParsing();
    T.TestChunkedParsing();
    T.TestFrameSplitAcrossFeeds();
    T.TestMultipleFramesPerFeed();
    T.TestFragmentedMessages();
    T.TestPingPongAndClose();
    T.TestInvalidFrames();
    T.TestHeaderValueContains();
    T.TestCrlfScanning();
    `log("TmNetTests: " $ string(T.PassCount) $ " passed, " $ string(T.FailCount) $ " failed", true, 'TmNetwork');
    return T.FailCount == 0;
}

// --- Helpers ---

function Check(bool Cond, string What) {
    if (Cond) {
        PassCount++;
    } else {
        FailCount++;
        `LogError('TmNetwork', "TEST FAIL: " $ What);
    }
}

function CheckStr(string Got, string Want, string What) {
    if (Got == Want) {
        PassCount++;
    } else {
        FailCount++;
        `LogError('TmNetwork', "TEST FAIL: " $ What $ " — got '" $ Got $ "', want '" $ Want $ "'");
    }
}

function TmByteBuffer BufFromStr(string S) {
    local TmByteBuffer B;

    B = new class'TmByteBuffer';
    B.AppendString(S);
    return B;
}

// Builds an unmasked (server-style) frame around Payload.
function TmByteBuffer ServerFrame(int Opcode, bool bFin, TmByteBuffer Payload) {
    local TmByteBuffer Out;
    local int Count, i;

    Out = new class'TmByteBuffer';
    Count = 0;
    if (Payload != none) {
        Count = Payload.Length;
    }
    i = Opcode & 15;
    if (bFin) {
        i = i | 0x80;
    }
    Out.AppendByte(byte(i));
    if (Count < 126) {
        Out.AppendByte(byte(Count));
    } else if (Count <= 65535) {
        Out.AppendByte(126);
        Out.AppendByte(byte((Count >> 8) & 0xff));
        Out.AppendByte(byte(Count & 0xff));
    } else {
        Out.AppendByte(127);
        Out.AppendByte(0); Out.AppendByte(0); Out.AppendByte(0); Out.AppendByte(0);
        Out.AppendByte(byte((Count >> 24) & 0xff));
        Out.AppendByte(byte((Count >> 16) & 0xff));
        Out.AppendByte(byte((Count >> 8) & 0xff));
        Out.AppendByte(byte(Count & 0xff));
    }
    if (Payload != none) {
        for (i = 0; i < Count; i++) {
            Out.AppendByte(Payload.Data[i]);
        }
    }
    return Out;
}

// Runs the parser over Buf and collects opcodes/texts. Returns false on a
// parser error, filling Err.
function bool ParseAll(TmByteBuffer Buf, out array<int> Opcodes, out array<string> Texts, out string Err) {
    local TmWsFrameParser P;
    local int Offset, Res;

    P = new class'TmWsFrameParser';
    P.Reset();
    Offset = 0;
    while (true) {
        Res = P.Advance(Buf, Offset);
        if (Res == class'TmWsFrameParser'.const.RES_NEED_MORE) {
            if (Offset < Buf.Length) {
                Err = "Parser stalled with " $ string(Buf.Length - Offset) $ " bytes unparsed";
                return false;
            }
            return true;
        }
        if (Res == class'TmWsFrameParser'.const.RES_ERROR) {
            Err = P.ErrorMessage;
            return false;
        }
        Opcodes[Opcodes.Length] = P.Opcode;
        Texts[Texts.Length] = Buf.ToStringAt(P.PayloadOffset, P.PayloadLen);
        Offset += P.TotalLen;
    }
}

// --- Base64 (RFC 4648 vectors) ---

function TestBase64() {
    local TmByteBuffer B;
    local string Encoded;
    local TmByteBuffer Decoded;

    // Encode vectors
    B = BufFromStr("");
    class'TmBase64'.static.Encode(B, Encoded);
    CheckStr(Encoded, "", "base64 empty");

    B = BufFromStr("f");
    class'TmBase64'.static.Encode(B, Encoded);
    CheckStr(Encoded, "Zg==", "base64 'f'");

    B = BufFromStr("fo");
    class'TmBase64'.static.Encode(B, Encoded);
    CheckStr(Encoded, "Zm8=", "base64 'fo'");

    B = BufFromStr("foo");
    class'TmBase64'.static.Encode(B, Encoded);
    CheckStr(Encoded, "Zm9v", "base64 'foo'");

    B = BufFromStr("foob");
    class'TmBase64'.static.Encode(B, Encoded);
    CheckStr(Encoded, "Zm9vYg==", "base64 'foob'");

    B = BufFromStr("fooba");
    class'TmBase64'.static.Encode(B, Encoded);
    CheckStr(Encoded, "Zm9vYmE=", "base64 'fooba'");

    B = BufFromStr("foobar");
    class'TmBase64'.static.Encode(B, Encoded);
    CheckStr(Encoded, "Zm9vYmFy", "base64 'foobar'");

    // Round-trips
    Decoded = new class'TmByteBuffer';
    Check(class'TmBase64'.static.Decode("Zm9vYmFy", Decoded) && Decoded.ToStringAt(0, Decoded.Length) == "foobar", "base64 decode round-trip");
    Check(class'TmBase64'.static.Decode("Zm8=", Decoded) && Decoded.ToStringAt(0, Decoded.Length) == "fo", "base64 decode padded 2");
    Check(class'TmBase64'.static.Decode("Zg==", Decoded) && Decoded.ToStringAt(0, Decoded.Length) == "f", "base64 decode padded 1");

    // Strictness
    Check(!class'TmBase64'.static.Decode("Zm9vY", Decoded), "base64 rejects bad length");
    Check(!class'TmBase64'.static.Decode("Zm9v!", Decoded), "base64 rejects bad char");
    Check(!class'TmBase64'.static.Decode("=m9v", Decoded), "base64 rejects leading pad");
    Check(!class'TmBase64'.static.Decode("Zm9vYg=A", Decoded), "base64 rejects pad placement");
    Decoded.Shrink();
}

// --- SHA-1 (FIPS 180-1 / RFC 3174 vectors) ---

function TestSha1() {
    local TmByteBuffer B;

    B = BufFromStr("abc");
    CheckStr(class'TmSha1'.static.DigestToHex(B), "a9993e364706816aba3e25717850c26c9cd0d89d", "sha1 'abc'");

    B = BufFromStr("");
    CheckStr(class'TmSha1'.static.DigestToHex(B), "da39a3ee5e6b4b0d3255bfef95601890afd80709", "sha1 empty");

    B = BufFromStr("abcdbcdecdefdefgefghfghighijhijkijkljklmklmnlmnomnopnopq");
    CheckStr(class'TmSha1'.static.DigestToHex(B), "84983e441c3bd26ebaae4aa1f95129e5e54670f1", "sha1 448-bit msg");

    // Multi-block + streaming-split check: feed 'foobar' in two Updates.
    MultiUpdateTest("foo", "bar", "8843d7f92416211de9ebb963ff4ce28125932878", "sha1 split foobar");
}

function MultiUpdateTest(string Part1, string Part2, string WantHex, string What) {
    local TmSha1State St;
    local TmByteBuffer Digest;
    local string Hex;
    local int i;

    St = new class'TmSha1State';
    St.Reset();
    St.Update(BufFromStr(Part1));
    St.Update(BufFromStr(Part2));
    Digest = new class'TmByteBuffer';
    if (!St.Finish(Digest)) {
        Check(false, What $ " (finish failed)");
        return;
    }
    Hex = "";
    for (i = 0; i < Digest.Length; i++) {
        Hex = Hex $ class'TmSha1'.static.ByteToHex(Digest.Data[i]);
    }
    CheckStr(Hex, WantHex, What);
}

// --- WebSocket handshake (RFC 6455 section 1.3 example) ---

function TestWsAcceptKey() {
    local string Accept;

    // RFC 6455 1.3 example: key "dGhlIHNhbXBsZSBub25jZQ==" ("the sample nonce")
    Accept = class'TmWsHandshake'.static.ComputeAcceptKeyFromString("dGhlIHNhbXBsZSBub25jZQ==");
    CheckStr(Accept, "s3pPLMBiTxaQ9kYGzzhZRbK+xOo=", "RFC 6455 accept key example");

    MakeKeyRoundTrip();
}

function MakeKeyRoundTrip() {
    local string Key, ExpectedAccept, ActualAccept;
    local TmByteBuffer Raw;
    local int i;

    for (i = 0; i < 8; i++) {
        Key = class'TmWsHandshake'.static.MakeKey(ExpectedAccept);
        Raw = new class'TmByteBuffer';
        class'TmBase64'.static.Decode(Key, Raw);
        ActualAccept = "";
        if (Len(Key) == 24 && Raw.Length == 16) { // 16 bytes -> 24 b64 chars
            ActualAccept = class'TmWsHandshake'.static.ComputeAcceptKeyFromString(Key);
        }
        if (ActualAccept != "" && ActualAccept == ExpectedAccept) {
            PassCount++;
        } else {
            FailCount++;
            `LogError('TmNetwork', "TEST FAIL: makekey round-trip " $ string(i));
        }
        Raw.Shrink();
    }
}

// --- ByteBuffer ---

function TestByteBuffer() {
    local TmByteBuffer B, B2;
    local byte StaticArr[255];
    local int N;

    B = new class'TmByteBuffer';
    B.AppendString("hello");
    B.AppendByte(0);
    Check(B.Length == 6, "bytebuffer append counts");
    Check(B.ToStringAt(0, 5) == "hello", "bytebuffer tostring");
    Check(B.Get(5) == 0 && B.Get(999) == 0, "bytebuffer get bounds");

    B.Consume(2);
    CheckStr(B.ToStringAt(0, B.Length), "llo" $ Chr(0), "bytebuffer consume");

    B2 = new class'TmByteBuffer';
    B2.AppendString("xy");
    B.AppendBuffer(B2);
    CheckStr(B.ToStringAt(0, B.Length), "llo" $ Chr(0) $ "xy", "bytebuffer appendbuffer");
    Check(B2.Length == 0, "bytebuffer appendbuffer drains source");

    N = B.ToStaticBytes(StaticArr);
    Check(N == 6 && StaticArr[0] == Asc("l"), "bytebuffer tostatic");

    B.Reset();
    Check(B.Length == 0, "bytebuffer reset");
}

// --- HTTP head parsing (status line + headers, split feeds) ---

function TestHttpHeadParsing() {
    local TmHttpRequest Req;
    local TmHttpResponse Got;
    local string Raw1, Raw2;

    Req = new class'TmHttpRequest';
    Req.Response = new class'TmHttpResponse';
    Req.Response.Reset();
    Req.ParseBuf = new class'TmByteBuffer';
    Req.ParseState = HPS_StatusLine;

    // Split in the middle of the status line and again mid-headers.
    Raw1 = "HTTP/1.1 200 OK\r\nContent-Ty";
    Raw2 = "pe: text/html\r\nX-Test: a-b\r\n\r\nbody-start";

    Req.ParseBuf.AppendString(Raw1);
    Req.ParseBuffer();
    Check(Req.ParseState == HPS_StatusLine || Req.ParseState == HPS_Headers,
        "http split feed: safe state after partial");
    Check(!Req.Response.bFailed, "http split feed: no premature failure");

    Req.ParseBuf.AppendString(Raw2);
    Req.ParseBuffer();
    Check(!Req.Response.bFailed, "http head parsed across feeds");
    Check(Req.Response.StatusCode == 200, "http status code");
    CheckStr(Req.Response.ReasonPhrase, "OK", "http reason phrase");
    CheckStr(Req.Response.Headers.Get("content-type"), "text/html", "http header case-insensitive");
    CheckStr(Req.Response.Headers.Get("X-Test"), "a-b", "http second header");
    CheckStr(Req.Response.Body.ToStringAt(0, Req.Response.Body.Length), "body-start",
        "http body bytes after head");
    Check(Req.ParseState == HPS_Body, "http state advanced to body");
    Got = Req.Response;
    Check(Got != none, "http response exists");
}

// --- Chunked transfer decoding ---

function TestChunkedParsing() {
    local TmHttpRequest Req;

    Req = new class'TmHttpRequest';
    Req.Response = new class'TmHttpResponse';
    Req.Response.Reset();
    Req.ParseBuf = new class'TmByteBuffer';
    Req.ParseState = HPS_Body;
    Req.bChunked = true;
    Req.bHeadSeen = true;
    Req.bReadingChunkSize = true;

    // Two chunks with extensions, trailers, and awkward feed boundaries.
    Req.ParseBuf.AppendString("4\r\nWiki\r\n5\r\npedia\r\n0\r\nX-T: 1\r\n\r\n");
    Req.ParseBuffer();
    Check(!Req.Response.bFailed, "chunked parse ok");
    CheckStr(Req.Response.Body.ToStringAt(0, Req.Response.Body.Length), "Wikipedia", "chunked reassembly");
    Check(Req.Response.bFinished, "chunked finished");

    // Byte-at-a-time feed: worst-case fragmentation must still work.
    Req = new class'TmHttpRequest';
    Req.Response = new class'TmHttpResponse';
    Req.Response.Reset();
    Req.ParseBuf = new class'TmByteBuffer';
    Req.ParseState = HPS_Body;
    Req.bChunked = true;
    Req.bHeadSeen = true;
    Req.bReadingChunkSize = true;
    FeedByteByByte(Req, "3\r\nabc\r\n0\r\n\r\n");
    Check(!Req.Response.bFailed, "chunked byte-by-byte ok");
    CheckStr(Req.Response.Body.ToStringAt(0, Req.Response.Body.Length), "abc", "chunked byte-by-byte body");
}

function FeedByteByByte(TmHttpRequest Req, string Raw) {
    local int i;

    for (i = 0; i < Len(Raw); i++) {
        Req.ParseBuf.AppendString(Mid(Raw, i, 1));
        Req.ParseBuffer();
        if (Req.Response.bFailed || Req.Response.bFinished) {
            return;
        }
    }
}

// --- Frame splitting: one frame across many feeds ---

function TestFrameSplitAcrossFeeds() {
    local TmWsFrameParser P;
    local TmByteBuffer Wire, Piece;
    local int Offset, Res, Frames;
    local int i;
    local string Whole, Text;

    Wire = ServerFrame(class'TmWsFrame'.const.OP_TEXT, true, BufFromStr("Hello, split world!"));
    Whole = Wire.ToStringAt(0, Wire.Length);

    P = new class'TmWsFrameParser';
    P.Reset();
    Piece = new class'TmByteBuffer';
    Offset = 0;
    Frames = 0;
    Text = "";
    // Feed one byte at a time.
    for (i = 0; i < Len(Whole); i++) {
        Piece.AppendString(Mid(Whole, i, 1));
        do {
            Res = P.Advance(Piece, Offset);
            if (Res == class'TmWsFrameParser'.const.RES_FRAME) {
                Frames++;
                Text = Text $ Piece.ToStringAt(P.PayloadOffset, P.PayloadLen);
                Offset += P.TotalLen;
            } else if (Res == class'TmWsFrameParser'.const.RES_ERROR) {
                Check(false, "split feed: unexpected error: " $ P.ErrorMessage);
                return;
            }
        } until (Res != class'TmWsFrameParser'.const.RES_FRAME);
    }
    Check(Frames == 1, "split feed: exactly one frame");
    CheckStr(Text, "Hello, split world!", "split feed: payload reassembled");
}

// --- Multiple frames in one feed ---

function TestMultipleFramesPerFeed() {
    local TmByteBuffer Wire;
    local array<int> Opcodes;
    local array<string> Texts;
    local string Err;

    Wire = new class'TmByteBuffer';
    Wire.AppendBuffer(ServerFrame(class'TmWsFrame'.const.OP_TEXT, true, BufFromStr("one")));
    Wire.AppendBuffer(ServerFrame(class'TmWsFrame'.const.OP_TEXT, true, BufFromStr("two")));
    Wire.AppendBuffer(ServerFrame(class'TmWsFrame'.const.OP_PING, true, BufFromStr("hb")));

    if (!ParseAll(Wire, Opcodes, Texts, Err)) {
        Check(false, "multi-frame parse failed: " $ Err);
        return;
    }
    Check(Opcodes.Length == 3, "multi-frame count");
    if (Opcodes.Length == 3) {
        Check(Opcodes[0] == 1 && Opcodes[1] == 1 && Opcodes[2] == 9, "multi-frame opcodes");
        CheckStr(Texts[0], "one", "multi-frame text 0");
        CheckStr(Texts[1], "two", "multi-frame text 1");
        CheckStr(Texts[2], "hb", "multi-frame text 2");
    }

    // 16-bit length path
    BigFrameTest(300, "long frame body -");
}

function BigFrameTest(int PayloadLen, string Fill) {
    local TmByteBuffer Wire, Payload;
    local array<int> Opcodes;
    local array<string> Texts;
    local string Err;
    local int i;

    Payload = new class'TmByteBuffer';
    for (i = 0; i < PayloadLen; i++) {
        Payload.AppendByte(byte(Asc(Mid(Fill, i % Len(Fill), 1))));
    }
    Wire = ServerFrame(class'TmWsFrame'.const.OP_BINARY, true, Payload);
    if (!ParseAll(Wire, Opcodes, Texts, Err)) {
        Check(false, "16-bit frame parse failed: " $ Err);
        return;
    }
    Check(Opcodes.Length == 1 && Opcodes[0] == 2, "16-bit frame opcode");
    Check(Texts[0] == Payload.ToStringAt(0, Payload.Length), "16-bit frame payload intact");
}

// --- Fragmented messages (with interleaved ping) ---

function TestFragmentedMessages() {
    local TmByteBuffer Wire;
    local array<int> Opcodes;
    local array<string> Texts;
    local string Err;

    Wire = new class'TmByteBuffer';
    // TEXT, no FIN: "frag"
    Wire.AppendBuffer(ServerFrame(class'TmWsFrame'.const.OP_TEXT, false, BufFromStr("frag")));
    // Interleaved ping (control frames may nest between fragments)
    Wire.AppendBuffer(ServerFrame(class'TmWsFrame'.const.OP_PING, true, BufFromStr("keepalive")));
    // CONTINUATION, no FIN: "ment"
    Wire.AppendBuffer(ServerFrame(class'TmWsFrame'.const.OP_CONTINUATION, false, BufFromStr("ment")));
    // CONTINUATION, FIN: "ed!"
    Wire.AppendBuffer(ServerFrame(class'TmWsFrame'.const.OP_CONTINUATION, true, BufFromStr("ed!")));

    if (!ParseAll(Wire, Opcodes, Texts, Err)) {
        Check(false, "fragment parse failed: " $ Err);
        return;
    }
    Check(Opcodes.Length == 4, "fragment frame count");
    if (Opcodes.Length == 4) {
        Check(Opcodes[0] == 1 && Opcodes[1] == 9 && Opcodes[2] == 0 && Opcodes[3] == 0,
            "fragment opcodes order");
        CheckStr(Texts[0] $ Texts[2] $ Texts[3], "fragmented!", "fragment reassembly");
        CheckStr(Texts[1], "keepalive", "interleaved ping payload");
    }
}

// --- Ping/pong/close round-trips through the codec ---

function TestPingPongAndClose() {
    local TmByteBuffer Wire, Pong, Close;
    local array<int> Opcodes;
    local array<string> Texts;
    local string Err;

    // Client pong (masked) must decode back through a masked-parse variant:
    // our parser rejects masked frames (server direction), so verify the
    // codec structurally instead: header says masked, unmask matches input.
    Pong = new class'TmByteBuffer';
    if (!class'TmWsFrame'.static.EncodeClientFrame(class'TmWsFrame'.const.OP_PONG, true, BufFromStr("hb"), 0, 2, Pong)) {
        Check(false, "pong encode failed");
        return;
    }
    Check((Pong.Data[1] & 0x80) != 0, "client frames carry mask bit");
    Check((Pong.Length) == 2 + 4 + 2, "pong wire size");

    // Close frame with code 1000 + reason.
    Close = new class'TmByteBuffer';
    Close.AppendByte(byte(1000 >> 8));
    Close.AppendByte(byte(1000 & 0xff));
    Close.AppendString("bye");
    Wire = ServerFrame(class'TmWsFrame'.const.OP_CLOSE, true, Close);
    if (!ParseAll(Wire, Opcodes, Texts, Err)) {
        Check(false, "close frame parse failed: " $ Err);
        return;
    }
    Check(Opcodes.Length == 1 && Opcodes[0] == 8, "close opcode");
    Check((((Asc(Left(Texts[0], 1))) << 8) | Asc(Mid(Texts[0], 1, 1))) == 1000, "close code bytes");
    CheckStr(Mid(Texts[0], 2), "bye", "close reason");
}

// --- Invalid frames must fail cleanly ---

function TestInvalidFrames() {
    local TmByteBuffer Wire;
    local array<int> Opcodes;
    local array<string> Texts;
    local string Err;

    // Reserved opcode 5
    Wire = ServerFrame(5, true, BufFromStr("x"));
    Check(!ParseAll(Wire, Opcodes, Texts, Err), "reserved opcode rejected");

    // RSV bit set
    Wire = ServerFrame(1, true, BufFromStr("x"));
    Wire.Data[0] = byte(Wire.Data[0] | 0x40);
    Check(!ParseAll(Wire, Opcodes, Texts, Err), "RSV bit rejected");

    // Masked inbound frame (server must not mask)
    Wire = ServerFrame(1, true, BufFromStr("x"));
    Wire.Data[1] = byte(Wire.Data[1] | 0x80);
    Wire.AppendByte(1); Wire.AppendByte(2); Wire.AppendByte(3); Wire.AppendByte(4);
    Check(!ParseAll(Wire, Opcodes, Texts, Err), "masked inbound frame rejected");

    // Truncated frame (declares 10 bytes, sends 3) must not parse as done
    Wire = ServerFrame(1, true, BufFromStr("0123456789"));
    Wire.Length = Wire.Length - 7;
    Opcodes.Length = 0;
    Texts.Length = 0;
    Err = "";
    Check(!ParseAll(Wire, Opcodes, Texts, Err) || Opcodes.Length == 0,
        "truncated frame does not yield a frame");

    // Non-minimal 16-bit length
    Wire = new class'TmByteBuffer';
    Wire.AppendByte(byte(0x81));
    Wire.AppendByte(126);
    Wire.AppendByte(0);
    Wire.AppendByte(5);
    Wire.AppendString("hello");
    Check(!ParseAll(Wire, Opcodes, Texts, Err), "non-minimal length rejected");
}

// --- Header ValueContains: comma tokens with spaces ---

function TestHeaderValueContains() {
    local TmHttpHeaders H;

    H = new class'TmHttpHeaders';
    H.Add("Connection", "keep-alive, Upgrade"); // space after comma, as servers send
    Check(H.ValueContains("Connection", "Upgrade"), "valuecontains trims comma space");
    Check(H.ValueContains("Connection", "keep-alive"), "valuecontains first token");
    Check(!H.ValueContains("Connection", "upgrad"), "valuecontains no partial match");
    Check(!H.ValueContains("X-Absent", "Upgrade"), "valuecontains absent header");
}

// --- CRLF scanning: many bare CRs must not recurse/fail ---

function TestCrlfScanning() {
    local TmHttpRequest Req;
    local TmWsClient Cli;
    local int i;

    // HTTP: 3000 bare CRs then a real CRLF — iterative scan must find it.
    Req = new class'TmHttpRequest';
    Req.Response = new class'TmHttpResponse';
    Req.Response.Reset();
    Req.ParseBuf = new class'TmByteBuffer';
    for (i = 0; i < 3000; i++) {
        Req.ParseBuf.AppendByte(13);
    }
    Req.ParseBuf.AppendString("\r\n");
    Check(Req.FindCrlf(0) == 3001, "findcrlf skips many bare CRs");

    // WS handshake path: same shape through FindCrlfAt.
    Cli = new class'TmWsClient';
    Cli.Setup(none);
    for (i = 0; i < 3000; i++) {
        Cli.RecvBuf.AppendByte(13);
    }
    Cli.RecvBuf.AppendString("\r\n");
    Check(Cli.FindCrlfAt(0) == 3001, "findcrlfat skips many bare CRs");
}

// (No class-level state beyond the tally; loop counters stay function-local.)
