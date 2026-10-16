class TgCameraModule_SpectatorOverview extends TgCameraModule_Spectator
    native(View)
    config(Game);

struct native CameraPitchInfo
{
    var float ZHeight;
    var float Pitch;

    structdefaultproperties
    {
        ZHeight=0.0000000
        Pitch=0.0000000
    }
};

var() Rotator WorldViewRotation;
var() config float FOV;
var float TargetZoomedFOV;
var() config float ZoomIncrement;
var() config float MinZoom;
var() config float MaxZoom;
var() config float ZoomInterpTime;
var Vector CurrentSpringLocation;
var() config float PawnTargetSpringDamping;
var() config float FreeCamSpringDamping;
var() config float IgnoreSpringDistance;
var() array<CameraPitchInfo> CameraPitchData;
var() bool bFlippedSides;
var bool bJustBecameActive;
var() config bool bAutoZoomEnabled;
var() float OverviewCameraInfluenceDist;
var array<TgOverviewCameraActor> OverviewCameras;
var array<TgPawn_TowerBase> TransparentTowerList;
var() Vector ObstacleTransparentExtent;
var() config float fMinAutoZoomFOVAngle;
var() config float fMaxAutoZoomFOVAngle;
var() config float fMinAutoZoomDistance;
var() config float fMaxAutoZoomDistance;
var() config float fAutoZoomDetectionRadius;
var() config float fAutoZoomInSpeed;
var() config float fAutoZoomOutSpeed;
var() config float fAutoZoomInLockOutTime;
var() config float fAutoZoomOutLockOutTime;
var transient float m_RemainingAutoZoomInLockOutTime;
var transient float m_RemainingAutoZoomOutLockOutTime;

// Export UTgCameraModule_SpectatorOverview::execGetWorldViewRotation(FFrame&, void* const)
native function Rotator GetWorldViewRotation();

// Export UTgCameraModule_SpectatorOverview::execUpdateAutoZoom(FFrame&, void* const)
native function bool UpdateAutoZoom(float DeltaTime);

// Export UTgCameraModule_SpectatorOverview::execCheckObstacleTransparency(FFrame&, void* const)
native function CheckObstacleTransparency();

// Export UTgCameraModule_SpectatorOverview::execClearObstacleTransparency(FFrame&, void* const)
native function ClearObstacleTransparency();

function OnBecomeActive(TgCameraModule OldCamera)
{
    local Vector StartLocation;
    local TgOverviewCameraActor C;
    local Rotator Rot;

    PlayerCamera.PlayerOwner.SwitchControl(Class'TgGame.TgControlModule_SpectatorOverview');
    StartLocation = PlayerCamera.PlayerOwner.Location;
    StartLocation.Z = TgControlModule_SpectatorOverview(PlayerCamera.PlayerOwner.ControlModule).GetMinStallZ();
    BlendCameraToLocation(StartLocation, 0.0000000, false);
    CurrentSpringLocation = StartLocation;
    Rot = PlayerCamera.PlayerOwner.Rotation;
    Rot.Yaw = 0;
    PlayerCamera.PlayerOwner.SetRotation(Rot);
    PlayerCamera.PlayerOwner.SetRotation(GetWorldViewRotation());
    OverviewCameras.Remove(0, OverviewCameras.Length);
    // End:0x238
    foreach PlayerCamera.AllActors(Class'TgGame.TgOverviewCameraActor', C)
    {
        OverviewCameras.AddItem(C);        
    }    
    TargetZoomedFOV = FOV;
    bJustBecameActive = true;
    //return;    
}

function OnBecomeInActive(TgCameraModule NewCamera)
{
    ClearObstacleTransparency();
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
    // End:0x1CA
    if(bUseFocalPoint)
    {
        ViewDir = Vector(GetWorldViewRotation());
        Angle = Acos(ViewDir Dot vect(0.0000000, 0.0000000, -1.0000000));
        CamToFocalPoint = (Loc.Z / Cos(Angle)) * ViewDir;
        FinalLocation.Z = 0.0000000;
        FinalLocation -= CamToFocalPoint;
    }
    PlayerCamera.PlayerOwner.SetLocation(FinalLocation);
    PlayerCamera.PlayerOwner.SetRotation(Rot);
    //return;    
}

function OverridePawnTargetLocation(TgPawn TgP, out Vector TargetLocation)
{
    // End:0x51
    if(int(TgP.r_eTweenState) == int(3))
    {
        TargetLocation = TgP.r_vPhysTweenTarget;
    }
    //return;    
}

