class NavigationPoint extends Actor
    native
    notplaceable
    hidecategories(Navigation,Lighting,LightColor,Force)
    classgroup(Navigation);

const INFINITE_PATH_COST = 10000000;

struct native NavigationOctreeObject
{
    var Box BoundingBox;
    var Vector BoxCenter;
    var native const transient Pointer OctreeNode;
    var const noexport Object Owner;
    var const noexport byte OwnerType;

    structdefaultproperties
    {
        BoundingBox=(Min=(X=0.0000000,Y=0.0000000,Z=0.0000000),Max=(X=0.0000000,Y=0.0000000,Z=0.0000000),IsValid=0)
        BoxCenter=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        Owner=none
        OwnerType=0
    }
};

struct native DebugNavCost
{
    var string Desc;
    var int Cost;

    structdefaultproperties
    {
        Desc=""
        Cost=0
    }
};

struct CheckpointRecord
{
    var bool bDisabled;
    var bool bBlocked;

    structdefaultproperties
    {
        bDisabled=false
        bBlocked=false
    }
};

var transient bool bEndPoint;
var transient bool bTransientEndPoint;
var transient bool bHideEditorPaths;
var transient bool bCanReach;
var() bool bBlocked;
var() bool bOneWayPath;
var bool bNeverUseStrafing;
var bool bAlwaysUseStrafing;
var const bool bForceNoStrafing;
var const bool bAutoBuilt;
var bool bSpecialMove;
var bool bNoAutoConnect;
var const bool bNotBased;
var const bool bPathsChanged;
var() bool bDestinationOnly;
var bool bSourceOnly;
var bool bSpecialForced;
var bool bMustBeReachable;
var bool bBlockable;
var bool bFlyingPreferred;
var bool bMayCausePain;
var transient bool bAlreadyVisited;
var() bool bVehicleDestination;
var() bool bMakeSourceOnly;
var bool bMustTouchToReach;
var bool bCanWalkOnToReach;
var bool bBuildLongPaths;
var(VehicleUsage) bool bBlockedForVehicles;
var(VehicleUsage) bool bPreferredVehiclePath;
var const bool bHasCrossLevelPaths;
var transient bool bShouldSaveForCheckpoint;
var native const transient NavigationOctreeObject NavOctreeObject;
var() duplicatetransient const editconst array<editconst editinline ReachSpec> PathList;
var() const editconst array<editconst ActorReference> Volumes;
var int visitedWeight;
var const int bestPathWeight;
var private const NavigationPoint nextNavigationPoint;
var const NavigationPoint nextOrdered;
var const NavigationPoint prevOrdered;
var const NavigationPoint previousPath;
var int Cost;
var() int ExtraCost;
var transient int TransientCost;
var transient int FearCost;
var transient array<DebugNavCost> CostArray;
var DroppedPickup InventoryCache;
var float InventoryDist;
var const float LastDetourWeight;
var export editinline CylinderComponent CylinderComponent;
var() const editconst Cylinder MaxPathSize;
var() duplicatetransient const editconst Guid NavGuid;
var const export editinline transient SpriteComponent GoodSprite;
var const export editinline transient SpriteComponent BadSprite;
var() const editconst int NetworkID;
var transient Pawn AnchoredPawn;
var transient float LastAnchoredPawnTime;

// Export UNavigationPoint::execGetBoundingCylinder(FFrame&, void* const)
native function GetBoundingCylinder(out float CollisionRadius, out float CollisionHeight);

// Export UNavigationPoint::execGetReachSpecTo(FFrame&, void* const)
native final function ReachSpec GetReachSpecTo(NavigationPoint Nav, optional Class<ReachSpec> SpecClass);

// Export UNavigationPoint::execIsUsableAnchorFor(FFrame&, void* const)
native function bool IsUsableAnchorFor(Pawn P);

// Export UNavigationPoint::execCanTeleport(FFrame&, void* const)
native function bool CanTeleport(Actor A);

event int SpecialCost(Pawn Seeker, ReachSpec Path)
{
    //return ReturnValue;    
}

event bool Accept(Actor Incoming, Actor Source)
{
    local bool bResult;

    bResult = Incoming.SetLocation(Location);
    // End:0x86
    if(bResult)
    {
        Incoming.Velocity = vect(0.0000000, 0.0000000, 0.0000000);
        Incoming.SetRotation(Rotation);
    }
    Incoming.PlayTeleportEffect(true, false);
    return bResult;
    //return ReturnValue;    
}

event float DetourWeight(Pawn Other, float PathWeight)
{
    //return ReturnValue;    
}

event bool SuggestMovePreparation(Pawn Other)
{
    return Other.SpecialMoveTo(Other.Anchor, self, Other.Controller.MoveTarget);
    //return ReturnValue;    
}

