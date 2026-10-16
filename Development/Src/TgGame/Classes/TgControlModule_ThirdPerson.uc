class TgControlModule_ThirdPerson extends TgControlModule
    config(Engine);

var int CameraYawOffset;
var float fRotInterpSpeed;
var Vector2D vDazedRotError;
var float fAimPitch;
var InterpCurveFloat PitchCurve;
var InterpCurveFloat AimCurve;
var CameraAnim m_StrafeCameraAnim;

function Init() { }

function OnSettingsChanged(TgClientSettings Settings) { }

function UpdatePitchCurve() { }

function OnBecomeActive(TgControlModule OldModule) { }

singular simulated function Rotator GetBaseAimRotation(Weapon W, optional bool bIgnoreAutoLock) { }

function ProcessMove(float DeltaTime, Vector newAccel, Actor.EDoubleClickDir DoubleClickMove, Rotator DeltaRot) { }

function PlayerMove(float DeltaTime) { }

function Vector CalcNewAccel() { }

function bool IsPlayingForcedViewCameraAnim() { }

function UpdateRotation(float DeltaTime) { }

function UpdateAimPitch() { }

function bool IsInputLocked() { }

function bool IsRotationLocked() { }

function bool IsCameraLocked() { }

function bool IsYawLocked() { }

function bool IsFixedPitchMode() { }

function AdjustAimingView(out Vector ViewLocation, out Rotator ViewRotation) { }

defaultproperties
{
    fRotInterpSpeed=16.0000000
}
