class TgAnimNodeTriggerCameraAnim extends AnimNodeBlendBase
    native(Anim)
    hidecategories(Object,Object,Object);

var() CameraAnim CameraAnim;
var() float fBlendInTime;
var() float fBlendOutTime;
var() bool bLoopAnimation;
var() bool bBlendInOnBecomeRelevant;
var() bool bBlendInOnReplayAnim;
var() bool bBlendOutOnStopFire;
var() bool bPlayAnimInLocalSpace;
var() TgObject.TG_EQUIP_POINT m_StopFireEquipSlotTarget;
var CameraAnimInst CameraAnimInst;

// Export UTgAnimNodeTriggerCameraAnim::execStartCameraAnim(FFrame&, void* const)
native function StartCameraAnim();

// Export UTgAnimNodeTriggerCameraAnim::execEndCameraAnim(FFrame&, void* const)
native function EndCameraAnim();

// Export UTgAnimNodeTriggerCameraAnim::execReplayAnim(FFrame&, void* const)
native function ReplayAnim();

// Export UTgAnimNodeTriggerCameraAnim::execOnDeviceStopFire(FFrame&, void* const)
native function OnDeviceStopFire(TgObject.TG_EQUIP_POINT eqp);

defaultproperties
{
    fBlendInTime=0.1000000
    fBlendOutTime=0.1000000
    bBlendInOnBecomeRelevant=true
    bBlendInOnReplayAnim=true
    bPlayAnimInLocalSpace=true
    Children=/* Array type was not detected. */
    NodeName="TriggerCameraAnim"
}