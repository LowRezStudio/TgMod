class TgCameraModule extends Object
    abstract
    native(View)
    config(Engine);

var transient TgPlayerCamera PlayerCamera;

function Init() { }

function OnBecomeActive(TgCameraModule OldCamera) { }

function OnBecomeInActive(TgCameraModule NewCamera) { }

function OnTweenOutEnd() { }

function UpdateCamera(Pawn P, TgPlayerCamera CameraActor, float DeltaTime, out TViewTarget OutVT) { }

function ProcessInput(PlayerInput PlayerInput, float DeltaTime) { }

simulated function BecomeViewTarget(TgPlayerController PC) { }

function zoomIn() { }

function ZoomOut() { }
