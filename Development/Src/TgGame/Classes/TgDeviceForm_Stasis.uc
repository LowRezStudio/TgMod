class TgDeviceForm_Stasis extends TgDeviceForm
    native(ChampEvie)
    config(Engine);

var bool m_bNeedsLoopActivation;
var float m_fFireStartTime;
var float m_fLoopDelay;

event StartFire(int nFireMode, optional float fRefireTime, optional Actor Target, optional int nAmmoRemaining) { }

event StopFire(int nFireModeNum) { }

defaultproperties
{
    m_fLoopDelay=0.2800000
}
