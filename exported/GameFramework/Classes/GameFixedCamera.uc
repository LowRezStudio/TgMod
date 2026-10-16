class GameFixedCamera extends GameCameraBase;

var() protected const float DefaultFOV;

simulated function UpdateCamera(Pawn P, GamePlayerCamera CameraActor, float DeltaTime, out TViewTarget OutVT)
{
    local CameraActor CamActor;

    CamActor = CameraActor(OutVT.Target);
    // End:0x8F
    if(CamActor != none)
    {
        OutVT.POV.FOV = CamActor.FOVAngle;        
    }
    else
    {
        OutVT.POV.FOV = DefaultFOV;
    }
    // End:0x186
    if(OutVT.Target != none)
    {
        OutVT.POV.Location = CamActor.Location;
        OutVT.POV.Rotation = CamActor.Rotation;
    }
    PlayerCamera.ApplyCameraModifiers(DeltaTime, OutVT.POV);
    bResetCameraInterpolation = false;
    //return;    
}

function OnBecomeActive(GameCameraBase OldCamera)
{
    bResetCameraInterpolation = true;
    super.OnBecomeActive(OldCamera);
    //return;    
}

defaultproperties
{
    DefaultFOV=80.0000000
}