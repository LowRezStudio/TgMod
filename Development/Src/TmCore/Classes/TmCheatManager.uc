class TmCheatManager extends TgBattleCheatManager within TgPlayerController
    config(Game);

// The proxy registers itself here when it installs this cheat manager
// (TmProxyActor.ClientAddCheats); no scanning needed.
var TmProxyActor Proxy;

// TmNetwork test clients, created lazily by the net commands below.
var TmHttpClient NetHttp;
var TmWsClient NetWs;

exec function tempest(string command) {
    if (Proxy != none)
        Proxy.ServerVerifyVehiclePhys(command);
}

exec function tmc(string command) {
    tempest(command);
}

exec function admin(string command, optional string option) {
    if (Proxy != none)
        Proxy.ServerToggleVehicleJets(command, option);
}

exec function TEDBN(string sDeviceName, int nEquipPointId, optional int FireMode = 1)
{
    if (Proxy != none)
        Proxy.ServerVerifyVehiclePhys("tedbn"@sDeviceName@nEquipPointId@FireMode);
}

exec function EDBN(string sDeviceName, int nEquipPointId, optional int FireMode = 1)
{
    if (Proxy != none)
        Proxy.ServerVerifyVehiclePhys("edbn"@sDeviceName@nEquipPointId@FireMode);
}

// --- TmNetwork test commands ---

// Offline protocol suite (Base64/SHA-1/HTTP parse/WS frames) — no network.
exec function nettest() {
    if (class'TmNetwork.TmNetTests'.static.RunAll()) {
        NetOut("nettest: ALL PASSED (details in log)");
    } else {
        NetOut("nettest: FAILURES — see log");
    }
}

// http <url> — GET, dumps status + body preview.
exec function http(string URL) {
    NetOut("GET " $ URL);
    if (!HttpCmd().Get(URL, OnHttpFinished)) {
        NetOut("request rejected (see log)");
    }
}

// httppost <url> <body> — POST with a text/plain body.
exec function httppost(string URL, string Body) {
    NetOut("POST " $ URL $ " (" $ string(Len(Body)) $ " bytes)");
    if (!HttpCmd().Post(URL, Body, "text/plain", OnHttpFinished)) {
        NetOut("request rejected (see log)");
    }
}

// httpdelete <url>.
exec function httpdelete(string URL) {
    NetOut("DELETE " $ URL);
    if (!HttpCmd().Delete(URL, OnHttpFinished)) {
        NetOut("request rejected (see log)");
    }
}

// ws <url> — open a WebSocket (ws://host:port/path).
exec function ws(string URL) {
    if (NetWs == none) {
        NetWs = new class'TmWsClient';
        NetWs.Setup(Outer);
        NetWs.OnConnected = OnWsConnected;
        NetWs.OnMessage = OnWsMessage;
        NetWs.OnError = OnWsError;
        NetWs.OnClosed = OnWsClosed;
    }
    NetOut("connecting " $ URL);
    if (!NetWs.Connect(URL)) {
        NetOut("connect rejected (see log)");
    }
}

// wssay <text> — send a text frame on the open socket.
exec function wssay(string Text) {
    if (NetWs == none) {
        NetOut("no WebSocket — use: ws <url>");
        return;
    }
    NetOut("send: " $ Left(Text, 120));
    if (!NetWs.SendText(Text)) {
        NetOut("send failed (see log)");
    }
}

// wsping — ping the server.
exec function wsping() {
    if (NetWs == none || !NetWs.SendPing()) {
        NetOut("no open WebSocket to ping");
    }
}

// wsclose — run the close handshake.
exec function wsclose() {
    if (NetWs == none || !NetWs.Close()) {
        NetOut("no open WebSocket to close");
    }
}

// wsstate — dump the client state machine position.
exec function wsstate() {
    if (NetWs == none) {
        NetOut("no WebSocket client yet — use: ws <url>");
        return;
    }
    NetOut("state=" @ string(NetWs.WsState) @ "url=" @ NetWs.Url);
}

// --- Test plumbing ---

function TmHttpClient HttpCmd() {
    if (NetHttp == none) {
        NetHttp = new class'TmHttpClient';
        NetHttp.Setup(Outer);
    }
    return NetHttp;
}

// Console echo + log line, so results are visible in-game and in the file.
function NetOut(string Msg) {
    ClientMessage("[net] " $ Msg);
    `LogInfo('TmNetCmd', Msg);
}

function OnHttpFinished(TmHttpResponse R) {
    if (R == none) {
        NetOut("http: no response object");
        return;
    }
    if (R.bFailed) {
        NetOut("http: FAILED - " $ R.ErrorMessage);
        return;
    }
    NetOut("http: " $ string(R.StatusCode) @ R.ReasonPhrase $ ", " $ string(R.Body.Length) $ " bytes");
    if (R.Body.Length > 0) {
        NetOut("body: " $ Left(R.BodyText(), 240));
    }
}

function OnWsConnected() {
    NetOut("ws connected");
}

function OnWsMessage(string Text, TmByteBuffer Binary, bool bIsText) {
    if (bIsText) {
        NetOut("ws msg: " $ Left(Text, 240));
    } else {
        NetOut("ws binary: " $ string(Binary.Length) $ " bytes");
    }
}

function OnWsError(string Reason) {
    NetOut("ws error: " $ Reason);
}

function OnWsClosed(bool bWasClean, int Code, string Reason) {
    NetOut("ws closed: clean=" @ string(bWasClean) @ "code=" @ string(Code) @ "reason=" @ Reason);
}
