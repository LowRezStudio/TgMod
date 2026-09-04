class TgCameraModule_GroundTarget extends TgCameraModule_Free
    native(View)
    config(Engine);

function Vector GetCamLocationOffset(Pawn P) { }

function UpdateCamera(Pawn P, TgPlayerCamera CameraActor, float DeltaTime, out TViewTarget OutVT) { }

function zoomIn() { }

function ZoomOut() { }

defaultproperties
{
    DesiredCamAltitude=1440.0000000
}
