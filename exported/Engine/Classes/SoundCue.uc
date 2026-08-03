class SoundCue extends AkBaseSoundObject
    native
    hidecategories(Object);

struct native export SoundNodeEditorData
{
    var native const int NodePosX;
    var native const int NodePosY;
};

var() name SoundClass;
var AudioDevice.ESoundClassName SoundClassName;
var() bool bDebug;
var(Fade) bool m_bFadeOutWhenStopped;
var SoundNode FirstNode;
var native const map{VOID,VOID} EditorData;
var transient float MaxAudibleDistance;
var() float VolumeMultiplier;
var() float PitchMultiplier;
var float Duration;
var() FaceFXAnimSet FaceFXAnimSetRef;
var() string FaceFXGroupName;
var() string FaceFXAnimName;
var() int MaxConcurrentPlayCount;
var duplicatetransient const transient int CurrentPlayCount;
var deprecated name SoundGroup;
var(Fade) float m_fFadeOutTime;
var(Fade) float m_fFadeToPct;
var(Fade) float m_fFadePitchToPct;
var() SoundCue m_StereoSoundCue;

// Export USoundCue::execGetCueDuration(FFrame&, void* const)
native final function float GetCueDuration();

defaultproperties
{
    VolumeMultiplier=0.7500000
    PitchMultiplier=1.0000000
    MaxConcurrentPlayCount=16
    m_fFadeOutTime=0.4000000
    m_fFadePitchToPct=1.0000000
}