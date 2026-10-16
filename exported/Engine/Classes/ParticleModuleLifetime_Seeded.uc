class ParticleModuleLifetime_Seeded extends ParticleModuleLifetime
    native(Particle)
    editinlinenew
    hidecategories(Object,Object,Object,Object);

var(RandomSeed) ParticleRandomSeedInfo RandomSeedInfo;

defaultproperties
{
    // Reference: DistributionFloatUniform'Engine.Default__ParticleModuleLifetime_Seeded.DistributionLifetime'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionLifetime'
    // Archetype: DistributionFloatUniform'Engine.Default__ParticleModuleLifetime.DistributionLifetime'
    begin object name="DistributionLifetime"
    end object
    RandomSeedInfo=(ParameterName="None",bGetSeedFromInstance=false,bInstanceSeedIsIndex=false,bResetSeedOnEmitterLooping=true,RandomSeeds=none)
    Lifetime=(Distribution=Distribution=DistributionLifetime)
    bSupportsRandomSeed=true
    bRequiresLoopingNotification=true
}