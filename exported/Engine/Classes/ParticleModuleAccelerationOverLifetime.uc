class ParticleModuleAccelerationOverLifetime extends ParticleModuleAccelerationBase
    native(Particle)
    editinlinenew
    hidecategories(Object,Object,Object);

var(Acceleration) RawDistributionVector AccelOverLife;

defaultproperties
{
    // Reference: DistributionVectorConstantCurve'Engine.Default__ParticleModuleAccelerationOverLifetime.DistributionAccelOverLife'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionAccelOverLife'
    begin object name="DistributionAccelOverLife" class=Engine.DistributionVectorConstantCurve
    end object
    AccelOverLife=(Distribution=Distribution=DistributionAccelOverLife,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=3,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    bUpdateModule=true
}