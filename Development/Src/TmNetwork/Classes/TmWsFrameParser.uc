// Incremental RFC 6455 frame parser for the client endpoint.
//
// State persists across feeds: frames split across receives, and multiple
// frames per receive, both work. Call Advance in a loop over the
// accumulating connection buffer:
//
//   Offset = 0
//   while ((Res = Parser.Advance(Buf, Offset)) == RES_FRAME):
//       HandleFrame(Buf, Offset)   // Parser.* describes the frame
//       Offset += Parser.TotalLen
//
// Masking direction (RFC 6455 5.1): client->server frames are masked,
// server->client frames are NOT. We are the client, so an inbound masked
// frame is a protocol violation; inbound payloads need no unmasking.
class TmWsFrameParser extends Object;

// Advance() outcomes
const RES_NEED_MORE = 0;
const RES_FRAME = 1;
const RES_ERROR = 2;

var int LastResult;
var string ErrorMessage;

// Valid after RES_FRAME:
var bool bFin;
var int Opcode;
var int PayloadOffset;  // absolute index of payload start in Buf
var int PayloadLen;
var int TotalLen;       // header + payload bytes consumed by this frame

// Parser state across Advance() calls
var int Step;           // 0=header, 1=len16, 2=len64, 3=payload wait
var bool bMasked;
var int Len7;
var int LongLen;        // extended length (fits int; see step 2)
var int HeaderLen;

var int MaxFramePayload;

function Reset() {
    Step = 0;
    bMasked = false;
    Len7 = 0;
    LongLen = 0;
    HeaderLen = 0;
    LastResult = RES_NEED_MORE;
    ErrorMessage = "";
    PayloadOffset = 0;
    PayloadLen = 0;
    TotalLen = 0;
}

function int Advance(TmByteBuffer Buf, int Offset) {
    local int B0, B1;

    // --- Step 0: fixed 2-byte header ---
    if (Step == 0) {
        if (Buf.Length - Offset < 2) {
            return NeedMore();
        }
        B0 = int(Buf.Data[Offset]);
        B1 = int(Buf.Data[Offset + 1]);

        if ((B0 & 0x70) != 0) {
            return Error("Frame has RSV bits set but no extension was negotiated");
        }
        bFin = (B0 & 0x80) != 0;
        Opcode = B0 & 0x0F;
        // RFC 6455 5.2: opcodes 3-7 and 11-15 are reserved; receiving them
        // is a protocol error, not something to ignore.
        if ((Opcode >= 3 && Opcode <= 7) || Opcode >= 11) {
            return Error("Unknown opcode " $ string(Opcode));
        }
        Len7 = B1 & 0x7F;
        bMasked = (B1 & 0x80) != 0;
        HeaderLen = 2;

        if (Len7 == 126) {
            Step = 1;
        } else if (Len7 == 127) {
            Step = 2;
        } else {
            LongLen = Len7;
            Step = 3;
        }
    }

    // --- Step 1: 16-bit extended length ---
    if (Step == 1) {
        if (Buf.Length - Offset < HeaderLen + 2) {
            return NeedMore();
        }
        LongLen = (int(Buf.Data[Offset + 2]) << 8) | int(Buf.Data[Offset + 3]);
        if (LongLen < 126) {
            return Error("Non-minimal 16-bit length encoding");
        }
        HeaderLen = 4;
        Step = 3;
    }

    // --- Step 2: 64-bit extended length ---
    if (Step == 2) {
        if (Buf.Length - Offset < HeaderLen + 8) {
            return NeedMore();
        }
        // The top four length bytes must be zero: anything >= 2^31 exceeds
        // both the int range and every buffer cap in this library.
        if (Buf.Data[Offset + 2] != 0 || Buf.Data[Offset + 3] != 0
            || Buf.Data[Offset + 4] != 0 || Buf.Data[Offset + 5] != 0) {
            return Error("Frame length exceeds 2^31 (unsupported)");
        }
        LongLen = (int(Buf.Data[Offset + 6]) << 24)
                | (int(Buf.Data[Offset + 7]) << 16)
                | (int(Buf.Data[Offset + 8]) << 8)
                | int(Buf.Data[Offset + 9]);
        if (LongLen < 0) {
            return Error("Frame length exceeds 2^31 (unsupported)");
        }
        if (LongLen < 65536) {
            return Error("Non-minimal 64-bit length encoding");
        }
        HeaderLen = 10;
        Step = 3;
    }

    // --- Step 3: finalize header, wait for payload ---
    if (Step == 3) {
        // RFC 6455 5.1: server-to-client frames MUST NOT be masked.
        if (bMasked) {
            return Error("Inbound frame is masked (server-to-client frames must not be)");
        }
        if (LongLen > MaxFramePayload) {
            return Error("Frame payload " $ string(LongLen) $ " exceeds limit " $ string(MaxFramePayload));
        }
        PayloadLen = LongLen;
        PayloadOffset = Offset + HeaderLen;
        TotalLen = HeaderLen + PayloadLen;
        Step = 4;
    }

    // --- Step 4: wait until the full payload has arrived ---
    if (Step == 4) {
        if (Buf.Length - PayloadOffset < PayloadLen) {
            return NeedMore();
        }
        Step = 0; // ready for the next frame
        LastResult = RES_FRAME;
        return RES_FRAME;
    }

    // Unreachable.
    return Error("Frame parser in invalid state");
}

function int NeedMore() {
    LastResult = RES_NEED_MORE;
    return RES_NEED_MORE;
}

function int Error(string Reason) {
    LastResult = RES_ERROR;
    ErrorMessage = Reason;
    return RES_ERROR;
}

function bool IsError() {
    return LastResult == RES_ERROR;
}

defaultproperties
{
    MaxFramePayload=786432
}
