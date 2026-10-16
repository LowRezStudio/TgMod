class SeqAct_SetMatInstScalarParam extends SequenceAction
    native(Sequence)
    hidecategories(Object);

var() MaterialInstanceConstant MatInst;
var() name ParamName;
var() float ScalarValue;

defaultproperties
{
    VariableLinks[0]=(ExpectedType=Class'Engine.SeqVar_Float',LinkedVariables=none,LinkDesc="ScalarValue",LinkVar="None",PropertyName="ScalarValue",bWriteable=false,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    ObjName="Set ScalarParam"
}