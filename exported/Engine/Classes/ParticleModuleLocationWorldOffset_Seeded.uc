class ParticleModuleLocationWorldOffset_Seeded extends ParticleModuleLocationWorldOffset
    native(Particle)
    editinlinenew
    hidecategories(Object,Object,Object);

var(RandomSeed) ParticleRandomSeedInfo RandomSeedInfo;

defaultproperties
{
    // Reference: DistributionVectorUniform'Engine.Default__ParticleModuleLocationWorldOffset_Seeded.DistributionStartLocation'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionStartLocation'
    // Archetype: DistributionVectorUniform'Engine.Default__ParticleModuleLocationWorldOffset.DistributionStartLocation'
    begin object name="DistributionStartLocation"
    end object
    RandomSeedInfo=(ParameterName="None",bGetSeedFromInstance=false,bInstanceSeedIsIndex=false,bResetSeedOnEmitterLooping=true,RandomSeeds=none)
    StartLocation=(Distribution=Distribution=DistributionStartLocation)
    bSupportsRandomSeed=true
    bRequiresLoopingNotification=true
}