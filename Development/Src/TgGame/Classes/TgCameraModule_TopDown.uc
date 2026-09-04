class TgCameraModule_TopDown extends TgCameraModule_Spectator
    config(Engine);

var Rotator WorldViewRotation;

function UpdateCamera(Pawn P, TgPlayerCamera CameraActor, float DeltaTime, out TViewTarget OutVT) { }

function OnBecomeActive(TgCameraModule OldCamera) { }

function OnBecomeInActive(TgCameraModule NewCamera) { }

function BlendToTarget(float BlendTime) { }

defaultproperties
{
    WorldViewPitch=-12000
    bCollideWorld=false
}
