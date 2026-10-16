// RFC 6455 opening-handshake helpers: key generation, request generation,
// strict server-response validation.
//
// Per RFC 6455 4.2.2 the Accept value is Base64(SHA1(key-string + GUID))
// where key-string is the base64 Sec-WebSocket-Key text itself, not the
// decoded bytes.
class TmWsHandshake extends Object;

const WS_GUID = "258EAFA5-E914-47DA-95CA-C5AB0DC85B11";

// Generates a random 16-byte key. Returns its base64 form (the value sent
// in Sec-WebSocket-Key) and fills ExpectedAccept with the value the server
// must return in Sec-WebSocket-Accept.
static function string MakeKey(out string ExpectedAccept) {
    local TmByteBuffer Raw;
    local string KeyB64;
    local int i;

    Raw = new class'TmByteBuffer';
    Raw.Reserve(16);
    for (i = 0; i < 16; i++) {
        Raw.Data[i] = byte(Rand(256));
    }
    Raw.Length = 16;

    KeyB64 = EncodeKey(Raw);
    ExpectedAccept = ComputeAcceptKeyFromString(KeyB64);
    Raw.Shrink();
    return KeyB64;
}

// Base64 of the raw key bytes (the Sec-WebSocket-Key header value).
static function string EncodeKey(TmByteBuffer RawKey) {
    local string B64;

    if (RawKey == none) {
        return "";
    }
    if (!class'TmBase64'.static.Encode(RawKey, B64)) {
        return "";
    }
    return B64;
}

// Base64(SHA1(key-string + GUID)) per RFC 6455 4.2.2. The key STRING is
// hashed, not its decoded bytes.
static function string ComputeAcceptKeyFromString(string KeyB64) {
    local TmByteBuffer Input;
    local TmByteBuffer Digest;
    local string B64;

    Input = new class'TmByteBuffer';
    Input.AppendString(KeyB64);
    Input.AppendString(WS_GUID);
    Digest = new class'TmByteBuffer';
    if (!class'TmSha1'.static.Digest(Input, Digest)) {
        Input.Shrink();
        return "";
    }
    if (!class'TmBase64'.static.Encode(Digest, B64)) {
        B64 = "";
    }
    Input.Shrink();
    Digest.Shrink();
    return B64;
}

// Request line + headers for the opening handshake. Key must already be
// base64. ExtraHeaders entries are appended verbatim ("Name: value").
static function string BuildRequest(string HostHeader, string Path, string Key, TmHttpHeaders ExtraHeaders) {
    local string Req;
    local int i;

    Req = "GET " $ Path $ " HTTP/1.1\r\n";
    Req = Req $ "Host: " $ HostHeader $ "\r\n";
    Req = Req $ "Upgrade: websocket\r\n";
    Req = Req $ "Connection: Upgrade\r\n";
    Req = Req $ "Sec-WebSocket-Key: " $ Key $ "\r\n";
    Req = Req $ "Sec-WebSocket-Version: 13\r\n";
    if (ExtraHeaders != none) {
        for (i = 0; i < ExtraHeaders.Names.Length; i++) {
            Req = Req $ ExtraHeaders.Names[i] $ ": " $ ExtraHeaders.Values[i] $ "\r\n";
        }
    }
    Req = Req $ "\r\n";
    return Req;
}

// Full validation of the server's response head. Returns "" when the
// handshake is acceptable, else the reason it is not. Comparison is
// case-sensitive for the Accept value (base64 is case-sensitive) and the
// exact string per RFC 6455 4.2.2.
static function string ValidateResponse(TmHttpResponse Response, string ExpectedAccept) {
    if (Response == none) {
        return "No handshake response";
    }
    if (Response.StatusCode != 101) {
        return "Handshake rejected: status " $ string(Response.StatusCode) $ " (expected 101)";
    }
    if (Locs(Response.Headers.Get("Upgrade")) != "websocket") {
        return "Handshake rejected: missing/invalid Upgrade header";
    }
    if (!Response.Headers.ValueContains("Connection", "Upgrade")) {
        return "Handshake rejected: Connection header lacks Upgrade";
    }
    if (Response.Headers.Get("Sec-WebSocket-Accept") != ExpectedAccept) {
        return "Handshake rejected: Sec-WebSocket-Accept mismatch";
    }
    return "";
}
