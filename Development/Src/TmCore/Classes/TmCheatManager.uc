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

exec function tempest(string command) {
    if (GetProxy() != none) {
        GetProxy().ServerVerifyVehiclePhys(command);
    }
}

exec function tmc(string command) {
    tempest(command);
}

exec function admin(string command, optional string option) {
    if (GetProxy() != none) {
        GetProxy().ServerToggleVehicleJets(command, option);
    }
}

exec function TEDBN(string sDeviceName, int nEquipPointId, optional int FireMode = 1)
{
    if (GetProxy() != none) {
        GetProxy().ServerVerifyVehiclePhys("tedbn"@sDeviceName@nEquipPointId@FireMode);
    }
}

exec function EDBN(string sDeviceName, int nEquipPointId, optional int FireMode = 1)
{
    if (GetProxy() != none) {
        GetProxy().ServerVerifyVehiclePhys("edbn"@sDeviceName@nEquipPointId@FireMode);
    }
}