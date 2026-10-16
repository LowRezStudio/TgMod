class TgGameLaunch extends GameInfo
    native
    config(Game)
    hidecategories(Navigation,Movement,Collision);

var globalconfig string LoginName;
var globalconfig string LoginPwd;
var globalconfig bool SaveLoginName;

defaultproperties
{
    DefaultPawnClass=Class'Engine.Pawn'
    HUDType=Class'TgClient.TgLobbyHUD'
    PlayerControllerClass=Class'TgGame.TgPlayerController'
}