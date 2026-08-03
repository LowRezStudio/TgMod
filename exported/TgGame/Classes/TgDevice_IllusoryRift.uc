class TgDevice_IllusoryRift extends TgDevice
    native(ChampYing)
    hidecategories(Navigation);

// Export UTgDevice_IllusoryRift::execApplyHealingToAllies(FFrame&, void* const)
native function ApplyHealingToAllies();

simulated function FireAmmunition()
{
    super.FireAmmunition();
    ApplyHealingToAllies();
    //return;    
}

simulated event bool ShouldLockFiring(TgDevice Current)
{
    return false;
    //return ReturnValue;    
}

defaultproperties
{
    m_DeviceTimerBarType=DeviceTimerBarType.DTBT_PostHit
}