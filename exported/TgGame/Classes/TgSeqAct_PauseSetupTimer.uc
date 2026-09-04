class TgSeqAct_PauseSetupTimer extends SequenceAction
    forcescriptorder(true)
    hidecategories(Object);

var(PauseSetupTimer) bool PauseImmediately;
var(PauseSetupTimer) float PauseAtTimeRemaining;

function Activated()
{
    local TgGame_Paladins_Tutorial TgG;

    TgG = TgGame_Paladins_Tutorial(GetWorldInfo().Game);
    // End:0xBE
    if((TgG != none) && !TgG.m_bSetupTimerPaused)
    {
        // End:0x96
        if(PauseImmediately)
        {
            TgG.PauseSetupTimer();            
        }
        else
        {
            TgG.PauseSetupTimerAt(PauseAtTimeRemaining);
        }
    }
    //return;    
}

defaultproperties
{
    VariableLinks[0]=(ExpectedType=Class'Engine.SeqVar_Bool',LinkedVariables=none,LinkDesc="Pause Immediately",LinkVar="None",PropertyName="PauseImmediately",bWriteable=false,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    VariableLinks[1]=(ExpectedType=Class'Engine.SeqVar_Float',LinkedVariables=none,LinkDesc="Pause At Time Remaining",LinkVar="None",PropertyName="PauseAtTimeRemaining",bWriteable=false,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    ObjName="Pause Setup Timer"
}