class SoundNodeModulator extends SoundNode
    native(Sound)
    editinlinenew
    hidecategories(Object,Object);

var(Modulation) float PitchMin;
var(Modulation) float PitchMax;
var(Modulation) float VolumeMin;
var(Modulation) float VolumeMax;
var deprecated RawDistributionFloat PitchModulation;
var deprecated RawDistributionFloat VolumeModulation;

defaultproperties
{
    PitchMin=0.9500000
    PitchMax=1.0500000
    VolumeMin=0.9500000
    VolumeMax=1.0500000
}