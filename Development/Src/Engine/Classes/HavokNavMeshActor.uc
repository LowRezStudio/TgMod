class HavokNavMeshActor extends Actor
    native(Havok)
    placeable
    hidecategories(Navigation,Display,Attachment,Collision,Physics,Advanced,Debug,Object,Relevancy,Mobile)
    config(Engine);

enum EHavokVersion {
    HAVOK_2012_2,  // 0
    HAVOK_2013_3,  // 1
    HAVOK_2014_2,  // 2
    HAVOK_2016_1,  // 3
};

struct NavMeshLayerInfo {
    var name Desc;
    var float Radius;
    var float Height;
    var float CrouchHeight;
    var byte PathColor;
    structdefaultproperties {}
};

struct UserEdgeData {
    var Vector StartA;
    var Vector EndA;
    var Vector StartB;
    var Vector EndB;
    var byte TraversalType;
    var float EdgeCost;
    structdefaultproperties {}
};

var transient bool bNavMeshLoaded;
var (DebugDraw) bool DrawTraversalAnalysis;
var (DebugDraw) bool DrawNavMeshEdges;
var (DebugDraw) bool DrawNavMeshUserEdges;
var (DebugDraw) bool DrawNavMeshFaces;
var (DebugDraw) bool DrawCluster;
var (DebugDraw) bool DrawFaceToClusterLines;
var (GenerationBasic) bool FixupOverlappingTriangles;
var (GenerationBasic) bool IncludeUserEdgesInClusters;
var (GenerationBasic) bool ShrinkNavMeshByCharacterWidth;
var (Simplification) bool UseSimplification;
var (RegionPruning) bool PreserveVerticalBorderRegions;
var (RegionPruning) bool BorderPreservationTolerance;
var (TraversalAnalsysisDropDowns) bool bAnalyzeDropDowns;
var (TraversalAnalsysisJumps) bool bAnalyzeJumps;
var const export editinline transient SpriteComponent EditorSprite;
var export editinline HavokNavigationRenderingComponent RenderingComponent;
var native const UntypedBulkData_Mirror NavMeshData;
var native Pointer HavokWorld;
var HavokNavMeshGrid HavokGrid;
var () editconst HavokNavMeshActor.EHavokVersion Version;
var (DebugDraw) Vector DrawClusterOffset;
var (GenerationBasic) Vector SingleCarverAABBMin;
var (GenerationBasic) Vector SingleCarverAABBMax;
var (Simplification) float MaxBorderDistanceError;
var (Simplification) float MaxPartitionHeightError;
var (RegionPruning) float MinRegionArea;
var (RegionPruning) float MinDistanceToSeed;
var (Character) float MaxWalkableSlope;
var (Character) float EntityHalfHeight;
var (Character) float StartingHeightOffset;
var (Character) float MaxStepHeight;
var (Character) float MaxPolyHeight;
var (Character) float HeightMergeThreshold;
var (Character) float MinRadius;
var (Character) float MaxRadius;
var (TraversalAnalsysisDropDowns) float MaxDropHeight;
var (TraversalAnalsysisDropDowns) float MaxUnderhang;
var (TraversalAnalsysisDropDowns) float DropDownCost;
var (TraversalAnalsysisJumps) float MaxJumpHeight;
var (TraversalAnalsysisJumps) float StandardJumpHeight;
var (TraversalAnalsysisJumps) float StandardJumpDistance;
var (TraversalAnalsysisJumps) float JumpCost;

native function InitializeNavMesh();  // Export UHavokNavMeshActor::execInitializeNavMesh(FFrame&, void* const)

native function CleanupNavMesh();  // Export UHavokNavMeshActor::execCleanupNavMesh(FFrame&, void* const)

defaultproperties
{
    DrawTraversalAnalysis=true
    DrawNavMeshEdges=true
    DrawNavMeshUserEdges=true
    DrawNavMeshFaces=true
    ShrinkNavMeshByCharacterWidth=true
    UseSimplification=true
    bAnalyzeDropDowns=true
    Version=HAVOK_2014_2
    DrawClusterOffset=(X=0.0000000,Y=0.0000000,Z=64.0000000)
    MaxBorderDistanceError=2.0000000
    MaxPartitionHeightError=16.0000000
    MinRegionArea=200000.0000000
    MinDistanceToSeed=0.5000000
    MaxWalkableSlope=0.8000000
    EntityHalfHeight=17.5000000
    StartingHeightOffset=65.0000000
    MaxStepHeight=20.0000000
    MaxPolyHeight=120.0000000
    MinRadius=35.0000000
    MaxRadius=55.0000000
    MaxDropHeight=4000.0000000
    MaxUnderhang=10.0000000
    DropDownCost=1.0000000
    MaxJumpHeight=100.0000000
    StandardJumpHeight=80.0000000
    StandardJumpDistance=160.0000000
    JumpCost=2.0000000
    Components[0]=none
    Components[1]=none
    bStatic=true
    bNoDelete=true
    bMovable=false
}
