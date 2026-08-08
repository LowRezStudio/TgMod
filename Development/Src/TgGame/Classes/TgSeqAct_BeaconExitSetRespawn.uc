class TgSeqAct_BeaconExitSetRespawn extends SequenceAction
    forcescriptorder(true)
    hidecategories(Object)
    config(Engine);

var Actor m_RespawnPoint;
var bool m_bRespawnImmediately;

defaultproperties
{
    VariableLinks[0]=(ExpectedType=Class'SeqVar_Object',LinkedVariables=none,LinkDesc="BeaconExit",LinkVar="None",PropertyName="Targets",bWriteable=false,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    VariableLinks[1]=(ExpectedType=Class'SeqVar_Object',LinkedVariables=none,LinkDesc="RespawnPoint",LinkVar="None",PropertyName="m_RespawnPoint",bWriteable=false,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    VariableLinks[2]=(ExpectedType=Class'SeqVar_Bool',LinkedVariables=none,LinkDesc="RespawnImmediately",LinkVar="None",PropertyName="m_bRespawnImmediately",bWriteable=false,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    ObjName="BeaconExitSetRespawn"
}
