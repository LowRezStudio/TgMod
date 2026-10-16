class ParticleModuleColorOverLife extends ParticleModuleColorBase
    native(Particle)
    editinlinenew
    hidecategories(Object,Object,Object);

var(Color) RawDistributionVector ColorOverLife;
var(Color) RawDistributionFloat AlphaOverLife;
var(Color) bool bClampAlpha;

defaultproperties
{
    // Reference: DistributionVectorConstantCurve'Engine.Default__ParticleModuleColorOverLife.DistributionColorOverLife'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionColorOverLife'
    begin object name="DistributionColorOverLife" class=Engine.DistributionVectorConstantCurve
    end object
    // Reference: DistributionFloatConstant'Engine.Default__ParticleModuleColorOverLife.DistributionAlphaOverLife'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionAlphaOverLife'
    begin object name="DistributionAlphaOverLife" class=Engine.DistributionFloatConstant
        Constant=1.0000000
    end object
    ColorOverLife=(Distribution=Distribution=DistributionColorOverLife,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=3,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    AlphaOverLife=(Distribution=Distribution=DistributionAlphaOverLife,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(1.0000000,1.0000000,1.0000000,1.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    bClampAlpha=true
    bSpawnModule=true
    bUpdateModule=true
    bCurvesAsColor=true
}