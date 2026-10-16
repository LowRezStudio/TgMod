class ProcBuildingRuleset extends Object
    native(ProcBuilding)
    hidecategories(Object);

enum EProcBuildingAxis
{
    EPBAxis_X,                      // 0
    EPBAxis_Z,                      // 1
    EPBAxis_MAX                     // 2
};

struct native PBVariationInfo
{
    var() name VariationName;
    var() bool bMeshOnTopOfFacePoly;

    structdefaultproperties
    {
        VariationName="None"
        bMeshOnTopOfFacePoly=false
    }
};

struct native PBParamSwatch
{
    var() name SwatchName;
    var() array<PBMaterialParam> Params;

    structdefaultproperties
    {
        SwatchName="None"
        Params=none
    }
};

var export editinline PBRuleNodeBase RootRule;
var editoronly transient bool bBeingEdited;
var(LOD) bool bEnableInteriorTexture;
var(LOD) bool bLODOnlyRoof;
var() bool bPickRandomSwatch;
var(Roof) MaterialInterface DefaultRoofMaterial;
var(Floor) MaterialInterface DefaultFloorMaterial;
var() MaterialInterface DefaultNonRectWallMaterial;
var(Roof) float RoofZOffset;
var(Roof) float NotRoofZOffset;
var(Floor) float FloorZOffset;
var(Floor) float NotFloorZOffset;
var(Roof) float RoofPolyInset;
var(Floor) float FloorPolyInset;
var(LOD) float BuildingLODSpecular;
var(Roof) float RoofEdgeScopeRaise;
var(LOD) Texture LODCubemap;
var(LOD) Texture InteriorTexture;
var() array<PBVariationInfo> Variations;
var() array<PBParamSwatch> ParamSwatches;

defaultproperties
{
    bEnableInteriorTexture=true
    BuildingLODSpecular=2.0000000
}