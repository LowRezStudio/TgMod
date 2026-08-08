class TgDeviceForm_Hustle extends TgDeviceForm
    config(Engine);

event StartFire(int nFireMode, optional float fRefireTime, optional Actor Target, optional int nAmmoRemaining) { }

event StopFire(int nFireModeNum) { }

defaultproperties
{
    m_bLoopWhileFiringCameraAnim=true
    m_fWhileFiringCameraAnimBlendOutTime=0.1500000
}
