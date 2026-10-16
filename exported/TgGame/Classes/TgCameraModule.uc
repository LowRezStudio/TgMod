class TgCameraModule extends Object
    abstract
    native(View);

var transient TgPlayerCamera PlayerCamera;

function Init()
{
    //return;    
}

function OnBecomeActive(TgCameraModule OldCamera)
{
    //return;    
}

function OnBecomeInActive(TgCameraModule NewCamera)
{
    //return;    
}

function OnTweenOutEnd()
{
    //return;    
}

function UpdateCamera(Pawn P, TgPlayerCamera CameraActor, float DeltaTime, out TViewTarget OutVT)
{
    //return;    
}

function ProcessInput(PlayerInput PlayerInput, float DeltaTime)
{
    //return;    
}

simulated function BecomeViewTarget(TgPlayerController PC)
{
    //return;    
}

function zoomIn()
{
    //return;    
}

function ZoomOut()
{
    //return;    
}
