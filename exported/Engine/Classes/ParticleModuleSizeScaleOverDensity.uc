class ParticleModuleSizeScaleOverDensity extends ParticleModuleSizeBase
    native(Particle)
    editinlinenew
    hidecategories(Object,Object,Object);

var(Size) RawDistributionVector SizeScaleOverDensity;

defaultproperties
{
    // Reference: DistributionVectorConstantCurve'Engine.Default__ParticleModuleSizeScaleOverDensity.DistributionSizeScaleOverDensity'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionSizeScaleOverDensity'
    begin object name="DistributionSizeScaleOverDensity" class=Engine.DistributionVectorConstantCurve
    end object
    SizeScaleOverDensity=(Distribution=Distribution=DistributionSizeScaleOverDensity,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=3,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    bSpawnModule=true
    bUpdateModule=true
}