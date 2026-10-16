class InterpTrackFloatMaterialParam extends InterpTrackFloatBase
    native(Interpolation)
    collapsecategories
    hidecategories(Object);

var() const array<MaterialReferenceList> Materials;
var const deprecated MaterialInterface Material;
var() name ParamName;
var transient bool bNeedsMaterialRefsUpdate;

defaultproperties
{
    TrackInstClass=Class'Engine.InterpTrackInstFloatMaterialParam'
    TrackTitle="Float Material Param"
}