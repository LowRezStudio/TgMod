class SoundNodeAttenuationAndGain extends SoundNode
    native(Sound)
    editinlinenew
    hidecategories(Object,Object);

var(AttenuationAndGain) bool bAttenuate;
var(AttenuationAndGain) bool bSpatialize;
var(LowPassFilter) bool bAttenuateWithLPF;
var(AttenuationAndGain) float dBAttenuationAtMax;
var(AttenuationAndGain) float OmniRadius;
var(AttenuationAndGain) SoundNodeAttenuation.SoundDistanceModel GainDistanceAlgorithm;
var(AttenuationAndGain) SoundNodeAttenuation.SoundDistanceModel AttenuateDistanceAlgorithm;
var(AttenuationAndGain) SoundNodeAttenuation.ESoundDistanceCalc DistanceType;
var(AttenuationAndGain) float MinimalVolume;
var(AttenuationAndGain) float RadiusMin;
var(AttenuationAndGain) float RadiusPeak;
var(AttenuationAndGain) float RadiusMax;
var(LowPassFilter) float LPFMinimal;
var(LowPassFilter) float LPFRadiusMin;
var(LowPassFilter) float LPFRadiusPeak;
var(LowPassFilter) float LPFRadiusMax;

defaultproperties
{
    bAttenuate=true
    bSpatialize=true
    dBAttenuationAtMax=-60.0000000
    MinimalVolume=0.7500000
    RadiusMin=400.0000000
    RadiusPeak=2000.0000000
    RadiusMax=4000.0000000
    LPFMinimal=0.7500000
    LPFRadiusMin=400.0000000
    LPFRadiusPeak=2000.0000000
    LPFRadiusMax=4000.0000000
}