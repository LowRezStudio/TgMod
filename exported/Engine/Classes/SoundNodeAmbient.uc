class SoundNodeAmbient extends SoundNode
    native(Sound)
    editinlinenew
    dontsortcategories(Attenuation,LowPassFilter,Modulation,Sounds,Spatialization)
    hidecategories(Object,Object)
    autoexpandcategories(Attenuation,LowPassFilter,Modulation,Sounds,Spatialization);

struct native AmbientSoundSlot
{
    var() SoundNodeWave Wave;
    var() float PitchScale;
    var() float VolumeScale;
    var() float Weight;

    structdefaultproperties
    {
        Wave=none
        PitchScale=1.0000000
        VolumeScale=1.0000000
        Weight=1.0000000
    }
};

var(Attenuation) bool bAttenuate;
var(Attenuation) bool bSpatialize;
var(LowPassFilter) bool bAttenuateWithLPF;
var(Attenuation) float dBAttenuationAtMax;
var(Attenuation) SoundNodeAttenuation.SoundDistanceModel DistanceModel;
var(Attenuation) float RadiusMin;
var(Attenuation) float RadiusMax;
var(LowPassFilter) float LPFRadiusMin;
var(LowPassFilter) float LPFRadiusMax;
var(Modulation) float PitchMin;
var(Modulation) float PitchMax;
var(Modulation) float VolumeMin;
var(Modulation) float VolumeMax;
var(Sounds) array<AmbientSoundSlot> SoundSlots;

defaultproperties
{
    bAttenuate=true
    bSpatialize=true
    dBAttenuationAtMax=-60.0000000
    RadiusMin=2000.0000000
    RadiusMax=5000.0000000
    LPFRadiusMin=3500.0000000
    LPFRadiusMax=7000.0000000
    PitchMin=1.0000000
    PitchMax=1.0000000
    VolumeMin=0.7000000
    VolumeMax=0.7000000
}