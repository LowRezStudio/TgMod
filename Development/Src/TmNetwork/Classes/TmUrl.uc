// Minimal URL parser: scheme://host[:port][/path][?query][#fragment].
// No percent-encoding normalization; whatever is in the string is what gets
// sent. IPv6 literals are not supported (brackets break port parsing).
// Only http/ws are usable; https/wss fail at connect time with an explicit
// "TLS not supported" error.
class TmUrl extends Object;

var string Scheme;  // "http" | "https" | "ws" | "wss"
var string Host;    // hostname or dotted quad, no brackets
var int Port;       // resolved port (explicit or scheme default)
var string Path;    // path+query, always starts with "/"

function bool Parse(string Text) {
    local string Rest;
    local int Slash, Colon;

    Scheme = "";
    Host = "";
    Port = 0;
    Path = "/";

    Rest = Text;

    // scheme
    if (InStr(Rest, "://") != -1) {
        Scheme = Locs(Left(Rest, InStr(Rest, "://")));
        Rest = Mid(Rest, InStr(Rest, "://") + 3);
    } else {
        Scheme = "http";
    }

    // fragment — not sent to servers
    if (InStr(Rest, "#") != -1) {
        Rest = Left(Rest, InStr(Rest, "#"));
    }

    // host[:port][/path...][?query]
    Slash = InStr(Rest, "/");
    if (Slash == -1) {
        // No path: everything up to a query marker is the authority.
        Colon = InStr(Rest, "?");
        if (Colon != -1) {
            if (!ParseAuthority(Left(Rest, Colon))) {
                return false;
            }
            Path = "/?" $ Mid(Rest, Colon + 1);
            return Finish();
        }
        if (!ParseAuthority(Rest)) {
            return false;
        }
        Path = "/";
        return Finish();
    }

    if (!ParseAuthority(Left(Rest, Slash))) {
        return false;
    }
    Path = Mid(Rest, Slash);
    return Finish();
}

// Splits host:port out of the authority section (no user:pass support —
// nothing here needs it and credentials in URLs would log badly).
function bool ParseAuthority(string Authority) {
    local int Colon;

    Colon = InStr(Authority, ":");
    if (Colon == -1) {
        Host = Authority;
        return Len(Host) > 0;
    }
    Host = Left(Authority, Colon);
    Port = int(Mid(Authority, Colon + 1));
    return Len(Host) > 0 && Port > 0 && Port <= 65535;
}

// Applies scheme defaults and rejects TLS schemes explicitly.
function bool Finish() {
    if (Scheme == "https" || Scheme == "wss") {
        // Allowed to parse; transport refuses it with a clear error so
        // callers see "TLS unsupported" instead of "host not found".
        Port = 443;
        return true;
    }
    if (Scheme == "ws") {
        if (Port == 0) {
            Port = 80;
        }
        return true;
    }
    if (Scheme == "http") {
        if (Port == 0) {
            Port = 80;
        }
        return true;
    }
    return false;
}

static function TmUrl FromString(string Text) {
    local TmUrl U;

    U = new class'TmUrl';
    if (!U.Parse(Text)) {
        return none;
    }
    return U;
}

// True when the scheme needs TLS (transport rejects these).
function bool IsTls() {
    return Scheme == "https" || Scheme == "wss";
}
