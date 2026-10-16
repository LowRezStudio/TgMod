class RB_BodySetup extends KMeshProps
    native(Physics)
    hidecategories(Object);

enum ESleepFamily
{
    SF_Normal,                      // 0
    SF_Sensitive,                   // 1
    SF_MAX                          // 2
};

struct KCachedConvexDataElement
{
    var native array<byte> ConvexElementData;
};

struct KCachedConvexData
{
    var native array<KCachedConvexDataElement> CachedConvexElements;
};

var() RB_BodySetup.ESleepFamily SleepFamily;
var() editconst name BoneName;
var() bool bFixed;
var() bool bNoCollision;
var() bool bBlockZeroExtent;
var() bool bBlockNonZeroExtent;
var() bool bNoBodyShotChecks;
var() bool bEnableContinuousCollisionDetection;
var() bool bAlwaysFullAnimWeight;
var() bool bConsiderForBounds;
var() PhysicalMaterial PhysMaterial;
var() float MassScale;
var native const array<Pointer> CollisionGeom;
var native const array<Vector> CollisionGeomScale3D;
var() const array<Vector> PreCachedPhysScale;
var native const array<KCachedConvexData> PreCachedPhysData;
var const int PreCachedPhysDataVersion;

defaultproperties
{
    bBlockZeroExtent=true
    bBlockNonZeroExtent=true
    bConsiderForBounds=true
    MassScale=1.0000000
}