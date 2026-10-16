// Streaming SHA-1 state so callers can hash assembled pieces without a
// single contiguous copy of the whole input. Split out of TmSha1 because
// UnrealScript requires one class per file.
class TmSha1State extends Object;

const BLOCK_SIZE = 64;

var int H0, H1, H2, H3, H4;
var int MessageBitLength;
var TmByteBuffer Tail; // partial block carried between Update calls

function Reset() {
    H0 = 0x67452301;
    H1 = 0xEFCDAB89;
    H2 = 0x98BADCFE;
    H3 = 0x10325476;
    H4 = 0xC3D2E1F0;
    MessageBitLength = 0;
    if (Tail == none) {
        Tail = new class'TmByteBuffer';
    }
    Tail.Reset();
}

// Feed bytes; false when the total would exceed the byte buffer cap.
function bool Update(TmByteBuffer Input) {
    local int Offset, Chunk;

    if (Input == none) {
        return true;
    }
    Offset = 0;
    while (Offset < Input.Length) {
        Chunk = BLOCK_SIZE - Tail.Length;
        if (Chunk > Input.Length - Offset) {
            Chunk = Input.Length - Offset;
        }
        if (!Tail.Reserve(Chunk)) {
            return false;
        }
        CopyIntoTail(Input, Offset, Chunk);
        Offset += Chunk;
        if (Tail.Length == BLOCK_SIZE) {
            if (!ProcessBlockRange(0)) {
                return false;
            }
            Tail.Reset();
        }
        MessageBitLength += Chunk * 8;
    }
    return true;
}

function CopyIntoTail(TmByteBuffer Input, int Offset, int Chunk) {
    local int i;

    for (i = 0; i < Chunk; i++) {
        Tail.Data[Tail.Length + i] = Input.Data[Offset + i];
    }
    Tail.Length += Chunk;
}

function bool Finish(out TmByteBuffer OutDigest) {
    local int PadLen, i;
    local int BitLenLo;

    if (OutDigest == none) {
        return false;
    }
    BitLenLo = MessageBitLength;

    // Zeros needed so that 0x80 + zeros + 8-byte length lands exactly on a
    // 64-byte boundary: PadLen = (55 - Tail.Length) mod 64. US % keeps the
    // dividend's sign, so normalize by adding 64 before the second mod.
    PadLen = ((55 - Tail.Length) % BLOCK_SIZE + BLOCK_SIZE) % BLOCK_SIZE;
    AppendToTail(0x80);
    for (i = 0; i < PadLen; i++) {
        AppendToTail(0);
    }
    // Big-endian 64-bit bit length; high word is 0 (inputs never approach
    // 512 MB — buffers are capped at 1 MB).
    AppendToTail(0); AppendToTail(0); AppendToTail(0); AppendToTail(0);
    AppendToTail(byte((BitLenLo >> 24) & 0xff));
    AppendToTail(byte((BitLenLo >> 16) & 0xff));
    AppendToTail(byte((BitLenLo >> 8) & 0xff));
    AppendToTail(byte(BitLenLo & 0xff));

    while (Tail.Length >= BLOCK_SIZE) {
        if (!ProcessBlockRange(0)) {
            return false;
        }
        Tail.Consume(BLOCK_SIZE);
    }

    OutDigest.Reset();
    AppendWord(OutDigest, H0);
    AppendWord(OutDigest, H1);
    AppendWord(OutDigest, H2);
    AppendWord(OutDigest, H3);
    AppendWord(OutDigest, H4);
    return true;
}

function AppendToTail(byte B) {
    if (!Tail.Reserve(1)) {
        return;
    }
    Tail.Data[Tail.Length] = B;
    Tail.Length++;
}

function AppendWord(TmByteBuffer Out, int W) {
    Out.AppendByte(byte((W >> 24) & 0xff));
    Out.AppendByte(byte((W >> 16) & 0xff));
    Out.AppendByte(byte((W >> 8) & 0xff));
    Out.AppendByte(byte(W & 0xff));
}

// Hash the 64-byte block starting at StartIndex in Tail.
function bool ProcessBlockRange(int StartIndex) {
    local int W[80];
    local int i, Temp;
    local int A, B, C, D, E;
    local int B0, B1, B2, B3;

    if (Tail.Length - StartIndex < BLOCK_SIZE) {
        return false;
    }

    for (i = 0; i < 16; i++) {
        // Widen bytes through int locals before shifting: byte-domain
        // arithmetic would wrap at 255.
        B0 = Tail.Data[StartIndex + i*4];
        B1 = Tail.Data[StartIndex + i*4 + 1];
        B2 = Tail.Data[StartIndex + i*4 + 2];
        B3 = Tail.Data[StartIndex + i*4 + 3];
        W[i] = (B0 << 24) | (B1 << 16) | (B2 << 8) | B3;
    }
    for (i = 16; i < 80; i++) {
        Temp = W[i-3] ^ W[i-8] ^ W[i-14] ^ W[i-16];
        W[i] = Rotl32(Temp, 1);
    }
    A = H0; B = H1; C = H2; D = H3; E = H4;
    for (i = 0; i < 80; i++) {
        // FIPS 180-1 round functions operate on (B, C, D): Cho for rounds
        // 0-19, parity for 20-39 and 60-79, Maj for 40-59.
        if (i < 20) {
            Temp = ((B & C) | ((~B) & D)) + E + W[i] + 0x5A827999;
        } else if (i < 40) {
            Temp = (B ^ C ^ D) + E + W[i] + 0x6ED9EBA1;
        } else if (i < 60) {
            Temp = ((B & C) | (B & D) | (C & D)) + E + W[i] + 0x8F1BBCDC;
        } else {
            Temp = (B ^ C ^ D) + E + W[i] + 0xCA62C1D6;
        }
        Temp = Temp + Rotl32(A, 5);
        E = D;
        D = C;
        C = Rotl32(B, 30);
        B = A;
        A = Temp;
    }
    // int adds wrap in UnrealScript, which is exactly what SHA-1 wants.
    H0 += A;
    H1 += B;
    H2 += C;
    H3 += D;
    H4 += E;
    return true;
}

// Rotate left with wrapping. US >> is arithmetic, so mask AFTER the shift to
// strip sign extension; the mask keeps the top S bits, which the shift has
// already brought down into the low positions. Valid for S in 1..31.
static function int Rotl32(int V, int S) {
    return (V << S) | ((V >> (32 - S)) & ((1 << S) - 1));
}

defaultproperties
{
}
