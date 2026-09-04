class TgSkelCon_ClockworkSpinner extends SkelControlSingleBone
    native(Anim)
    hidecategories(Object,Object);

var() float m_fInterpTime;
var float m_fRemainingInterpTime;
var() float m_fPauseTime;
var float m_fRemainingPauseTime;
var() Object.EAxis RotationAxis;
var int DeltaRotation;
var() float m_fInterpRotation;
var() bool bLimitedRotation;
var bool bForward;
var() float m_fRotationMin;
var() float m_fRotationMax;
var() float m_fResetInterpTime;
var() float m_fResetPauseTime;
var() float m_fResetRotation;
var float m_fRotatorMin;
var float m_fRotatorMax;
var float RotationsPerSecond;
var float ResetRotationsPerSecond;

defaultproperties
{
    m_fInterpTime=10.0000000
    m_fPauseTime=1.0000000
    RotationAxis=EAxis.AXIS_Z
    bForward=true
    m_fRotationMax=1.0000000
    RotationsPerSecond=1.0000000
    ResetRotationsPerSecond=1.0000000
    bApplyRotation=true
    bAddRotation=true
    BoneRotationSpace=EBoneControlSpace.BCS_BoneSpace
}