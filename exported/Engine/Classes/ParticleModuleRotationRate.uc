class ParticleModuleRotationRate extends ParticleModuleRotationRateBase
    native(Particle)
    editinlinenew
    hidecategories(Object,Object,Object);

var(Rotation) RawDistributionFloat StartRotationRate;

defaultproperties
{
    // Reference: DistributionFloatConstant'Engine.Default__ParticleModuleRotationRate.DistributionStartRotationRate'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionStartRotationRate'
    begin object name="DistributionStartRotationRate" class=Engine.DistributionFloatConstant
    end object
    StartRotationRate=(Distribution=Distribution=DistributionStartRotationRate,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    bSpawnModule=true
}