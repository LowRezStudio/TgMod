class TgDevice_Whirlwind2 extends TgDevice_ActiveAura
    hidecategories(Navigation);

simulated event bool ShouldLockFiring(TgDevice Current)
{
    return IsFiring();
    //return ReturnValue;    
}

simulated event bool CanBeCanceled()
{
    return GetTimerCount('FirePostHitDelay') > 0.5000000;
    //return ReturnValue;    
}

defaultproperties
{
    m_DeviceTimerBarType=DeviceTimerBarType.DTBT_PostHit
}