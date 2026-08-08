class TgSeqAct_PauseSetupTimer extends SequenceAction
    forcescriptorder(true)
    hidecategories(Object)
    config(Engine);

var (PauseSetupTimer) bool PauseImmediately;
var (PauseSetupTimer) float PauseAtTimeRemaining;

function Activated() { }

defaultproperties
{
    VariableLinks[0]=(ExpectedType=Class'SeqVar_Bool',LinkedVariables=none,LinkDesc="Pause Immediately",LinkVar="None",PropertyName="PauseImmediately",bWriteable=false,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    VariableLinks[1]=(ExpectedType=Class'SeqVar_Float',LinkedVariables=none,LinkDesc="Pause At Time Remaining",LinkVar="None",PropertyName="PauseAtTimeRemaining",bWriteable=false,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    ObjName="Pause Setup Timer"
}
