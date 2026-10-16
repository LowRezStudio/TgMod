class TgDevice_ShadowTravel extends TgDevice
    native(ChampOracle)
    hidecategories(Navigation)
    config(Engine);

simulated event bool CanBeCanceled() { }

simulated function bool ShouldInterruptReloadOnFire() { }

native function float GetMoveSpeedMultiplier();  // Export UTgDevice_ShadowTravel::execGetMoveSpeedMultiplier(FFrame&, void* const)

state DeviceFiring {}

defaultproperties
{
    m_DeviceTimerBarType=DTBT_PostHit
    m_bPostFireShouldInterruptStealth=false
    m_bUsesOutroLockout=true
    m_fEnterCombatDuration=1.0000000
}
