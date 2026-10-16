class TgSeqEvent_PlayerInitialized extends SequenceEvent
    native
    forcescriptorder(true)
    hidecategories(Object)
    config(Engine);

var () bool bLocalPlayerOnly;

defaultproperties
{
    bClientSideOnly=true
    ObjName="Player Initialized"
}
