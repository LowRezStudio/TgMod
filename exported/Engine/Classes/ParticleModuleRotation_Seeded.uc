class ParticleModuleRotation_Seeded extends ParticleModuleRotation
    native(Particle)
    editinlinenew
    hidecategories(Object,Object,Object,Object);

var(RandomSeed) ParticleRandomSeedInfo RandomSeedInfo;

defaultproperties
{
    // Reference: DistributionFloatUniform'Engine.Default__ParticleModuleRotation_Seeded.DistributionStartRotation'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionStartRotation'
    // Archetype: DistributionFloatUniform'Engine.Default__ParticleModuleRotation.DistributionStartRotation'
    begin object name="DistributionStartRotation"
    end object
    RandomSeedInfo=(ParameterName="None",bGetSeedFromInstance=false,bInstanceSeedIsIndex=false,bResetSeedOnEmitterLooping=true,RandomSeeds=none)
    StartRotation=(Distribution=Distribution=DistributionStartRotation)
    bSupportsRandomSeed=true
    bRequiresLoopingNotification=true
}