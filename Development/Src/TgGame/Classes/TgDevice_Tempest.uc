class TgDevice_Tempest extends TgDevice_HitPulse
    native(ChampGrohk)
    hidecategories(Navigation)
    config(Engine)
    dependson(TgObject);

native function bool CanFireIfLeftMouseDown();  // Export UTgDevice_Tempest::execCanFireIfLeftMouseDown(FFrame&, void* const)

simulated event bool CanBeInterrupted() { }

simulated event bool CanBeCanceled() { }

simulated event DeliverQueuedPendingHits() { }

simulated function PersistTimer() { }

simulated function bool ShouldInterruptReloadOnFire() { }

state DeviceFiring {}

defaultproperties
{
    m_DeviceTimerBarType=DTBT_PersistTime
    m_bAlwaysStartCooldown=false
    m_bDisableLagCompensation=true
}
