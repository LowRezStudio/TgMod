class TgDevice_Stim extends TgDevice
    native(Devices)
    hidecategories(Navigation)
    config(Engine);

simulated event bool ShouldLockFiring(TgDevice Current) { }

simulated function bool ShouldInterruptReloadOnFire() { }

simulated event bool ShouldInterruptInhand() { }

defaultproperties
{
    m_DeviceTimerBarType=DTBT_PostHit
    m_bPostFireShouldInterruptStealth=false
    m_bAbilityRequiresInhandResync=false
}
