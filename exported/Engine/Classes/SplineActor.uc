class SplineActor extends Actor
    native(Spline)
    placeable
    hidecategories(Navigation);

struct native SplineConnection
{
    var() export editinline SplineComponent SplineComponent;
    var() SplineActor ConnectTo;

    structdefaultproperties
    {
        SplineComponent=none
        ConnectTo=none
    }
};

var array<SplineConnection> Connections;
var() interp Vector SplineActorTangent;
var() Color SplineColor;
var() bool bDisableDestination;
var transient bool bAlreadyVisited;
var array<SplineActor> LinksFrom;
var transient SplineActor nextOrdered;
var transient SplineActor prevOrdered;
var transient SplineActor previousPath;
var transient int bestPathWeight;
var transient int visitedWeight;
var() editinline InterpCurveFloat SplineVelocityOverTime;

// Export USplineActor::execGetWorldSpaceTangent(FFrame&, void* const)
native function Vector GetWorldSpaceTangent();

// Export USplineActor::execUpdateSplineComponents(FFrame&, void* const)
native function UpdateSplineComponents();

// Export USplineActor::execUpdateConnectedSplineComponents(FFrame&, void* const)
native function UpdateConnectedSplineComponents(bool bFinish);

// Export USplineActor::execAddConnectionTo(FFrame&, void* const)
native function AddConnectionTo(SplineActor NextActor);

// Export USplineActor::execIsConnectedTo(FFrame&, void* const)
native function bool IsConnectedTo(SplineActor NextActor, bool bCheckForDisableDestination);

// Export USplineActor::execFindSplineComponentTo(FFrame&, void* const)
native function SplineComponent FindSplineComponentTo(SplineActor NextActor);

// Export USplineActor::execFindTargetForComponent(FFrame&, void* const)
native function SplineActor FindTargetForComponent(SplineComponent SplineComp);

// Export USplineActor::execBreakConnectionTo(FFrame&, void* const)
native function BreakConnectionTo(SplineActor NextActor);

// Export USplineActor::execBreakAllConnections(FFrame&, void* const)
native function BreakAllConnections();

// Export USplineActor::execBreakAllConnectionsFrom(FFrame&, void* const)
native function BreakAllConnectionsFrom();

// Export USplineActor::execGetRandomConnection(FFrame&, void* const)
native function SplineActor GetRandomConnection(optional bool bUseLinksFrom);

// Export USplineActor::execGetBestConnectionInDirection(FFrame&, void* const)
native function SplineActor GetBestConnectionInDirection(Vector DesiredDir, optional bool bUseLinksFrom);

// Export USplineActor::execFindSplinePathTo(FFrame&, void* const)
native function bool FindSplinePathTo(SplineActor Goal, out array<SplineActor> OutRoute);

// Export USplineActor::execGetAllConnectedSplineActors(FFrame&, void* const)
native function GetAllConnectedSplineActors(out array<SplineActor> OutSet);

function OnToggle(SeqAct_Toggle inAction)
{
    // End:0x46
    if(inAction.InputLinks[0].bHasImpulse)
    {
        bDisableDestination = false;        
    }
    else
    {
        // End:0x8C
        if(inAction.InputLinks[1].bHasImpulse)
        {
            bDisableDestination = true;            
        }
        else
        {
            bDisableDestination = !bDisableDestination;
        }
    }
    UpdateConnectedSplineComponents(true);
    //return;    
}

simulated function OnToggleHidden(SeqAct_ToggleHidden Action)
{
    super.OnToggleHidden(Action);
    UpdateConnectedSplineComponents(true);
    //return;    
}

defaultproperties
{
    SplineActorTangent=(X=300.0000000,Y=0.0000000,Z=0.0000000)
    SplineColor=(R=255,G=0,B=255,A=255)
    Components[0]=none
}