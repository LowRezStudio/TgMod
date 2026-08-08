class TgCameraModule_FrontFacingCamera extends TgCameraModule_ThirdPerson
    config(Engine);

var () Rotator m_rWorldRotationOffset;
var () float m_fFOV;

function OnBecomeActive(TgCameraModule OldCamera) { }

function OnBecomeInActive(TgCameraModule NewCamera) { }

function Rotator GetWorldRotation(TgPlayerCamera CameraActor) { }

function UpdateCamera(Pawn P, TgPlayerCamera CameraActor, float DeltaTime, out TViewTarget OutVT) { }

defaultproperties
{
    m_rWorldRotationOffset=(Pitch=0,Yaw=30947,Roll=0)
    m_fFOV=60.0000000
    CameraOffset=(X=-142.0000000,Y=30.0000000,Z=-35.0000000)
    bForce3PView=true
}
