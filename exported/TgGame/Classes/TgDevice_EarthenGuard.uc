class TgDevice_EarthenGuard extends TgDevice
    hidecategories(Navigation);

simulated event bool ShouldLockFiring(TgDevice Current)
{
    return IsTimerActive('FirePreHitDelay') || IsTimerActive('OutroLockoutTime');
    //return ReturnValue;    
}

defaultproperties
{
    m_DeviceTimerBarType=DeviceTimerBarType.DTBT_PostHit
    m_bUsesOutroLockout=true
    m_fOutroLockoutTime=0.1000000
}