function bool ProceedWithMove(Pawn Other)
{
    return true;
    //return ReturnValue;    
}

static final function NavigationPoint GetNearestNavToActor(Actor ChkActor, optional Class<NavigationPoint> RequiredClass, optional array<NavigationPoint> ExcludeList, optional float MinDist)
{
    local NavigationPoint Nav, BestNav;
    local float Dist, bestDist;

    // End:0x16B
    if(ChkActor != none)
    {
        // End:0x16A
        foreach ChkActor.WorldInfo.AllNavigationPoints(Class'Engine.NavigationPoint', Nav)
        {
            // End:0x169
            if(((RequiredClass == none) || Nav.Class == RequiredClass) && ExcludeList.Find(Nav) == -1)
            {
                Dist = VSize(Nav.Location - ChkActor.Location);
                // End:0x169
                if(Dist > MinDist)
                {
                    // End:0x169
                    if((BestNav == none) || Dist < bestDist)
                    {
                        BestNav = Nav;
                        bestDist = Dist;
                    }
                }
            }            
        }        
    }
    return BestNav;
    //return ReturnValue;    
}

static final function NavigationPoint GetNearestNavToPoint(Actor ChkActor, Vector ChkPoint, optional Class<NavigationPoint> RequiredClass, optional array<NavigationPoint> ExcludeList)
{
    local NavigationPoint Nav, BestNav;
    local float Dist, bestDist;

    // End:0x13E
    if(ChkActor != none)
    {
        // End:0x13D
        foreach ChkActor.WorldInfo.AllNavigationPoints(Class'Engine.NavigationPoint', Nav)
        {
            // End:0x13C
            if(((RequiredClass == none) || Nav.Class == RequiredClass) && ExcludeList.Find(Nav) == -1)
            {
                Dist = VSize(Nav.Location - ChkPoint);
                // End:0x13C
                if((BestNav == none) || Dist < bestDist)
                {
                    BestNav = Nav;
                    bestDist = Dist;
                }
            }            
        }        
    }
    return BestNav;
    //return ReturnValue;    
}

// Export UNavigationPoint::execGetAllNavInRadius(FFrame&, void* const)
native static final function bool GetAllNavInRadius(Actor ChkActor, Vector ChkPoint, float Radius, out array<NavigationPoint> out_NavList, optional bool bSkipBlocked, optional int inNetworkID = -1, optional Cylinder MinSize);

// Export UNavigationPoint::execIsOnDifferentNetwork(FFrame&, void* const)
native final function bool IsOnDifferentNetwork(NavigationPoint Nav);

function OnToggle(SeqAct_Toggle inAction)
{
    // End:0x46
    if(inAction.InputLinks[0].bHasImpulse)
    {
        bBlocked = false;        
    }
    else
    {
        // End:0x8C
        if(inAction.InputLinks[1].bHasImpulse)
        {
            bBlocked = true;            
        }
        else
        {
            // End:0xDB
            if(inAction.InputLinks[2].bHasImpulse)
            {
                bBlocked = !bBlocked;
            }
        }
    }
    WorldInfo.Game.NotifyNavigationChanged(self);
    bShouldSaveForCheckpoint = true;
    //return;    
}

simulated event ShutDown()
{
    super.ShutDown();
    bBlocked = true;
    WorldInfo.Game.NotifyNavigationChanged(self);
    bShouldSaveForCheckpoint = true;
    //return;    
}

function bool ShouldSaveForCheckpoint()
{
    return bShouldSaveForCheckpoint;
    //return ReturnValue;    
}

function CreateCheckpointRecord(out CheckpointRecord Record)
{
    Record.bBlocked = bBlocked;
    //return;    
}

function ApplyCheckpointRecord(const out CheckpointRecord Record)
{
    bBlocked = Record.bBlocked;
    bShouldSaveForCheckpoint = true;
    //return;    
}

simulated event string GetDebugAbbrev()
{
    return "NP?";
    //return ReturnValue;    
}

defaultproperties
{
    bMayCausePain=true
    bMustTouchToReach=true
    bBuildLongPaths=true
    // Reference: CylinderComponent'Engine.Default__NavigationPoint.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    begin object name="CollisionCylinder" class=Engine.CylinderComponent
        CollisionHeight=50.0000000
        CollisionRadius=50.0000000
        ReplacementPrimitive=none
    end object
    CylinderComponent=CollisionCylinder
    NetworkID=-1
    Components[0]=none
    Components[1]=none
    Components[2]=none
    Components[3]=CollisionCylinder
    Components[4]=none
    bStatic=true
    bNoDelete=true
    bCollideWhenPlacing=true
    bForceAllowKismetModification=true
    CollisionComponent=CollisionCylinder
}