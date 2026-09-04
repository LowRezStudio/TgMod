class ParticleModuleParameterDynamic_Seeded extends ParticleModuleParameterDynamic
    native(Particle)
    editinlinenew
    hidecategories(Object,Object,Object,Object);

var(RandomSeed) ParticleRandomSeedInfo RandomSeedInfo;

defaultproperties
{
    // Reference: DistributionFloatConstant'Engine.Default__ParticleModuleParameterDynamic_Seeded.DistributionParam1'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionParam1'
    // Archetype: DistributionFloatConstant'Engine.Default__ParticleModuleParameterDynamic.DistributionParam1'
    begin object name="DistributionParam1"
    end object
    // Reference: DistributionFloatConstant'Engine.Default__ParticleModuleParameterDynamic_Seeded.DistributionParam2'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionParam2'
    // Archetype: DistributionFloatConstant'Engine.Default__ParticleModuleParameterDynamic.DistributionParam2'
    begin object name="DistributionParam2"
    end object
    // Reference: DistributionFloatConstant'Engine.Default__ParticleModuleParameterDynamic_Seeded.DistributionParam3'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionParam3'
    // Archetype: DistributionFloatConstant'Engine.Default__ParticleModuleParameterDynamic.DistributionParam3'
    begin object name="DistributionParam3"
    end object
    // Reference: DistributionFloatConstant'Engine.Default__ParticleModuleParameterDynamic_Seeded.DistributionParam4'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionParam4'
    // Archetype: DistributionFloatConstant'Engine.Default__ParticleModuleParameterDynamic.DistributionParam4'
    begin object name="DistributionParam4"
    end object
    RandomSeedInfo=(ParameterName="None",bGetSeedFromInstance=false,bInstanceSeedIsIndex=false,bResetSeedOnEmitterLooping=true,RandomSeeds=none)
    DynamicParams[0]=(ParamName="None",bUseEmitterTime=false,bSpawnTimeOnly=false,ValueMethod=EEmitterDynamicParameterValue.EDPV_UserSet,bScaleVelocityByParamValue=false,ParamValue=(Distribution=Distribution=DistributionParam1,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000))
    DynamicParams[1]=(ParamName="None",bUseEmitterTime=false,bSpawnTimeOnly=false,ValueMethod=EEmitterDynamicParameterValue.EDPV_UserSet,bScaleVelocityByParamValue=false,ParamValue=(Distribution=Distribution=DistributionParam2,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000))
    DynamicParams[2]=(ParamName="None",bUseEmitterTime=false,bSpawnTimeOnly=false,ValueMethod=EEmitterDynamicParameterValue.EDPV_UserSet,bScaleVelocityByParamValue=false,ParamValue=(Distribution=Distribution=DistributionParam3,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000))
    DynamicParams[3]=(ParamName="None",bUseEmitterTime=false,bSpawnTimeOnly=false,ValueMethod=EEmitterDynamicParameterValue.EDPV_UserSet,bScaleVelocityByParamValue=false,ParamValue=(Distribution=Distribution=DistributionParam4,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000))
    bSupportsRandomSeed=true
    bRequiresLoopingNotification=true
}