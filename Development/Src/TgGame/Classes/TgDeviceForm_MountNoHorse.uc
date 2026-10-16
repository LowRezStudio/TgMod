class TgDeviceForm_MountNoHorse extends TgDeviceForm_Mount
    config(Engine);

var int c_SparkleFXID;
var TgSpecialFx c_SparkleFX;

event StartFire(int nFireMode, optional float fRefireTime, optional Actor Target, optional int nAmmoRemaining) { }

event StopFire(int nFireModeNum) { }

simulated event string GetAnimSetStringForBot(int PlayerBotId) { }

defaultproperties
{
    c_SparkleFXID=7197
}
