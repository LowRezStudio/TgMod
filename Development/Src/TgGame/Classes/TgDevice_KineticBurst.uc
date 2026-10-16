class TgDevice_KineticBurst extends TgDevice
    native(ChampFlak)
    hidecategories(Navigation)
    config(Engine);

var TgDevice_FlakInhand m_CachedInhand;

simulated event bool ShouldLockFiring(TgDevice Current) { }

native function bool HasCachedInhand();  // Export UTgDevice_KineticBurst::execHasCachedInhand(FFrame&, void* const)

simulated function FireAmmunition() { }

simulated event bool ShouldCooldownAfterFire() { }

simulated event bool ShouldMountCancelFiring() { }

simulated event bool ShouldInterruptInhand() { }

state DeviceFiring {}
