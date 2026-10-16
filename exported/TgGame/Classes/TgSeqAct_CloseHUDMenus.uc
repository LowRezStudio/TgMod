class TgSeqAct_CloseHUDMenus extends SequenceAction
    native(Kismet)
    forcescriptorder(true)
    hidecategories(Object);

function Activated()
{
    local TgPlayerController TgPC;

    // End:0x7A
    foreach GetWorldInfo().AllControllers(Class'TgGame.TgPlayerController', TgPC)
    {
        // End:0x79
        if(TgPC.IsLocalPlayerController())
        {
            TgPC.CloseHUDMenus();
            // End:0x7A
            break;
        }        
    }    
    //return;    
}

defaultproperties
{
    ObjName="Close HUD Menus"
}