class TerrainComponent extends PrimitiveComponent
    native(Terrain);

struct TerrainPatchBounds
{
    var float MinHeight;
    var float MaxHeight;
    var float MaxDisplacement;

    structdefaultproperties
    {
        MinHeight=0.0000000
        MaxHeight=0.0000000
        MaxDisplacement=0.0000000
    }
};

struct TerrainMaterialMask
{
    var QWord BitMask;
    var int NumBits;

    structdefaultproperties
    {
        BitMask=()
        NumBits=0
    }
};

struct TerrainBVTree
{
    var private native const array<int> Nodes;
};

var private const array<ShadowMap2D> ShadowMaps;
var const array<Guid> IrrelevantLights;
var native const transient Pointer TerrainObject;
var const int SectionBaseX;
var const int SectionBaseY;
var const int SectionSizeX;
var const int SectionSizeY;
var const int TrueSectionSizeX;
var const int TrueSectionSizeY;
var private native const LightMapRef LightMap;
var private native const transient array<TerrainPatchBounds> PatchBounds;
var private native const transient array<TerrainMaterialMask> BatchMaterials;
var private native const transient int FullBatch;
var private native const transient TerrainBVTree BVTree;
var private native const transient array<Vector> CollisionVertices;
var native const Pointer RBHeightfield;
var private const bool bDisplayCollisionLevel;

defaultproperties
{
    ReplacementPrimitive=none
    bAllowCullDistanceVolume=false
    bUseAsOccluder=true
    bAcceptsStaticDecals=true
    CastShadow=true
    bAcceptsLights=true
    bUsePrecomputedShadows=true
    CollideActors=true
    BlockActors=true
    BlockZeroExtent=true
    BlockNonZeroExtent=true
    BlockRigidBody=true
}