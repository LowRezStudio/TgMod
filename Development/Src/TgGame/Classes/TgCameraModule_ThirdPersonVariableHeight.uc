class TgCameraModule_ThirdPersonVariableHeight extends TgCameraModule_ThirdPerson
    config(Engine);

var () float ZOffset;

function OnBecomeActive(TgCameraModule OldCamera) { }

function Vector GetCamLocationOffset(Rotator PawnRot, Actor ViewTarget) { }

function zoomIn() { }

function ZoomOut() { }
