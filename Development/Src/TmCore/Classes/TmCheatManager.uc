class TmCheatManager extends TgBattleCheatManager within TgPlayerController
    config(Game);

var TmProxyActor Proxy;

function TmProxyActor GetProxy() {
    local TmProxyActor PA;

    if (Proxy != none) {
        return Proxy;
    }

    foreach Outer.AllActors(class'TmCore.TmProxyActor', PA) {
        if (PA.Owner == Outer) {
            Proxy = PA;
            return PA;
        }
    }
    return none;
}

exec function GMCommand(string command) {
    if (GetProxy() != none) {
        GetProxy().ServerVerifyVehiclePhys(command);
    }
}