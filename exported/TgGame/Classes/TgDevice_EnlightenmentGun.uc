class TgDevice_EnlightenmentGun extends TgDevice
    native(ChampPrincess)
    hidecategories(Navigation);

var TgPawn_Princess m_CachedPrincess;
var bool m_bAutoFireAfterPostHitDelay;

// Export UTgDevice_EnlightenmentGun::execRequiresAmmoToFire(FFrame&, void* const)
native function bool RequiresAmmoToFire();

simulated function bool HasCachedPrincess()
{
    // End:0x2B
    if(m_CachedPrincess == none)
    {
        m_CachedPrincess = TgPawn_Princess(Instigator);
    }
    return m_CachedPrincess != none;
    //return ReturnValue;    
}

simulated event bool UsesSimulatedAmmo()
{
    return false;
    //return ReturnValue;    
}

simulated function bool ShouldSwitchBackToBasicAttackTargeting(TgClientSettings.ECastMode CastMode)
{
    return false;
    //return ReturnValue;    
}

simulated state DeviceFiring
{
    simulated function StartFiringLogic()
    {
        m_bAutoFireAfterPostHitDelay = false;
        // End:0xEE
        if(HasCachedPrincess())
        {
            // End:0xEE
            if(m_CachedPrincess.HasCachedEnlightenment())
            {
                // End:0xBA
                if(m_CachedPrincess.m_CachedEnlightenment.IsTimerActive('TimeOut'))
                {
                    m_CachedPrincess.m_CachedEnlightenment.ClearTimer('TimeOut');
                }
                m_CachedPrincess.m_CachedEnlightenment.StartWaitForResultOfFireTimer();
            }
        }
        super.StartFiringLogic();
        //return;        
    }
    stop;    
}
