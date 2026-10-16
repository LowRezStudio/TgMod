class TgAnimNodeAimOffset extends AnimNodeAimOffset
    native(Anim)
    hidecategories(Object,Object,Object,Object)
    config(Engine);

enum EPitchControlType {
    PITCHCONTROL_Disable,  // 0
    PITCHCONTROL_Legacy,  // 1
    PITCHCONTROL_Pure,  // 2
    PITCHCONTROL_UserDefined,  // 3
};

var const transient TgPawn Owner;
var array<AnimNode> m_CachedNodeList;
var transient bool m_bInitializedCachedNodeList;
var deprecated bool m_bDisableVerticalAiming;
var const transient bool bInterpolating;
var () bool m_bBakeAllProfileOffsetsFromAnimations;
var () bool m_bPopulateAnimNamesWithPrefixes;
var (Random) bool m_bRandomAimPointsEnabled;
var (OverrideAim) bool m_bOverrideAim;
var (AI) bool m_bAimAtTarget;
var (PitchControl) const TgAnimNodeAimOffset.EPitchControlType m_PitchControlType;
var (PitchControl) const InterpCurveFloat m_PitchControlUserCurve;
var () const transient float TurnInPlaceOffset;
var const transient float LastAimX;
var () float InterpSpeed;
var const transient Vector2D m_AimOffsetPct;
var (Random) Vector2D m_RandomAimPointsRangeX;
var (Random) Vector2D m_RandomAimPointsRangeY;
var (Random) float m_fRandomAimPointsInterpRate;
var (Random) float m_fRandomAimPointsIntervalMin;
var (Random) float m_fRandomAimPointsIntervalMax;
var float m_fCurrentRandomAimPointsInterval;
var Vector2D m_TargetRandomAimLocation;
var float m_fDeltaTime;
var (OverrideAim) Vector2D m_OverriddenAim;
var TgWeaponMeshActor m_WeaponMeshActor;

defaultproperties
{
    m_PitchControlType=PITCHCONTROL_Legacy
    m_PitchControlUserCurve=(Points=((InVal=-17920.0000000,OutVal=-1.0000000,ArriveTangent=0.0000000,LeaveTangent=0.0000000,InterpMode=CIM_Linear),(InVal=17920.0000000,OutVal=1.0000000,ArriveTangent=0.0000000,LeaveTangent=0.0000000,InterpMode=CIM_Linear)),InterpMethod=IMT_UseFixedTangentEval)
    InterpSpeed=12.0000000
    m_RandomAimPointsRangeX=(X=-1.0000000,Y=1.0000000)
    m_RandomAimPointsRangeY=(X=-1.0000000,Y=1.0000000)
    m_fRandomAimPointsInterpRate=8.0000000
    m_fRandomAimPointsIntervalMin=1.0000000
    m_fRandomAimPointsIntervalMax=2.0000000
}
