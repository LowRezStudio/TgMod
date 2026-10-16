class TgSeqAct_SetPlayerMeshVisible extends SequenceAction
    native(Kismet)
    forcescriptorder(true)
    hidecategories(Object);

var() bool bIs1PMeshVisible;
var() bool bIs3PMeshVisible;

function Activated()
{
    local TgPlayerController TgPC;

    // End:0x6D
    foreach GetWorldInfo().AllControllers(Class'TgGame.TgPlayerController', TgPC)
    {
        TgPC.HideMeshes(!bIs1PMeshVisible, !bIs3PMeshVisible);        
    }    
    //return;    
}

defaultproperties
{
    bIs1PMeshVisible=true
    bIs3PMeshVisible=true
    ObjName="Set Player Meshes Enabled/Disabled"
}