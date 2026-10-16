class GFxEvent_FSCommand extends SequenceEvent
    native(UISequence)
    forcescriptorder(true)
    hidecategories(Object)
    config(Engine);

var () SwfMovie Movie;
var () string FSCommand;
var GFxFSCmdHandler_Kismet Handler;

defaultproperties
{
    MaxTriggerCount=0
    bPlayerOnly=false
    VariableLinks[0]=(ExpectedType=Class'SeqVar_String',LinkedVariables=none,LinkDesc="Argument",LinkVar="None",PropertyName="None",bWriteable=false,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    ObjName="FsCommand"
}
