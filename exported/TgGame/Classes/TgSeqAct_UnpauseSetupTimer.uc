class TgSeqAct_UnpauseSetupTimer extends SequenceAction
    forcescriptorder(true)
    hidecategories(Object);

function Activated()
{
    local TgGame_Paladins_Tutorial TgG;

    TgG = TgGame_Paladins_Tutorial(GetWorldInfo().Game);
    // End:0x84
    if((TgG != none) && TgG.m_bSetupTimerPaused)
    {
        TgG.UnpauseSetupTimer();
    }
    //return;    
}

defaultproperties
{
    VariableLinks=none
    ObjName="Unpause Setup Timer"
}