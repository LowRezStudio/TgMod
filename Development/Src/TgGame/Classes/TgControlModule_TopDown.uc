class TgControlModule_TopDown extends TgControlModule_Spectator
    config(Game);

var const config float DefaultStartHeight;

function ProcessMove(float DeltaTime, Vector newAccel, Actor.EDoubleClickDir DoubleClickMove, Rotator DeltaRot) { }

function PlayerMove(float DeltaTime) { }

defaultproperties
{
    DefaultStartHeight=700.0000000
    SpectatorStallZ=850.0000000
    SpectatorMinStallZ=350.0000000
}
