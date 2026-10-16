// Ordered HTTP header collection. Duplicate names are allowed (Set-Cookie),
// lookups are case-insensitive, serialization preserves insertion order.
class TmHttpHeaders extends Object;

const MAX_HEADERS = 64;

var array<string> Names;
var array<string> Values;

function Reset() {
    Names.Length = 0;
    Values.Length = 0;
}

function int Count() {
    return Names.Length;
}

// Adds without replacing existing entries with the same name.
function Add(string HeaderName, string Value) {
    if (Names.Length >= MAX_HEADERS) {
        `LogWarn('TmNetwork', "TmHttpHeaders: header limit reached, dropping '" $ HeaderName $ "'");
        return;
    }
    Names[Names.Length] = HeaderName;
    Values[Values.Length] = Value;
}

// Replaces the first entry with this name (case-insensitive) and drops any
// others; appends when absent.
function Set(string HeaderName, string Value) {
    local int i, Found;

    Found = -1;
    for (i = 0; i < Names.Length; i++) {
        if (Names[i] ~= HeaderName) {
            if (Found == -1) {
                Found = i;
                Values[i] = Value;
            } else {
                RemoveAt(i);
                i--;
            }
        }
    }
    if (Found == -1) {
        Add(HeaderName, Value);
    }
}

function Remove(string HeaderName) {
    local int i;

    for (i = 0; i < Names.Length; i++) {
        if (Names[i] ~= HeaderName) {
            RemoveAt(i);
            i--;
        }
    }
}

function RemoveAt(int Index) {
    local int i;

    // All internal callers pass indexes found by scanning Names, but guard
    // anyway: Names[i+1] on a bad index corrupts the arrays GC tracks.
    if (Index < 0 || Index >= Names.Length) {
        return;
    }
    for (i = Index; i < Names.Length - 1; i++) {
        Names[i] = Names[i + 1];
        Values[i] = Values[i + 1];
    }
    Names.Length = Names.Length - 1;
    Values.Length = Values.Length - 1;
}

// First value for HeaderName, or "" when absent. Case-insensitive.
function string Get(string HeaderName) {
    local int i;

    for (i = 0; i < Names.Length; i++) {
        if (Names[i] ~= HeaderName) {
            return Values[i];
        }
    }
    return "";
}

// True when HeaderName is present, even with an empty value.
function bool Has(string HeaderName) {
    local int i;

    for (i = 0; i < Names.Length; i++) {
        if (Names[i] ~= HeaderName) {
            return true;
        }
    }
    return false;
}

// Case-insensitive, comma-tolerant containment check for values like
// "Connection: keep-alive, Upgrade". Tokens are trimmed: servers commonly
// emit a space after the comma.
function bool ValueContains(string HeaderName, string Needle) {
    local string V;
    local int i, Start;

    V = Locs(Get(HeaderName));
    if (V == "") {
        return false;
    }
    Needle = Locs(Needle);
    Start = 0;
    for (i = 0; i <= Len(V); i++) {
        if (i == Len(V) || Mid(V, i, 1) == ",") {
            if (TrimToken(Mid(V, Start, i - Start)) == Needle) {
                return true;
            }
            Start = i + 1;
        }
    }
    return false;
}

static function string TrimToken(string S) {
    local int Start, End;

    Start = 0;
    End = Len(S) - 1;
    while (Start <= End && (Mid(S, Start, 1) == " " || Mid(S, Start, 1) == Chr(9))) {
        Start++;
    }
    while (End >= Start && (Mid(S, End, 1) == " " || Mid(S, End, 1) == Chr(9))) {
        End--;
    }
    return Mid(S, Start, End - Start + 1);
}

// Copies all entries from Other, replacing same-named entries.
function CopyFrom(TmHttpHeaders Other) {
    local int i;

    Reset();
    if (Other == none) {
        return;
    }
    for (i = 0; i < Other.Names.Length; i++) {
        Add(Other.Names[i], Other.Values[i]);
    }
}
