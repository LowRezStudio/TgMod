class Terrain extends Info
    native(Terrain)
    placeable
    hidecategories(Navigation);

struct TerrainHeight
{
};

struct TerrainInfoData
{
};

struct TerrainWeightedMaterial
{
};

struct TerrainLayer
{
    var() string Name;
    var() TerrainLayerSetup Setup;
    var int AlphaMapIndex;
    var() bool Highlighted;
    var() bool WireframeHighlighted;
    var() bool Hidden;
    var() Color HighlightColor;
    var() Color WireframeColor;
    var int MinX;
    var int MinY;
    var int MaxX;
    var int MaxY;

    structdefaultproperties
    {
        Name=""
        Setup=none
        AlphaMapIndex=-1
        Highlighted=false
        WireframeHighlighted=false
        Hidden=false
        HighlightColor=(R=255,G=255,B=255,A=0)
        WireframeColor=(R=0,G=0,B=0,A=0)
        MinX=0
        MinY=0
        MaxX=0
        MaxY=0
    }
};

struct AlphaMap
{
};

struct TerrainDecorationInstance
{
    var export editinline PrimitiveComponent Component;
    var float X;
    var float Y;
    var float Scale;
    var int Yaw;

    structdefaultproperties
    {
        Component=none
        X=0.0000000
        Y=0.0000000
        Scale=0.0000000
        Yaw=0
    }
};

struct TerrainDecoration
{
    var() editinline PrimitiveComponentFactory Factory;
    var() float MinScale;
    var() float MaxScale;
    var() float Density;
    var() float SlopeRotationBlend;
    var() int RandSeed;
    var array<TerrainDecorationInstance> Instances;

    structdefaultproperties
    {
        Factory=none
        MinScale=1.0000000
        MaxScale=1.0000000
        Density=0.0100000
        SlopeRotationBlend=0.0000000
        RandSeed=0
        Instances=none
    }
};

struct TerrainDecoLayer
{
    var() string Name;
    var() array<TerrainDecoration> Decorations;
    var int AlphaMapIndex;

    structdefaultproperties
    {
        Name=""
        Decorations=none
        AlphaMapIndex=-1
    }
};

struct TerrainMaterialResource
{
};

struct native CachedTerrainMaterialArray
{
    var native const array<Pointer> CachedMaterials;
};

struct SelectedTerrainVertex
{
    var int X;
    var int Y;
    var int Weight;

    structdefaultproperties
    {
        X=0
        Y=0
        Weight=0
    }
};

var private native const array<TerrainHeight> Heights;
var private native const array<TerrainInfoData> InfoData;
var() const array<TerrainLayer> Layers;
var() int NormalMapLayer;
var() const array<TerrainDecoLayer> DecoLayers;
var native const array<AlphaMap> AlphaMaps;
var nontransactional const export editinline array<export editinline TerrainComponent> TerrainComponents;
var const int NumSectionsX;
var const int NumSectionsY;
var private native const array<TerrainWeightedMaterial> WeightedMaterials;
var private native const array<TerrainWeightMapTexture> WeightedTextureMaps;
var() int MaxTesselationLevel;
var() int MinTessellationLevel;
var() float TesselationDistanceScale;
var() float TessellationCheckDistance;
var(Collision) int CollisionTesselationLevel;
var native const CachedTerrainMaterialArray CachedTerrainMaterials[2];
var const int NumVerticesX;
var const int NumVerticesY;
var() int NumPatchesX;
var() int NumPatchesY;
var() int MaxComponentSize;
var(Lighting) int StaticLightingResolution;
var(Lighting) bool bIsOverridingLightResolution;
var(Lighting) bool bBilinearFilterLightmapGeneration;
var(Lighting) bool bCastShadow;
var(Lighting) const bool bForceDirectLightMap;
var(Lighting) const bool bCastDynamicShadow;
var(Lighting) bool bEnableSpecular;
var(Collision) const bool bBlockRigidBody;
var(Collision) const bool bAllowRigidBodyUnderneath;
var(Lighting) const bool bAcceptsDynamicLights;
var() bool bMorphingEnabled;
var() bool bMorphingGradientsEnabled;
var bool bLocked;
var bool bHeightmapLocked;
var bool bShowingCollision;
var() bool bUseWorldOriginTextureUVs;
var() bool bShowWireframe;
var(Physics) const PhysicalMaterial TerrainPhysMaterialOverride;
var(Lighting) const LightingChannelContainer LightingChannels;
var(Lightmass) LightmassPrimitiveSettings LightmassSettings;
var native const Pointer ReleaseResourcesFence;
var() transient int EditorTessellationLevel;
var transient array<SelectedTerrainVertex> SelectedVertices;
var() Color WireframeColor;

// Export UTerrain::execCalcLayerBounds(FFrame&, void* const)
native final function CalcLayerBounds();

simulated event PostBeginPlay()
{
    local int I;

    CalcLayerBounds();
    I = 0;
    J0x15:

    // End:0xA3 [Loop If]
    if(I < Layers.Length)
    {
        // End:0x95
        if(Layers[I].Setup != none)
        {
            Layers[I].Setup.PostBeginPlay();
        }
        I++;
        // [Loop Continue]
        goto J0x15;
    }
    //return;    
}

defaultproperties
{
    NormalMapLayer=-1
    MaxTesselationLevel=4
    MinTessellationLevel=1
    TesselationDistanceScale=1.0000000
    TessellationCheckDistance=-1.0000000
    CollisionTesselationLevel=1
    NumPatchesX=1
    NumPatchesY=1
    MaxComponentSize=16
    StaticLightingResolution=4
    bBilinearFilterLightmapGeneration=true
    bCastShadow=true
    bForceDirectLightMap=true
    bCastDynamicShadow=true
    bBlockRigidBody=true
    bAcceptsDynamicLights=true
    LightingChannels=(bInitialized=true,BSP=false,Static=true,Dynamic=false,CompositeDynamic=false,Skybox=false,Unnamed_1=false,Unnamed_2=false,Unnamed_3=false,Unnamed_4=false,Unnamed_5=false,Unnamed_6=false,Cinematic_1=false,Cinematic_2=false,Cinematic_3=false,Cinematic_4=false,Cinematic_5=false,Cinematic_6=false,Cinematic_7=false,Cinematic_8=false,Cinematic_9=false,Cinematic_10=false,Gameplay_1=false,Gameplay_2=false,Gameplay_3=false,Gameplay_4=false,Crowd=false)
    LightmassSettings=(bUseTwoSidedLighting=false,bShadowIndirectOnly=false,bUseEmissiveForStaticLighting=false,EmissiveLightFalloffExponent=2.0000000,EmissiveLightExplicitInfluenceRadius=0.0000000,EmissiveBoost=1.0000000,DiffuseBoost=1.0000000,SpecularBoost=1.0000000,FullyOccludedSamplesFraction=1.0000000)
    WireframeColor=(R=0,G=255,B=255,A=0)
    DrawScale3D=(X=256.0000000,Y=256.0000000,Z=256.0000000)
    bStatic=true
    bHidden=false
    bNoDelete=true
    bWorldGeometry=true
    bCollideActors=true
    bBlockActors=true
    bEdShouldSnap=true
}