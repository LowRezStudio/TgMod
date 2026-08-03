class SeqAct_CastToInt extends SeqAct_SetSequenceVariable
    native(Sequence)
    hidecategories(Object);

var() bool bTruncate;
var float Value;
var int IntResult;

defaultproperties
{
    VariableLinks[0]=(ExpectedType=Class'Engine.SeqVar_Float',LinkedVariables=none,LinkDesc="Int",LinkVar="None",PropertyName="Value",bWriteable=false,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    VariableLinks[1]=(ExpectedType=Class'Engine.SeqVar_Int',LinkedVariables=none,LinkDesc="Result",LinkVar="None",PropertyName="IntResult",bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    ObjName="Cast To Int"
}