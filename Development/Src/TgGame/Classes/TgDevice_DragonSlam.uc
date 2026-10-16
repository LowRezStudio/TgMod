class TgDevice_DragonSlam extends TgDevice
    native(ChampDrogoz)
    hidecategories(Navigation)
    config(Engine);

var bool m_bHasHitTarget;
var TgPawn_Drogoz m_CachedDrogozOwner;
var TgCollisionProxy_Cylinder m_CollisionProxy;

simulated function bool InterceptRightMousePressed(TgPlayerController TgController) { }

simulated function CustomFire() { }

function OnProxyTouch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal) { }

reliable client simulated function ClientImpactTarget() { }

reliable server function ServerImpactTarget(Actor Target, Vector HitLocation, Vector HitNormal) { }

function RefundEnergy() { }

simulated event Destroyed() { }

simulated event SpawnCollisionProxy() { }

simulated function FireAmmunition() { }

simulated event bool CanBeCanceled() { }

simulated event bool ShouldLockFiring(TgDevice Current) { }

simulated event bool ShouldMountCancelFiring() { }

state DeviceFiring {}

defaultproperties
{
    m_DeviceTimerBarType=DTBT_PostHit
}
