class BrushComponent extends PrimitiveComponent
    native
    editinlinenew
    collapsecategories
    noexport;

struct KCachedConvexData_Mirror
{
    var array<int> CachedConvexElements;

    structdefaultproperties
    {
        CachedConvexElements=none
    }
};

var const Model Brush;
var KAggregateGeom BrushAggGeom;
var private noimport native const transient Pointer BrushPhysDesc;
var private noimport native const transient KCachedConvexData_Mirror CachedPhysBrushData;
var private const int CachedPhysBrushDataVersion;
var() bool bBlockComplexCollisionTrace;

defaultproperties
{
    ReplacementPrimitive=none
    HiddenGame=true
    bUseAsOccluder=true
    AlwaysLoadOnClient=false
    AlwaysLoadOnServer=false
}