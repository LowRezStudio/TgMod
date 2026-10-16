class TgSeqEvent_BotDied extends SequenceEvent
    native
    forcescriptorder(true)
    hidecategories(Object);

event UpdateLinkedVars(Actor Killer)
{
    local SeqVar_Object ObjVar;

    // End:0x50
    foreach LinkedVariables(Class'Engine.SeqVar_Object', ObjVar, "Killer")
    {
        ObjVar.SetObjectValue(Killer);        
    }    
    //return;    
}

defaultproperties
{
    MaxTriggerCount=0
    VariableLinks[0]=(ExpectedType=Class'Engine.SeqVar_Object',LinkedVariables=none,LinkDesc="Instigator",LinkVar="None",PropertyName="None",bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    VariableLinks[1]=(ExpectedType=Class'Engine.SeqVar_Object',LinkedVariables=none,LinkDesc="Killer",LinkVar="None",PropertyName="None",bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    ObjName="TgSeqEvent_BotDied"
}