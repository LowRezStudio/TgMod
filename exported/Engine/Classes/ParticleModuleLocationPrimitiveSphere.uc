class ParticleModuleLocationPrimitiveSphere extends ParticleModuleLocationPrimitiveBase
    native(Particle)
    editinlinenew
    hidecategories(Object,Object,Object,Object);

var(Location) RawDistributionFloat StartRadius;

defaultproperties
{
    // Reference: DistributionFloatConstant'Engine.Default__ParticleModuleLocationPrimitiveSphere.DistributionStartRadius'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionStartRadius'
    begin object name="DistributionStartRadius" class=Engine.DistributionFloatConstant
        Constant=50.0000000
    end object
    // Reference: DistributionFloatConstant'Engine.Default__ParticleModuleLocationPrimitiveSphere.DistributionVelocityScale'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionVelocityScale'
    // Archetype: DistributionFloatConstant'Engine.Default__ParticleModuleLocationPrimitiveBase.DistributionVelocityScale'
    begin object name="DistributionVelocityScale"
    end object
    // Reference: DistributionVectorConstant'Engine.Default__ParticleModuleLocationPrimitiveSphere.DistributionStartLocation'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionStartLocation'
    // Archetype: DistributionVectorConstant'Engine.Default__ParticleModuleLocationPrimitiveBase.DistributionStartLocation'
    begin object name="DistributionStartLocation"
    end object
    StartRadius=(Distribution=Distribution=DistributionStartRadius,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(50.0000000,50.0000000,50.0000000,50.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    VelocityScale=(Distribution=Distribution=DistributionVelocityScale)
    StartLocation=(Distribution=Distribution=DistributionStartLocation)
    bSupported3DDrawMode=true
}