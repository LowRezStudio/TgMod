class SpeedTreeComponent extends PrimitiveComponent
    native(SpeedTree)
    editinlinenew
    hidecategories(Object)
    autoexpandcategories(Collision,Rendering,Lighting);

enum ESpeedTreeMeshType
{
    STMT_MinMinusOne,               // 0
    STMT_Branches1,                 // 1
    STMT_Branches2,                 // 2
    STMT_Fronds,                    // 3
    STMT_LeafCards,                 // 4
    STMT_LeafMeshes,                // 5
    STMT_Billboards,                // 6
    STMT_Max                        // 7
};

struct native SpeedTreeStaticLight
{
    var private const Guid Guid;
    var private const ShadowMap1D BranchShadowMap;
    var private const ShadowMap1D FrondShadowMap;
    var private const ShadowMap1D LeafMeshShadowMap;
    var private const ShadowMap1D LeafCardShadowMap;
    var private const ShadowMap1D BillboardShadowMap;

    structdefaultproperties
    {
        Guid=(A=0,B=0,C=0,D=0)
        BranchShadowMap=none
        FrondShadowMap=none
        LeafMeshShadowMap=none
        LeafCardShadowMap=none
        BillboardShadowMap=none
    }
};

var(SpeedTree) const SpeedTree SpeedTree;
var(SpeedTree) bool bUseLeafCards;
var(SpeedTree) bool bUseLeafMeshes;
var(SpeedTree) bool bUseBranches;
var(SpeedTree) bool bUseFronds;
var(SpeedTree) bool bUseBillboards;
var(SpeedTree) float Lod3DStart;
var(SpeedTree) float Lod3DEnd;
var(SpeedTree) float LodBillboardStart;
var(SpeedTree) float LodBillboardEnd;
var(SpeedTree) float LodLevelOverride;
var(SpeedTree) MaterialInterface Branch1Material;
var(SpeedTree) MaterialInterface Branch2Material;
var(SpeedTree) MaterialInterface FrondMaterial;
var(SpeedTree) MaterialInterface LeafCardMaterial;
var(SpeedTree) MaterialInterface LeafMeshMaterial;
var(SpeedTree) MaterialInterface BillboardMaterial;
var(SpeedTree) MaterialInterface Branch1MaterialNoScreenDoor;
var(SpeedTree) MaterialInterface Branch2MaterialNoScreenDoor;
var(SpeedTree) MaterialInterface FrondMaterialNoScreenDoor;
var(SpeedTree) MaterialInterface LeafCardMaterialNoScreenDoor;
var(SpeedTree) MaterialInterface LeafMeshMaterialNoScreenDoor;
var(SpeedTree) MaterialInterface BillboardMaterialNoScreenDoor;
var private const array<SpeedTreeStaticLight> StaticLights;
var private native const LightMapRef BranchLightMap;
var private native const LightMapRef FrondLightMap;
var private native const LightMapRef LeafMeshLightMap;
var private native const LightMapRef LeafCardLightMap;
var private native const LightMapRef BillboardLightMap;
var private native const Matrix RotationOnlyMatrix;
var(Lightmass) LightmassPrimitiveSettings LightmassSettings;

// Export USpeedTreeComponent::execGetMaterial(FFrame&, void* const)
native function MaterialInterface GetMaterial(SpeedTreeComponent.ESpeedTreeMeshType MeshType);

// Export USpeedTreeComponent::execSetMaterial(FFrame&, void* const)
native function SetMaterial(SpeedTreeComponent.ESpeedTreeMeshType MeshType, MaterialInterface Material);

defaultproperties
{
    bUseLeafCards=true
    bUseLeafMeshes=true
    bUseBranches=true
    bUseFronds=true
    bUseBillboards=true
    Lod3DStart=500.0000000
    Lod3DEnd=3000.0000000
    LodBillboardStart=3500.0000000
    LodBillboardEnd=3850.0000000
    LodLevelOverride=-1.0000000
    LightmassSettings=(bUseTwoSidedLighting=false,bShadowIndirectOnly=false,bUseEmissiveForStaticLighting=false,EmissiveLightFalloffExponent=2.0000000,EmissiveLightExplicitInfluenceRadius=0.0000000,EmissiveBoost=1.0000000,DiffuseBoost=1.0000000,SpecularBoost=1.0000000,FullyOccludedSamplesFraction=1.0000000)
    ReplacementPrimitive=none
    bUseAsOccluder=true
    CastShadow=true
    bAcceptsLights=true
    bUsePrecomputedShadows=true
    CollideActors=true
    BlockActors=true
    BlockZeroExtent=true
    BlockNonZeroExtent=true
    BlockRigidBody=true
}