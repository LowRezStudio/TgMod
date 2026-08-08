class TgSeqEvent_ControlPointOwnershipChange extends SequenceEvent
    forcescriptorder(true)
    hidecategories(Object)
    config(Engine);

var () int PointIndex;

defaultproperties
{
    MaxTriggerCount=0
    bPlayerOnly=false
    bClientSideOnly=true
    OutputLinks[0]=(Links=none,LinkDesc="Neutral",bHasImpulse=false,bDisabled=false,bDisabledPIE=false,LinkedOp=none,ActivateDelay=0.0000000,DrawY=0,bHidden=false,bMoving=false,bClampedMax=false,bClampedMin=false,bIsActivated=false)
    OutputLinks[1]=(Links=none,LinkDesc="Friendly",bHasImpulse=false,bDisabled=false,bDisabledPIE=false,LinkedOp=none,ActivateDelay=0.0000000,DrawY=0,bHidden=false,bMoving=false,bClampedMax=false,bClampedMin=false,bIsActivated=false)
    OutputLinks[2]=(Links=none,LinkDesc="Enemy",bHasImpulse=false,bDisabled=false,bDisabledPIE=false,LinkedOp=none,ActivateDelay=0.0000000,DrawY=0,bHidden=false,bMoving=false,bClampedMax=false,bClampedMin=false,bIsActivated=false)
    ObjName="Control Point Ownership Change"
}
