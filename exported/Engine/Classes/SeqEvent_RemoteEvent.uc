class SeqEvent_RemoteEvent extends SequenceEvent
    native(Sequence)
    hidecategories(Object);

var() name EventName;
var transient bool bStatusIsOk;

static event int GetObjClassVersion()
{
    return super(SequenceObject).GetObjClassVersion() + 1;
    //return ReturnValue;    
}

defaultproperties
{
    EventName="DefaultEvent"
    MaxTriggerCount=0
    bPlayerOnly=false
    ObjName="Remote Event"
}