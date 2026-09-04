class AnimNodeSlot extends AnimNodeBlendBase
    native(Anim)
    hidecategories(Object,Object,Object,Object);

var const bool bIsPlayingCustomAnim;
var() bool bEarlyAnimEndNotify;
var() bool bSkipBlendWhenNotRendered;
var() bool bAdditiveAnimationsOverrideSource;
var const transient bool bIsBeingUsedByInterpGroup;
var() bool bDontAddToAlwaysTickArray;
var const float PendingBlendOutTime;
var const int CustomChildIndex;
var const int TargetChildIndex;
var array<float> TargetWeight;
var const float BlendTimeToGo;

// Export UAnimNodeSlot::execPlayCustomAnim(FFrame&, void* const)
native final function float PlayCustomAnim(name AnimName, float Rate, optional float BlendInTime, optional float BlendOutTime, optional bool bLooping, optional bool bOverride, optional float StartTime, optional float EndTime);

// Export UAnimNodeSlot::execPlayCustomAnimByDuration(FFrame&, void* const)
native final function bool PlayCustomAnimByDuration(name AnimName, float Duration, optional float BlendInTime, optional float BlendOutTime, optional bool bLooping, optional bool bOverride = true);

// Export UAnimNodeSlot::execGetPlayedAnimation(FFrame&, void* const)
native final function name GetPlayedAnimation();

// Export UAnimNodeSlot::execStopCustomAnim(FFrame&, void* const)
native function StopCustomAnim(float BlendOutTime);

// Export UAnimNodeSlot::execSetAllowPauseAnims(FFrame&, void* const)
native final function SetAllowPauseAnims(bool bSet);

// Export UAnimNodeSlot::execSetCustomAnim(FFrame&, void* const)
native final function SetCustomAnim(name AnimName);

// Export UAnimNodeSlot::execSetActorAnimEndNotification(FFrame&, void* const)
native final function SetActorAnimEndNotification(bool bNewStatus);

// Export UAnimNodeSlot::execGetCustomAnimNodeSeq(FFrame&, void* const)
native final function AnimNodeSequence GetCustomAnimNodeSeq();

// Export UAnimNodeSlot::execSetRootBoneAxisOption(FFrame&, void* const)
native final function SetRootBoneAxisOption(optional AnimNodeSequence.ERootBoneAxis AxisX = 0, optional AnimNodeSequence.ERootBoneAxis AxisY = 0, optional AnimNodeSequence.ERootBoneAxis AxisZ = 0);

// Export UAnimNodeSlot::execSetRootBoneRotationOption(FFrame&, void* const)
native final function SetRootBoneRotationOption(optional AnimNodeSequence.ERootRotationOption AxisX = 0, optional AnimNodeSequence.ERootRotationOption AxisY = 0, optional AnimNodeSequence.ERootRotationOption AxisZ = 0);

// Export UAnimNodeSlot::execTickChildWeights(FFrame&, void* const)
native final function TickChildWeights(float DeltaSeconds);

defaultproperties
{
    bEarlyAnimEndNotify=true
    TargetWeight[0]=1.0000000
    Children[0]=(Name="Source",Anim=none,Weight=1.0000000,BlendWeight=0.0000000,bMirrorSkeleton=false,bIsAdditive=false)
    Children[1]=(Name="Channel 01",Anim=none,Weight=0.0000000,BlendWeight=0.0000000,bMirrorSkeleton=false,bIsAdditive=false)
    NodeName="SlotName"
}