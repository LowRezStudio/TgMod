class TgCameraModule_SpectatorThirdPerson extends TgCameraModule_ThirdPerson
    config(Engine);

var transient TPOV OldViewpoint;
var transient float RemainingBlendTime;
var transient float TotalBlendTime;

function UpdateCamera(Pawn P, TgPlayerCamera CameraActor, float DeltaTime, out TViewTarget OutVT) { }

function BlendToTarget(float BlendTime) { }

defaultproperties
{
    OldViewpoint=(Location=(X=0.0000000,Y=0.0000000,Z=0.0000000),Rotation=(Pitch=0,Yaw=0,Roll=0),FOV=90.0000000,HUDOffset=(X=0.0000000,Y=0.0000000))
}
