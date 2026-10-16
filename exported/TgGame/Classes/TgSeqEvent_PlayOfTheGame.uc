class TgSeqEvent_PlayOfTheGame extends SequenceEvent
    native
    forcescriptorder(true)
    hidecategories(Object);

event UpdateLinkedVars(int MapLane)
{
    local SeqVar_Int IntVar;

    // End:0x52
    foreach LinkedVariables(Class'Engine.SeqVar_Int', IntVar, "Map Lane")
    {
        IntVar.IntValue = MapLane;        
    }    
    //return;    
}

defaultproperties
{
    bPlayerOnly=false
    VariableLinks[0]=(ExpectedType=Class'Engine.SeqVar_Object',LinkedVariables=none,LinkDesc="Instigator",LinkVar="None",PropertyName="None",bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    VariableLinks[1]=(ExpectedType=Class'Engine.SeqVar_Int',LinkedVariables=none,LinkDesc="Map Lane",LinkVar="None",PropertyName="None",bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    ObjName="Play of the Game"
}