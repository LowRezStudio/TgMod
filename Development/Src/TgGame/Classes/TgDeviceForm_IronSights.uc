class TgDeviceForm_IronSights extends TgDeviceForm_ToggleWithLockout
    native(ChampViktor)
    config(Engine);

var float m_fCameraFOVInterpolationTime;
var () float m_fMaxCameraFOVInteprolationTime;
var float m_fCameraFOVInterpolationTarget;
var float m_fActiveFOV;
var bool m_fHasStartedInterpolation;
var float m_fDesiredStartInterpolationTimestamp;

event Generic1(optional byte byExtraData) { }

event Fire(Vector HitLocation, int nFireMode, optional int nEquipSlot=0, optional int nSocketIndex=0, optional bool bSuccessfulHit=false, optional float fRefireTime) { }

event StopFire(int nFireModeNum) { }

event Generic2(optional byte byExtraData) { }

simulated function ClearPendingFOVInterpolation() { }

simulated event PlayToggleTransitionAnimations(float transitionPercent, float totalTransitionTime, bool transitionToActive) { }

simulated event StartCameraInterpolation() { }

defaultproperties
{
    m_fMaxCameraFOVInteprolationTime=0.1200000
    m_fActiveFOV=70.0000000
}
