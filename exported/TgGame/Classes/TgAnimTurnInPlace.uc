class TgAnimTurnInPlace extends AnimNodeBlend
    native(Anim)
    hidecategories(Object,Object,Object,Object);

enum ForcedTransitionAngle
{
    FTA_NONE,                       // 0
    FTA_90,                         // 1
    FTA_180,                        // 2
    FTA_MAX                         // 3
};

struct native RotTransitionInfo
{
    var() float RotationOffset;
    var() name TransName;

    structdefaultproperties
    {
        RotationOffset=0.0000000
        TransName="None"
    }
};

var const transient bool bInitialized;
var const transient bool bRootRotInitialized;
var() bool m_bDisableRotation;
var() bool bDelayBlendOutToPlayAnim;
var const bool bPlayingTurnTransition;
var(ChooseNewTransition) bool m_bCanChooseNewTransition;
var(Interpolation) bool m_bOverrideInterpolationTime;
var() bool m_bMirrorOffsetWhenPawnMirrored;
var() bool m_bAlwaysUpdateYawOffset;
var(IgnoreTransitionAnimations) bool m_bIgnoreTransitionAnimations;
var(IgnoreTransitionAnimations) bool m_bOnlyUpdateRotationWhenMoving;
var(TurnTowardsVelocity) bool m_bTurnTowardsVelocity;
var(TurnTowardsVelocity) bool m_bUsePawnRotationAtZeroVelocity;
var(TurnTowardsVelocity) bool m_bUse180ShortestRoute;
var(TurnTowardsVelocity) bool m_bConstrictIdleYawOffset;
var() bool m_bDisableAllTurning;
var bool m_bJustBecameRelevant;
var const transient int LastPawnYaw;
var const transient int LastPawnPitch;
var const transient float PawnRotationRate;
var const transient int LastRootBoneYaw;
var() const transient int YawOffset;
var() const transient int PitchOffset;
var const transient float RelativeOffset;
var const transient TgPawn m_TgPawn;
var array<TgAnimNodeAimOffset> OffsetNodes2;
var() array<RotTransitionInfo> RotTransitions;
var() float TransitionBlendTime;
var const int CurrentTransitionIndex;
var() float TransitionThresholdAngle;
var(ChooseNewTransition) TgAnimTurnInPlace.ForcedTransitionAngle m_ForcedTransitionAngle;
var(ChooseNewTransition) float m_fChooseNewTransitionPercent;
var(Interpolation) float m_fInterpolationTime;
var float m_RemainingInterpolationTime;
var array<TgAnimTurnInPlace_Player> PlayerNodes;
var(IgnoreTransitionAnimations) float m_fIgnoredTransitionTime;
var(TurnTowardsVelocity) float m_fTurnInterpTime;
var Rotator m_InterpRotation;

// Export UTgAnimTurnInPlace::execOverrideYawOffset(FFrame&, void* const)
native function OverrideYawOffset(float Value);

defaultproperties
{
    m_bCanChooseNewTransition=true
    m_bJustBecameRelevant=true
    RotTransitions[0]=(RotationOffset=16384.0000000,TransName="Rt_90")
    RotTransitions[1]=(RotationOffset=32768.0000000,TransName="Rt_180")
    RotTransitions[2]=(RotationOffset=-16384.0000000,TransName="Lt_90")
    RotTransitions[3]=(RotationOffset=-32768.0000000,TransName="Lt_180")
    TransitionBlendTime=0.1000000
    TransitionThresholdAngle=4096.0000000
    m_fChooseNewTransitionPercent=0.5000000
    m_fIgnoredTransitionTime=2.0000000
    Children=/* Array type was not detected. */
}