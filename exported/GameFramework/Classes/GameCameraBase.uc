class GameCameraBase extends Object
    abstract
    native(Camera);

var transient GamePlayerCamera PlayerCamera;
var transient bool bResetCameraInterpolation;

function OnBecomeActive(GameCameraBase OldCamera)
{
    //return;    
}

function OnBecomeInActive(GameCameraBase NewCamera)
{
    //return;    
}

function ResetInterpolation()
{
    bResetCameraInterpolation = true;
    //return;    
}

function UpdateCamera(Pawn P, GamePlayerCamera CameraActor, float DeltaTime, out TViewTarget OutVT)
{
    //return;    
}

function ProcessViewRotation(float DeltaTime, Actor ViewTarget, out Rotator out_ViewRotation, out Rotator out_DeltaRot)
{
    //return;    
}

simulated function DisplayDebug(HUD HUD, out float out_YL, out float out_YPos)
{
    //return;    
}

function Init()
{
    //return;    
}

event ModifyPostProcessSettings(out PostProcessSettings PP)
{
    //return;    
}
