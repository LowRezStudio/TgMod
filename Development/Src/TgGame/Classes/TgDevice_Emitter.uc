class TgDevice_Emitter extends TgDevice
    native(ChampRuckus)
    hidecategories(Navigation)
    config(Engine);

var array<Actor> m_PawnsInRange;
var TgCollisionProxy_Cylinder m_CollisionProxy;
var bool m_bHasProjector;
var bool m_bIsOnOwner;
var float m_fProjectorPercent;
var TgPawn m_CachedPawnOwner;

simulated event bool ShouldLockFiring(TgDevice Current) { }

simulated event bool CanJumpWhileFiring() { }

simulated function bool ShouldInterruptReloadOnFire() { }

function OnProxyTouch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal) { }

function OnProxyUnTouch(Actor Other) { }

simulated event ClearAllTouched() { }

simulated event SpawnCollisionProxy() { }

state DeviceFiring {}

defaultproperties
{
    m_DeviceTimerBarType=DTBT_PostHit
    m_bPostFireShouldInterruptStealth=false
    m_bAbilityRequiresInhandResync=false
}
