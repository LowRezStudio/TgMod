class ProcBuilding extends Volume
    native(ProcBuilding)
    placeable
    hidecategories(Navigation,Object,Movement,Display);

const ROOF_MINZ = 0.7;
const PROCBUILDING_VERSION = 1;

enum EScopeEdge
{
    EPSA_Top,                       // 0
    EPSA_Bottom,                    // 1
    EPSA_Left,                      // 2
    EPSA_Right,                     // 3
    EPSA_None,                      // 4
    EPSA_MAX                        // 5
};

enum EPBCornerType
{
    EPBC_Default,                   // 0
    EPBC_Chamfer,                   // 1
    EPBC_Round,                     // 2
    EPBC_MAX                        // 3
};

enum EBuildingStatsBrowserColumns
{
    BSBC_Name,                      // 0
    BSBC_Ruleset,                   // 1
    BSBC_NumStaticMeshComps,        // 2
    BSBC_NumInstancedStaticMeshComps,// 3
    BSBC_NumInstancedTris,          // 4
    BSBC_LightmapMemBytes,          // 5
    BSBC_ShadowmapMemBytes,         // 6
    BSBC_LODDiffuseMemBytes,        // 7
    BSBC_LODLightingMemBytes,       // 8
    BSBC_MAX                        // 9
};

struct native PBScope2D
{
    var Matrix ScopeFrame;
    var float DimX;
    var float DimZ;

    structdefaultproperties
    {
        ScopeFrame=(XPlane=(W=0.0000000,X=0.0000000,Y=0.0000000,Z=0.0000000),YPlane=(W=0.0000000,X=0.0000000,Y=0.0000000,Z=0.0000000),ZPlane=(W=0.0000000,X=0.0000000,Y=0.0000000,Z=0.0000000),WPlane=(W=0.0000000,X=0.0000000,Y=0.0000000,Z=0.0000000))
        DimX=0.0000000
        DimZ=0.0000000
    }
};

struct native PBScopeProcessInfo
{
    var ProcBuilding OwningBuilding;
    var ProcBuildingRuleset Ruleset;
    var name RulesetVariation;
    var bool bGenerateLODPoly;
    var bool bPartOfNonRect;

    structdefaultproperties
    {
        OwningBuilding=none
        Ruleset=none
        RulesetVariation="None"
        bGenerateLODPoly=false
        bPartOfNonRect=false
    }
};

struct native PBFaceUVInfo
{
    var Vector2D Offset;
    var Vector2D Size;

    structdefaultproperties
    {
        Offset=(X=0.0000000,Y=0.0000000)
        Size=(X=0.0000000,Y=0.0000000)
    }
};

struct native PBEdgeInfo
{
    var Vector EdgeEnd;
    var Vector EdgeStart;
    var int ScopeAIndex;
    var ProcBuilding.EScopeEdge ScopeAEdge;
    var int ScopeBIndex;
    var ProcBuilding.EScopeEdge ScopeBEdge;
    var float EdgeAngle;

    structdefaultproperties
    {
        EdgeEnd=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        EdgeStart=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        ScopeAIndex=0
        ScopeAEdge=EScopeEdge.EPSA_Top
        ScopeBIndex=0
        ScopeBEdge=EScopeEdge.EPSA_Top
        EdgeAngle=0.0000000
    }
};

struct native PBMeshCompInfo
{
    var export editinline StaticMeshComponent MeshComp;
    var int TopLevelScopeIndex;

    structdefaultproperties
    {
        MeshComp=none
        TopLevelScopeIndex=0
    }
};

struct native PBFracMeshCompInfo
{
    var export editinline FracturedStaticMeshComponent FracMeshComp;
    var int TopLevelScopeIndex;

    structdefaultproperties
    {
        FracMeshComp=none
        TopLevelScopeIndex=0
    }
};

struct native PBMaterialParam
{
    var() name ParamName;
    var() LinearColor Color;

    structdefaultproperties
    {
        ParamName="None"
        Color=(R=0.0000000,G=0.0000000,B=0.0000000,A=1.0000000)
    }
};

struct native PBMemUsageInfo
{
    var ProcBuilding Building;
    var ProcBuildingRuleset Ruleset;
    var int NumStaticMeshComponent;
    var int NumInstancedStaticMeshComponents;
    var int NumInstancedTris;
    var int LightmapMemBytes;
    var int ShadowmapMemBytes;
    var int LODDiffuseMemBytes;
    var int LODLightingMemBytes;

