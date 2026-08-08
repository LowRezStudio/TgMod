class TgSeqAct_UIAlert extends SequenceAction
    native(Kismet)
    forcescriptorder(true)
    hidecategories(Object)
    config(Engine);

var () int nMsgId;
var array<int> Taskforces;
var array<bool> Broadcast;

defaultproperties
{
    VariableLinks[0]=(ExpectedType=Class'SeqVar_Object',LinkedVariables=none,LinkDesc="Players",LinkVar="None",PropertyName="Targets",bWriteable=false,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    VariableLinks[1]=(ExpectedType=Class'SeqVar_Int',LinkedVariables=none,LinkDesc="Taskforces",LinkVar="None",PropertyName="Taskforces",bWriteable=false,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    VariableLinks[2]=(ExpectedType=Class'SeqVar_Object',LinkedVariables=none,LinkDesc="Broadcast",LinkVar="None",PropertyName="Broadcast",bWriteable=false,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    ObjName="UI Alert"
}
