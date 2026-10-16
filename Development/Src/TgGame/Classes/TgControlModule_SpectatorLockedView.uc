class TgControlModule_SpectatorLockedView extends TgControlModule_Spectator
    config(Input);

var const config float DirectorModeSpectatorStallZ;
var const config float DirectorModeSpectatorMinStallZ;

function float GetMaxStallZ() { }

function float GetMinStallZ() { }

function PlayerMove(float DeltaTime) { }
