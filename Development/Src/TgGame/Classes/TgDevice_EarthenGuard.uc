class TgDevice_EarthenGuard extends TgDevice
    hidecategories(Navigation)
    config(Engine);

simulated event bool ShouldLockFiring(TgDevice Current) { }

defaultproperties
{
    m_DeviceTimerBarType=DTBT_PostHit
    m_bUsesOutroLockout=true
    m_fOutroLockoutTime=0.1000000
}
