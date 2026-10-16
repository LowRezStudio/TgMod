// Growable byte buffer built on array<byte>.
//
// UnrealScript has no dynamic byte[] parameter passing (only byte[255]
// static arrays), so everything that accumulates raw bytes — TCP receive,
// frame reassembly, hashing — funnels through here. Growth is amortized;
// a hard byte cap fails cleanly instead of ballooning memory in-game.
//
// Receive contract: TmTcpConnection passes its buffer to the owner's
// OnReceive; the owner parses incrementally and Consume()s what it accepts.
// Unparsed bytes stay put until the next receive appends behind them.
class TmByteBuffer extends Object;

const MAX_BUFFER_BYTES = 1048576; // 1 MB hard cap for any single buffer

var array<byte> Data;
var int Length;

function Reset() {
    // Keep the allocation; drop the count so we don't churn allocations on
    // every message. Callers that want memory back call Shrink().
    Length = 0;
}

function Shrink() {
    Data.Length = 0;
    Length = 0;
}

// Grow Data to hold at least Length + Extra bytes, enforcing the cap.
// Returns false when the request would exceed MAX_BUFFER_BYTES.
function bool Reserve(int Extra) {
    local int NewLen;

    if (Extra < 0) {
        return false;
    }
    if (Length + Extra > MAX_BUFFER_BYTES) {
        return false;
    }
    NewLen = Length + Extra;
    if (NewLen > Data.Length) {
        NewLen = NewLen + NewLen / 4; // +25% headroom
        if (NewLen > MAX_BUFFER_BYTES) {
            NewLen = MAX_BUFFER_BYTES;
        }
        Data.Length = NewLen;
    }
    return true;
}

function AppendByte(byte B) {
    if (!Reserve(1)) {
        return;
    }
    Data[Length] = B;
    Length++;
}

// Append from a native-style static array (TcpLink's byte[255] world).
function AppendBytes(byte B[255], int Count) {
    local int i;

    if (Count <= 0 || Count > 255) {
        return;
    }
    if (!Reserve(Count)) {
        return;
    }
    for (i = 0; i < Count; i++) {
        Data[Length + i] = B[i];
    }
    Length += Count;
}

// Moves Other's contents onto the tail and resets Other for reuse.
// Fails (leaves both untouched) when the combined size would exceed the cap.
function bool AppendBuffer(TmByteBuffer Other) {
    local int i;

    if (Other == none || Other.Length == 0) {
        return true;
    }
    if (!Reserve(Other.Length)) {
        return false;
    }
    for (i = 0; i < Other.Length; i++) {
        Data[Length + i] = Other.Data[i];
    }
    Length += Other.Length;
    Other.Reset();
    return true;
}

// Copies Count bytes from Src at SrcOffset onto the tail.
function bool AppendRange(TmByteBuffer Src, int SrcOffset, int Count) {
    local int i;

    if (Src == none || Count < 0 || SrcOffset < 0 || SrcOffset + Count > Src.Length) {
        return false;
    }
    if (!Reserve(Count)) {
        return false;
    }
    for (i = 0; i < Count; i++) {
        Data[Length + i] = Src.Data[SrcOffset + i];
    }
    Length += Count;
    return true;
}

// Appends the low 8 bits of each character. Non-ASCII input is a caller
// contract violation; only the byte-transparent paths may widen strings.
function AppendString(coerce string S) {
    local int i, Count;

    Count = Len(S);
    if (!Reserve(Count)) {
        return;
    }
    for (i = 0; i < Count; i++) {
        Data[Length + i] = byte(Asc(Mid(S, i, 1)));
    }
    Length += Count;
}

// Drops the first Count bytes by copying the tail down. O(n) over the
// residual bytes only, which stays at most one protocol unit in practice.
function Consume(int Count) {
    local int i;

    if (Count <= 0) {
        return;
    }
    if (Count >= Length) {
        Reset();
        return;
    }
    for (i = 0; i < Length - Count; i++) {
        Data[i] = Data[Count + i];
    }
    Length -= Count;
}

// First index of B at or after Start; -1 when absent.
function int IndexOf(byte B, optional int Start) {
    local int i;

    if (Start < 0) {
        Start = 0;
    }
    for (i = Start; i < Length; i++) {
        if (Data[i] == B) {
            return i;
        }
    }
    return -1;
}

function byte Get(int Index) {
    if (Index < 0 || Index >= Length) {
        return 0;
    }
    return Data[Index];
}

function Set(int Index, byte B) {
    if (Index < 0 || Index >= Length) {
        return;
    }
    Data[Index] = B;
}

// Bytes -> string, one Chr() per byte (Latin-1 style widening). Only for
// protocol text known to be ASCII; body bytes keep their raw form in Data.
function string ToStringAt(int Offset, int Count) {
    local string S;
    local int i;

    if (Offset < 0 || Offset + Count > Length) {
        return "";
    }
    S = "";
    for (i = 0; i < Count; i++) {
        S = S $ Chr(Data[Offset + i]);
    }
    return S;
}

// Copies up to MaxCount (default 255) bytes into a native static array.
function int ToStaticBytes(out byte B[255], optional int MaxCount) {
    return CopyToStatic(0, B, MaxCount);
}

// Copies up to MaxCount (default 255) bytes starting at Offset into a
// native static array. Returns the number of bytes copied. Offsets outside
// [0, Length] yield 0: a negative or past-end index must never reach the
// array access below (engine Array.h assertion i>=0 && i<ArrayNum).
function int CopyToStatic(int Offset, out byte B[255], optional int MaxCount) {
    local int i, Count;

    if (Offset < 0 || Offset > Length) {
        return 0;
    }
    Count = Length - Offset;
    if (Count > 255) {
        Count = 255;
    }
    if (MaxCount > 0 && Count > MaxCount) {
        Count = MaxCount;
    }
    for (i = 0; i < Count; i++) {
        B[i] = Data[Offset + i];
    }
    return Count;
}

defaultproperties
{
}
