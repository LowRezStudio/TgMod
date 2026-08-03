class ParticleModuleSize extends ParticleModuleSizeBase
    native(Particle)
    editinlinenew
    hidecategories(Object,Object,Object);

var(Size) RawDistributionVector StartSize;

defaultproperties
{
    // Reference: DistributionVectorUniform'Engine.Default__ParticleModuleSize.DistributionStartSize'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionStartSize'
    begin object name="DistributionStartSize" class=Engine.DistributionVectorUniform
        Max=(X=1.0000000,Y=1.0000000,Z=1.0000000)
        Min=(X=1.0000000,Y=1.0000000,Z=1.0000000)
    end object
    StartSize=(Distribution=Distribution=DistributionStartSize,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=3,LookupTable=(1.0000000,1.0000000,1.0000000,1.0000000,1.0000000,1.0000000,1.0000000,1.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    bSpawnModule=true
}