class TgDevice_Stim extends TgDevice
    native(Devices)
    hidecategories(Navigation);

simulated event bool ShouldLockFiring(TgDevice Current)
{
    return false;
    //return ReturnValue;    
}

simulated function bool ShouldInterruptReloadOnFire()
{
    return false;
    //return ReturnValue;    
}

simulated event bool ShouldInterruptInhand()
{
    return false;
    //return ReturnValue;    
}

defaultproperties
{
    m_DeviceTimerBarType=DeviceTimerBarType.DTBT_PostHit
    m_bPostFireShouldInterruptStealth=false
    m_bAbilityRequiresInhandResync=false
}