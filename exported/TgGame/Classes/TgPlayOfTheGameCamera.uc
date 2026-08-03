class TgPlayOfTheGameCamera extends CameraActor
    native(View)
    hidecategories(Navigation);

var(CameraActor) TgSkeletalMeshActor_Loader m_ViewTarget;
var transient bool m_bActive;
var float m_fRemainingTweenTime;
var float m_fTotalTweenTime;
var transient TPOV m_TweenSourcePOV;
var Vector m_vRelativeLocation;
var Vector m_vRelativeRotation;
var(CameraActor) Vector m_vRelativeLocationOffset;
var(CameraActor) Vector m_vRelativeRotationOffset;

// Export UTgPlayOfTheGameCamera::execSetActive(FFrame&, void* const)
native function SetActive(bool bActive);

// Export UTgPlayOfTheGameCamera::execUpdateTransform(FFrame&, void* const)
native function UpdateTransform();

simulated function StartTween(float TweenTime)
{
    m_fRemainingTweenTime = TweenTime;
    m_fTotalTweenTime = TweenTime;
    m_TweenSourcePOV = GetALocalPlayerController().PlayerCamera.CameraCache.POV;
    //return;    
}

simulated function GetCameraView(float DeltaTime, out TPOV OutPOV)
{
    GetActorEyesViewPoint(OutPOV.Location, OutPOV.Rotation);
    OutPOV.FOV = (57.2957800 * Atan(Tan((0.0174533 * FOVAngle) / 2.0000000) * AspectRatio)) * 2.0000000;
    //return;    
}

simulated event ApplyPostProcessOverrides()
{
    CamOverridePostProcessAlpha = 1.0000000;
    CamOverridePostProcess.bOverride_EnableDOF = true;
    CamOverridePostProcess.bEnableDOF = true;
    CamOverridePostProcess.bOverride_DOF_BlurBloomKernelSize = true;
    CamOverridePostProcess.DOF_BlurBloomKernelSize = 16.0000000;
    CamOverridePostProcess.bOverride_DOF_FalloffExponent = true;
    CamOverridePostProcess.DOF_FalloffExponent = 4.0000000;
    CamOverridePostProcess.bOverride_DOF_BlurKernelSize = true;
    CamOverridePostProcess.DOF_BlurKernelSize = 16.0000000;
    CamOverridePostProcess.bOverride_DOF_MaxNearBlurAmount = true;
    CamOverridePostProcess.DOF_MaxNearBlurAmount = 0.9000000;
    CamOverridePostProcess.bOverride_DOF_MinBlurAmount = true;
    CamOverridePostProcess.DOF_MinBlurAmount = 0.0000000;
    CamOverridePostProcess.bOverride_DOF_MaxFarBlurAmount = true;
    CamOverridePostProcess.DOF_MaxFarBlurAmount = 0.9000000;
    CamOverridePostProcess.bOverride_DOF_FocusType = true;
    CamOverridePostProcess.DOF_FocusType = 0;
    CamOverridePostProcess.bOverride_DOF_FocusInnerRadius = true;
    CamOverridePostProcess.DOF_FocusInnerRadius = 500.0000000;
    CamOverridePostProcess.bOverride_DOF_FocusDistance = true;
    CamOverridePostProcess.DOF_FocusDistance = 0.0000000;
    CamOverridePostProcess.bOverride_DOF_FocusPosition = true;
    CamOverridePostProcess.DOF_FocusPosition.X = 0.0000000;
    CamOverridePostProcess.DOF_FocusPosition.Y = 0.0000000;
    CamOverridePostProcess.DOF_FocusPosition.Z = 0.0000000;
    CamOverridePostProcess.bOverride_DOF_InterpolationDuration = true;
    CamOverridePostProcess.DOF_InterpolationDuration = 1.0000000;
    CamOverridePostProcess.bOverride_DOF_BokehTexture = true;
    CamOverridePostProcess.DOF_BokehTexture = none;
    //return;    
}

defaultproperties
{
    m_TweenSourcePOV=(Location=(X=0.0000000,Y=0.0000000,Z=0.0000000),Rotation=(Pitch=0,Yaw=0,Roll=0),FOV=90.0000000,HUDOffset=(X=0.0000000,Y=0.0000000))
    m_vRelativeLocation=(X=95.0000000,Y=-7.0000000,Z=64.0000000)
    m_vRelativeRotation=(X=0.0000000,Y=0.0000000,Z=160.0000000)
    FOVAngle=40.0000000
}