class SeqAct_ConcatenateStrings extends SequenceAction
    hidecategories(Object);

var() string StrA;
var() string StrB;
var() bool ConcatenateWithSpace;
var string StrResult;

event Activated()
{
    StrResult = ((ConcatenateWithSpace) ? StrA @ StrB : StrA $ StrB);
    ActivateOutputLink(0);
    //return;    
}

defaultproperties
{
    VariableLinks[0]=(ExpectedType=Class'Engine.SeqVar_String',LinkedVariables=none,LinkDesc="First String",LinkVar="None",PropertyName="StrA",bWriteable=false,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    VariableLinks[1]=(ExpectedType=Class'Engine.SeqVar_String',LinkedVariables=none,LinkDesc="Second String",LinkVar="None",PropertyName="StrB",bWriteable=false,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    VariableLinks[2]=(ExpectedType=Class'Engine.SeqVar_String',LinkedVariables=none,LinkDesc="Result",LinkVar="None",PropertyName="StrResult",bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    ObjName="Concatenate Strings"
}