class ParticleModuleMeshRotationRate extends ParticleModuleRotationRateBase
    native(Particle)
    editinlinenew
    hidecategories(Object,Object,Object);

var(Rotation) RawDistributionVector StartRotationRate;

defaultproperties
{
    // Reference: DistributionVectorUniform'Engine.Default__ParticleModuleMeshRotationRate.DistributionStartRotationRate'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionStartRotationRate'
    begin object name="DistributionStartRotationRate" class=Engine.DistributionVectorUniform
        Max=(X=360.0000000,Y=360.0000000,Z=360.0000000)
    end object
    StartRotationRate=(Distribution=Distribution=DistributionStartRotationRate,Type=0,Op=2,LookupTableNumElements=2,LookupTableChunkSize=6,LookupTable=(0.0000000,360.0000000,0.0000000,0.0000000,0.0000000,360.0000000,360.0000000,360.0000000,0.0000000,0.0000000,0.0000000,360.0000000,360.0000000,360.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    bSpawnModule=true
    bUpdateModule=true
}