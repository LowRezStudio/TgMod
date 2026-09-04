class TgSiegePushActor extends Actor
    placeable
    hidecategories(Navigation)
    config(Engine);

enum EPushState {
    PushState_Paused,  // 0
    PushState_Forward,  // 1
    PushState_PendingReverse,  // 2
    PushState_Reverse,  // 3
};

var TgCollisionProxy_Cylinder s_CollisionProxy;
var () const float m_fCollisionProxyRadius;
var () const float m_fCollisionProxyHeight;
var () export editinline SkeletalMeshComponent m_SkelMesh;
var () export editinline StaticMeshComponent m_RadiusMesh;
var transient int m_nTF1Count;
var transient int m_nTF2Count;
var () int m_nDefenderTaskForce;
var transient TgSiegePushActor.EPushState m_CurrentPushState;
var () float m_fPendingReverseTime;

simulated event PostBeginPlay() { }

simulated event CollisionProxyOnTouch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal) { }

simulated event CollisionProxyOnUnTouch(Actor Other) { }

function NearbyPawnsUpdated() { }

function SetReversePushState() { }

function SetCurrentPushState(TgSiegePushActor.EPushState NewPushState) { }

defaultproperties
{}
