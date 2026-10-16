class ParticleModuleMeshRotationRate_Seeded extends ParticleModuleMeshRotationRate
    native(Particle)
    editinlinenew
    hidecategories(Object,Object,Object,Object);

var(RandomSeed) ParticleRandomSeedInfo RandomSeedInfo;

defaultproperties
{
    // Reference: DistributionVectorUniform'Engine.Default__ParticleModuleMeshRotationRate_Seeded.DistributionStartRotationRate'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionStartRotationRate'
    // Archetype: DistributionVectorUniform'Engine.Default__ParticleModuleMeshRotationRate.DistributionStartRotationRate'
    begin object name="DistributionStartRotationRate"
    end object
    RandomSeedInfo=(ParameterName="None",bGetSeedFromInstance=false,bInstanceSeedIsIndex=false,bResetSeedOnEmitterLooping=true,RandomSeeds=none)
    StartRotationRate=(Distribution=Distribution=DistributionStartRotationRate)
    bSupportsRandomSeed=true
    bRequiresLoopingNotification=true
}