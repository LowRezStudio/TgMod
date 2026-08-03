class ParticleModuleSize_Seeded extends ParticleModuleSize
    native(Particle)
    editinlinenew
    hidecategories(Object,Object,Object,Object);

var(RandomSeed) ParticleRandomSeedInfo RandomSeedInfo;

defaultproperties
{
    // Reference: DistributionVectorUniform'Engine.Default__ParticleModuleSize_Seeded.DistributionStartSize'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionStartSize'
    // Archetype: DistributionVectorUniform'Engine.Default__ParticleModuleSize.DistributionStartSize'
    begin object name="DistributionStartSize"
    end object
    RandomSeedInfo=(ParameterName="None",bGetSeedFromInstance=false,bInstanceSeedIsIndex=false,bResetSeedOnEmitterLooping=true,RandomSeeds=none)
    StartSize=(Distribution=Distribution=DistributionStartSize)
    bSupportsRandomSeed=true
    bRequiresLoopingNotification=true
}