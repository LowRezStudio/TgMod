class TgSeqAct_ShowGameTip extends SequenceAction
    forcescriptorder(true)
    hidecategories(Object);

var() int GameTipId;
var TgPlayerController TargetPlayer;

function Activated()
{
    local TgPlayerController TgPC;

    // End:0x3A
    if(TargetPlayer != none)
    {
        TargetPlayer.ClientRequestHelpText(GameTipId);        
    }
    else
    {
        // End:0x98
        foreach GetWorldInfo().AllControllers(Class'TgGame.TgPlayerController', TgPC)
        {
            TgPC.ClientRequestHelpText(GameTipId);            
        }        
    }
    //return;    
}

defaultproperties
{
    VariableLinks[0]=(ExpectedType=Class'Engine.SeqVar_Int',LinkedVariables=none,LinkDesc="Game Tip ID",LinkVar="None",PropertyName="GameTipId",bWriteable=false,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    VariableLinks[1]=(ExpectedType=Class'Engine.SeqVar_Object',LinkedVariables=none,LinkDesc="Target Player",LinkVar="None",PropertyName="TargetPlayer",bWriteable=false,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    ObjName="Show Game Tip"
}