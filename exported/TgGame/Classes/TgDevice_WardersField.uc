class TgDevice_WardersField extends TgDevice
    hidecategories(Navigation);

const WARDERSFIELD_POST_DEPLOY_LOCKOUT_TIME = 0.3f;

simulated function bool InterceptSlotPressed(TgPlayerController TgController)
{
    // End:0x26
    if(IsFiring())
    {
        // End:0x24
        if(CanBeCanceled())
        {
            InterruptFiring();
        }
        return true;
    }
    return false;
    //return ReturnValue;    
}

simulated event bool CanBeCanceled()
{
    local float firePostHitTime;

    // End:0x4A
    if(IsTimerActive('FirePostHitDelay'))
    {
        firePostHitTime = GetTimerCount('FirePostHitDelay');
        // End:0x4A
        if(firePostHitTime > 0.5000000)
        {
            return true;
        }
    }
    return false;
    //return ReturnValue;    
}

event OnDeployableDestroyed(TgDeployable deployable)
{
    // End:0x45
    if(deployable == r_Deployable)
    {
        r_Deployable = none;
        // End:0x39
        if(IsFiring())
        {
            InterruptFiring();
        }
        StartCooldown();
    }
    //return;    
}

simulated event bool ShouldLockFiring(TgDevice Current)
{
    local float firePostHitTime;

    // End:0x1C
    if(IsTimerActive('FirePreHitDelay'))
    {
        return true;        
    }
    else
    {
        // End:0xA3
        if(IsTimerActive('FirePostHitDelay'))
        {
            // End:0x6E
            if((Current != none) && Current.r_nDeviceId == 16251)
            {
                return false;
            }
            firePostHitTime = GetTimerCount('FirePostHitDelay');
            // End:0xA1
            if(firePostHitTime > 0.3000000)
            {
                return false;
            }
            return true;
        }
    }
    return false;
    //return ReturnValue;    
}

simulated state DeviceFiring
{
    simulated function StopFiringLogic()
    {
        super.StopFiringLogic();
        // End:0x44
        if(r_Deployable != none)
        {
            r_Deployable.DestroyIt();
            r_Deployable = none;
        }
        //return;        
    }
    stop;    
}

defaultproperties
{
    m_bDeployAtFeetOnFailure=true
}