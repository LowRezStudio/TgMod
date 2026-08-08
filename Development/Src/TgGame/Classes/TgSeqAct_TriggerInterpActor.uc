class TgSeqAct_TriggerInterpActor extends SequenceAction
    forcescriptorder(true)
    hidecategories(Object)
    config(Engine);

var string m_sStateName;

defaultproperties
{
    VariableLinks[0]=(ExpectedType=Class'SeqVar_Object',LinkedVariables=none,LinkDesc="InterpActor",LinkVar="None",PropertyName="Targets",bWriteable=false,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=0,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    VariableLinks[1]=(ExpectedType=Class'SeqVar_String',LinkedVariables=none,LinkDesc="State",LinkVar="None",PropertyName="m_sStateName",bWriteable=false,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=0,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    ObjName="Trigger InterpActor"
}
