class TgDevice_RestoreSoul extends TgDevice
    native(ChampOracle)
    hidecategories(Navigation)
    config(Engine)
    dependson(TgObject);

var TgPawn_Oracle m_CachedOraclePawn;
var ImpactInfo m_CachedImpact;
var bool m_bApplyCooldown;

native function bool CanDeviceFireNow(byte FireModeNum, AimData Aim, bool bDeviceFailLog, out TgObject.EDeviceFailType failType);  // Export UTgDevice_RestoreSoul::execCanDeviceFireNow(FFrame&, void* const)

simulated event bool CanBeCanceled() { }

simulated event bool CanBeInterrupted() { }

simulated function bool HasCachedOracle() { }

simulated event DeliverQueuedPendingHits() { }

simulated event bool ShouldCooldownAfterFire() { }

simulated event DeliverHit(ImpactInfo Impact) { }

simulated function DelayedDeliverHit() { }

simulated function ImpactInfo CalcWeaponFire(vector StartTrace, vector EndTrace, optional out array<ImpactInfo> ImpactList, optional vector Extent) { }

function OnInstantShotVerified(ImpactInfo VerifiedPrimaryImpact) { }

function OnInstantShotRejected(ImpactToValidate RejectedPrimaryImpact) { }

simulated function UpdateHitTargetInfo(Actor HitActor, Vector HitLocation) { }

state DeviceFiring {}

defaultproperties
{
    m_DeviceTimerBarType=DTBT_PostHit
}
