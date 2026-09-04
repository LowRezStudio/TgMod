class TgCameraModule_Free extends TgCameraModule
    native(View)
    config(Engine);

var float CamAltitude;
var float DesiredCamAltitude;
var float MaxCamAltitude;
var float MinCamAltitude;
var float CamZoomIncrement;

function ProcessInput(PlayerInput PlayerInput, float DeltaTime) { }

function Vector GetCamLocationOffset(Pawn P) { }

function UpdateCamera(Pawn P, TgPlayerCamera CameraActor, float DeltaTime, out TViewTarget OutVT) { }

simulated function BecomeViewTarget(TgPlayerController PC) { }

function zoomIn() { }

function ZoomOut() { }

defaultproperties
{
    CamAltitude=150.0000000
    DesiredCamAltitude=150.0000000
    MaxCamAltitude=150.0000000
    MinCamAltitude=150.0000000
    CamZoomIncrement=96.0000000
}
