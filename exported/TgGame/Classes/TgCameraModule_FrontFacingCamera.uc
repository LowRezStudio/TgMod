class TgCameraModule_FrontFacingCamera extends TgCameraModule_ThirdPerson;

var() Rotator m_rWorldRotationOffset;
var() float m_fFOV;

function OnBecomeActive(TgCameraModule OldCamera)
{
    PlayerCamera.PlayerOwner.SwitchControl(Class'TgGame.TgControlModule_FrontFacingCamera');
    //return;    
}

function OnBecomeInActive(TgCameraModule NewCamera)
{
    PlayerCamera.PlayerOwner.SwitchControl(Class'TgGame.TgControlModule_ThirdPerson');
    //return;    
}

function Rotator GetWorldRotation(TgPlayerCamera CameraActor)
{
    local Rotator OutRotation;

    OutRotation = super.GetWorldRotation(CameraActor);
    OutRotation.Pitch = 0;
    OutRotation.Roll = 0;
    return OutRotation + m_rWorldRotationOffset;
    //return ReturnValue;    
}

function UpdateCamera(Pawn P, TgPlayerCamera CameraActor, float DeltaTime, out TViewTarget OutVT)
{
    super.UpdateCamera(P, CameraActor, DeltaTime, OutVT);
    OutVT.POV.FOV = m_fFOV;
    //return;    
}

defaultproperties
{
    m_rWorldRotationOffset=(Pitch=0,Yaw=30947,Roll=0)
    m_fFOV=60.0000000
    CameraOffset=(X=-142.0000000,Y=30.0000000,Z=-35.0000000)
    bForce3PView=true
}