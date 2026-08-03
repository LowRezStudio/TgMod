class BattleLaunch extends TgGameLaunch
    native
    config(Game)
    hidecategories(Navigation,Movement,Collision);

defaultproperties
{
    HUDType=Class'BattleClient.BattleHUD'
    PlayerControllerClass=Class'BattleGame.BattlePlayerController'
}