class SoundNodeModulatorContinuous extends SoundNode
    native(Sound)
    editinlinenew
    hidecategories(Object,Object);

var() RawDistributionFloat PitchModulation;
var() RawDistributionFloat VolumeModulation;

defaultproperties
{
    // Reference: DistributionFloatUniform'Engine.Default__SoundNodeModulatorContinuous.DistributionPitch'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionPitch'
    begin object name="DistributionPitch" class=Engine.DistributionFloatUniform
        Min=0.9500000
        Max=1.0500000
    end object
    // Reference: DistributionFloatUniform'Engine.Default__SoundNodeModulatorContinuous.DistributionVolume'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionVolume'
    begin object name="DistributionVolume" class=Engine.DistributionFloatUniform
        Min=0.9500000
        Max=1.0500000
    end object
    PitchModulation=(Distribution=Distribution=DistributionPitch,Type=0,Op=2,LookupTableNumElements=2,LookupTableChunkSize=2,LookupTable=(0.9500000,1.0500000,0.9500000,1.0500000,0.9500000,1.0500000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    VolumeModulation=(Distribution=Distribution=DistributionVolume,Type=0,Op=2,LookupTableNumElements=2,LookupTableChunkSize=2,LookupTable=(0.9500000,1.0500000,0.9500000,1.0500000,0.9500000,1.0500000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
}