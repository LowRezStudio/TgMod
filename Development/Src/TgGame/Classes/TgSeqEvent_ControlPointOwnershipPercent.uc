class TgSeqEvent_ControlPointOwnershipPercent extends SequenceEvent
    forcescriptorder(true)
    hidecategories(Object)
    config(Engine);

var () float OwnershipPercent;
var () int PointIndex;

defaultproperties
{
    MaxTriggerCount=0
    bPlayerOnly=false
    bClientSideOnly=true
    ObjName="Control Point Ownership Percent"
}
