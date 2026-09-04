class TgCameraModule_SpectatorLockedView extends TgCameraModule_Spectator
    config(Engine);

var () Rotator WorldViewRotation;
var () bool bAutoRotate;
var float FOV;
var float ZoomIncrement;
var int CurrentWorldViewTargetIndex;

function OnBecomeActive(TgCameraModule OldCamera) { }

function OnBecomeInActive(TgCameraModule NewCamera) { }

function BlendCameraToLocation(Vector NewLocation, float BlendTime, bool bUseFocalPoint) { }

function UpdateCamera(Pawn P, TgPlayerCamera CameraActor, float DeltaTime, out TViewTarget OutVT) { }

function zoomIn() { }

function ZoomOut() { }

simulated function RotateView() { }

defaultproperties
{
    ZoomIncrement=96.0000000
}
