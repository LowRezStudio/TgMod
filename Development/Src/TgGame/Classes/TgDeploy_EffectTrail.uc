class TgDeploy_EffectTrail extends TgDeploy_MatchParentFireMode
    native(Deployable)
    placeable
    hidecategories(Navigation)
    config(Engine);

const MAX_TRAIL_POINTS = 20;

var TgPawn r_TrailPawn;
var int m_TrailEffectID;
var TgSpecialFx m_TrailEffects;
var bool m_bHasInitialPoint;
var bool r_bInDeployMode;
var float m_fPointDistance;
var float m_fPointLifetime;
var int m_nNextPointIndex;
var int m_nTailPointIndex;
var Vector m_TrailPoints[20];
var Vector m_ParticleSystemOffsets[20];
var float m_TrailTimes[20];
var TgCollisionProxy_Cylinder m_CollisionProxies[20];
var export editinline DecalComponent m_Decals[20];

replication {
    if(bNetInitial && int(Role) == int(ENetRole.ROLE_Authority)) r_TrailPawn;
    if(int(Role) == int(ENetRole.ROLE_Authority)) r_bInDeployMode;
}

native function bool CalculateAndSpawnNextPiece();  // Export UTgDeploy_EffectTrail::execCalculateAndSpawnNextPiece(FFrame&, void* const)

function OnProxyTouch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal) { }

simulated event ConsumeTailPiece() { }

simulated event bool SpawnNewTrailFX(Vector trailLocation, Vector particleOffset) { }

function OnPersistTimerExpire() { }

simulated event ShutdownDeployMode() { }

simulated function Destroyed() { }

defaultproperties
{}
