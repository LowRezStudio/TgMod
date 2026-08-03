class ParticleModuleColor_Seeded extends ParticleModuleColor
    native(Particle)
    editinlinenew
    hidecategories(Object,Object,Object,Object);

var(RandomSeed) ParticleRandomSeedInfo RandomSeedInfo;

defaultproperties
{
    // Reference: DistributionVectorConstant'Engine.Default__ParticleModuleColor_Seeded.DistributionStartColor'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionStartColor'
    // Archetype: DistributionVectorConstant'Engine.Default__ParticleModuleColor.DistributionStartColor'
    begin object name="DistributionStartColor"
    end object
    // Reference: DistributionFloatConstant'Engine.Default__ParticleModuleColor_Seeded.DistributionStartAlpha'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionStartAlpha'
    // Archetype: DistributionFloatConstant'Engine.Default__ParticleModuleColor.DistributionStartAlpha'
    begin object name="DistributionStartAlpha"
    end object
    RandomSeedInfo=(ParameterName="None",bGetSeedFromInstance=false,bInstanceSeedIsIndex=false,bResetSeedOnEmitterLooping=true,RandomSeeds=none)
    StartColor=(Distribution=Distribution=DistributionStartColor)
    StartAlpha=(Distribution=Distribution=DistributionStartAlpha)
    bSupportsRandomSeed=true
    bRequiresLoopingNotification=true
}