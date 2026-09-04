class TgDevice_KineticBurst extends TgDevice
    native(ChampFlak)
    hidecategories(Navigation);

var TgDevice_FlakInhand m_CachedInhand;

simulated event bool ShouldLockFiring(TgDevice Current)
{
    // End:0x19
    if(IsTimerActive('FirePreHitDelay'))
    {
        return true;
    }
    return false;
    //return ReturnValue;    
}

// Export UTgDevice_KineticBurst::execHasCachedInhand(FFrame&, void* const)
native function bool HasCachedInhand();

simulated function FireAmmunition()
{
    super.FireAmmunition();
    // End:0x38
    if(HasCachedInhand())
    {
        m_CachedInhand.SetFireMode(1, true);
    }
    //return;    
}

simulated event bool ShouldCooldownAfterFire()
{
    return false;
    //return ReturnValue;    
}

simulated event bool ShouldMountCancelFiring()
{
    return false;
    //return ReturnValue;    
}

simulated event bool ShouldInterruptInhand()
{
    return false;
    //return ReturnValue;    
}

simulated state DeviceFiring
{
    simulated function FirePreHitDelay()
    {
        super.FirePreHitDelay();
        ClearTimer('FirePostHitDelay');
        //return;        
    }
    stop;    
}
