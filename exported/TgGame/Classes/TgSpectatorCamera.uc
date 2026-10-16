class TgSpectatorCamera extends TgPlayerCamera
    transient
    native(View)
    hidecategories(Navigation);

var ViewTargetTransitionParams m_DefaultBlendParams;
var ViewTargetTransitionParams m_SnapBlendParams;
var CameraAnim m_CinematicAnim;
var transient CameraAnimInst m_AnimInstance;

simulated function DoUpdateCamera(float DeltaTime)
{
    DeltaTime = WorldInfo.m_fRealDeltaSeconds;
    super(Camera).DoUpdateCamera(DeltaTime);
    //return;    
}

simulated function StartCinematicAnim()
{
    // End:0x3C
    if(m_AnimInstance == none)
    {
        m_AnimInstance = PlayCameraAnim(m_CinematicAnim,,, 0.3000000, 0.3000000, true, false,, true);
    }
    //return;    
}

simulated function EndCinematicAnim()
{
    // End:0x2E
    if(m_AnimInstance != none)
    {
        StopCameraAnim(m_AnimInstance, true);
        m_AnimInstance = none;
    }
    //return;    
}

defaultproperties
{
    m_DefaultBlendParams=(BlendTime=0.3000000,BlendFunction=EViewTargetBlendFunction.VTBlend_Cubic,BlendExp=2.0000000,bLockOutgoing=true)
    m_SnapBlendParams=(BlendTime=0.0001000,BlendFunction=EViewTargetBlendFunction.VTBlend_Cubic,BlendExp=2.0000000,bLockOutgoing=true)
    DefaultCameraModuleClass=Class'TgGame.TgCameraModule_Spectator'
}