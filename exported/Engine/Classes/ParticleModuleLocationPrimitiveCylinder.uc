class ParticleModuleLocationPrimitiveCylinder extends ParticleModuleLocationPrimitiveBase
    native(Particle)
    editinlinenew
    hidecategories(Object,Object,Object,Object);

enum CylinderHeightAxis
{
    PMLPC_HEIGHTAXIS_X,             // 0
    PMLPC_HEIGHTAXIS_Y,             // 1
    PMLPC_HEIGHTAXIS_Z,             // 2
    PMLPC_HEIGHTAXIS_MAX            // 3
};

var(Location) bool RadialVelocity;
var(Location) private bool bAdjustForWorldSpace;
var(Location) RawDistributionFloat StartRadius;
var(Location) RawDistributionFloat StartHeight;
var(Location) ParticleModuleLocationPrimitiveCylinder.CylinderHeightAxis HeightAxis;

defaultproperties
{
    // Reference: DistributionFloatConstant'Engine.Default__ParticleModuleLocationPrimitiveCylinder.DistributionStartRadius'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionStartRadius'
    begin object name="DistributionStartRadius" class=Engine.DistributionFloatConstant
        Constant=50.0000000
    end object
    // Reference: DistributionFloatConstant'Engine.Default__ParticleModuleLocationPrimitiveCylinder.DistributionStartHeight'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionStartHeight'
    begin object name="DistributionStartHeight" class=Engine.DistributionFloatConstant
        Constant=50.0000000
    end object
    // Reference: DistributionFloatConstant'Engine.Default__ParticleModuleLocationPrimitiveCylinder.DistributionVelocityScale'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionVelocityScale'
    // Archetype: DistributionFloatConstant'Engine.Default__ParticleModuleLocationPrimitiveBase.DistributionVelocityScale'
    begin object name="DistributionVelocityScale"
    end object
    // Reference: DistributionVectorConstant'Engine.Default__ParticleModuleLocationPrimitiveCylinder.DistributionStartLocation'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionStartLocation'
    // Archetype: DistributionVectorConstant'Engine.Default__ParticleModuleLocationPrimitiveBase.DistributionStartLocation'
    begin object name="DistributionStartLocation"
    end object
    RadialVelocity=true
    StartRadius=(Distribution=Distribution=DistributionStartRadius,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(50.0000000,50.0000000,50.0000000,50.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    StartHeight=(Distribution=Distribution=DistributionStartHeight,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(50.0000000,50.0000000,50.0000000,50.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    HeightAxis=CylinderHeightAxis.PMLPC_HEIGHTAXIS_Z
    VelocityScale=(Distribution=Distribution=DistributionVelocityScale)
    StartLocation=(Distribution=Distribution=DistributionStartLocation)
    bSupported3DDrawMode=true
}