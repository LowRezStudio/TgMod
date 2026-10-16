class AnimNodeSequence extends AnimNode
    native(Anim)
    hidecategories(Object,Object,Object);

enum ERootBoneAxis
{
    RBA_Default,                    // 0
    RBA_Discard,                    // 1
    RBA_Translate,                  // 2
    RBA_MAX                         // 3
};

enum ERootRotationOption
{
    RRO_Default,                    // 0
    RRO_Discard,                    // 1
    RRO_Extract,                    // 2
    RRO_MAX                         // 3
};

struct native DeferredAnimNotifyTickInformation
{
    var AnimNotify Notify;
    var float CurrentTime;
    var float TimeStep;
    var float TotalDuration;

    structdefaultproperties
    {
        Notify=none
        CurrentTime=0.0000000
        TimeStep=0.0000000
        TotalDuration=0.0000000
    }
};

struct native DeferredAnimNotifyEndInformation
{
    var AnimNotify Notify;
    var float CurrentTime;

    structdefaultproperties
    {
        Notify=none
        CurrentTime=0.0000000
    }
};

var() const name AnimSeqName;
var() float Rate;
var() bool bPlaying;
var() bool bLooping;
var() bool bCauseActorAnimEnd;
var() bool bCauseActorAnimPlay;
var() bool bZeroRootRotation;
var() bool bZeroRootTranslation;
var() bool bDisableWarningWhenAnimNotFound;
var() bool bNoNotifies;
var() bool bForceRefposeWhenNotPlaying;
var bool bIsIssuingNotifies;
var(Group) bool bForceAlwaysSlave;
var(Group) const bool bSynchronize;
var(Group) const bool bReverseSync;
var(Display) bool bShowTimeLineSlider;
var(Camera) bool bLoopCameraAnim;
var(Camera) bool bRandomizeCameraAnimLoopStartTime;
var() bool m_bIgnoreFootSkelControls;
var() bool m_bIgnoreBlendBySpeedScaling;
var() bool bDoNotResetIfPlaying;
var(Group) bool bOnlyResetSynchGroupOnReplayAnim;
var const bool bEditorOnlyAddRefPoseToAdditiveAnimation;
var transient bool bCheckForFinishAnimEarly;
var transient bool bBlendingOut;
var() const float CurrentTime;
var const transient float PreviousTime;
var const transient float EndTime;
var const transient AnimSequence AnimSeq;
var const transient int AnimLinkupIndex;
var() float NotifyWeightThreshold;
var(Group) const name SynchGroupName;
var(Group) float SynchPosOffset;
var(Camera) CameraAnim CameraAnim;
var transient CameraAnimInst ActiveCameraAnimInstance;
var(Camera) float CameraAnimScale;
var(Camera) float CameraAnimPlayRate;
var(Camera) float CameraAnimBlendInTime;
var(Camera) float CameraAnimBlendOutTime;
var() const AnimNodeSequence.ERootBoneAxis RootBoneOption[3];
var() const AnimNodeSequence.ERootRotationOption RootRotationOption[3];
var Texture2D DebugTrack;
var Texture2D DebugCarat;
var transient array<AnimNotify> DeferredNotifies;
var transient array<DeferredAnimNotifyTickInformation> DeferredNotifyTicks;
var transient array<DeferredAnimNotifyEndInformation> DeferredNotifyEnds;
var const transient array<SkelControlBase> MetaDataSkelControlList;

// Export UAnimNodeSequence::execSetAnim(FFrame&, void* const)
native function SetAnim(name Sequence);

// Export UAnimNodeSequence::execPlayAnim(FFrame&, void* const)
native function PlayAnim(optional bool bLoop = false, optional float InRate = 1.0000000, optional float StartTime = 0.0000000);

// Export UAnimNodeSequence::execStopAnim(FFrame&, void* const)
native function StopAnim();

// Export UAnimNodeSequence::execReplayAnim(FFrame&, void* const)
native function ReplayAnim();

// Export UAnimNodeSequence::execSetPosition(FFrame&, void* const)
native function SetPosition(float NewTime, bool bFireNotifies);

// Export UAnimNodeSequence::execGetNormalizedPosition(FFrame&, void* const)
native function float GetNormalizedPosition();

// Export UAnimNodeSequence::execFindGroupRelativePosition(FFrame&, void* const)
native function float FindGroupRelativePosition(float GroupRelativePosition);

// Export UAnimNodeSequence::execFindGroupPosition(FFrame&, void* const)
native function float FindGroupPosition(float GroupRelativePosition);

// Export UAnimNodeSequence::execGetGroupRelativePosition(FFrame&, void* const)
native function float GetGroupRelativePosition();

// Export UAnimNodeSequence::execGetGlobalPlayRate(FFrame&, void* const)
native function float GetGlobalPlayRate();

// Export UAnimNodeSequence::execGetAnimPlaybackLength(FFrame&, void* const)
native function float GetAnimPlaybackLength();

// Export UAnimNodeSequence::execGetTimeLeft(FFrame&, void* const)
native function float GetTimeLeft();

// Export UAnimNodeSequence::execSetRootBoneAxisOption(FFrame&, void* const)
native final function SetRootBoneAxisOption(optional AnimNodeSequence.ERootBoneAxis AxisX = 0, optional AnimNodeSequence.ERootBoneAxis AxisY = 0, optional AnimNodeSequence.ERootBoneAxis AxisZ = 0);

// Export UAnimNodeSequence::execSetRootBoneRotationOption(FFrame&, void* const)
native final function SetRootBoneRotationOption(optional AnimNodeSequence.ERootRotationOption AxisX = 0, optional AnimNodeSequence.ERootRotationOption AxisY = 0, optional AnimNodeSequence.ERootRotationOption AxisZ = 0);

defaultproperties
{
    Rate=1.0000000
    bSynchronize=true
    NotifyWeightThreshold=0.0100000
    CameraAnimScale=1.0000000
    CameraAnimPlayRate=1.0000000
    CameraAnimBlendInTime=0.2000000
    CameraAnimBlendOutTime=0.2000000
}