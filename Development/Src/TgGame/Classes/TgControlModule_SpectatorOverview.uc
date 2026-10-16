class TgControlModule_SpectatorOverview extends TgControlModule_Spectator
    config(Game);

var () const config float DirectorModeSpectatorStallZ;
var () const config float DirectorModeSpectatorMinStallZ;

function float GetMaxStallZ() { }

function float GetMinStallZ() { }

function ProcessMove(float DeltaTime, Vector newAccel, Actor.EDoubleClickDir DoubleClickMove, Rotator DeltaRot) { }

function PlayerMove(float DeltaTime) { }

function UpdateRotation(float DeltaTime) { }

function OnLeftMousePressed() { }

defaultproperties
{
    DirectorModeSpectatorStallZ=2000.0000000
    DirectorModeSpectatorMinStallZ=750.0000000
    SpectatorStallZ=2000.0000000
    SpectatorMinStallZ=750.0000000
}
