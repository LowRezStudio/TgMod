class GFxAction_SetVariable extends SequenceAction
    native(UISequence)
    forcescriptorder(true)
    hidecategories(Object);

var GFxMoviePlayer Movie;
var() string Variable;

event bool IsValidLevelSequenceObject()
{
    return true;
    //return ReturnValue;    
}

defaultproperties
{
    VariableLinks[0]=(ExpectedType=Class'Engine.SequenceVariable',LinkedVariables=none,LinkDesc="Value",LinkVar="None",PropertyName="None",bWriteable=false,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    VariableLinks[1]=(ExpectedType=Class'Engine.SeqVar_Object',LinkedVariables=none,LinkDesc="Movie Player",LinkVar="None",PropertyName="None",bWriteable=false,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    ObjName="GFx SetVariable"
}