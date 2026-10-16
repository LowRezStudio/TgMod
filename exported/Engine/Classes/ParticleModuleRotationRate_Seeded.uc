class ParticleModuleRotationRate_Seeded extends ParticleModuleRotationRate
    native(Particle)
    editinlinenew
    hidecategories(Object,Object,Object,Object);

var(RandomSeed) ParticleRandomSeedInfo RandomSeedInfo;

defaultproperties
{
    // Reference: DistributionFloatConstant'Engine.Default__ParticleModuleRotationRate_Seeded.DistributionStartRotationRate'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionStartRotationRate'
    // Archetype: DistributionFloatConstant'Engine.Default__ParticleModuleRotationRate.DistributionStartRotationRate'
    begin object name="DistributionStartRotationRate"
    end object
    RandomSeedInfo=(ParameterName="None",bGetSeedFromInstance=false,bInstanceSeedIsIndex=false,bResetSeedOnEmitterLooping=true,RandomSeeds=none)
    StartRotationRate=(Distribution=Distribution=DistributionStartRotationRate)
    bSupportsRandomSeed=true
    bRequiresLoopingNotification=true
}