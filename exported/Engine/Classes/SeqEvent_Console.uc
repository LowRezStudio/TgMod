class SeqEvent_Console extends SequenceEvent
    native(Sequence)
    hidecategories(Object);

var() name ConsoleEventName;
var() string EventDesc;

defaultproperties
{
    ConsoleEventName="Default"
    EventDesc="No description"
    MaxTriggerCount=0
    ObjName="Console Event"
}