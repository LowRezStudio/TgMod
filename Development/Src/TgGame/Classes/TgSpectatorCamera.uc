class TgSpectatorCamera extends TgPlayerCamera
    transient
    native(View)
    hidecategories(Navigation)
    config(Engine);

var ViewTargetTransitionParams m_DefaultBlendParams;
var ViewTargetTransitionParams m_SnapBlendParams;
var CameraAnim m_CinematicAnim;
var transient CameraAnimInst m_AnimInstance;

simulated function DoUpdateCamera(float DeltaTime) { }

simulated function StartCinematicAnim() { }

simulated function EndCinematicAnim() { }

defaultproperties
{
    m_DefaultBlendParams=(BlendTime=0.3000000,BlendFunction=VTBlend_Cubic,BlendExp=2.0000000,bLockOutgoing=true)
    m_SnapBlendParams=(BlendTime=0.0001000,BlendFunction=VTBlend_Cubic,BlendExp=2.0000000,bLockOutgoing=true)
    DefaultCameraModuleClass=Class'TgCameraModule_Spectator'
}
