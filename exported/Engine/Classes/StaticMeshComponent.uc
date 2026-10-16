class StaticMeshComponent extends MeshComponent
    native(Mesh)
    editinlinenew
    noexport
    hidecategories(Object);

enum ELightmapModificationFunction
{
    MLMF_Modulate,                  // 0
    MLMF_ModulateAlpha,             // 1
    MLMF_MAX                        // 2
};

struct PaintedVertex
{
    var Vector Position;
    var PackedNormal Normal;
    var Color Color;

    structdefaultproperties
    {
        Position=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        Normal=/* ERROR: System.ArgumentException */
        Color=(R=0,G=0,B=0,A=0)
    }
};

struct StaticMeshComponentLODInfo
{
    var private const array<ShadowMap2D> ShadowMaps;
    var private const array<Object> ShadowVertexBuffers;
    var private native const Pointer LightMap;
    var private native const Pointer OverrideVertexColors;
    var private const array<PaintedVertex> PaintedVertices;

    structdefaultproperties
    {
        ShadowMaps=none
        ShadowVertexBuffers=none
        PaintedVertices=none
    }
};

var() int ForcedLodModel;
var int PreviousLODLevel;
var() const StaticMesh StaticMesh;
var() Color WireframeColor;
var() bool bIgnoreInstanceForTextureStreaming;
var const deprecated bool bOverrideLightMapResolution;
var() const bool bOverrideLightMapRes;
var const deprecated int OverriddenLightMapResolution;
var() const int OverriddenLightMapRes;
var() float OverriddenLODMaxRange;
var() float StreamingDistanceMultiplier;
var const int SubDivisionStepSize;
var const bool bUseSubDivisions;
var const transient bool bForceStaticDecals;
var transient bool bCanHighlightSelectedSections;
var(MobileSettings) bool bUseSimpleLightmapModifications;
var(MobileSettings) StaticMeshComponent.ELightmapModificationFunction SimpleLightmapModificationFunction;
var(Physics) bool bNeverBecomeDynamic;
var const array<Guid> IrrelevantLights;
var private serializetext native const array<serializetext StaticMeshComponentLODInfo> LODData;
var private const int VertexPositionVersionNumber;
var private const int ForcedElementIndex;
var(Lightmass) LightmassPrimitiveSettings LightmassSettings;

// Export UStaticMeshComponent::execSetStaticMesh(FFrame&, void* const)
native simulated function bool SetStaticMesh(StaticMesh NewMesh, optional bool bForce);

// Export UStaticMeshComponent::execDisableRBCollisionWithSMC(FFrame&, void* const)
native simulated function DisableRBCollisionWithSMC(PrimitiveComponent OtherSMC, bool bDisabled);

// Export UStaticMeshComponent::execSetForceStaticDecals(FFrame&, void* const)
native final function SetForceStaticDecals(bool bInForceStaticDecals);

// Export UStaticMeshComponent::execCanBecomeDynamic(FFrame&, void* const)
native function bool CanBecomeDynamic();

defaultproperties
{
    WireframeColor=(R=0,G=255,B=255,A=255)
    OverriddenLightMapRes=64
    StreamingDistanceMultiplier=1.0000000
    SubDivisionStepSize=32
    ForcedElementIndex=-1
    LightmassSettings=(bUseTwoSidedLighting=false,bShadowIndirectOnly=false,bUseEmissiveForStaticLighting=false,EmissiveLightFalloffExponent=2.0000000,EmissiveLightExplicitInfluenceRadius=0.0000000,EmissiveBoost=1.0000000,DiffuseBoost=1.0000000,SpecularBoost=1.0000000,FullyOccludedSamplesFraction=1.0000000)
    ReplacementPrimitive=none
    bAcceptsStaticDecals=true
    CollideActors=true
    BlockActors=true
    BlockZeroExtent=true
    BlockNonZeroExtent=true
    BlockRigidBody=true
    TickGroup=ETickingGroup.TG_PreAsyncWork
}