class TgDevice_GhostWalk extends TgDevice
    hidecategories(Navigation)
    config(Engine);

simulated event bool CanBeCanceled() { }

simulated function bool ShouldInterruptReloadOnFire() { }

defaultproperties
{
    m_DeviceTimerBarType=DTBT_PostHit
    m_bPostFireShouldInterruptStealth=false
    m_fEnterCombatDuration=1.0000000
}
