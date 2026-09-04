class TgProj_DarklordBase extends TgProj_SpeedOverRange
    native(ChampDarklord)
    hidecategories(Navigation)
    config(Engine);

struct TrackedCollision {
    var bool IsColliding;
    var Actor Target;
    var export editinline PrimitiveComponent TargetComp;
    var int NumTouches;
    structdefaultproperties {}
};

var TgCollisionProxy_Cylinder m_SecondaryCollisionProxies[2];
var export editinline ParticleSystemComponent m_SecondaryDebugProximityDistancePSC[2];
var array<TrackedCollision> m_TrackedCollisions;

native function CompleteInitialization();  // Export UTgProj_DarklordBase::execCompleteInitialization(FFrame&, void* const)

simulated function OnSecondaryProxyTouch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal) { }

simulated event OnSecondaryProxyUnTouch(Actor Other) { }

simulated event ForwardProxyTouch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal) { }

simulated event ForwardProxyUntouch(Actor Other) { }

simulated event ProxyTouch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal) { }

simulated event ProxyUnTouch(Actor Other) { }

native simulated function HandleSecondaryProxyTouch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal);  // Export UTgProj_DarklordBase::execHandleSecondaryProxyTouch(FFrame&, void* const)

native simulated function HandleSecondaryProxyUntouch(Actor Other);  // Export UTgProj_DarklordBase::execHandleSecondaryProxyUntouch(FFrame&, void* const)

simulated function Vector GetCollisionOffsetDir() { }

simulated event SpawnSecondaryCollisionProxies() { }

simulated function HideProjectile() { }

simulated function float GetDecalRotationOffset() { }

simulated function PlayHitTargetFX(Actor Target, Vector HitLocation, Vector HitNormal, bool bExploded) { }

simulated event PlayHitWallExplosionFX(Vector HitNormal, Vector HitLocation) { }

defaultproperties
{}
