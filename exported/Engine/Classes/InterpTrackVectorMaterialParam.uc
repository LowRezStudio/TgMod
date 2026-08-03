class InterpTrackVectorMaterialParam extends InterpTrackVectorBase
    native(Interpolation)
    collapsecategories
    hidecategories(Object);

var() const array<MaterialReferenceList> Materials;
var const deprecated MaterialInterface Material;
var() name ParamName;
var transient bool bNeedsMaterialRefsUpdate;

defaultproperties
{
    TrackInstClass=Class'Engine.InterpTrackInstVectorMaterialParam'
    TrackTitle="Vector Material Param"
}