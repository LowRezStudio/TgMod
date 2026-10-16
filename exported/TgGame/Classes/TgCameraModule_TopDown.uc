class TgCameraModule_TopDown extends TgCameraModule_Spectator;

var Rotator WorldViewRotation;

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
    TargetLocation = CameraActor.PlayerOwner.Location;
    // End:0x2A6
    if(RemainingBlendTime > float(0))
    {
        RemainingBlendTime -= DeltaTime;
        // End:0xBB
        if(RemainingBlendTime < 0.0000000)
        {
            RemainingBlendTime = 0.0000000;
        }
        TargetRotation = OutVT.Target.Rotation;
        TargetRotation.Pitch = WorldViewPitch;
        DurationPct = (TotalBlendTime - RemainingBlendTime) / TotalBlendTime;
        BlendPct = FCubicInterp(0.0000000, 0.0000000, 1.0000000, 0.0000000, DurationPct);
        OutVT.POV.Location = VLerp(OldViewpoint.Location, TargetLocation, BlendPct);
        OutVT.POV.Rotation = RLerp(OldViewpoint.Rotation, TargetRotation, BlendPct, true);
        PlayerCamera.PlayerOwner.SetRotation(OutVT.POV.Rotation);        
    }
    else
    {
        OutVT.POV.Location = TargetLocation;
        OutVT.POV.Rotation = CameraActor.PlayerOwner.Rotation;
    }
    //return;    
}

function OnBecomeActive(TgCameraModule OldCamera)
{
    PlayerCamera.PlayerOwner.SwitchControl(Class'TgGame.TgControlModule_TopDown');
    //return;    
}

function OnBecomeInActive(TgCameraModule NewCamera)
{
    PlayerCamera.PlayerOwner.SwitchControl(Class'TgGame.TgControlModule_Spectator');
    //return;    
}

function BlendToTarget(float BlendTime)
{
    local Vector Loc, ViewDir, FinalLocation, CamToFocalPoint;
    local Rotator Rot;
    local float Angle;

    PlayerCamera.PlayerOwner.GetPlayerViewPoint(Loc, Rot);
    OldViewpoint.Location = Loc;
    OldViewpoint.Rotation = Rot;
    OldViewpoint.FOV = PlayerCamera.GetFOVAngle();
    RemainingBlendTime = BlendTime;
    TotalBlendTime = BlendTime;
    FinalLocation = PlayerCamera.PlayerOwner.ViewTarget.Location;
    WorldViewRotation = PlayerCamera.PlayerOwner.ViewTarget.Rotation;
    WorldViewRotation.Pitch = WorldViewPitch;
    ViewDir = Vector(WorldViewRotation);
    Angle = Acos(ViewDir Dot vect(0.0000000, 0.0000000, -1.0000000));
    Loc.Z = FClamp(PlayerCamera.PlayerOwner.Location.Z, Class'TgGame.TgControlModule_TopDown'.default.SpectatorMinStallZ, Class'TgGame.TgControlModule_TopDown'.default.SpectatorStallZ);
    CamToFocalPoint = (Loc.Z / Cos(Angle)) * ViewDir;
    FinalLocation.Z = 0.0000000;
    FinalLocation -= CamToFocalPoint;
    PlayerCamera.PlayerOwner.SetLocation(FinalLocation);
    //return;    
}

defaultproperties
{
    WorldViewPitch=-12000
    bCollideWorld=false
}