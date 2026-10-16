class SoundMode extends Object
    native(AudioDevice)
    dontsortcategories(SoundMode)
    hidecategories(Object);

struct native AudioEQEffect
{
    var native transient Double RootTime;
    var(HighPass) float HFFrequency;
    var(HighPass) float HFGain;
    var(BandPass) float MFCutoffFrequency;
    var(BandPass) float MFBandwidth;
    var(BandPass) float MFGain;
    var(LowPass) float LFFrequency;
    var(LowPass) float LFGain;

    structdefaultproperties
    {
        HFFrequency=0.0000000
        HFGain=0.0000000
        MFCutoffFrequency=0.0000000
        MFBandwidth=0.0000000
        MFGain=0.0000000
        LFFrequency=0.0000000
        LFGain=0.0000000
    }
};

struct native SoundClassAdjuster
{
    var() transient AudioDevice.ESoundClassName SoundClassName;
    var() editconst name SoundClass;
    var() float VolumeAdjuster;
    var() float PitchAdjuster;
    var() bool bApplyToChildren;
    var() float VoiceCenterChannelVolumeAdjuster;

    structdefaultproperties
    {
        SoundClassName=ESoundClassName.Master
        SoundClass="Master"
        VolumeAdjuster=1.0000000
        PitchAdjuster=1.0000000
        bApplyToChildren=false
        VoiceCenterChannelVolumeAdjuster=1.0000000
    }
};

var(EQ) bool bApplyEQ;
var(EQ) AudioEQEffect EQSettings;
var(SoundClasses) array<SoundClassAdjuster> SoundClassEffects;
var() float InitialDelay;
var() float FadeInTime;
var() float Duration;
var() float FadeOutTime;

defaultproperties
{
    EQSettings=(HFFrequency=2000.0000000,HFGain=1.0000000,MFCutoffFrequency=1000.0000000,MFBandwidth=1.0000000,MFGain=1.0000000,LFFrequency=600.0000000,LFGain=1.0000000)
    FadeInTime=0.2000000
    Duration=-1.0000000
    FadeOutTime=0.2000000
}