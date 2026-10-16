class ParticleModuleLocation_Seeded extends ParticleModuleLocation
    native(Particle)
    editinlinenew
    hidecategories(Object,Object,Object,Object);

var(RandomSeed) ParticleRandomSeedInfo RandomSeedInfo;

defaultproperties
{
    // Reference: DistributionVectorUniform'Engine.Default__ParticleModuleLocation_Seeded.DistributionStartLocation'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionStartLocation'
    // Archetype: DistributionVectorUniform'Engine.Default__ParticleModuleLocation.DistributionStartLocation'
    begin object name="DistributionStartLocation"
    end object
    RandomSeedInfo=(ParameterName="None",bGetSeedFromInstance=false,bInstanceSeedIsIndex=false,bResetSeedOnEmitterLooping=true,RandomSeeds=none)
    StartLocation=(Distribution=Distribution=DistributionStartLocation)
    bSupportsRandomSeed=true
    bRequiresLoopingNotification=true
}