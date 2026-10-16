class ParticleModuleOrbit extends ParticleModuleOrbitBase
    native(Particle)
    editinlinenew
    hidecategories(Object,Object,Object,Orbit);

enum EOrbitChainMode
{
    EOChainMode_Add,                // 0
    EOChainMode_Scale,              // 1
    EOChainMode_Link,               // 2
    EOChainMode_MAX                 // 3
};

struct native OrbitOptions
{
    var() bool bProcessDuringSpawn;
    var() bool bProcessDuringUpdate;
    var() bool bUseEmitterTime;

    structdefaultproperties
    {
        bProcessDuringSpawn=true
        bProcessDuringUpdate=false
        bUseEmitterTime=false
    }
};

var(Chaining) ParticleModuleOrbit.EOrbitChainMode ChainMode;
var(Offset) RawDistributionVector OffsetAmount;
var(Offset) OrbitOptions OffsetOptions;
var(Rotation) RawDistributionVector RotationAmount;
var(Rotation) OrbitOptions RotationOptions;
var(RotationRate) RawDistributionVector RotationRateAmount;
var(RotationRate) OrbitOptions RotationRateOptions;

defaultproperties
{
    // Reference: DistributionVectorUniform'Engine.Default__ParticleModuleOrbit.DistributionOffsetAmount'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionOffsetAmount'
    begin object name="DistributionOffsetAmount" class=Engine.DistributionVectorUniform
        Max=(X=0.0000000,Y=50.0000000,Z=0.0000000)
    end object
    // Reference: DistributionVectorUniform'Engine.Default__ParticleModuleOrbit.DistributionRotationAmount'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionRotationAmount'
    begin object name="DistributionRotationAmount" class=Engine.DistributionVectorUniform
        Max=(X=1.0000000,Y=1.0000000,Z=1.0000000)
    end object
    // Reference: DistributionVectorUniform'Engine.Default__ParticleModuleOrbit.DistributionRotationRateAmount'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionRotationRateAmount'
    begin object name="DistributionRotationRateAmount" class=Engine.DistributionVectorUniform
        Max=(X=1.0000000,Y=1.0000000,Z=1.0000000)
    end object
    ChainMode=EOrbitChainMode.EOChainMode_Link
    OffsetAmount=(Distribution=Distribution=DistributionOffsetAmount,Type=0,Op=2,LookupTableNumElements=2,LookupTableChunkSize=6,LookupTable=(0.0000000,50.0000000,0.0000000,0.0000000,0.0000000,0.0000000,50.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,50.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    OffsetOptions=(bProcessDuringSpawn=true,bProcessDuringUpdate=false,bUseEmitterTime=false)
    RotationAmount=(Distribution=Distribution=DistributionRotationAmount,Type=0,Op=2,LookupTableNumElements=2,LookupTableChunkSize=6,LookupTable=(0.0000000,1.0000000,0.0000000,0.0000000,0.0000000,1.0000000,1.0000000,1.0000000,0.0000000,0.0000000,0.0000000,1.0000000,1.0000000,1.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    RotationOptions=(bProcessDuringSpawn=true,bProcessDuringUpdate=false,bUseEmitterTime=false)
    RotationRateAmount=(Distribution=Distribution=DistributionRotationRateAmount,Type=0,Op=2,LookupTableNumElements=2,LookupTableChunkSize=6,LookupTable=(0.0000000,1.0000000,0.0000000,0.0000000,0.0000000,1.0000000,1.0000000,1.0000000,0.0000000,0.0000000,0.0000000,1.0000000,1.0000000,1.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    RotationRateOptions=(bProcessDuringSpawn=true,bProcessDuringUpdate=false,bUseEmitterTime=false)
    bSpawnModule=true
    bUpdateModule=true
}