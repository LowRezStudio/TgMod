class ParticleModuleRotation extends ParticleModuleRotationBase
    native(Particle)
    editinlinenew
    hidecategories(Object,Object,Object);

var(Rotation) RawDistributionFloat StartRotation;

defaultproperties
{
    // Reference: DistributionFloatUniform'Engine.Default__ParticleModuleRotation.DistributionStartRotation'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionStartRotation'
    begin object name="DistributionStartRotation" class=Engine.DistributionFloatUniform
        Max=1.0000000
    end object
    StartRotation=(Distribution=Distribution=DistributionStartRotation,Type=0,Op=2,LookupTableNumElements=2,LookupTableChunkSize=2,LookupTable=(0.0000000,1.0000000,0.0000000,1.0000000,0.0000000,1.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    bSpawnModule=true
}