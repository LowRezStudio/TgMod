class ParticleModuleLocationPrimitiveSphere_Seeded extends ParticleModuleLocationPrimitiveSphere
    native(Particle)
    editinlinenew
    hidecategories(Object,Object,Object,Object,Object);

var(RandomSeed) ParticleRandomSeedInfo RandomSeedInfo;

defaultproperties
{
    // Reference: DistributionFloatConstant'Engine.Default__ParticleModuleLocationPrimitiveSphere_Seeded.DistributionStartRadius'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionStartRadius'
    // Archetype: DistributionFloatConstant'Engine.Default__ParticleModuleLocationPrimitiveSphere.DistributionStartRadius'
    begin object name="DistributionStartRadius"
    end object
    // Reference: DistributionFloatConstant'Engine.Default__ParticleModuleLocationPrimitiveSphere_Seeded.DistributionVelocityScale'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionVelocityScale'
    // Archetype: DistributionFloatConstant'Engine.Default__ParticleModuleLocationPrimitiveSphere.DistributionVelocityScale'
    begin object name="DistributionVelocityScale"
    end object
    // Reference: DistributionVectorConstant'Engine.Default__ParticleModuleLocationPrimitiveSphere_Seeded.DistributionStartLocation'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionStartLocation'
    // Archetype: DistributionVectorConstant'Engine.Default__ParticleModuleLocationPrimitiveSphere.DistributionStartLocation'
    begin object name="DistributionStartLocation"
    end object
    RandomSeedInfo=(ParameterName="None",bGetSeedFromInstance=false,bInstanceSeedIsIndex=false,bResetSeedOnEmitterLooping=true,RandomSeeds=none)
    StartRadius=(Distribution=Distribution=DistributionStartRadius)
    VelocityScale=(Distribution=Distribution=DistributionVelocityScale)
    StartLocation=(Distribution=Distribution=DistributionStartLocation)
    bSupportsRandomSeed=true
    bRequiresLoopingNotification=true
}