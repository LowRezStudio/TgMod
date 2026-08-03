class ParticleModuleColorScaleOverLife extends ParticleModuleColorBase
    native(Particle)
    editinlinenew
    hidecategories(Object,Object,Object);

var(Color) RawDistributionVector ColorScaleOverLife;
var(Color) RawDistributionFloat AlphaScaleOverLife;
var(Color) bool bEmitterTime;

defaultproperties
{
    // Reference: DistributionVectorConstantCurve'Engine.Default__ParticleModuleColorScaleOverLife.DistributionColorScaleOverLife'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionColorScaleOverLife'
    begin object name="DistributionColorScaleOverLife" class=Engine.DistributionVectorConstantCurve
    end object
    // Reference: DistributionFloatConstant'Engine.Default__ParticleModuleColorScaleOverLife.DistributionAlphaScaleOverLife'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionAlphaScaleOverLife'
    begin object name="DistributionAlphaScaleOverLife" class=Engine.DistributionFloatConstant
        Constant=1.0000000
    end object
    ColorScaleOverLife=(Distribution=Distribution=DistributionColorScaleOverLife,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=3,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    AlphaScaleOverLife=(Distribution=Distribution=DistributionAlphaScaleOverLife,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(1.0000000,1.0000000,1.0000000,1.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    bSpawnModule=true
    bUpdateModule=true
    bCurvesAsColor=true
}