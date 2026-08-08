class TgSeqAct_GetBot extends SequenceAction
    forcescriptorder(true)
    hidecategories(Object)
    config(Engine);

var int m_nBotNumber;

defaultproperties
{
    VariableLinks[0]=(ExpectedType=Class'SeqVar_Object',LinkedVariables=none,LinkDesc="Factory",LinkVar="None",PropertyName="Targets",bWriteable=false,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    VariableLinks[1]=(ExpectedType=Class'SeqVar_Int',LinkedVariables=none,LinkDesc="Bot Number",LinkVar="None",PropertyName="m_nBotNumber",bWriteable=false,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    VariableLinks[2]=(ExpectedType=Class'SeqVar_Object',LinkedVariables=none,LinkDesc="Bot Pawn",LinkVar="None",PropertyName="None",bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    ObjName="GetBot"
}
