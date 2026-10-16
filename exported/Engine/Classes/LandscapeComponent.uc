class LandscapeComponent extends PrimitiveComponent
    native(Terrain)
    hidecategories(Display,Attachment,Physics,Debug,Lighting,Collision,Movement,Rendering,PrimitiveComponent,Object);

struct native WeightmapLayerAllocationInfo
{
    var name LayerName;
    var byte WeightmapTextureIndex;
    var byte WeightmapTextureChannel;

    structdefaultproperties
    {
        LayerName="None"
        WeightmapTextureIndex=0
        WeightmapTextureChannel=0
    }
};

var() const editconst int SectionBaseX;
var() const editconst int SectionBaseY;
var const int ComponentSizeQuads;
var const int SubsectionSizeQuads;
var const int NumSubsections;
var() MaterialInterface OverrideMaterial;
var MaterialInstanceConstant MaterialInstance;
var private const array<WeightmapLayerAllocationInfo> WeightmapLayerAllocations;
var private const array<Texture2D> WeightmapTextures;
var native IndirectArray_Mirror WeightmapData;
var Vector4 WeightmapScaleBias;
var float WeightmapSubsectionOffset;
var Vector4 HeightmapScaleBias;
var private const Texture2D HeightmapTexture;
var const BoxSphereBounds CachedBoxSphereBounds;
var const Box CachedLocalBox;
var private const array<ShadowMap2D> ShadowMaps;
var const array<Guid> IrrelevantLights;
var private native const LightMapRef LightMap;
var private native Pointer EditToolRenderData;
var int CollisionMipLevel;
var private native Pointer PlatformData;
var native const int PlatformDataSize;
var editoronly transient bool bNeedPostUndo;
var(LOD) int ForcedLOD;
var byte NeighborLOD[8];
var byte NeighborLODBias[8];
var(LOD) int LODBias;

defaultproperties
{
    WeightmapScaleBias=(X=0.0000000,Y=0.0000000,Z=0.0000000,W=1.0000000)
    HeightmapScaleBias=(X=0.0000000,Y=0.0000000,Z=0.0000000,W=1.0000000)
    ForcedLOD=-1
    NeighborLOD[0]=255
    NeighborLOD[1]=255
    NeighborLOD[2]=255
    NeighborLOD[3]=255
    NeighborLOD[4]=255
    NeighborLOD[5]=255
    NeighborLOD[6]=255
    NeighborLOD[7]=255
    NeighborLODBias[0]=128
    NeighborLODBias[1]=128
    NeighborLODBias[2]=128
    NeighborLODBias[3]=128
    NeighborLODBias[4]=128
    NeighborLODBias[5]=128
    NeighborLODBias[6]=128
    NeighborLODBias[7]=128
    ReplacementPrimitive=none
    bAllowCullDistanceVolume=false
    bUseAsOccluder=true
    bAcceptsStaticDecals=true
    CastShadow=true
    bForceDirectLightMap=true
    bAcceptsLights=true
    bUsePrecomputedShadows=true
    CollideActors=true
    BlockActors=true
    BlockZeroExtent=true
    BlockNonZeroExtent=true
    BlockRigidBody=true
    LightingChannels=(bInitialized=true,Static=true)
}