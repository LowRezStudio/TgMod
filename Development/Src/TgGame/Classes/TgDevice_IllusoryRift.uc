class TgDevice_IllusoryRift extends TgDevice
    native(ChampYing)
    hidecategories(Navigation)
    config(Engine);

native function ApplyHealingToAllies();  // Export UTgDevice_IllusoryRift::execApplyHealingToAllies(FFrame&, void* const)

simulated function FireAmmunition() { }

simulated event bool ShouldLockFiring(TgDevice Current) { }

defaultproperties
{
    m_DeviceTimerBarType=DTBT_PostHit
}
