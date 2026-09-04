class SoundNodeAttenuation extends SoundNode
    native(Sound)
    editinlinenew
    dontsortcategories(Attenuation,LowPassFilter)
    hidecategories(Object,Object);

enum SoundDistanceModel
{
    ATTENUATION_Linear,             // 0
    ATTENUATION_Logarithmic,        // 1
    ATTENUATION_Inverse,            // 2
    ATTENUATION_LogReverse,         // 3
    ATTENUATION_NaturalSound,       // 4
    ATTENUATION_MAX                 // 5
};

enum ESoundDistanceCalc
{
    SOUNDDISTANCE_Normal,           // 0
    SOUNDDISTANCE_InfiniteXYPlane,  // 1
    SOUNDDISTANCE_InfiniteXZPlane,  // 2
    SOUNDDISTANCE_InfiniteYZPlane,  // 3
    SOUNDDISTANCE_MAX               // 4
};

var(Attenuation) bool bAttenuate;
var(Attenuation) bool bSpatialize;
var(LowPassFilter) bool bAttenuateWithLPF;
var(Attenuation) float dBAttenuationAtMax;
var(Attenuation) float OmniRadius;
var(Attenuation) SoundNodeAttenuation.SoundDistanceModel DistanceAlgorithm;
var(Attenuation) SoundNodeAttenuation.ESoundDistanceCalc DistanceType;
var(Attenuation) float RadiusMin;
var(Attenuation) float RadiusMax;
var(LowPassFilter) float LPFRadiusMin;
var(LowPassFilter) float LPFRadiusMax;

defaultproperties
{
    bAttenuate=true
    bSpatialize=true
    dBAttenuationAtMax=-60.0000000
    RadiusMin=400.0000000
    RadiusMax=4000.0000000
    LPFRadiusMin=3000.0000000
    LPFRadiusMax=6000.0000000
}