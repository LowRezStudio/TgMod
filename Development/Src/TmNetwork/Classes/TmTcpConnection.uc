// TCP client transport over the engine's TcpLink.
//
// One connection = one spawned TcpLink actor (this class). Everything above
// (HTTP, WebSocket) talks to this: Connect/Close + byte callbacks. Binary
// mode with event receive; bytes land in a TmByteBuffer and are handed to
// OnReceive, which may pull them out incrementally.
//
// Byte[255] static arrays are the only binary the native side passes, so
// ReceivedBinary feeds the buffer in <=255-byte chunks.
class TmTcpConnection extends TcpLink
    transient;

enum ETcpState {
    TCPS_Idle,
    TCPS_Resolving,
    TCPS_Connecting,
    TCPS_Connected,
    TCPS_Closed
};

var ETcpState ConnState;
var string PendingHost;
var int PendingPort;
var string HostHeader;    // "Host:" value for the layers above (host[:port])
var TmByteBuffer RecvBuffer;
var float DeadlineTime;   // WorldInfo.TimeSeconds deadline; 0 = none
var bool bDestroyPending; // ScheduleDestroy fired; native callbacks must no-op

// Owned by the higher-level client; fired on the TcpLink's thread of execution.
delegate OnConnected();
delegate OnReceive(TmByteBuffer Bytes);
delegate OnClosed(bool bWasClean, string Reason);
delegate OnError(string Reason);

function bool Setup() {
    LinkMode = MODE_Binary;
    ReceiveMode = RMODE_Event;
    InLineMode = LMODE_auto;
    OutLineMode = LMODE_DOS;
    bDestroyPending = false;
    ClearTimer('TimerDestroy');
    if (RecvBuffer == none) {
        RecvBuffer = new class'TmByteBuffer';
    }
    RecvBuffer.Reset();
    return true;
}

// Dotted-quad or resolvable hostname + port. Async: result arrives via
// OnConnected/OnError. Returns false on immediate argument rejection.
function bool Connect(string Host, int RemotePort) {
    local IpAddr Addr;

    if (bDestroyPending) {
        return false; // actor is draining; owner must spawn a fresh connection
    }
    if (ConnState == TCPS_Resolving || ConnState == TCPS_Connecting || ConnState == TCPS_Connected) {
        FireError("Connect: connection already active");
        return false;
    }
    if (Len(Host) == 0 || RemotePort <= 0 || RemotePort > 65535) {
        FireError("Connect: bad host or port");
        return false;
    }

    PendingHost = Host;
    PendingPort = RemotePort;
    HostHeader = Host;
    if (RemotePort != 80) {
        HostHeader = Host $ ":" $ string(RemotePort);
    }

    // Numeric addresses skip the async resolver entirely.
    if (StringToIpAddr(Host, Addr)) {
        BeginOpen(Addr);
        return true;
    }

    ConnState = TCPS_Resolving;
    Resolve(Host);
    return true;
}

function BeginOpen(IpAddr Addr) {
    Addr.Port = PendingPort;
    ConnState = TCPS_Connecting;
    if (!Open(Addr)) {
        ConnState = TCPS_Idle;
        FireError("Connect: Open failed (" $ string(GetLastError()) $ ")");
    }
}

// Close and schedule destroy. In-flight buffered bytes are discarded.
//
// The destroy is deferred through a one-shot timer instead of running
// synchronously: Disconnect is routinely reached from inside native
// callbacks (ReceivedBinary -> owner -> Fail -> Disconnect, Tick timeout,
// Closed event), and destroying the TcpLink actor while the native side is
// still inside its callback corrupts the object GC is tracking (delayed
// Array.h assertion / "Crashed during garbage collection" on Transient).
// Engine precedent: WebConnection defers teardown via Timer/bDelayCleanup
// and only destroys from the Closed event.
function Disconnect() {
    ConnState = TCPS_Closed;
    DeadlineTime = 0.0;
    if (LinkState == STATE_Connected || LinkState == STATE_Connecting
        || LinkState == STATE_ConnectClosePending || LinkState == STATE_ConnectClosing) {
        Close();
    }
    ScheduleDestroy();
}

// Idempotent: safe to call from re-entrant paths (Tick timeout fires
// OnError, whose handler may already have called Disconnect).
function ScheduleDestroy() {
    if (bDestroyPending) {
        return;
    }
    bDestroyPending = true;
    SetTimer(0.05, false, 'TimerDestroy');
}

function TimerDestroy() {
    Destroy();
}

// Engine events

event Opened() {
    if (bDestroyPending) {
        return;
    }
    ConnState = TCPS_Connected;
    OnConnected();
    // The owner may have synchronously disconnected inside OnConnected
    // (e.g. immediate failure); the teardown is already scheduled.
}

event Closed() {
    local bool bWasConnected;

    if (bDestroyPending) {
        return;
    }
    bWasConnected = (ConnState == TCPS_Connected);
    ConnState = TCPS_Closed;
    // Engine-side close while we still expected data is reported as an
    // unclean close; higher layers decide whether that's an error.
    OnClosed(bWasConnected, "ConnectionClosed");
    // Owner cleanup runs inside OnClosed (it calls Disconnect); schedule the
    // destroy out of the native callback instead of destroying here.
    ScheduleDestroy();
}

event ReceivedBinary(int Count, byte B[255]) {
    if (bDestroyPending) {
        return;
    }
    if (Count <= 0) {
        return;
    }
    if (!RecvBuffer.Reserve(Count)) {
        FireError("Receive buffer overflow");
        Disconnect();
        return;
    }
    RecvBuffer.AppendBytes(B, Count);
    // Hand the whole buffered remainder to the owner; it consumes what its
    // parser accepts. (AppendBytes only grew the tail; nothing to trim.)
    // The owner may disconnect synchronously (parse failure) — after this
    // returns, touch no member state; ScheduleDestroy already ran.
    OnReceive(RecvBuffer);
}

event ResolveFailed() {
    if (bDestroyPending) {
        return;
    }
    ConnState = TCPS_Idle;
    FireError("Connect: DNS resolution failed for '" $ PendingHost $ "'");
}

// Deadline watchdog for the layers above. An Object can't SetTimer, so the
// HTTP/WS clients stamp DeadlineTime and this actor checks it per tick.
event Tick(float DeltaTime) {
    if (bDestroyPending) {
        return;
    }
    if (DeadlineTime > 0.0 && WorldInfo != none
        && WorldInfo.TimeSeconds >= DeadlineTime) {
        DeadlineTime = 0.0;
        FireError("Operation timed out");
        Disconnect();
    }
}

// Arms the watchdog; 0 clears it. Ignored once teardown is scheduled.
function SetDeadline(float SecondsFromNow) {
    if (bDestroyPending) {
        return;
    }
    if (SecondsFromNow <= 0.0 || WorldInfo == none) {
        DeadlineTime = 0.0;
        return;
    }
    DeadlineTime = WorldInfo.TimeSeconds + SecondsFromNow;
}

event Resolved(IpAddr Addr) {
    if (bDestroyPending) {
        return;
    }
    if (ConnState != TCPS_Resolving) {
        return; // stale callback after an abort
    }
    BeginOpen(Addr);
}

// Helpers

function FireError(string Reason) {
    `LogWarn('TmNetwork', Reason);
    OnError(Reason);
}

defaultproperties
{
}
