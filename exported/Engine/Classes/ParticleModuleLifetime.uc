class ParticleModuleLifetime extends ParticleModuleLifetimeBase
    native(Particle)
    editinlinenew
    hidecategories(Object,Object,Object);

var(Lifetime) RawDistributionFloat Lifetime;

defaultproperties
{
    // Reference: DistributionFloatUniform'Engine.Default__ParticleModuleLifetime.DistributionLifetime'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionLifetime'
    begin object name="DistributionLifetime" class=Engine.DistributionFloatUniform
    end object
    Lifetime=(Distribution=Distribution=DistributionLifetime,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    bSpawnModule=true
}