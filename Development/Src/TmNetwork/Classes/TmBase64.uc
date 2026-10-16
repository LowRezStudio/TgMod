// Base64 (RFC 4648) in pure UnrealScript, over TmByteBuffer.
//
// Used for the WebSocket handshake key and Sec-WebSocket-Accept comparison.
// Decoder is strict: rejects characters outside the alphabet, misplaced '='
// padding, and non-multiple-of-4 input lengths.
class TmBase64 extends Object;

var const string Alphabet;

defaultproperties
{
    Alphabet="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
}

// Encode the whole buffer into Out. Returns false on missing input.
static function bool Encode(TmByteBuffer Input, out string Out) {
    local int i;
    local int B0, B1, B2;

    Out = "";
    if (Input == none) {
        return false;
    }

    i = 0;
    while (i + 2 < Input.Length) {
        B0 = Input.Data[i];
        B1 = Input.Data[i + 1];
        B2 = Input.Data[i + 2];
        Out = Out $ Sextet(B0 >> 2);
        Out = Out $ Sextet((B0 & 3) << 4 | (B1 >> 4));
        Out = Out $ Sextet((B1 & 15) << 2 | (B2 >> 6));
        Out = Out $ Sextet(B2 & 63);
        i += 3;
    }
    if (i < Input.Length) {
        B0 = Input.Data[i];
        if (i + 1 < Input.Length) {
            B1 = Input.Data[i + 1];
            Out = Out $ Sextet(B0 >> 2);
            Out = Out $ Sextet((B0 & 3) << 4 | (B1 >> 4));
            Out = Out $ Sextet((B1 & 15) << 2);
            Out = Out $ "=";
        } else {
            Out = Out $ Sextet(B0 >> 2);
            Out = Out $ Sextet((B0 & 3) << 4);
            Out = Out $ "==";
        }
    }
    return true;
}

// One base64 digit. Sextet must be 0..63.
static function string Sextet(int V) {
    return Mid(default.Alphabet, V & 63, 1);
}

// Alphabet lookup; -1 when C is not a valid base64 character.
static function int SextetIndex(string C) {
    local int i;

    for (i = 0; i < 64; i++) {
        if (Mid(default.Alphabet, i, 1) == C) {
            return i;
        }
    }
    return -1;
}

// Decode In into Out. Strict per RFC 4648: length must be a multiple of 4,
// '=' only in the last one or two positions, nothing after padding.
static function bool Decode(string In, TmByteBuffer Out) {
    local int i, Len;
    local int S0, S1, S2, S3;
    local bool Padded;

    if (Out == none) {
        return false;
    }
    Out.Reset();

    Len = Len_(In);
    if (Len == 0) {
        return true;
    }
    if (Len % 4 != 0) {
        return false;
    }

    i = 0;
    while (i < Len) {
        S0 = SextetIndex(Mid(In, i, 1));
        S1 = SextetIndex(Mid(In, i + 1, 1));
        S2 = SextetIndex(Mid(In, i + 2, 1));
        S3 = SextetIndex(Mid(In, i + 3, 1));

        if (S0 < 0 || S1 < 0) {
            return false;
        }
        // '=' is only legal in the final group, positions 3 and/or 2.
        if (IsPad(Mid(In, i, 1)) || IsPad(Mid(In, i + 1, 1))) {
            return false;
        }
        Padded = IsPad(Mid(In, i + 2, 1)) || IsPad(Mid(In, i + 3, 1));
        if (Padded && i + 4 != Len) {
            return false;
        }

        if (Mid(In, i + 2, 1) == "=" && Mid(In, i + 3, 1) == "=") {
            // one byte from two sextets
            Out.AppendByte(byte(S0 << 2 | S1 >> 4));
            return true;
        }
        if (Mid(In, i + 3, 1) == "=") {
            // two bytes from three sextets
            if (S2 < 0) {
                return false;
            }
            Out.AppendByte(byte(S0 << 2 | S1 >> 4));
            Out.AppendByte(byte((S1 & 15) << 4 | S2 >> 2));
            return true;
        }

        if (S2 < 0 || S3 < 0) {
            return false;
        }
        Out.AppendByte(byte(S0 << 2 | S1 >> 4));
        Out.AppendByte(byte((S1 & 15) << 4 | S2 >> 2));
        Out.AppendByte(byte((S2 & 3) << 6 | S3));
        i += 4;
    }
    return true;
}

static function bool IsPad(string C) {
    return C == "=";
}

// Local alias so the class's own Len doesn't collide with the global Len().
static function int Len_(string S) {
    return Len(S);
}
