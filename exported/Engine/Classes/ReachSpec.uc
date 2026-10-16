class ReachSpec extends Object
    native;

const BLOCKEDPATHCOST = 10000000;

var native const editconst transient Pointer NavOctreeObject;
var int Distance;
var Vector Direction;
var() const editconst NavigationPoint Start;
var() const editconst ActorReference End;
var() const editconst int CollisionRadius;
var() const editconst int CollisionHeight;
var int reachFlags;
var int MaxLandingVelocity;
var byte bPruned;
var byte PathColorIndex;
var const editconst bool bAddToNavigationOctree;
var bool bCanCutCorners;
var bool bCheckForObstructions;
var const bool bSkipPrune;
var() editconst bool bDisabled;
var const array< Class<ReachSpec> > PruneSpecList;
var Actor BlockedBy;

// Export UReachSpec::execCostFor(FFrame&, void* const)
native final function int CostFor(Pawn P);

// Export UReachSpec::execGetEnd(FFrame&, void* const)
native final function NavigationPoint GetEnd();

// Export UReachSpec::execGetDirection(FFrame&, void* const)
native final function Vector GetDirection();

function bool IsBlockedFor(Pawn P)
{
    return CostFor(P) >= 10000000;
    //return ReturnValue;    
}

defaultproperties
{
    bAddToNavigationOctree=true
    bCanCutCorners=true
    bCheckForObstructions=true
}