class TgCameraModule_Spectator extends TgCameraModule
    native(View);

var() int WorldViewPitch;
var transient TPOV OldViewpoint;
var transient float RemainingBlendTime;
var transient float TotalBlendTime;
var const bool bCollideWorld;

function UpdateCamera(Pawn P, TgPlayerCamera CameraActor, float DeltaTime, out TViewTarget OutVT)
{
    local float DurationPct, BlendPct;
    local Vector TargetLocation;
    local Rotator TargetRotation;

    // End:0x37
    if((CameraActor == none) || CameraActor.PlayerOwner == none)
    {
        return;
    }
    TargetLocation = OutVT.Target.Location;
    TargetRotation = OutVT.Target.Rotation;
    // End:0x222
    if(RemainingBlendTime > float(0))
    {
        RemainingBlendTime -= DeltaTime;
        // End:0xF4
        if(RemainingBlendTime < 0.0000000)
        {
            RemainingBlendTime = 0.0000000;
        }
        DurationPct = (TotalBlendTime - RemainingBlendTime) / TotalBlendTime;
        BlendPct = FCubicInterp(0.0000000, 0.0000000, 1.0000000, 0.0000000, DurationPct);
        OutVT.POV.Location = VLerp(OldViewpoint.Location, TargetLocation, BlendPct);
        OutVT.POV.Rotation = RLerp(OldViewpoint.Rotation, TargetRotation, BlendPct, true);        
    }
    else
    {
        OutVT.POV.Location = TargetLocation;
        OutVT.POV.Rotation = TargetRotation;
    }
    //return;    
}

function float GetFOVAngle()
{
    local float DurationPct, BlendPct, TargetFOV;

    TargetFOV = PlayerCamera.DefaultFOV;
    // End:0xF0
    if((RemainingBlendTime > float(0)) && TargetFOV != OldViewpoint.FOV)
    {
        DurationPct = (TotalBlendTime - RemainingBlendTime) / TotalBlendTime;
        BlendPct = FCubicInterp(0.0000000, 0.0000000, 1.0000000, 0.0000000, DurationPct);
        return Lerp(OldViewpoint.FOV, TargetFOV, BlendPct);
    }
    return TargetFOV;
    //return ReturnValue;    
}

function zoomIn()
{
    //return;    
}

function ZoomOut()
{
    //return;    
}

function IncreaseCameraSpeeed()
{
    PlayerCamera.PlayerOwner.SpectatorCameraSpeed = FClamp(PlayerCamera.PlayerOwner.SpectatorCameraSpeed + float(150), 150.0000000, 3000.0000000);
    //return;    
}

function DecreaseCameraSpeed()
{
    PlayerCamera.PlayerOwner.SpectatorCameraSpeed = FClamp(PlayerCamera.PlayerOwner.SpectatorCameraSpeed - float(150), 150.0000000, 3000.0000000);
    //return;    
}

function OnBecomeActive(TgCameraModule OldCamera)
{
    local Rotator CameraRot;
    local Vector CameraLoc;
    local TgPlayerController Controller;

    super.OnBecomeActive(OldCamera);
    Controller = PlayerCamera.PlayerOwner;
    Controller.GetPlayerViewPoint(CameraLoc, CameraRot);
    Controller.SetLocation(CameraLoc);
    Controller.SetRotation(CameraRot);
    Controller.bCollideWorld = bCollideWorld;
    //return;    
}

function OnBecomeInActive(TgCameraModule NewCamera)
{
    local TgPlayerController Controller;

    Controller = PlayerCamera.PlayerOwner;
    Controller.bCollideWorld = false;
    super.OnBecomeInActive(NewCamera);
    //return;    
}

function BlendCameraToLocation(Vector NewLocation, float BlendTime, bool bUseFocalPoint)
{
    local Vector Loc, CamToFocalPoint, ViewDir, FinalLocation;
    local Rotator Rot;
    local float Angle;

    PlayerCamera.PlayerOwner.GetPlayerViewPoint(Loc, Rot);
    OldViewpoint.Location = Loc;
    OldViewpoint.Rotation = Rot;
    OldViewpoint.FOV = PlayerCamera.GetFOVAngle();
    RemainingBlendTime = BlendTime;
    TotalBlendTime = BlendTime;
    FinalLocation = NewLocation;
    // End:0x30D
    if(bUseFocalPoint)
    {
        Rot.Pitch = WorldViewPitch;
        ViewDir = Vector(Rot);
        Angle = Acos(ViewDir Dot vect(0.0000000, 0.0000000, -1.0000000));
        CamToFocalPoint = (TgControlModule_Spectator(PlayerCamera.PlayerOwner.ControlModule).SpectatorStallZ / Cos(Angle)) * ViewDir;
        FinalLocation.Z = 0.0000000;
        FinalLocation -= CamToFocalPoint;
        PlayerCamera.PlayerOwner.SetLocation(FinalLocation);
        // End:0x30A
        if(FinalLocation != PlayerCamera.PlayerOwner.Location)
        {
            NewLocation.Z = Loc.Z;
            PlayerCamera.PlayerOwner.SetLocation(NewLocation);
        }        
    }
    else
    {
        FinalLocation.Z = Loc.Z;
        PlayerCamera.PlayerOwner.SetLocation(FinalLocation);
    }
    PlayerCamera.PlayerOwner.SetRotation(Rot);
    //return;    
}

defaultproperties
{
    WorldViewPitch=-6000
    OldViewpoint=(Location=(X=0.0000000,Y=0.0000000,Z=0.0000000),Rotation=(Pitch=0,Yaw=0,Roll=0),FOV=90.0000000,HUDOffset=(X=0.0000000,Y=0.0000000))
    bCollideWorld=true
}