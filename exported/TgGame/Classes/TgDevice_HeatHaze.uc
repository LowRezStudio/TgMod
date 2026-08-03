class TgDevice_HeatHaze extends TgDevice
    hidecategories(Navigation);

const InhandBow = 14891;

simulated function InhandFired()
{
    local TgDeviceFire FireMode;

    // End:0x59
    if(IsFiring())
    {
        FireMode = GetCurrentFire();
        // End:0x59
        if(FireMode != none)
        {
            CacheAim();
            FireMode.Deploy();
        }
    }
    //return;    
}

simulated event bool ShouldLockFiring(TgDevice Current)
{
    // End:0xB9
    if(IsFiring())
    {
        // End:0x77
        if((Current != none) && Current.r_nDeviceId == 14988)
        {
            // End:0x75
            if(HasRemoteOwner() && GetRemainingTimeForTimer('FirePostHitDelay') < 0.1000000)
            {
                return false;
            }
            return true;
        }
        // End:0xA4
        if(HasRemoteOwner())
        {
            // End:0xA4
            if(GetRemainingTimeForTimer('FirePreHitDelay') < 0.1000000)
            {
                return false;
            }
        }
        return IsTimerActive('FirePreHitDelay');
    }
    return false;
    //return ReturnValue;    
}

simulated event LinkedDeviceEquipped(TgDevice Dev)
{
    // End:0x8A
    if(Dev != none)
    {
        super.LinkedDeviceEquipped(Dev);
        switch(Dev.r_nDeviceId)
        {
            // End:0x87
            case 14891:
                Dev.RegisterDelegate(0, InhandFired);
                // End:0x8A
                break;
            // End:0xFFFF
            default:
                break;
        }
    }
    else
    {
        //return;        
    }
}

simulated event LinkedDeviceUnequipped(TgDevice Dev)
{
    // End:0x8A
    if(Dev != none)
    {
        super.LinkedDeviceUnequipped(Dev);
        switch(Dev.r_nDeviceId)
        {
            // End:0x87
            case 14891:
                Dev.UnregisterDelegate(0, InhandFired);
                // End:0x8A
                break;
            // End:0xFFFF
            default:
                break;
        }
    }
    else
    {
        //return;        
    }
}

defaultproperties
{
    m_DeviceTimerBarType=DeviceTimerBarType.DTBT_PostHit
    m_bBuildupShouldInterruptStealth=false
    m_bPreFireShouldInterruptStealth=false
    m_bFireShouldInterruptStealth=false
    m_bPostFireShouldInterruptStealth=false
    m_bCancelingShouldInterruptStealth=false
    m_nLinkedDeviceIDs[0]=14891
}