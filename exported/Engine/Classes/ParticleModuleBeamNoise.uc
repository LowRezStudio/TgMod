class ParticleModuleBeamNoise extends ParticleModuleBeamBase
    native(Particle)
    editinlinenew
    hidecategories(Object,Object,Object);

var(LowFreq) bool bLowFreq_Enabled;
var(LowFreq) bool bNRScaleEmitterTime;
var(LowFreq) bool bSmooth;
var const bool bNoiseLock;
var(LowFreq) bool bOscillate;
var(LowFreq) bool bUseNoiseTangents;
var(LowFreq) bool bTargetNoise;
var(LowFreq) bool bApplyNoiseScale;
var(LowFreq) int Frequency;
var(LowFreq) int Frequency_LowRange;
var(LowFreq) RawDistributionVector NoiseRange;
var(LowFreq) RawDistributionFloat NoiseRangeScale;
var(LowFreq) RawDistributionVector NoiseSpeed;
var(LowFreq) float NoiseLockRadius;
var(LowFreq) float NoiseLockTime;
var(LowFreq) float NoiseTension;
var(LowFreq) RawDistributionFloat NoiseTangentStrength;
var(LowFreq) int NoiseTessellation;
var(LowFreq) float FrequencyDistance;
var(LowFreq) RawDistributionFloat NoiseScale;

defaultproperties
{
    // Reference: DistributionVectorConstant'Engine.Default__ParticleModuleBeamNoise.DistributionNoiseRange'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionNoiseRange'
    begin object name="DistributionNoiseRange" class=Engine.DistributionVectorConstant
        Constant=(X=50.0000000,Y=50.0000000,Z=50.0000000)
    end object
    // Reference: DistributionFloatConstant'Engine.Default__ParticleModuleBeamNoise.DistributionNoiseRangeScale'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionNoiseRangeScale'
    begin object name="DistributionNoiseRangeScale" class=Engine.DistributionFloatConstant
        Constant=1.0000000
    end object
    // Reference: DistributionVectorConstant'Engine.Default__ParticleModuleBeamNoise.DistributionNoiseSpeed'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionNoiseSpeed'
    begin object name="DistributionNoiseSpeed" class=Engine.DistributionVectorConstant
        Constant=(X=50.0000000,Y=50.0000000,Z=50.0000000)
    end object
    // Reference: DistributionFloatConstant'Engine.Default__ParticleModuleBeamNoise.DistributionNoiseTangentStrength'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionNoiseTangentStrength'
    begin object name="DistributionNoiseTangentStrength" class=Engine.DistributionFloatConstant
        Constant=250.0000000
    end object
    // Reference: DistributionFloatConstantCurve'Engine.Default__ParticleModuleBeamNoise.DistributionNoiseScale'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionNoiseScale'
    begin object name="DistributionNoiseScale" class=Engine.DistributionFloatConstantCurve
    end object
    NoiseRange=(Distribution=Distribution=DistributionNoiseRange,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=3,LookupTable=(50.0000000,50.0000000,50.0000000,50.0000000,50.0000000,50.0000000,50.0000000,50.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    NoiseRangeScale=(Distribution=Distribution=DistributionNoiseRangeScale,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(1.0000000,1.0000000,1.0000000,1.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    NoiseSpeed=(Distribution=Distribution=DistributionNoiseSpeed,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=3,LookupTable=(50.0000000,50.0000000,50.0000000,50.0000000,50.0000000,50.0000000,50.0000000,50.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    NoiseLockRadius=1.0000000
    NoiseTension=0.5000000
    NoiseTangentStrength=(Distribution=Distribution=DistributionNoiseTangentStrength,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(250.0000000,250.0000000,250.0000000,250.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    NoiseTessellation=1
    NoiseScale=(Distribution=Distribution=DistributionNoiseScale,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
}