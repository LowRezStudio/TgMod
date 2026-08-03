class ParticleModuleMeshRotation_Seeded extends ParticleModuleMeshRotation
    native(Particle)
    editinlinenew
    hidecategories(Object,Object,Object,Object);

var(RandomSeed) ParticleRandomSeedInfo RandomSeedInfo;

defaultproperties
{
    // Reference: DistributionVectorUniform'Engine.Default__ParticleModuleMeshRotation_Seeded.DistributionStartRotation'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionStartRotation'
    // Archetype: DistributionVectorUniform'Engine.Default__ParticleModuleMeshRotation.DistributionStartRotation'
    begin object name="DistributionStartRotation"
    end object
    RandomSeedInfo=(ParameterName="None",bGetSeedFromInstance=false,bInstanceSeedIsIndex=false,bResetSeedOnEmitterLooping=true,RandomSeeds=none)
    StartRotation=(Distribution=Distribution=DistributionStartRotation)
    bSupportsRandomSeed=true
    bRequiresLoopingNotification=true
}