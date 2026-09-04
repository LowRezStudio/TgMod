class TgControlModule extends Object
    abstract
    config(Engine);

var TgPlayerController Controller;
var bool m_bIsActive;

function Init() { }

function OnBecomeActive(TgControlModule OldModule) { }

function OnBecomeInActive(TgControlModule NewModule) { }

function OnSettingsChanged(TgClientSettings Settings) { }

singular simulated function Rotator GetBaseAimRotation(Weapon W, optional bool bIgnoreAutoLock) { }

function ProcessMove(float DeltaTime, Vector newAccel, Actor.EDoubleClickDir DoubleClickMove, Rotator DeltaRot) { }

function PlayerMove(float DeltaTime) { }

function UpdateRotation(float DeltaTime) { }

function OnRightMousePressed() { }

exec function OnRightMouseReleased() { }

function AdjustAimingView(out Vector ViewLocation, out Rotator ViewRotation) { }

function bool InterceptFlashInput(name ButtonName, Object.EInputEvent Event) { }
