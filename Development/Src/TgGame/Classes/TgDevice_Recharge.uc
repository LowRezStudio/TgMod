class TgDevice_Recharge extends TgDevice
    native(ChampGauntlet)
    hidecategories(Navigation)
    config(Engine)
    dependson(TgObject);

var TgPawn_Gauntlet m_CachedGauntletPawn;

simulated event bool ShouldLockFiring(TgDevice Current) { }

simulated event bool IsFunctionallyToggleDevice() { }

simulated function bool ShouldStopActionOnOffhandSlotReleased() { }

simulated event bool CanBeCanceled() { }

simulated function CancelSafetyTimer() { }

function StartCooldownTimer() { }

reliable client simulated function ClientStartCooldownTimer() { }

simulated function CooldownTimer() { }

simulated function ImpactInfo CalcWeaponFire(vector StartTrace, vector EndTrace, optional out array<ImpactInfo> ImpactList, optional vector Extent) { }

function OnInstantShotVerified(ImpactInfo VerifiedPrimaryImpact) { }

simulated function UpdateHitTargetInfo(Actor HitActor, Vector HitLocation) { }

simulated function bool HasCachedGauntlet() { }

state DeviceFiring {}
