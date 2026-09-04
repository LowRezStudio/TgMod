class TerrainWeightMapTexture extends Texture2D
    native(Terrain)
    hidecategories(Object,Object);

struct TerrainWeightedMaterial
{
};

var const Terrain ParentTerrain;
var private native const array<Pointer> WeightedMaterials;
