class ParticleModuleVelocity_Seeded extends ParticleModuleVelocity
    native(Particle)
    editinlinenew
    hidecategories(Object,Object,Object,Object);

var(RandomSeed) ParticleRandomSeedInfo RandomSeedInfo;

defaultproperties
{
    // Reference: DistributionVectorUniform'Engine.Default__ParticleModuleVelocity_Seeded.DistributionStartVelocity'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionStartVelocity'
    // Archetype: DistributionVectorUniform'Engine.Default__ParticleModuleVelocity.DistributionStartVelocity'
    begin object name="DistributionStartVelocity"
    end object
    // Reference: DistributionFloatUniform'Engine.Default__ParticleModuleVelocity_Seeded.DistributionStartVelocityRadial'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionStartVelocityRadial'
    // Archetype: DistributionFloatUniform'Engine.Default__ParticleModuleVelocity.DistributionStartVelocityRadial'
    begin object name="DistributionStartVelocityRadial"
    end object
    RandomSeedInfo=(ParameterName="None",bGetSeedFromInstance=false,bInstanceSeedIsIndex=false,bResetSeedOnEmitterLooping=true,RandomSeeds=none)
    StartVelocity=(Distribution=Distribution=DistributionStartVelocity)
    StartVelocityRadial=(Distribution=Distribution=DistributionStartVelocityRadial)
    bSupportsRandomSeed=true
    bRequiresLoopingNotification=true
}