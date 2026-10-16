class ParticleModuleVelocity extends ParticleModuleVelocityBase
    native(Particle)
    editinlinenew
    hidecategories(Object,Object,Object);

var(Velocity) RawDistributionVector StartVelocity;
var(Velocity) RawDistributionFloat StartVelocityRadial;

defaultproperties
{
    // Reference: DistributionVectorUniform'Engine.Default__ParticleModuleVelocity.DistributionStartVelocity'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionStartVelocity'
    begin object name="DistributionStartVelocity" class=Engine.DistributionVectorUniform
    end object
    // Reference: DistributionFloatUniform'Engine.Default__ParticleModuleVelocity.DistributionStartVelocityRadial'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionStartVelocityRadial'
    begin object name="DistributionStartVelocityRadial" class=Engine.DistributionFloatUniform
    end object
    StartVelocity=(Distribution=Distribution=DistributionStartVelocity,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=3,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    StartVelocityRadial=(Distribution=Distribution=DistributionStartVelocityRadial,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    bSpawnModule=true
}