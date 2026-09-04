class LandscapeHeightfieldCollisionComponent extends PrimitiveComponent
    native(Terrain);

var native const UntypedBulkData_Mirror CollisionHeightData;
var const array<name> ComponentLayers;
var native const UntypedBulkData_Mirror DominantLayerData;
var const int SectionBaseX;
var const int SectionBaseY;
var int CollisionSizeQuads;
var float CollisionScale;
var const array<byte> CollisionQuadFlags;
var const array<PhysicalMaterial> PhysicalMaterials;
var native const Pointer RBHeightfield;
var const bool bHasKDOPData;
var bool bIncludeHoles;
var editoronly transient bool bHeightFieldDataHasHole;
var native const Pointer kDOPTree;
var init native const array<init Vector> kDOPCollisionVerts;
var const BoxSphereBounds CachedBoxSphereBounds;

defaultproperties
{
    ReplacementPrimitive=none
    bAllowCullDistanceVolume=false
    bUseAsOccluder=true
    bAcceptsDynamicDecals=false
    CastShadow=true
    bAcceptsLights=true
    bUsePrecomputedShadows=true
    CollideActors=true
    BlockActors=true
    BlockZeroExtent=true
    BlockNonZeroExtent=true
    BlockRigidBody=true
}