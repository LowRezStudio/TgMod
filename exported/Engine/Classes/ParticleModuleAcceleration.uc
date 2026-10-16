class ParticleModuleAcceleration extends ParticleModuleAccelerationBase
    native(Particle)
    editinlinenew
    hidecategories(Object,Object,Object);

var(Acceleration) RawDistributionVector Acceleration;
var(Acceleration) bool bApplyOwnerScale;

defaultproperties
{
    // Reference: DistributionVectorUniform'Engine.Default__ParticleModuleAcceleration.DistributionAcceleration'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionAcceleration'
    begin object name="DistributionAcceleration" class=Engine.DistributionVectorUniform
    end object
    Acceleration=(Distribution=Distribution=DistributionAcceleration,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=3,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    bSpawnModule=true
    bUpdateModule=true
}