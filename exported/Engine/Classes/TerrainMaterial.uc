class TerrainMaterial extends Object
    native(Terrain)
    hidecategories(Object);

enum ETerrainMappingType
{
    TMT_Auto,                       // 0
    TMT_XY,                         // 1
    TMT_XZ,                         // 2
    TMT_YZ,                         // 3
    TMT_MAX                         // 4
};

var Matrix LocalToMapping;
var(Material) TerrainMaterial.ETerrainMappingType MappingType;
var(Material) float MappingScale;
var(Material) float MappingRotation;
var(Material) float MappingPanU;
var(Material) float MappingPanV;
var(Material) MaterialInterface Material;
var(Displacement) Texture2D DisplacementMap;
var(Displacement) float DisplacementScale;

defaultproperties
{
    MappingScale=4.0000000
    DisplacementScale=0.2500000
}