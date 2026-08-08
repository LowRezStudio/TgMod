class TgSeqAct_SetTaskforce extends SequenceAction
    forcescriptorder(true)
    hidecategories(Object)
    config(Engine);

var () int TaskForceNumber;

defaultproperties
{
    VariableLinks[0]=(ExpectedType=Class'SeqVar_Object',LinkedVariables=none,LinkDesc="Bots/Factory",LinkVar="None",PropertyName="Targets",bWriteable=false,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    VariableLinks[1]=(ExpectedType=Class'SeqVar_Int',LinkedVariables=none,LinkDesc="TaskForceNumber",LinkVar="None",PropertyName="TaskForceNumber",bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    ObjName="Set Taskforce"
}