function UpdateCamera(Pawn P, TgPlayerCamera CameraActor, float DeltaTime, out TViewTarget OutVT)
{
    local float DurationPct, BlendPct, ZHeight, Angle, SpringDamping;

    local Vector TargetLocation, ViewDir, CamToFocalPoint, OutLocation;
    local TgPawn TgP;
    local Rotator ViewRot, OutRotation;
    local TgSpectatorController SpectatorController;

    // End:0x37
    if((CameraActor == none) || CameraActor.PlayerOwner == none)
    {
        return;
    }
    SpringDamping = FreeCamSpringDamping;
    TargetLocation = OutVT.Target.Location;
    ViewRot = GetWorldViewRotation();
    TgP = TgPawn(OutVT.Target);
    // End:0x1F4
    if(TgP != none)
    {
        OverridePawnTargetLocation(TgP, TargetLocation);
        ViewDir = Vector(ViewRot);
        ZHeight = CameraActor.PlayerOwner.Location.Z - TargetLocation.Z;
        Angle = Acos(ViewDir Dot vect(0.0000000, 0.0000000, -1.0000000));
        CamToFocalPoint = (ZHeight / Cos(Angle)) * ViewDir;
        TargetLocation -= CamToFocalPoint;
        SpringDamping = PawnTargetSpringDamping;
    }
    // End:0x356
    if(RemainingBlendTime > float(0))
    {
        RemainingBlendTime -= DeltaTime;
        // End:0x23B
        if(RemainingBlendTime < 0.0000000)
        {
            RemainingBlendTime = 0.0000000;
        }
        DurationPct = (TotalBlendTime - RemainingBlendTime) / TotalBlendTime;
        BlendPct = FCubicInterp(0.0000000, 0.0000000, 1.0000000, 0.0000000, DurationPct);
        TargetLocation = VLerp(OldViewpoint.Location, TargetLocation, BlendPct);
        OutRotation = RLerp(OldViewpoint.Rotation, ViewRot, BlendPct, true);
        OutVT.POV.FOV = FOV;        
    }
    else
    {
        OutRotation = ViewRot;
    }
    // End:0x45B
    if((RemainingBlendTime <= float(0)) && !bJustBecameActive)
    {
        // End:0x3D1
        if(VSizeSq2D(CurrentSpringLocation - TargetLocation) > (IgnoreSpringDistance * IgnoreSpringDistance))
        {
            SpringDamping = 0.0000000;
        }
        CurrentSpringLocation = VInterpTo(CurrentSpringLocation, TargetLocation, DeltaTime, SpringDamping * FMax(PlayerCamera.WorldInfo.DemoPlayTimeDilation, 1.0000000));
        OutLocation = CurrentSpringLocation;        
    }
    else
    {
        CurrentSpringLocation = TargetLocation;
    }
    bJustBecameActive = false;
    OutLocation = CurrentSpringLocation;
    CheckObstacleTransparency();
    SpectatorController = TgSpectatorController(CameraActor.PlayerOwner);
    // End:0x5CD
    if(bAutoZoomEnabled && !UpdateAutoZoom(DeltaTime))
    {
        // End:0x5CD
        if(SpectatorController != none)
        {
            // End:0x567
            if(int(SpectatorController.m_CurrentZoomState) == int(1))
            {
                TargetZoomedFOV = FClamp(TargetZoomedFOV - (ZoomIncrement * DeltaTime), MinZoom, MaxZoom);                
            }
            else
            {
                // End:0x5CD
                if(int(SpectatorController.m_CurrentZoomState) == int(2))
                {
                    TargetZoomedFOV = FClamp(TargetZoomedFOV + (ZoomIncrement * DeltaTime), MinZoom, MaxZoom);
                }
            }
        }
    }
    FOV = FInterpTo(FOV, TargetZoomedFOV, DeltaTime, ZoomInterpTime);
    OutVT.POV.Location = OutLocation;
    OutVT.POV.Rotation = OutRotation;
    //return;    
}

function zoomIn()
{
    TargetZoomedFOV -= ZoomIncrement;
    TargetZoomedFOV = FMax(MinZoom, TargetZoomedFOV);
    //return;    
}

function ZoomOut()
{
    TargetZoomedFOV += ZoomIncrement;
    TargetZoomedFOV = FMin(MaxZoom, TargetZoomedFOV);
    //return;    
}

function float GetFOVAngle()
{
    local float DurationPct, BlendPct;

    // End:0xC8
    if((RemainingBlendTime > float(0)) && FOV != OldViewpoint.FOV)
    {
        DurationPct = (TotalBlendTime - RemainingBlendTime) / TotalBlendTime;
        BlendPct = FCubicInterp(0.0000000, 0.0000000, 1.0000000, 0.0000000, DurationPct);
        return Lerp(OldViewpoint.FOV, FOV, BlendPct);
    }
    return FOV;
    //return ReturnValue;    
}

function FlipSides()
{
    bFlippedSides = !bFlippedSides;
    //return;    
}

defaultproperties
{
    WorldViewRotation=(Pitch=-6000,Yaw=0,Roll=0)
    FOV=55.0000000
    ZoomIncrement=25.0000000
    MinZoom=30.0000000
    MaxZoom=70.0000000
    ZoomInterpTime=3.0000000
    PawnTargetSpringDamping=1.7000000
    IgnoreSpringDistance=3000.0000000
    CameraPitchData[0]=(ZHeight=780.0000000,Pitch=-5500.0000000)
    CameraPitchData[1]=(ZHeight=2100.0000000,Pitch=-11000.0000000)
    bAutoZoomEnabled=true
    OverviewCameraInfluenceDist=1000000.0000000
    ObstacleTransparentExtent=(X=200.0000000,Y=200.0000000,Z=200.0000000)
    fMinAutoZoomFOVAngle=35.0000000
    fMaxAutoZoomFOVAngle=50.0000000
    fMaxAutoZoomDistance=900.0000000
    fAutoZoomDetectionRadius=1400.0000000
    fAutoZoomInSpeed=5.0000000
    fAutoZoomOutSpeed=15.0000000
    fAutoZoomInLockOutTime=2.0000000
    fAutoZoomOutLockOutTime=2.0000000
}