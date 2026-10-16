class ParticleModuleSubUVMovie extends ParticleModuleSubUV
    native(Particle)
    editinlinenew
    hidecategories(Object,Object,Object,Object,SubUV);

var(FlipBook) bool bUseEmitterTime;
var(FlipBook) RawDistributionFloat FrameRate;
var(FlipBook) int StartingFrame;

defaultproperties
{
    // Reference: DistributionFloatConstant'Engine.Default__ParticleModuleSubUVMovie.DistributionFrameRate'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionFrameRate'
    begin object name="DistributionFrameRate" class=Engine.DistributionFloatConstant
        Constant=30.0000000
    end object
    // Reference: DistributionFloatConstant'Engine.Default__ParticleModuleSubUVMovie.DistributionSubImage'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionSubImage'
    // Archetype: DistributionFloatConstant'Engine.Default__ParticleModuleSubUV.DistributionSubImage'
    begin object name="DistributionSubImage"
    end object
    FrameRate=(Distribution=Distribution=DistributionFrameRate,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(30.0000000,30.0000000,30.0000000,30.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    StartingFrame=1
    SubImageIndex=(Distribution=Distribution=DistributionSubImage)
}