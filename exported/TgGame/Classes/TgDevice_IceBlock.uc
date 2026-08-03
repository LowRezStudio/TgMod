class TgDevice_IceBlock extends TgDevice
    hidecategories(Navigation);

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

defaultproperties
{
    m_DeviceTimerBarType=DeviceTimerBarType.DTBT_PostHit
    m_bPostFireShouldInterruptStealth=false
}