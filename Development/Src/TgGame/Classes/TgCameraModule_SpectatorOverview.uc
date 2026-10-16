class TgCameraModule_SpectatorOverview extends TgCameraModule_Spectator
    native(View)
    config(Game);

struct CameraPitchInfo {
    var float ZHeight;
    var float Pitch;
    structdefaultproperties {}
};

var () Rotator WorldViewRotation;
var () config float FOV;
var float TargetZoomedFOV;
var () config float ZoomIncrement;
var () config float MinZoom;
var () config float MaxZoom;
var () config float ZoomInterpTime;
var Vector CurrentSpringLocation;
var () config float PawnTargetSpringDamping;
var () config float FreeCamSpringDamping;
var () config float IgnoreSpringDistance;
var () array<CameraPitchInfo> CameraPitchData;
var () bool bFlippedSides;
var bool bJustBecameActive;
var () config bool bAutoZoomEnabled;
var () float OverviewCameraInfluenceDist;
var array<TgOverviewCameraActor> OverviewCameras;
var array<TgPawn_TowerBase> TransparentTowerList;
var () Vector ObstacleTransparentExtent;
var () config float fMinAutoZoomFOVAngle;
var () config float fMaxAutoZoomFOVAngle;
var () config float fMinAutoZoomDistance;
var () config float fMaxAutoZoomDistance;
var () config float fAutoZoomDetectionRadius;
var () config float fAutoZoomInSpeed;
var () config float fAutoZoomOutSpeed;
var () config float fAutoZoomInLockOutTime;
var () config float fAutoZoomOutLockOutTime;
var transient float m_RemainingAutoZoomInLockOutTime;
var transient float m_RemainingAutoZoomOutLockOutTime;

native function Rotator GetWorldViewRotation();  // Export UTgCameraModule_SpectatorOverview::execGetWorldViewRotation(FFrame&, void* const)

native function bool UpdateAutoZoom(float DeltaTime);  // Export UTgCameraModule_SpectatorOverview::execUpdateAutoZoom(FFrame&, void* const)

native function CheckObstacleTransparency();  // Export UTgCameraModule_SpectatorOverview::execCheckObstacleTransparency(FFrame&, void* const)

native function ClearObstacleTransparency();  // Export UTgCameraModule_SpectatorOverview::execClearObstacleTransparency(FFrame&, void* const)

function OnBecomeActive(TgCameraModule OldCamera) { }

function OnBecomeInActive(TgCameraModule NewCamera) { }

function BlendCameraToLocation(Vector NewLocation, float BlendTime, bool bUseFocalPoint) { }

function OverridePawnTargetLocation(TgPawn TgP, out Vector TargetLocation) { }

function UpdateCamera(Pawn P, TgPlayerCamera CameraActor, float DeltaTime, out TViewTarget OutVT) { }

function zoomIn() { }

function ZoomOut() { }

function float GetFOVAngle() { }

function FlipSides() { }

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
