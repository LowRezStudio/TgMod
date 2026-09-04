class TgSeqAct_FillUltimateEnergy extends SequenceAction
    native(Kismet)
    forcescriptorder(true)
    hidecategories(Object);

function Activated()
{
    local TgPawn Pawn;
    local TgPlayerController TgPC;

    // End:0xB7
    foreach GetWorldInfo().AllControllers(Class'TgGame.TgPlayerController', TgPC)
    {
        Pawn = TgPawn(TgPC.Pawn);
        // End:0xB6
        if(Pawn != none)
        {
            Pawn.SetPropCurrentValue(2, Pawn.GetPropCurrentValue(1));
        }        
    }    
    //return;    
}

defaultproperties
{
    ObjName="Fill Ultimate Energy"
}