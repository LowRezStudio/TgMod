// RFC 6455 frame codec over TmByteBuffer: opcodes, wire serialization.
// Parsing lives in TmWsFrameParser (incremental state machine).
class TmWsFrame extends Object;

const MAX_FRAME_PAYLOAD = 1048576; // 1 MB per frame
const MAX_MESSAGE_BYTES = 4194304; // 4 MB reassembled message cap

// Opcodes (RFC 6455 5.2)
const OP_CONTINUATION = 0;
const OP_TEXT = 1;
const OP_BINARY = 2;
const OP_CLOSE = 8;
const OP_PING = 9;
const OP_PONG = 10;

// Serializes one client frame: always masked, minimal length encoding.
// Payload bytes are taken from Payload[Start..Start+Count).
// Returns false when Count exceeds MAX_FRAME_PAYLOAD.
static function bool EncodeClientFrame(int Opcode, bool bFin, TmByteBuffer Payload, int Start, int Count, TmByteBuffer Out) {
    local byte Mask[4];
    local int i, B;

    if (Count > MAX_FRAME_PAYLOAD) {
        return false;
    }
    for (i = 0; i < 4; i++) {
        Mask[i] = byte(Rand(256));
    }

    // Byte 1: FIN + opcode
    B = Opcode & 15;
    if (bFin) {
        B = B | 0x80;
    }
    Out.AppendByte(byte(B));

    // Byte 2: mask bit + length
    if (Count < 126) {
        Out.AppendByte(byte(0x80 | Count));
    } else if (Count <= 65535) {
        Out.AppendByte(byte(0x80 | 126));
        Out.AppendByte(byte((Count >> 8) & 0xff));
        Out.AppendByte(byte(Count & 0xff));
    } else {
        Out.AppendByte(byte(0x80 | 127));
        // 64-bit length field; upper 4 bytes zero (cap is 1 MB)
        Out.AppendByte(0); Out.AppendByte(0); Out.AppendByte(0); Out.AppendByte(0);
        Out.AppendByte(byte((Count >> 24) & 0xff));
        Out.AppendByte(byte((Count >> 16) & 0xff));
        Out.AppendByte(byte((Count >> 8) & 0xff));
        Out.AppendByte(byte(Count & 0xff));
    }

    // Mask key
    Out.AppendByte(Mask[0]);
    Out.AppendByte(Mask[1]);
    Out.AppendByte(Mask[2]);
    Out.AppendByte(Mask[3]);

    // Masked payload
    if (Payload != none) {
        for (i = 0; i < Count; i++) {
            Out.AppendByte(byte(Payload.Get(Start + i) ^ Mask[i % 4]));
        }
    }
    return true;
}

// Applies (or removes) the mask in place: XOR with the 4-byte key is its
// own inverse. Mask is 4 bytes.
static function ApplyMask(TmByteBuffer Buf, int Offset, int Count, byte Mask[4]) {
    local int i;

    for (i = 0; i < Count; i++) {
        Buf.Set(Offset + i, byte(Buf.Get(Offset + i) ^ Mask[i % 4]));
    }
}
