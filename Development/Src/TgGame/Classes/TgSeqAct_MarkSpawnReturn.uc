class TgSeqAct_MarkSpawnReturn extends SequenceAction
    forcescriptorder(true)
    hidecategories(Object)
    config(Engine);

var () Teleporter m_Teleporter;

event Activated() { }

defaultproperties
{
    VariableLinks[0]=(ExpectedType=Class'SeqVar_Object',LinkedVariables=none,LinkDesc="Player",LinkVar="None",PropertyName="Targets",bWriteable=false,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    ObjName="Mark Spawn Return"
}
