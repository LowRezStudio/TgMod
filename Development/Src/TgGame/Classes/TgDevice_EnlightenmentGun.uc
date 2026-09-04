class TgDevice_EnlightenmentGun extends TgDevice
    native(ChampPrincess)
    hidecategories(Navigation)
    config(Engine)
    dependson(TgClientSettings);

var TgPawn_Princess m_CachedPrincess;
var bool m_bAutoFireAfterPostHitDelay;

native function bool RequiresAmmoToFire();  // Export UTgDevice_EnlightenmentGun::execRequiresAmmoToFire(FFrame&, void* const)

simulated function bool HasCachedPrincess() { }

simulated event bool UsesSimulatedAmmo() { }

simulated function bool ShouldSwitchBackToBasicAttackTargeting(TgClientSettings.ECastMode CastMode) { }

state DeviceFiring {}
