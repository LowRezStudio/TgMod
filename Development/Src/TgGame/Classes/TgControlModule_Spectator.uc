class TgControlModule_Spectator extends TgControlModule
    config(Game);

var () config float RotationLimit;
var () const config float SpectatorStallZ;
var () const config float SpectatorMinStallZ;

singular simulated function Rotator GetBaseAimRotation(Weapon W, optional bool bIgnoreAutoLock) { }

function ProcessMove(float DeltaTime, Vector newAccel, Actor.EDoubleClickDir DoubleClickMove, Rotator DeltaRot) { }

function PlayerMove(float DeltaTime) { }

function UpdateRotation(float DeltaTime) { }

function Pawn GetPawnAtCursor() { }

function GetActorListAtCursor(out array<Actor> ActorList) { }

function bool InterceptFlashInput(name ButtonName, Object.EInputEvent Event) { }

function OnRightMousePressed() { }

function OnRightMouseReleased() { }

function OnLeftMousePressed() { }

defaultproperties
{
    RotationLimit=65536.0000000
    SpectatorStallZ=99999.0000000
    SpectatorMinStallZ=-99999.0000000
}
