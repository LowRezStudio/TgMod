class ParticleModuleSubUV extends ParticleModuleSubUVBase
    native(Particle)
    editinlinenew
    hidecategories(Object,Object,Object);

var(SubUV) RawDistributionFloat SubImageIndex;
var(Realtime) bool bUseRealTime;

defaultproperties
{
    // Reference: DistributionFloatConstant'Engine.Default__ParticleModuleSubUV.DistributionSubImage'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionSubImage'
    begin object name="DistributionSubImage" class=Engine.DistributionFloatConstant
    end object
    SubImageIndex=(Distribution=Distribution=DistributionSubImage,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    bSpawnModule=true
    bUpdateModule=true
}