class TgCameraModule_ThirdPerson extends TgCameraModule
    native(View)
    config(Engine);

struct ServerCorrectionSmoothingParams {
    var float fServerCorrectSnapDist;
    var float fMinBaseSpeed;
    var float fMaxBaseSpeed;
    var float fBaseSpeedMultiplier;
    var float fNewInfoWeight;
    var float fMinCorrectionModifier;
    var float fMaxCorrectionModifier;
    var float fCorrectionModifierMultiplier;
    structdefaultproperties {}
};

var Vector CameraOffset;
var float fZoomFactorInterp;
var float fZoomFactor;
var float fZoomStep;
var float fZoomMax;
var float fMountZoomMax;
var float fZoomMin;
var Vector2D fZoom3pPercentFromTo;
var float fZoomDuration;
var float fZoomDurationOverride;
var transient float fZoomUsedTime;
var Vector vCachedCameraAttachPoint;
var float f3pViewPaddingRemainingTime;
var float f3pViewPaddingTime;
var bool bForce3PView;
var Vector vServerCorrectionDelta;
var Vector vAvgServerCorrectionDelta;
var Vector vLastDesiredLocation;
var ServerCorrectionSmoothingParams CorrectionSmoothing;

function OnBecomeActive(TgCameraModule OldCamera) { }

function OnTweenOutEnd() { }

function Vector GetCamLocationOffset(Rotator PawnRot, Actor ViewTarget) { }

function Vector GetCamAttachPoint(Actor ViewTarget) { }

function Rotator GetWorldRotation(TgPlayerCamera CameraActor) { }

function float GetCurrent3pPercent() { }

function float GetZoomDuration() { }

function UpdateCameraZoom(TgPawn TgP, float DeltaTime) { }

function UpdateCamera(Pawn P, TgPlayerCamera CameraActor, float DeltaTime, out TViewTarget OutVT) { }

simulated function Vector SmoothServerCorrection(TgPawn TgP, Vector DesiredLocation, float DeltaTime) { }

simulated function UpdateServerCorrectionFromMovement(Vector DesiredLocation) { }

simulated function UpdateAverageServerCorrection(float DeltaTime) { }

simulated function BecomeViewTarget(TgPlayerController PC) { }

function zoomIn() { }

function ZoomOut() { }

defaultproperties
{
    CameraOffset=(X=-142.0000000,Y=0.0000000,Z=25.0000000)
    fZoomFactor=1.0000000
    fZoomStep=0.1000000
    fZoomMax=1.0000000
    fMountZoomMax=1.0000000
    fZoomMin=0.7500000
    fZoomDuration=0.2000000
    f3pViewPaddingTime=0.0100000
    CorrectionSmoothing=(fServerCorrectSnapDist=640.0000000,fMinBaseSpeed=16.0000000,fMaxBaseSpeed=320.0000000,fBaseSpeedMultiplier=0.0008000,fNewInfoWeight=1.0000000,fMinCorrectionModifier=0.5000000,fMaxCorrectionModifier=12.0000000,fCorrectionModifierMultiplier=0.0050000)
}
