class AudioComponent extends ActorComponent
    native
    editinlinenew
    collapsecategories
    noexport
    hidecategories(Object,ActorComponent);

struct native AudioComponentParam
{
    var() name ParamName;
    var() float FloatParam;
    var() SoundNodeWave WaveParam;

    structdefaultproperties
    {
        ParamName="None"
        FloatParam=0.0000000
        WaveParam=none
    }
};

var() SoundCue SoundCue;
var native const SoundNode CueFirstNode;
var() editinline array<editinline AudioComponentParam> InstanceParameters;
var bool bUseOwnerLocation;
var bool bAutoPlay;
var bool bAutoDestroy;
var bool bStopWhenOwnerDestroyed;
var bool bShouldRemainActiveIfDropped;
var bool bWasOccluded;
var transient bool bNeedsOcclusionCheck;
var transient bool bSuppressSubtitles;
var transient bool bWasPlaying;
var bool bAllowSpatialization;
var transient bool bFinished;
var transient bool bApplyRadioFilter;
var transient bool bRadioFilterSelected;
var transient bool bPreviewComponent;
var transient bool bIgnoreForFlushing;
var transient float StereoBleed;
var transient float LFEBleed;
var transient bool bEQFilterApplied;
var transient bool bAlwaysPlay;
var transient bool bIsUISound;
var transient bool bIsMusic;
var transient bool bReverb;
var transient bool bCenterChannelOnly;
var transient float m_fAdditionalPriority;
var duplicatetransient native const array<Pointer> WaveInstances;
var duplicatetransient native const array<byte> SoundNodeData;
var duplicatetransient native const map{VOID,VOID} SoundNodeOffsetMap;
var duplicatetransient native const MultiMap_Mirror SoundNodeResetWaveMap;
var duplicatetransient native const Pointer Listener;
var duplicatetransient native const float PlaybackTime;
var duplicatetransient native const PortalVolume PortalVolume;
var duplicatetransient native Vector Location;
var duplicatetransient native const Vector ComponentLocation;
var const transient Actor LastOwner;
var native float SubtitlePriority;
var float FadeInStartTime;
var float FadeInStopTime;
var float FadeInTargetVolume;
var float FadeOutStartTime;
var float FadeOutStopTime;
var float FadeOutTargetVolume;
var float m_fFadeOutTargetPitch;
var float AdjustVolumeStartTime;
var float AdjustVolumeStopTime;
var float AdjustVolumeTargetVolume;
var float CurrAdjustVolumeTargetVolume;
var native const SoundNode CurrentNotifyBufferFinishedHook;
var native const Vector CurrentLocation;
var native const Vector CurrentVelocity;
var native const float CurrentVolume;
var native const float CurrentPitch;
var native const float CurrentHighFrequencyGain;
var native const int CurrentUseSpatialization;
var native const int CurrentNotifyOnLoop;
var native const float OmniRadius;
var native const float CurrentVolumeMultiplier;
var native const float CurrentPitchMultiplier;
var native const float CurrentHighFrequencyGainMultiplier;
var native const float CurrentVoiceCenterChannelVolume;
var native const float CurrentRadioFilterVolume;
var native const float CurrentRadioFilterVolumeThreshold;
var native const Double LastUpdateTime;
var native const float SourceInteriorVolume;
var native const float SourceInteriorLPF;
var native const float CurrentInteriorVolume;
var native const float CurrentInteriorLPF;
var duplicatetransient native const Double SoundModeStartTime;
var const transient Vector LastLocation;
var native const InteriorSettings LastInteriorSettings;
var native const int LastReverbVolumeIndex;
var() float VolumeMultiplier;
var() float PitchMultiplier;
var() float HighFrequencyGainMultiplier;
var float OcclusionCheckInterval;
var transient float LastOcclusionCheckTime;
var const export editinline DrawSoundRadiusComponent PreviewSoundRadius;
//var delegate<OnAudioFinished> __OnAudioFinished__Delegate;
//var delegate<OnAudioFinishedFX> __OnAudioFinishedFX__Delegate;
//var delegate<OnQueueSubtitles> __OnQueueSubtitles__Delegate;

// Export UAudioComponent::execApplyAdditionalPriority(FFrame&, void* const)
native function ApplyAdditionalPriority();

// Export UAudioComponent::execPlay(FFrame&, void* const)
native final function Play();

// Export UAudioComponent::execStop(FFrame&, void* const)
native final function Stop(optional bool bFadeOut);

// Export UAudioComponent::execIsPlaying(FFrame&, void* const)
native final function bool IsPlaying();

// Export UAudioComponent::execIsFadingIn(FFrame&, void* const)
native final function bool IsFadingIn();

// Export UAudioComponent::execIsFadingOut(FFrame&, void* const)
native final function bool IsFadingOut();

// Export UAudioComponent::execFadeIn(FFrame&, void* const)
native final function FadeIn(float FadeInDuration, float FadeVolumeLevel);

// Export UAudioComponent::execFadeOut(FFrame&, void* const)
native final function FadeOut(float FadeOutDuration, float FadeVolumeLevel, optional float FadePitchLevel = 1.0000000);

// Export UAudioComponent::execAdjustVolume(FFrame&, void* const)
native final function AdjustVolume(float AdjustVolumeDuration, float AdjustVolumeLevel);

// Export UAudioComponent::execSetFloatParameter(FFrame&, void* const)
native final function SetFloatParameter(name InName, float InFloat);

// Export UAudioComponent::execSetWaveParameter(FFrame&, void* const)
native final function SetWaveParameter(name InName, SoundNodeWave InWave);

// Export UAudioComponent::execResetToDefaults(FFrame&, void* const)
native final function ResetToDefaults();

delegate OnAudioFinished(AudioComponent AC)
{
    //return;    
}

delegate OnAudioFinishedFX(AudioComponent AC)
{
    //return;    
}

delegate OnQueueSubtitles(array<SubtitleCue> Subtitles, float CueDuration)
{
    //return;    
}

// Export UAudioComponent::execOcclusionChanged(FFrame&, void* const)
native function OcclusionChanged(bool bNowOccluded);

defaultproperties
{
    bUseOwnerLocation=true
    bAllowSpatialization=true
    FadeInStopTime=-1.0000000
    FadeInTargetVolume=1.0000000
    FadeOutStopTime=-1.0000000
    FadeOutTargetVolume=1.0000000
    m_fFadeOutTargetPitch=1.0000000
    AdjustVolumeStopTime=-1.0000000
    AdjustVolumeTargetVolume=1.0000000
    CurrAdjustVolumeTargetVolume=1.0000000
    LastLocation=(X=1.0000000,Y=2.0000000,Z=3.0000000)
    VolumeMultiplier=1.0000000
    PitchMultiplier=1.0000000
    HighFrequencyGainMultiplier=1.0000000
}