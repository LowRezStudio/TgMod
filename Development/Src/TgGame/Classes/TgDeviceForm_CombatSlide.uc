class TgDeviceForm_CombatSlide extends TgDeviceForm
    config(Engine);

var () float m_fTransitionTime;

event StartFire(int nFireMode, optional float fRefireTime, optional Actor Target, optional int nAmmoRemaining) { }

event StopFire(int nFireModeNum) { }

defaultproperties
{
    m_fTransitionTime=0.1000000
    m_bLoopWhileFiringCameraAnim=true
}
