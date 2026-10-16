class TgSeqEvent_Named extends SequenceEvent
    native(Kismet)
    forcescriptorder(true)
    hidecategories(Object)
    config(Engine);

enum TSE_NAME {
    TSE_NONE,  // 0
    TSE_MENU_CLOSE,  // 1
    TSE_MOVIE_DONE,  // 2
};

var () TgSeqEvent_Named.TSE_NAME NamedEvent;

defaultproperties
{
    bPlayerOnly=false
    OutputLinks[0]=(Links=none,LinkDesc="Off/Close",bHasImpulse=false,bDisabled=false,bDisabledPIE=false,LinkedOp=none,ActivateDelay=0.0000000,DrawY=0,bHidden=false,bMoving=false,bClampedMax=false,bClampedMin=false,bIsActivated=false)
    OutputLinks[1]=(Links=none,LinkDesc="On/Open",bHasImpulse=false,bDisabled=false,bDisabledPIE=false,LinkedOp=none,ActivateDelay=0.0000000,DrawY=0,bHidden=false,bMoving=false,bClampedMax=false,bClampedMin=false,bIsActivated=false)
    ObjName="Named TgSeqEvent"
}
