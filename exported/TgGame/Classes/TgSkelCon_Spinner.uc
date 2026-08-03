class TgSkelCon_Spinner extends SkelControlSingleBone
    native(Anim)
    hidecategories(Object,Object,Adjustments,Translation);

var(Spin) float m_fDegreesPerSecond;
var(Spin) Vector m_vAxis;
var(Spin) editoronly transient bool m_PreviewStartStop;
var bool m_bIsSpinning;
var bool m_bSpinningUp;
var bool m_bSpinningDown;
var bool m_bSpinDownToZero;
var(TargetRotation) bool m_bRotateToTargetRotation;
var(Spin) float m_fSpinUpTime;
var(Spin) float m_fSpinDownTime;
var float m_fCurrentDegreesPerSecond;
var(TargetRotation) Rotator m_TargetRotation;
var(TargetRotation) float m_TimeToInterpToTargetRotation;
var transient int m_nRotationSpeedState;
var(Spin) array<float> m_fRotationSpeedStateMultipliers;

// Export UTgSkelCon_Spinner::execSpin(FFrame&, void* const)
native function Spin(bool bEnabled);

// Export UTgSkelCon_Spinner::execSpinToTargetRotation(FFrame&, void* const)
native function SpinToTargetRotation(Rotator TargetRotation, optional float Time, optional bool bReset);

defaultproperties
{
    m_fDegreesPerSecond=180.0000000
    m_bSpinDownToZero=true
    bApplyRotation=true
    bAddRotation=true
    BoneRotationSpace=EBoneControlSpace.BCS_ActorSpace
}