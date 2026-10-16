class TgPlayOfTheGameCamera extends CameraActor
    native(View)
    hidecategories(Navigation)
    config(Engine);

var (CameraActor) TgSkeletalMeshActor_Loader m_ViewTarget;
var transient bool m_bActive;
var float m_fRemainingTweenTime;
var float m_fTotalTweenTime;
var transient TPOV m_TweenSourcePOV;
var Vector m_vRelativeLocation;
var Vector m_vRelativeRotation;
var (CameraActor) Vector m_vRelativeLocationOffset;
var (CameraActor) Vector m_vRelativeRotationOffset;

native function SetActive(bool bActive);  // Export UTgPlayOfTheGameCamera::execSetActive(FFrame&, void* const)

native function UpdateTransform();  // Export UTgPlayOfTheGameCamera::execUpdateTransform(FFrame&, void* const)

simulated function StartTween(float TweenTime) { }

simulated function GetCameraView(float DeltaTime, out TPOV OutPOV) { }

simulated event ApplyPostProcessOverrides() { }

defaultproperties
{
    m_TweenSourcePOV=(Location=(X=0.0000000,Y=0.0000000,Z=0.0000000),Rotation=(Pitch=0,Yaw=0,Roll=0),FOV=90.0000000,HUDOffset=(X=0.0000000,Y=0.0000000))
    m_vRelativeLocation=(X=95.0000000,Y=-7.0000000,Z=64.0000000)
    m_vRelativeRotation=(X=0.0000000,Y=0.0000000,Z=160.0000000)
    FOVAngle=40.0000000
}
