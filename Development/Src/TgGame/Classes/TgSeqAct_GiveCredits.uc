class TgSeqAct_GiveCredits extends SequenceAction
    native(Kismet)
    forcescriptorder(true)
    hidecategories(Object)
    config(Engine);

var () int CreditsToGive;

function Activated() { }

defaultproperties
{
    VariableLinks[0]=(ExpectedType=Class'SeqVar_Int',LinkedVariables=none,LinkDesc="Credits to Give",LinkVar="None",PropertyName="CreditsToGive",bWriteable=false,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    ObjName="Give Credits"
}
