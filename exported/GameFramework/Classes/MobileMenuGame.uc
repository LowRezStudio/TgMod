class MobileMenuGame extends GameInfo
    config(Game)
    hidecategories(Navigation,Movement,Collision);

var Class<MobileMenuScene> InitialSceneToDisplayClass;

event PostLogin(PlayerController NewPlayer)
{
    local MobilePlayerInput MI;

    super.PostLogin(NewPlayer);
    // End:0x91
    if(InitialSceneToDisplayClass != none)
    {
        MI = MobilePlayerInput(NewPlayer.PlayerInput);
        // End:0x8E
        if(MI != none)
        {
            MI.OpenMenuScene(InitialSceneToDisplayClass);            
        }        
    }
    //return;    
}

function StartMatch()
{
    //return;    
}

function RestartPlayer(Controller NewPlayer)
{
    //return;    
}

defaultproperties
{
    HUDType=Class'GameFramework.MobileHUD'
    PlayerControllerClass=Class'GameFramework.MobileMenuPlayerController'
}