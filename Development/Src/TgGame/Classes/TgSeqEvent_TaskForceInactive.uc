class TgSeqEvent_TaskForceInactive extends SequenceEvent
    native(Kismet)
    forcescriptorder(true)
    hidecategories(Object)
    config(Engine);

defaultproperties
{
    bPlayerOnly=false
    VariableLinks[0]=(ExpectedType=Class'SeqVar_Int',LinkedVariables=none,LinkDesc="Inactive Task Force",LinkVar="None",PropertyName="None",bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    ObjName="Task Force Inactive"
}
