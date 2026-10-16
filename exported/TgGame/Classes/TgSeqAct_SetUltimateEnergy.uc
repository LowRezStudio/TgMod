class TgSeqAct_SetUltimateEnergy extends SequenceAction
    forcescriptorder(true)
    hidecategories(Object);

var() float fChargePercent;

function Activated()
{
    local TgPawn Pawn;
    local TgPlayerController TgPC;

    // End:0xC2
    foreach GetWorldInfo().AllControllers(Class'TgGame.TgPlayerController', TgPC)
    {
        Pawn = TgPawn(TgPC.Pawn);
        // End:0xC1
        if(Pawn != none)
        {
            Pawn.SetPropCurrentValue(2, Pawn.GetPropCurrentValue(1) * fChargePercent);
        }        
    }    
    //return;    
}

defaultproperties
{
    VariableLinks[0]=(ExpectedType=Class'Engine.SeqVar_Float',LinkedVariables=none,LinkDesc="Ultimate Charge %",LinkVar="None",PropertyName="fChargePercent",bWriteable=false,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    ObjName="Set Ultimate Energy"
}