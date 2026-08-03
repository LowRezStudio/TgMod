class MaterialExpressionTerrainLayerCoords extends MaterialExpression
    native(Material)
    collapsecategories
    hidecategories(Object,Object);

enum ETerrainCoordMappingType
{
    TCMT_Auto,                      // 0
    TCMT_XY,                        // 1
    TCMT_XZ,                        // 2
    TCMT_YZ,                        // 3
    TCMT_MAX                        // 4
};

var() MaterialExpressionTerrainLayerCoords.ETerrainCoordMappingType MappingType;
var() float MappingScale;
var() float MappingRotation;
var() float MappingPanU;
var() float MappingPanV;

defaultproperties
{
    MenuCategories[0]="Terrain"
    MenuCategories[1]="WorldPosOffset"
}