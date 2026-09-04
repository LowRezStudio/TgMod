class TmCheatManager extends TgBattleCheatManager within TgPlayerController
    config(Game);

// The proxy registers itself here when it installs this cheat manager
// (TmProxyActor.ClientAddCheats); no scanning needed.
var TmProxyActor Proxy;

exec function tempest(string command) {
    if (Proxy != none)
        Proxy.SendGM(command);
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
        Proxy.SendGM("tedbn"@sDeviceName@nEquipPointId@FireMode);
}

exec function EDBN(string sDeviceName, int nEquipPointId, optional int FireMode = 1)
{
    if (Proxy != none)
        Proxy.SendGM("edbn"@sDeviceName@nEquipPointId@FireMode);
}
