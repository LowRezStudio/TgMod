class ParticleModuleParameterDynamic extends ParticleModuleParameterBase
    native(Particle)
    editinlinenew
    hidecategories(Object,Object,Object);

enum EEmitterDynamicParameterValue
{
    EDPV_UserSet,                   // 0
    EDPV_VelocityX,                 // 1
    EDPV_VelocityY,                 // 2
    EDPV_VelocityZ,                 // 3
    EDPV_VelocityMag,               // 4
    EDPV_MAX                        // 5
};

struct native EmitterDynamicParameter
{
    var() editconst name ParamName;
    var() bool bUseEmitterTime;
    var() bool bSpawnTimeOnly;
    var() ParticleModuleParameterDynamic.EEmitterDynamicParameterValue ValueMethod;
    var() bool bScaleVelocityByParamValue;
    var() RawDistributionFloat ParamValue;

    structdefaultproperties
    {
        ParamName="None"
        bUseEmitterTime=false
        bSpawnTimeOnly=false
        ValueMethod=EEmitterDynamicParameterValue.EDPV_UserSet
        bScaleVelocityByParamValue=false
        ParamValue=(Distribution=none,Type=0,Op=0,LookupTableNumElements=0,LookupTableChunkSize=0,LookupTable=none,LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    }
};

var() editfixedsize array<EmitterDynamicParameter> DynamicParams;
var int UpdateFlags;
var bool bUsesVelocity;

defaultproperties
{
    // Reference: DistributionFloatConstant'Engine.Default__ParticleModuleParameterDynamic.DistributionParam1'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionParam1'
    begin object name="DistributionParam1" class=Engine.DistributionFloatConstant
    end object
    // Reference: DistributionFloatConstant'Engine.Default__ParticleModuleParameterDynamic.DistributionParam2'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionParam2'
    begin object name="DistributionParam2" class=Engine.DistributionFloatConstant
    end object
    // Reference: DistributionFloatConstant'Engine.Default__ParticleModuleParameterDynamic.DistributionParam3'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionParam3'
    begin object name="DistributionParam3" class=Engine.DistributionFloatConstant
    end object
    // Reference: DistributionFloatConstant'Engine.Default__ParticleModuleParameterDynamic.DistributionParam4'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionParam4'
    begin object name="DistributionParam4" class=Engine.DistributionFloatConstant
    end object
    DynamicParams[0]=(ParamName="None",bUseEmitterTime=false,bSpawnTimeOnly=false,ValueMethod=EEmitterDynamicParameterValue.EDPV_UserSet,bScaleVelocityByParamValue=false,ParamValue=(Distribution=Distribution=DistributionParam1,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000))
    DynamicParams[1]=(ParamName="None",bUseEmitterTime=false,bSpawnTimeOnly=false,ValueMethod=EEmitterDynamicParameterValue.EDPV_UserSet,bScaleVelocityByParamValue=false,ParamValue=(Distribution=Distribution=DistributionParam2,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000))
    DynamicParams[2]=(ParamName="None",bUseEmitterTime=false,bSpawnTimeOnly=false,ValueMethod=EEmitterDynamicParameterValue.EDPV_UserSet,bScaleVelocityByParamValue=false,ParamValue=(Distribution=Distribution=DistributionParam3,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000))
    DynamicParams[3]=(ParamName="None",bUseEmitterTime=false,bSpawnTimeOnly=false,ValueMethod=EEmitterDynamicParameterValue.EDPV_UserSet,bScaleVelocityByParamValue=false,ParamValue=(Distribution=Distribution=DistributionParam4,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000))
    bSpawnModule=true
    bUpdateModule=true
}