    structdefaultproperties
    {
        Building=none
        Ruleset=none
        NumStaticMeshComponent=0
        NumInstancedStaticMeshComponents=0
        NumInstancedTris=0
        LightmapMemBytes=0
        ShadowmapMemBytes=0
        LODDiffuseMemBytes=0
        LODLightingMemBytes=0
    }
};

var() const editconst array<editconst PBMeshCompInfo> BuildingMeshCompInfos;
var() const editconst array<editconst PBFracMeshCompInfo> BuildingFracMeshCompInfos;
var() const editconst export editinline StaticMeshComponent SimpleMeshComp;
var() bool bGenerateRoofMesh;
var() bool bGenerateFloorMesh;
var() bool bApplyRulesToRoof;
var() bool bApplyRulesToFloor;
var() bool bSplitWallsAtRoofLevels;
var() bool bSplitWallsAtWallEdges;
var transient bool bQuickEdited;
var() bool bBuildingBrushCollision;
var(Debug) bool bDebugDrawEdgeInfo;
var(Debug) bool bDebugDrawScopes;
var const export editinline array<export editinline StaticMeshComponent> LODMeshComps;
var int NumMeshedTopLevelScopes;
var float MaxFacadeZ;
var float MinFacadeZ;
var transient array<ProcBuilding> OverlappingBuildings;
var() float SimpleMeshMassiveLODDistance;
var() float RenderToTexturePullBackAmount;
var() int RoofLightmapRes;
var() int NonRectWallLightmapRes;
var() name ParamSwatchName;
var() array<PBMaterialParam> BuildingMaterialParams;
var() duplicatetransient crosslevelpassive const editconst StaticMeshActor LowLODPersistentActor;
var export editinline transient StaticMeshComponent CurrentSimpleMeshComp;
var transient Actor CurrentSimpleMeshActor;
var const int BuildingInstanceVersion;

// Export UProcBuilding::execClearBuildingMeshes(FFrame&, void* const)
native function ClearBuildingMeshes();

// Export UProcBuilding::execFindComponentsForTopLevelScope(FFrame&, void* const)
native function array<editinline StaticMeshComponent> FindComponentsForTopLevelScope(int TopLevelScopeIndex);

// Export UProcBuilding::execGetBaseMostBuilding(FFrame&, void* const)
native function ProcBuilding GetBaseMostBuilding();

// Export UProcBuilding::execGetAllGroupedProcBuildings(FFrame&, void* const)
native function GetAllGroupedProcBuildings(out array<ProcBuilding> OutSet);

// Export UProcBuilding::execBreakFractureComponent(FFrame&, void* const)
native function BreakFractureComponent(FracturedStaticMeshComponent Comp, Vector BoxMin, Vector BoxMax);

// Export UProcBuilding::execFindEdgeForTopLevelScope(FFrame&, void* const)
native function int FindEdgeForTopLevelScope(int TopLevelScopeIndex, ProcBuilding.EScopeEdge Edge);

defaultproperties
{
    bGenerateRoofMesh=true
    bSplitWallsAtRoofLevels=true
    bSplitWallsAtWallEdges=true
    bBuildingBrushCollision=true
    SimpleMeshMassiveLODDistance=10000.0000000
    RenderToTexturePullBackAmount=125.0000000
    RoofLightmapRes=64
    NonRectWallLightmapRes=64
    LowLODPersistentActor=none
    BrushColor=(R=222,G=255,B=135,A=255)
    bColored=true
    // Reference: BrushComponent'Engine.Default__ProcBuilding.BrushComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'BrushComponent0'
    // Archetype: BrushComponent'Engine.Default__Volume.BrushComponent0'
    begin object name="BrushComponent0"
        ReplacementPrimitive=none
        RBChannel=ERBCollisionChannel.RBCC_BlockingVolume
        BlockActors=true
        BlockRigidBody=true
        bDisableAllRigidBody=false
    end object
    BrushComponent=BrushComponent0
    Components[0]=BrushComponent0
    bHidden=false
    bWorldGeometry=true
    bRouteBeginPlayEvenIfStatic=false
    bGameRelevant=true
    bMovable=false
    bBlockActors=true
    bForceOctreeSNFilter=true
    bPathColliding=true
    CollisionComponent=BrushComponent0
}