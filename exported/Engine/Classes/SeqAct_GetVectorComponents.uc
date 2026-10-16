class SeqAct_GetVectorComponents extends SequenceAction
    native(Sequence)
    hidecategories(Object);

var Vector InVector;
var float X;
var float Y;
var float Z;

defaultproperties
{
    VariableLinks[0]=(ExpectedType=Class'Engine.SeqVar_Vector',LinkedVariables=none,LinkDesc="Input Vector",LinkVar="None",PropertyName="InVector",bWriteable=false,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    VariableLinks[1]=(ExpectedType=Class'Engine.SeqVar_Float',LinkedVariables=none,LinkDesc="X",LinkVar="None",PropertyName="X",bWriteable=false,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    VariableLinks[2]=(ExpectedType=Class'Engine.SeqVar_Float',LinkedVariables=none,LinkDesc="Y",LinkVar="None",PropertyName="Y",bWriteable=false,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    VariableLinks[3]=(ExpectedType=Class'Engine.SeqVar_Float',LinkedVariables=none,LinkDesc="Z",LinkVar="None",PropertyName="Z",bWriteable=false,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    ObjName="Get Vector Components"
}