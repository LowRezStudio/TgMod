class ParticleModuleLocationPrimitiveCylinder_Seeded extends ParticleModuleLocationPrimitiveCylinder
    native(Particle)
    editinlinenew
    hidecategories(Object,Object,Object,Object,Object);

var(RandomSeed) ParticleRandomSeedInfo RandomSeedInfo;

defaultproperties
{
    // Reference: DistributionFloatConstant'Engine.Default__ParticleModuleLocationPrimitiveCylinder_Seeded.DistributionStartRadius'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionStartRadius'
    // Archetype: DistributionFloatConstant'Engine.Default__ParticleModuleLocationPrimitiveCylinder.DistributionStartRadius'
    begin object name="DistributionStartRadius"
    end object
    // Reference: DistributionFloatConstant'Engine.Default__ParticleModuleLocationPrimitiveCylinder_Seeded.DistributionStartHeight'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionStartHeight'
    // Archetype: DistributionFloatConstant'Engine.Default__ParticleModuleLocationPrimitiveCylinder.DistributionStartHeight'
    begin object name="DistributionStartHeight"
    end object
    // Reference: DistributionFloatConstant'Engine.Default__ParticleModuleLocationPrimitiveCylinder_Seeded.DistributionVelocityScale'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionVelocityScale'
    // Archetype: DistributionFloatConstant'Engine.Default__ParticleModuleLocationPrimitiveCylinder.DistributionVelocityScale'
    begin object name="DistributionVelocityScale"
    end object
    // Reference: DistributionVectorConstant'Engine.Default__ParticleModuleLocationPrimitiveCylinder_Seeded.DistributionStartLocation'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionStartLocation'
    // Archetype: DistributionVectorConstant'Engine.Default__ParticleModuleLocationPrimitiveCylinder.DistributionStartLocation'
    begin object name="DistributionStartLocation"
    end object
    RandomSeedInfo=(ParameterName="None",bGetSeedFromInstance=false,bInstanceSeedIsIndex=false,bResetSeedOnEmitterLooping=true,RandomSeeds=none)
    StartRadius=(Distribution=Distribution=DistributionStartRadius)
    StartHeight=(Distribution=Distribution=DistributionStartHeight)
    VelocityScale=(Distribution=Distribution=DistributionVelocityScale)
    StartLocation=(Distribution=Distribution=DistributionStartLocation)
    bSupportsRandomSeed=true
    bRequiresLoopingNotification=true
}