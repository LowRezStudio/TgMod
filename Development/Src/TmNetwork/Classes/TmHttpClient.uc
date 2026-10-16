// HTTP/1.1 client facade: URL routing, one connection per exchange, and
// callback fan-out. Requests run one at a time; a second Request() while one
// is in flight is rejected. Every accepted request fires exactly one
// OnFinished delegate — on success with a populated response, on failure
// with bFailed=true and StatusCode=0. The delegate is always invoked
// asynchronously relative to the call that started the request.
//
// TLS: http:// only. https:// URLs fail with "TLS not supported" — the UE3
// TcpLink primitive is plaintext TCP, and no TLS layer exists in this
// engine build. See class TmUrl.
class TmHttpClient extends Object;

const DEFAULT_TIMEOUT_SECONDS = 10.0;

var TmTcpConnection Conn;
var Actor SpawnOwner;      // anchors spawned TmTcpConnection actors
var TmHttpRequest ActiveRequest;
var TmUrl PendingUrl;      // URL of the request awaiting connect completion
var string PendingMethod;
var TmHttpHeaders PendingHeaders;
var TmByteBuffer PendingBody;
var float TimeoutSeconds;

delegate OnFinished(TmHttpResponse Response);

function Setup(Actor InSpawnOwner, optional float InTimeoutSeconds = 10.0) {
    SpawnOwner = InSpawnOwner;
    TimeoutSeconds = InTimeoutSeconds;
}

// --- Public API ---

function bool Get(string URL, delegate<OnFinished> Callback) {
    return Request("GET", URL, none, none, Callback);
}

function bool Post(string URL, string Body, string ContentType, delegate<OnFinished> Callback) {
    return RequestWithBody("POST", URL, Body, ContentType, Callback);
}

function bool Put(string URL, string Body, string ContentType, delegate<OnFinished> Callback) {
    return RequestWithBody("PUT", URL, Body, ContentType, Callback);
}

function bool Delete(string URL, delegate<OnFinished> Callback) {
    return Request("DELETE", URL, none, none, Callback);
}

// Custom method with raw body (pass none/"" for none).
function bool RequestWithBody(string Method, string URL, string BodyText, string ContentType, delegate<OnFinished> Callback) {
    local TmByteBuffer BodyBytes;
    local TmHttpHeaders Headers;

    Headers = new class'TmHttpHeaders';
    if (Len(BodyText) > 0) {
        if (Len(ContentType) == 0) {
            ContentType = "application/octet-stream";
        }
        Headers.Set("Content-Type", ContentType);
        BodyBytes = new class'TmByteBuffer';
        BodyBytes.AppendString(BodyText);
    }
    return Request(Method, URL, Headers, BodyBytes, Callback);
}

// Full control variant. Headers/Body may be none; both are owned by the
// request after this call.
function bool Request(string Method, string URL, TmHttpHeaders Headers, TmByteBuffer Body, delegate<OnFinished> Callback) {
    local TmUrl U;

    if (ActiveRequest != none || PendingUrl != none) {
        `LogWarn('TmNetwork', "HTTP client: request already in flight");
        return false;
    }

    U = class'TmUrl'.static.FromString(URL);
    if (U == none) {
        FailWith(Callback, "Invalid URL: '" $ URL $ "'");
        return false;
    }
    if (U.IsTls()) {
        FailWith(Callback, "TLS not supported: '" $ URL $ "' (http:// and ws:// only)");
        return false;
    }
    if (SpawnOwner == none) {
        FailWith(Callback, "HTTP client not set up: call Setup(Actor) first");
        return false;
    }

    OnFinished = Callback;

    PendingUrl = U;
    PendingMethod = Method;
    PendingHeaders = Headers;
    PendingBody = Body;

    Conn = SpawnConnection(U);
    if (Conn == none) {
        ClearPending();
        FailWith(Callback, "Failed to spawn TCP connection actor");
        return false;
    }
    Conn.OnConnected = OnTransportConnected;
    Conn.OnError = OnTransportError;
    if (!Conn.Connect(U.Host, U.Port)) {
        // Connect() already fired OnError -> OnTransportError; that
        // path clears PendingUrl, so stop here either way.
        if (PendingUrl == none) {
            return false;
        }
        ClearPending();
        FailWith(Callback, "Connect call rejected");
        return false;
    }
    return true;
}

// --- Connection lifecycle ---

function TmTcpConnection SpawnConnection(TmUrl U) {
    local TmTcpConnection NewConn;

    // Objects can't Spawn actors; Setup() gave us an actor to anchor on.
    NewConn = SpawnOwner.Spawn(class'TmTcpConnection');
    if (NewConn != none) {
        NewConn.Setup();
    }
    return NewConn;
}

function OnTransportConnected() {
    StartRequest();
}

function OnTransportError(string Reason) {
    local delegate<OnFinished> Callback;

    Callback = OnFinished;
    ClearPending();
    if (Conn != none) {
        Conn.Disconnect();
        Conn = none;
    }
    if (Callback != none) {
        FailWith(Callback, Reason);
    }
}

function StartRequest() {
    local TmHttpRequest Req;
    local TmHttpHeaders Headers;
    local string ReqPath;
    local string ReqMethod;
    local TmByteBuffer ReqBody;

    if (PendingUrl == none) {
        return;
    }

    Req = new class'TmHttpRequest';
    ActiveRequest = Req;

    // Header defaults; caller values win because Set() replaces same-named
    // entries rather than stacking.
    Headers = PendingHeaders;
    if (Headers == none) {
        Headers = new class'TmHttpHeaders';
    }
    // Connection: close keeps the state machine simple and correct: bodies
    // without a length terminate on socket close, and every exchange gets a
    // clean teardown. Keep-alive can be revisited per-endpoint if needed.
    Headers.Set("Connection", "close");

    // Snapshot the pending state before clearing it; Req.Send can
    // synchronously fail and re-enter the client.
    ReqPath = PendingUrl.Path;
    ReqMethod = PendingMethod;
    ReqBody = PendingBody;
    PendingHeaders = none;
    PendingUrl = none;
    PendingMethod = "";
    PendingBody = none;

    Req.OnFinished = OnRequestFinished;
    if (!Req.Send(Conn, ReqMethod, ReqPath, Headers, ReqBody, TimeoutSeconds)) {
        // Req.Send already routed the failure through OnRequestFinished.
        ActiveRequest = none;
    }
}

function OnRequestFinished(TmHttpResponse Response) {
    ActiveRequest = none;
    // One connection per exchange: the request sent "Connection: close",
    // so drop the socket whatever the server did.
    if (Conn != none) {
        Conn.Disconnect();
        Conn = none;
    }
    OnFinished(Response);
}

// --- Helpers ---

function ClearPending() {
    PendingUrl = none;
    PendingMethod = "";
    PendingHeaders = none;
    PendingBody = none;
}

// Fires Callback with a fresh failed response. Usable on the early-exit
// paths (bad URL, no owner) before any instance state exists.
function FailWith(delegate<OnFinished> Callback, string Reason) {
    local TmHttpResponse Response;

    `LogWarn('TmNetwork', "HTTP: " $ Reason);
    Response = new class'TmHttpResponse';
    Response.Reset();
    Response.bFinished = true;
    Response.bFailed = true;
    Response.ErrorMessage = Reason;
    if (Callback != none) {
        Callback(Response);
    }
}
