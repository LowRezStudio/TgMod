class TerrainLayerSetup extends Object
    native(Terrain)
    collapsecategories
    hidecategories(Object);

struct FilterLimit
{
    var() bool Enabled;
    var() float Base;
    var() float NoiseScale;
    var() float NoiseAmount;

    structdefaultproperties
    {
        Enabled=false
        Base=0.0000000
        NoiseScale=0.0000000
        NoiseAmount=0.0000000
    }
};

struct TerrainFilteredMaterial
{
    var() bool UseNoise;
    var() float NoiseScale;
    var() float NoisePercent;
    var() FilterLimit MinHeight;
    var() FilterLimit MaxHeight;
    var() FilterLimit MinSlope;
    var() FilterLimit MaxSlope;
    var() float Alpha;
    var() TerrainMaterial Material;

    structdefaultproperties
    {
        UseNoise=false
        NoiseScale=0.0000000
        NoisePercent=0.0000000
        MinHeight=(Enabled=false,Base=0.0000000,NoiseScale=0.0000000,NoiseAmount=0.0000000)
        MaxHeight=(Enabled=false,Base=0.0000000,NoiseScale=0.0000000,NoiseAmount=0.0000000)
        MinSlope=(Enabled=false,Base=0.0000000,NoiseScale=0.0000000,NoiseAmount=0.0000000)
        MaxSlope=(Enabled=false,Base=0.0000000,NoiseScale=0.0000000,NoiseAmount=0.0000000)
        Alpha=1.0000000
        Material=none
    }
};

var() const array<TerrainFilteredMaterial> Materials;

simulated function PostBeginPlay()
{
    //return;    
}
