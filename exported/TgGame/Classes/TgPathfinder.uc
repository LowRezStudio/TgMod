class TgPathfinder extends Actor
    native(Navigation)
    notplaceable
    hidecategories(Navigation)
    implements(Interface_NavigationHandle);

var private native const noexport Pointer VfTable_IInterface_NavigationHandle;
var() float m_fMaxSpeed;
var init array<init Vector> m_vWaypoints;
var float m_fPathCheckRadius;
var HavokNavigationHandle m_NavigationHandle;
var SplineActor m_Spline;
var SplineActor m_CurrentSpline;
var float m_fCurrentSplineDist;
var() editinline NavMeshPathParams m_NavMeshPathParams;
var array<TgPathfinderWalker> m_ActiveWalkers;
var float m_WalkerLifeSpan;
//var delegate<OnFinishedPathing> __OnFinishedPathing__Delegate;

delegate OnFinishedPathing(TgPathfinder Pathfinder)
{
    //return;    
}

// Export UTgPathfinder::execSetRouteTo(FFrame&, void* const)
native function bool SetRouteTo(Actor destActor, optional bool bDrawDebugPath = false);

event NotifyPathChanged()
{
    //return;    
}

simulated function SetupPathProperties(float PathCheckRadius, float PathSpeed)
{
    m_fPathCheckRadius = PathCheckRadius;
    m_fMaxSpeed = PathSpeed;
    //return;    
}

simulated event Destroyed()
{
    local array<SplineActor> Path;
    local int I;

    // End:0x9F
    if(m_Spline != none)
    {
        m_Spline.GetAllConnectedSplineActors(Path);
        I = Path.Length;
        J0x4B:

        // End:0x9F [Loop If]
        if(I > 0)
        {
            I--;
            Path[I].Destroy();
            Path[I] = none;
            // [Loop Continue]
            goto J0x4B;
        }
    }
    super.Destroyed();
    //return;    
}

function StartWalkerStream(float StreamTime, float WalkerPulseTime, float WalkerLifetime, float WalkerSpeed)
{
    m_fMaxSpeed = WalkerSpeed;
    m_WalkerLifeSpan = WalkerLifetime;
    SpawnWalker();
    SetTimer(WalkerPulseTime, true, 'SpawnWalker');
    SetTimer(StreamTime, false, 'StopWalkerStream');
    //return;    
}

function StopWalkerStream()
{
    ClearTimer('SpawnWalker');
    //return;    
}

function SpawnWalker()
{
    local TgPathfinderWalker PathfinderWalker;
    local TgSpecialFx PathfinderFX;

    PathfinderWalker = Spawn(Class'TgGame.TgPathfinderWalker', Owner,, Location);
    PathfinderWalker.SetPathfinder(self);
    PathfinderWalker.__OnFinishedPathing__Delegate = OnPathfinderWalkerFinishedPathing;
    PathfinderWalker.LifeSpan = m_WalkerLifeSpan;
    PathfinderFX = Class'TgGame.TgPawn'.static.GetSpecialFx(6334);
    // End:0x152
    if(PathfinderFX != none)
    {
        PathfinderFX.AttachToOwner(PathfinderWalker);
        PathfinderFX.SetDepthPriorityGroup(3);
        PathfinderFX.Activate();
    }
    m_ActiveWalkers.AddItem(PathfinderWalker);
    //return;    
}

function OnPathfinderWalkerFinishedPathing(TgPathfinderWalker Walker)
{
    m_ActiveWalkers.RemoveItem(Walker);
    // End:0x44
    if((m_ActiveWalkers.Length == 0) && !IsTimerActive('StopWalkerStream'))
    {
        Destroy();
    }
    //return;    
}

defaultproperties
{
    m_fMaxSpeed=200.0000000
    m_NavMeshPathParams=(bCanMantle=false,bNeedsMantleValidityTest=false,bAbleToSearch=true,SearchExtent=(X=50.0000000,Y=50.0000000,Z=100.0000000),SearchLaneMultiplier=0.0000000,SearchStart=(X=0.0000000,Y=0.0000000,Z=0.0000000),MaxDropHeight=500.0000000,MinWalkableZ=0.7000000,MaxHoverDistance=10.0000000,MaxPathLength=0.0000000)
    Physics=EPhysics.PHYS_Custom
    bUpdateHavokPos=true
}