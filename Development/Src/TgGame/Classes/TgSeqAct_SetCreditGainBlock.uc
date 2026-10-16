class TgSeqAct_SetCreditGainBlock extends SequenceAction
    native(Kismet)
    forcescriptorder(true)
    hidecategories(Object)
    config(Engine);

var int m_bBlockCreditGain;

defaultproperties
{
    VariableLinks[0]=(ExpectedType=Class'SeqVar_Bool',LinkedVariables=none,LinkDesc="Block Credit Gain",LinkVar="None",PropertyName="m_bBlockCreditGain",bWriteable=false,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    ObjName="Block Credit Gain"
}
