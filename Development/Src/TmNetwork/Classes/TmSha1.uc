// SHA-1 (FIPS 180-1) in pure UnrealScript, int words with wrapping adds.
//
// Used only for the WebSocket handshake (Sec-WebSocket-Accept check). Inputs
// are tiny there (24-byte key + 36-byte GUID), so performance is a non-issue.
// Shifts are arithmetic on signed ints; nibble masking keeps sign extension
// out of the results.
class TmSha1 extends Object;

// One-shot digest. Returns false if the input is missing or overflows caps.
static function bool Digest(TmByteBuffer Input, out TmByteBuffer OutDigest) {
    local TmSha1State Sha;

    if (Input == none || OutDigest == none) {
        return false;
    }
    Sha = new class'TmSha1State';
    Sha.Reset();
    if (!Sha.Update(Input)) {
        return false;
    }
    return Sha.Finish(OutDigest);
}

// Conventional lowercase-hex form, for logging and tests.
static function string DigestToHex(TmByteBuffer Input) {
    local TmByteBuffer DigestBytes;
    local string Hex;
    local int i;

    DigestBytes = new class'TmByteBuffer';
    if (!Digest(Input, DigestBytes)) {
        return "";
    }
    for (i = 0; i < DigestBytes.Length; i++) {
        Hex = Hex $ ByteToHex(DigestBytes.Data[i]);
    }
    DigestBytes.Shrink();
    return Hex;
}

static function string ByteToHex(byte B) {
    local string Digits;

    Digits = "0123456789abcdef";
    return Mid(Digits, (B >> 4) & 15, 1) $ Mid(Digits, B & 15, 1);
}
