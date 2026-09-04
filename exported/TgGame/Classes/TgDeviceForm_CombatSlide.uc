class TgDeviceForm_CombatSlide extends TgDeviceForm;

var() float m_fTransitionTime;

event StartFire(int nFireMode, optional float fRefireTime, optional Actor Target, optional int nAmmoRemaining)
{
    super.StartFire(nFireMode, fRefireTime, Target, nAmmoRemaining);
    PlayToggleTransitionAnimations(0.0000000, m_fTransitionTime, true);
    //return;    
}

event StopFire(int nFireModeNum)
{
    super.StopFire(nFireModeNum);
    PlayToggleTransitionAnimations(0.0000000, m_fTransitionTime, false);
    //return;    
}

defaultproperties
{
    m_fTransitionTime=0.1000000
    m_bLoopWhileFiringCameraAnim=true
}