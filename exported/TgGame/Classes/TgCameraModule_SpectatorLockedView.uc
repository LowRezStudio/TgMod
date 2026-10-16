class TgCameraModule_SpectatorLockedView extends TgCameraModule_Spectator;

var() Rotator WorldViewRotation;
var() bool bAutoRotate;
var float FOV;
var float ZoomIncrement;
var int CurrentWorldViewTargetIndex;

function OnBecomeActive(TgCameraModule OldCamera)
{
    PlayerCamera.PlayerOwner.SwitchControl(Class'TgGame.TgControlModule_SpectatorLockedView');
    //return;    
}

function OnBecomeInActive(TgCameraModule NewCamera)
{
    PlayerCamera.PlayerOwner.SwitchControl(Class'TgGame.TgControlModule_Spectator');
    //return;    
}

function BlendCameraToLocation(Vector NewLocation, float BlendTime, bool bUseFocalPoint)
{
    local Vector Loc, CamToFocalPoint, ViewDir, FinalLocation;
    local Rotator Rot;
    local float Angle;

    PlayerCamera.PlayerOwner.GetPlayerViewPoint(Loc, Rot);
    OldViewpoint.Location = Loc;
    OldViewpoint.FOV = PlayerCamera.GetFOVAngle();
    OldViewpoint.Rotation = Rot;
    RemainingBlendTime = BlendTime;
    TotalBlendTime = BlendTime;
    FinalLocation = NewLocation;
    // End:0x1C9
    if(bUseFocalPoint)
    {
        ViewDir = Vector(WorldViewRotation);
        Angle = Acos(ViewDir Dot vect(0.0000000, 0.0000000, -1.0000000));
        CamToFocalPoint = (Loc.Z / Cos(Angle)) * ViewDir;
        FinalLocation.Z = 0.0000000;
        FinalLocation -= CamToFocalPoint;
    }
    PlayerCamera.PlayerOwner.SetLocation(FinalLocation);
    PlayerCamera.PlayerOwner.SetRotation(Rot);
    //return;    
}

function UpdateCamera(Pawn P, TgPlayerCamera CameraActor, float DeltaTime, out TViewTarget OutVT)
{
    local float DurationPct, BlendPct, ZHeight, Angle;
    local Vector TargetLocation, ViewDir, CamToFocalPoint, BaseLoc;
    local TgPawn TgP;
    local TgMapInfo MapInfo;

    // End:0x37
    if((CameraActor == none) || CameraActor.PlayerOwner == none)
    {
        return;
    }
    TargetLocation = OutVT.Target.Location;
    MapInfo = TgMapInfo(PlayerCamera.WorldInfo.GetMapInfo());
    // End:0x307
    if(MapInfo != none)
    {
        // End:0x1AF
        if(CurrentWorldViewTargetIndex == 0)
        {
            BaseLoc.X = MapInfo.m_vTaskForce1BaseLocation.X;
            BaseLoc.Y = MapInfo.m_vTaskForce1BaseLocation.Y;
            BaseLoc.Z = TargetLocation.Z;            
        }
        else
        {
            BaseLoc.X = MapInfo.m_vTaskForce2BaseLocation.X;
            BaseLoc.Y = MapInfo.m_vTaskForce2BaseLocation.Y;
            BaseLoc.Z = TargetLocation.Z;
        }
        WorldViewRotation = Rotator(BaseLoc - TargetLocation);
        WorldViewRotation.Pitch = CameraActor.PlayerOwner.Rotation.Pitch;
    }
    TgP = TgPawn(OutVT.Target);
    // End:0x448
    if(TgP != none)
    {
        ViewDir = Vector(WorldViewRotation);
        ZHeight = CameraActor.PlayerOwner.Location.Z - TgP.Location.Z;
        Angle = Acos(ViewDir Dot vect(0.0000000, 0.0000000, -1.0000000));
        CamToFocalPoint = (ZHeight / Cos(Angle)) * ViewDir;
        TargetLocation -= CamToFocalPoint;
    }
    // End:0x5BD
    if(RemainingBlendTime > float(0))
    {
        RemainingBlendTime -= DeltaTime;
        // End:0x48F
        if(RemainingBlendTime < 0.0000000)
        {
            RemainingBlendTime = 0.0000000;
        }
        DurationPct = (TotalBlendTime - RemainingBlendTime) / TotalBlendTime;
        BlendPct = FCubicInterp(0.0000000, 0.0000000, 1.0000000, 0.0000000, DurationPct);
        OutVT.POV.Location = VLerp(OldViewpoint.Location, TargetLocation, BlendPct);
        OutVT.POV.Rotation = RLerp(OldViewpoint.Rotation, WorldViewRotation, BlendPct, true);        
    }
    else
    {
        OutVT.POV.Location = TargetLocation;
        OutVT.POV.Rotation = WorldViewRotation;
    }
    //return;    
}

function zoomIn()
{
    local Vector NewLocation;
    local TgControlModule_SpectatorLockedView ControlModule;

    NewLocation = PlayerCamera.PlayerOwner.Location;
    ControlModule = TgControlModule_SpectatorLockedView(PlayerCamera.PlayerOwner.ControlModule);
    // End:0x14E
    if((ControlModule != none) && NewLocation.Z > ControlModule.GetMinStallZ())
    {
        NewLocation += (Vector(WorldViewRotation) * ZoomIncrement);
        // End:0x14E
        if(NewLocation.Z > ControlModule.GetMinStallZ())
        {
            BlendCameraToLocation(NewLocation, 0.3000000, false);
        }
    }
    //return;    
}

function ZoomOut()
{
    local Vector NewLocation;
    local TgControlModule_SpectatorLockedView ControlModule;

    NewLocation = PlayerCamera.PlayerOwner.Location;
    ControlModule = TgControlModule_SpectatorLockedView(PlayerCamera.PlayerOwner.ControlModule);
    // End:0x14E
    if((ControlModule != none) && NewLocation.Z < ControlModule.GetMaxStallZ())
    {
        NewLocation -= (Vector(WorldViewRotation) * ZoomIncrement);
        // End:0x14E
        if(NewLocation.Z < ControlModule.GetMaxStallZ())
        {
            BlendCameraToLocation(NewLocation, 0.3000000, false);
        }
    }
    //return;    
}

simulated function RotateView()
{
    CurrentWorldViewTargetIndex = ((CurrentWorldViewTargetIndex == 0) ? 1 : 0);
    //return;    
}

defaultproperties
{
    ZoomIncrement=96.0000000
}