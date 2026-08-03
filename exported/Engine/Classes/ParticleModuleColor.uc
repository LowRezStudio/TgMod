class ParticleModuleColor extends ParticleModuleColorBase
    native(Particle)
    editinlinenew
    hidecategories(Object,Object,Object);

var(Color) RawDistributionVector StartColor;
var(Color) RawDistributionFloat StartAlpha;
var(Color) bool bClampAlpha;

defaultproperties
{
    // Reference: DistributionVectorConstant'Engine.Default__ParticleModuleColor.DistributionStartColor'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionStartColor'
    begin object name="DistributionStartColor" class=Engine.DistributionVectorConstant
    end object
    // Reference: DistributionFloatConstant'Engine.Default__ParticleModuleColor.DistributionStartAlpha'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionStartAlpha'
    begin object name="DistributionStartAlpha" class=Engine.DistributionFloatConstant
        Constant=1.0000000
    end object
    StartColor=(Distribution=Distribution=DistributionStartColor,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=3,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    StartAlpha=(Distribution=Distribution=DistributionStartAlpha,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(1.0000000,1.0000000,1.0000000,1.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    bClampAlpha=true
    bSpawnModule=true
    bCurvesAsColor=true
}