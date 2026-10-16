class SeqEvent_SequenceActivated extends SequenceEvent
    native(Sequence)
    hidecategories(Object);

var() string InputLabel;

defaultproperties
{
    InputLabel="In"
    MaxTriggerCount=0
    bPlayerOnly=false
    ObjName="Sequence Activated"
}