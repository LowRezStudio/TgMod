class SoundClass extends Object
    native(AudioDevice)
    dontsortcategories(SoundClass)
    hidecategories(Object);

struct native export SoundClassEditorData
{
    var native const int NodePosX;
    var native const int NodePosY;
};

struct native SoundClassProperties
{
    var() float Volume;
    var() float Pitch;
    var() float StereoBleed;
    var() float LFEBleed;
    var() float VoiceCenterChannelVolume;
    var() float RadioFilterVolume;
    var() float RadioFilterVolumeThreshold;
    var() bool bApplyEffects;
    var() bool bAlwaysPlay;
    var() bool bIsUISound;
    var() bool bIsMusic;
    var() bool bReverb;
    var() bool bCenterChannelOnly;
    var() bool bApplyAmbientVolumes;
    var() bool bApplyInsulationVolumes;
    var() name m_nmSoundMode;
    var() float m_fNonLocalPriorityBoost;
    var() float m_fLocalPriorityBoost;

    structdefaultproperties
    {
        Volume=1.0000000
        Pitch=1.0000000
        StereoBleed=0.2500000
        LFEBleed=0.5000000
        VoiceCenterChannelVolume=0.0000000
        RadioFilterVolume=0.0000000
        RadioFilterVolumeThreshold=0.0000000
        bApplyEffects=false
        bAlwaysPlay=false
        bIsUISound=false
        bIsMusic=false
        bReverb=true
        bCenterChannelOnly=false
        bApplyAmbientVolumes=false
        bApplyInsulationVolumes=false
        m_nmSoundMode="None"
        m_fNonLocalPriorityBoost=0.0000000
        m_fLocalPriorityBoost=0.0000000
    }
};

var() SoundClassProperties Properties;
var() array<name> ChildClassNames;
var bool bIsChild;
var native const map{VOID,VOID} EditorData;

defaultproperties
{
    Properties=(Volume=1.0000000,Pitch=1.0000000,StereoBleed=0.2500000,LFEBleed=0.5000000,VoiceCenterChannelVolume=0.0000000,RadioFilterVolume=0.0000000,RadioFilterVolumeThreshold=0.0000000,bApplyEffects=false,bAlwaysPlay=false,bIsUISound=false,bIsMusic=false,bReverb=true,bCenterChannelOnly=false,bApplyAmbientVolumes=false,bApplyInsulationVolumes=false,m_nmSoundMode="None",m_fNonLocalPriorityBoost=0.0000000,m_fLocalPriorityBoost=0.0000000)
}