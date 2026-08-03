class ParticleModuleColorScaleOverDensity extends ParticleModuleColorBase
    native(Particle)
    editinlinenew
    hidecategories(Object,Object,Object);

var(Color) RawDistributionVector ColorScaleOverDensity;
var(Color) RawDistributionFloat AlphaScaleOverDensity;

defaultproperties
{
    // Reference: DistributionVectorConstantCurve'Engine.Default__ParticleModuleColorScaleOverDensity.DistributionColorScaleOverDensity'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionColorScaleOverDensity'
    begin object name="DistributionColorScaleOverDensity" class=Engine.DistributionVectorConstantCurve
    end object
    // Reference: DistributionFloatConstant'Engine.Default__ParticleModuleColorScaleOverDensity.DistributionAlphaScaleOverDensity'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionAlphaScaleOverDensity'
    begin object name="DistributionAlphaScaleOverDensity" class=Engine.DistributionFloatConstant
    end object
    ColorScaleOverDensity=(Distribution=Distribution=DistributionColorScaleOverDensity,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=3,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    AlphaScaleOverDensity=(Distribution=Distribution=DistributionAlphaScaleOverDensity,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    bSpawnModule=true
    bUpdateModule=true
}