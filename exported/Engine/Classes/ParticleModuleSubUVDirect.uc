class ParticleModuleSubUVDirect extends ParticleModuleSubUVBase
    native(Particle)
    editinlinenew
    hidecategories(Object,Object,Object);

var(SubUV) RawDistributionVector SubUVPosition;
var(SubUV) RawDistributionVector SubUVSize;

defaultproperties
{
    // Reference: DistributionVectorConstant'Engine.Default__ParticleModuleSubUVDirect.DistributionSubImagePosition'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionSubImagePosition'
    begin object name="DistributionSubImagePosition" class=Engine.DistributionVectorConstant
    end object
    // Reference: DistributionVectorConstant'Engine.Default__ParticleModuleSubUVDirect.DistributionSubImageSize'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionSubImageSize'
    begin object name="DistributionSubImageSize" class=Engine.DistributionVectorConstant
    end object
    SubUVPosition=(Distribution=Distribution=DistributionSubImagePosition,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=3,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    SubUVSize=(Distribution=Distribution=DistributionSubImageSize,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=3,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    bUpdateModule=true
}