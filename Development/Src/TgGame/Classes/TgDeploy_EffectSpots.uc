class TgDeploy_EffectSpots extends TgDeploy_MatchParentFireMode
    native(Deployable)
    placeable
    hidecategories(Navigation)
    config(Engine);

const MAX_SPOT_POINTS = 100;

struct EffectSpotInfo {
    var bool bIsActive;
    var Vector vLocation;
    var Rotator rRotation;
    var float fRadius;
    var float fHeight;
    var int nFXIndex;
    var int nIntensityLevel;
    structdefaultproperties {}
};

struct EffectSpotTarget {
    var Actor Target;
    var bool bNeedsRefresh;
    structdefaultproperties {}
};

struct EffectSpotFXInfo {
    var TgSpecialFx Fx;
    var int nFXIndex;
    structdefaultproperties {}
};

var repnotify EffectSpotInfo r_EffectSpots[100];
var int m_nNewSpotIndex;
var TgCollisionProxy_Cylinder m_CollisionProxy;
var float m_fFirstPassRadius;
var array<Actor> m_TouchingActors;
var array<EffectSpotTarget> m_AffectedActors;
var bool m_bUsesEffectRefresh;
var float m_fLastRefreshTime;
var float m_fMinRefreshTime;
var EffectSpotFXInfo c_SpotFX[100];

replication {
    if(int(Role) == int(ENetRole.ROLE_Authority)) r_EffectSpots;
}

native function ApplyEffects(Actor Target);  // Export UTgDeploy_EffectSpots::execApplyEffects(FFrame&, void* const)

native function RemoveEffects(Actor Target);  // Export UTgDeploy_EffectSpots::execRemoveEffects(FFrame&, void* const)

native function InitializeSpecialFX(int spotIndex);  // Export UTgDeploy_EffectSpots::execInitializeSpecialFX(FFrame&, void* const)

simulated event ReplicatedEvent(name VarName) { }

simulated function Tick(float DeltaSeconds) { }

function OnProxyTouch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal) { }

function OnProxyUnTouch(Actor Other) { }

event int SpawnNewSpot(Vector vLocation, Rotator rRotation, optional float fRadius=0.0000000, optional float fHeight=0.0000000, optional int nFXIndex=0, optional int nIntensityLevel=0) { }

simulated function UpdateEffectSpots() { }

simulated event SpawnCollisionProxy() { }

event ScaleCollisionProxy() { }

simulated function UpdateSpotFX(int spotIndex) { }

simulated function UpdateParticleParams(int spotIndex) { }

simulated function ClearEffectSpots() { }

simulated event ClearAllTouched() { }

simulated event DestroyIt(optional bool bSkipFx) { }

simulated event Destroyed() { }

defaultproperties
{}
