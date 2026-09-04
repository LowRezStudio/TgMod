class TgDevice_Soar extends TgDevice
    native(ChampEvie)
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

simulated event bool CanBeInterrupted()
{
    return super.CanBeInterrupted() || IsInState('DeviceFiring');
    //return ReturnValue;    
}

simulated event bool ShouldMountCancelFiring()
{
    return false;
    //return ReturnValue;    
}

simulated event bool ShouldLockFiring(TgDevice Current)
{
    // End:0x39
    if((IsFiring()) && Current.m_nDeviceType == 11077)
    {
        return true;
    }
    return super.ShouldLockFiring(Current);
    //return ReturnValue;    
}

simulated state DeviceFiring
{
    simulated function EndState(name NextStateName)
    {
        super.EndState(NextStateName);
        // End:0x59
        if(Instigator != none)
        {
            Instigator.Velocity.Z = 0.0000000;
        }
        //return;        
    }
    stop;    
}

defaultproperties
{
    m_DeviceTimerBarType=DeviceTimerBarType.DTBT_PostHit
    m_bPostFireShouldInterruptStealth=false
    m_AimAssistKeyframesMagnetVert=none
    m_AimAssistKeyframesMagnetHoriz=none
    m_AimAssistKeyframesFriction=none
    m_AimAssistKeyframesTrackingAccHoriz=none
    m_AimAssistKeyframesTrackingAngleHoriz=none
    m_AimAssistKeyframesTrackingAccVert=none
    m_AimAssistKeyframesTrackingAngleVert=none
    m_nAimAssistPriorityWhileFiring=2
}