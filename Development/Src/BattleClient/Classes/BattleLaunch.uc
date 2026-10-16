class BattleLaunch extends TgGameLaunch
    native
    config(Game)
    hidecategories(Navigation,Movement,Collision);

defaultproperties
{
    HUDType=Class'BattleHUD'
    PlayerControllerClass=Class'BattlePlayerController'
}
