class TgCameraModule_Spectator extends TgCameraModule
    native(View)
    config(Engine);

var () int WorldViewPitch;
var transient TPOV OldViewpoint;
var transient float RemainingBlendTime;
var transient float TotalBlendTime;
var const bool bCollideWorld;

function UpdateCamera(Pawn P, TgPlayerCamera CameraActor, float DeltaTime, out TViewTarget OutVT) { }

function float GetFOVAngle() { }

function zoomIn() { }

function ZoomOut() { }

function IncreaseCameraSpeeed() { }

function DecreaseCameraSpeed() { }

function OnBecomeActive(TgCameraModule OldCamera) { }

function OnBecomeInActive(TgCameraModule NewCamera) { }

function BlendCameraToLocation(Vector NewLocation, float BlendTime, bool bUseFocalPoint) { }

defaultproperties
{
    WorldViewPitch=-6000
    OldViewpoint=(Location=(X=0.0000000,Y=0.0000000,Z=0.0000000),Rotation=(Pitch=0,Yaw=0,Roll=0),FOV=90.0000000,HUDOffset=(X=0.0000000,Y=0.0000000))
    bCollideWorld=true
}
