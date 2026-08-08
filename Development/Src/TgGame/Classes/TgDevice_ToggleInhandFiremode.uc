class TgDevice_ToggleInhandFiremode extends TgDevice
    hidecategories(Navigation)
    config(Engine);

var TgDevice m_CachedInhand;

simulated function bool ShouldInterruptReloadOnFire() { }

simulated event bool ShouldLockFiring(TgDevice Current) { }

simulated function bool ShouldStopActionOnOffhandSlotReleased() { }

simulated function FireAmmunition() { }

simulated function bool HasCachedInhand() { }

simulated event bool ShouldCooldownAfterFire() { }

defaultproperties
{
    m_bFireShouldInterruptStealth=false
    m_bPostFireShouldInterruptStealth=false
}
