class TgPathfinder extends Actor
    native(Navigation)
    notplaceable
    hidecategories(Navigation)
    implements(Interface_NavigationHandle)
    config(Engine);

var () float m_fMaxSpeed;
var init array<init Vector> m_vWaypoints;
var float m_fPathCheckRadius;
var HavokNavigationHandle m_NavigationHandle;
var SplineActor m_Spline;
var SplineActor m_CurrentSpline;
var float m_fCurrentSplineDist;
var () editinline NavMeshPathParams m_NavMeshPathParams;
var array<TgPathfinderWalker> m_ActiveWalkers;
var float m_WalkerLifeSpan;

delegate OnFinishedPathing(TgPathfinder Pathfinder);

native function bool SetRouteTo(Actor destActor, optional bool bDrawDebugPath=false);  // Export UTgPathfinder::execSetRouteTo(FFrame&, void* const)

event NotifyPathChanged() { }

simulated function SetupPathProperties(float PathCheckRadius, float PathSpeed) { }

simulated event Destroyed() { }

function StartWalkerStream(float StreamTime, float WalkerPulseTime, float WalkerLifetime, float WalkerSpeed) { }

function StopWalkerStream() { }

function SpawnWalker() { }

function OnPathfinderWalkerFinishedPathing(TgPathfinderWalker Walker) { }

defaultproperties
{
    m_fMaxSpeed=200.0000000
    m_NavMeshPathParams=(bCanMantle=false,bNeedsMantleValidityTest=false,bAbleToSearch=true,SearchExtent=(X=50.0000000,Y=50.0000000,Z=100.0000000),SearchLaneMultiplier=0.0000000,SearchStart=(X=0.0000000,Y=0.0000000,Z=0.0000000),MaxDropHeight=500.0000000,MinWalkableZ=0.7000000,MaxHoverDistance=10.0000000,MaxPathLength=0.0000000)
    Physics=PHYS_Custom
    bUpdateHavokPos=true
}
