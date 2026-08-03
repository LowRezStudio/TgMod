class GFxAction_CloseMovie extends SequenceAction
    native(UISequence)
    forcescriptorder(true)
    hidecategories(Object);

var GFxMoviePlayer Movie;
var() bool bUnload;

event bool IsValidLevelSequenceObject()
{
    return true;
    //return ReturnValue;    
}

defaultproperties
{
    bUnload=true
    VariableLinks[0]=(ExpectedType=Class'Engine.SeqVar_Object',LinkedVariables=none,LinkDesc="Movie Player",LinkVar="None",PropertyName="None",bWriteable=false,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    ObjName="Close GFx Movie"
}