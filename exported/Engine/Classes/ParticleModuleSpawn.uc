class ParticleModuleSpawn extends ParticleModuleSpawnBase
    native(Particle)
    editinlinenew
    hidecategories(Object,Object,Object,ParticleModuleSpawnBase);

var(Spawn) RawDistributionFloat Rate;
var(Spawn) RawDistributionFloat RateScale;
var(Burst) ParticleEmitter.EParticleBurstMethod ParticleBurstMethod;
var(Burst) noclear export array<export ParticleBurst> BurstList;

defaultproperties
{
    // Reference: DistributionFloatConstant'Engine.Default__ParticleModuleSpawn.RequiredDistributionSpawnRate'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'RequiredDistributionSpawnRate'
    begin object name="RequiredDistributionSpawnRate" class=Engine.DistributionFloatConstant
        Constant=20.0000000
    end object
    // Reference: DistributionFloatConstant'Engine.Default__ParticleModuleSpawn.RequiredDistributionSpawnRateScale'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'RequiredDistributionSpawnRateScale'
    begin object name="RequiredDistributionSpawnRateScale" class=Engine.DistributionFloatConstant
        Constant=1.0000000
    end object
    Rate=(Distribution=Distribution=RequiredDistributionSpawnRate,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(20.0000000,20.0000000,20.0000000,20.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    RateScale=(Distribution=Distribution=RequiredDistributionSpawnRateScale,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(1.0000000,1.0000000,1.0000000,1.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    LODDuplicate=false
}