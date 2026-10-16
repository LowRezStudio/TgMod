class TgCameraModule_Attached extends TgCameraModule
    config(Engine);

function Vector GetAttachLocation(Pawn ViewTarget) { }

function Rotator GetAttachRotation(Pawn ViewTarget) { }

function UpdateCamera(Pawn P, TgPlayerCamera CameraActor, float DeltaTime, out TViewTarget OutVT) { }
