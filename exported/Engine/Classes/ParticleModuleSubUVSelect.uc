class ParticleModuleSubUVSelect extends ParticleModuleSubUVBase
    native(Particle)
    editinlinenew
    hidecategories(Object,Object,Object);

var(SubUV) RawDistributionVector SubImageSelect;

defaultproperties
{
    // Reference: DistributionVectorConstant'Engine.Default__ParticleModuleSubUVSelect.DistributionSubImageSelect'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionSubImageSelect'
    begin object name="DistributionSubImageSelect" class=Engine.DistributionVectorConstant
    end object
    SubImageSelect=(Distribution=Distribution=DistributionSubImageSelect,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=3,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    bUpdateModule=true
}