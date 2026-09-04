class Scout extends Pawn
    transient
    native(Pawn)
    config(Game)
    notplaceable
    hidecategories(Navigation);

struct native PathSizeInfo
{
    var name Desc;
    var float Radius;
    var float Height;
    var float CrouchHeight;
    var byte PathColor;

    structdefaultproperties
    {
        Desc="None"
        Radius=0.0000000
        Height=0.0000000
        CrouchHeight=0.0000000
        PathColor=0
    }
};

var array<PathSizeInfo> PathSizes;
var float TestJumpZ;
var float TestGroundSpeed;
var float TestMaxFallSpeed;
var float TestFallSpeed;
var const float MaxLandingVelocity;
var int MinNumPlayerStarts;
var Class<ReachSpec> DefaultReachSpecClass;
var array<Color> EdgePathColors;
var float NavMeshGen_StepSize;
var float NavMeshGen_EntityHalfHeight;
var float NavMeshGen_StartingHeightOffset;
var float NavMeshGen_MaxDropHeight;
var float NavMeshGen_MaxStepHeight;
var float NavMeshGen_VertZDeltaSnapThresh;
var float NavMeshGen_MinPolyArea;
var float NavMeshGen_BorderBackfill_CheckDist;
var float NavMeshGen_MinMergeDotAreaThreshold;
var float NavMeshGen_MinMergeDotSmallArea;
var float NavMeshGen_MinMergeDotLargeArea;
var float NavMeshGen_MaxPolyHeight;
var float NavMeshGen_HeightMergeThreshold;
var float NavMeshGen_EdgeMaxDelta;
var float NavMeshGen_MaxGroundCheckSize;
var float NavMeshGen_MinEdgeLength;
var float NavMeshGen_MinRadius;
var float NavMeshGen_MaxRadius;
var float StandardJumpHeight;
var float StandardJumpDistance;
var float NavMeshGen_RecastCellSize;
var float NavMeshGen_RecastCellHeight;
var float NavMeshGen_RecastErodeRadius;
var bool NavMeshGen_ExpansionDoObstacleMeshSimplification;
var() bool bHightlightOneWayReachSpecs;
var float MinMantleFallDist;
var float MaxMantleFallDist;
var float MinMantleLateralDist;
var float MaxMantleLateralDist;
var float MaxMantleFallTime;

simulated event PreBeginPlay()
{
    // End:0x13
    if(bCollideActors)
    {
        SetCollision(false, false);
    }
    //return;    
}

defaultproperties
{
    PathSizes[0]=(Desc="Human",Radius=48.0000000,Height=80.0000000,CrouchHeight=0.0000000,PathColor=0)
    PathSizes[1]=(Desc="Common",Radius=72.0000000,Height=100.0000000,CrouchHeight=0.0000000,PathColor=0)
    PathSizes[2]=(Desc="Max",Radius=120.0000000,Height=120.0000000,CrouchHeight=0.0000000,PathColor=0)
    PathSizes[3]=(Desc="Vehicle",Radius=260.0000000,Height=120.0000000,CrouchHeight=0.0000000,PathColor=0)
    TestJumpZ=420.0000000
    TestGroundSpeed=600.0000000
    TestMaxFallSpeed=2500.0000000
    TestFallSpeed=1200.0000000
    MinNumPlayerStarts=1
    DefaultReachSpecClass=Class'Engine.ReachSpec'
    EdgePathColors=/* ERROR: System.ArgumentOutOfRangeException */
    NavMeshGen_StepSize=30.0000000
    NavMeshGen_EntityHalfHeight=72.0000000
    NavMeshGen_StartingHeightOffset=65.0000000
    NavMeshGen_MaxDropHeight=60.0000000
    NavMeshGen_MaxStepHeight=35.0000000
    NavMeshGen_VertZDeltaSnapThresh=20.0000000
    NavMeshGen_MinPolyArea=25.0000000
    NavMeshGen_BorderBackfill_CheckDist=70.0000000
    NavMeshGen_MinMergeDotAreaThreshold=2.0000000
    NavMeshGen_MinMergeDotLargeArea=0.9500000
    NavMeshGen_MaxPolyHeight=160.0000000
    NavMeshGen_HeightMergeThreshold=10.0000000
    NavMeshGen_EdgeMaxDelta=2.0000000
    NavMeshGen_MaxGroundCheckSize=30.0000000
    NavMeshGen_MinEdgeLength=7.0000000
    NavMeshGen_MinRadius=48.0000000
    NavMeshGen_MaxRadius=260.0000000
    StandardJumpHeight=2.0000000
    StandardJumpDistance=60.0000000
    NavMeshGen_RecastCellSize=25.0000000
    NavMeshGen_RecastCellHeight=10.0000000
    NavMeshGen_RecastErodeRadius=25.0000000
    NavMeshGen_ExpansionDoObstacleMeshSimplification=true
    AccelRate=1.0000000
    // Reference: CylinderComponent'Engine.Default__Scout.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'Engine.Default__Pawn.CollisionCylinder'
    begin object name="CollisionCylinder"
        ReplacementPrimitive=none
    end object
    CylinderComponent=CollisionCylinder
    Components[0]=CollisionCylinder
    RemoteRole=ENetRole.ROLE_None
    bCollideActors=false
    bCollideWorld=false
    bBlockActors=false
    bProjTarget=false
    bPathColliding=true
    CollisionComponent=CollisionCylinder
}