class ParticleModuleTrailSpawn extends ParticleModuleTrailBase
    native(Particle)
    editinlinenew
    hidecategories(Object,Object,Object);

enum ETrail2SpawnMethod
{
    PET2SM_Emitter,                 // 0
    PET2SM_Velocity,                // 1
    PET2SM_Distance,                // 2
    PET2SM_MAX                      // 3
};

var(Spawn) noclear export editinline DistributionFloatParticleParameter SpawnDistanceMap;
var(Spawn) float MinSpawnVelocity;

defaultproperties
{
    // Reference: DistributionFloatParticleParameter'Engine.Default__ParticleModuleTrailSpawn.DistributionSpawnDistanceMap'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionSpawnDistanceMap'
    begin object name="DistributionSpawnDistanceMap" class=Engine.DistributionFloatParticleParameter
        MinInput=10.0000000
        MaxInput=100.0000000
        MinOutput=1.0000000
        MaxOutput=5.0000000
        Constant=1.0000000
    end object
    SpawnDistanceMap=DistributionSpawnDistanceMap
}