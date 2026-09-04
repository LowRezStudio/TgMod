class TgSeqEvent_PlayerMoved extends SequenceEvent
    native(Kismet)
    forcescriptorder(true)
    hidecategories(Object);

enum EPlayerCardinalDirection
{
    PCD_Forward,                    // 0
    PCD_Backward,                   // 1
    PCD_Left,                       // 2
    PCD_Right,                      // 3
    PCD_MAX                         // 4
};

var int ResultEnergy;

static event int GetIndex(TgSeqEvent_PlayerMoved.EPlayerCardinalDirection MovementDirection)
{
    return int(MovementDirection);
    //return ReturnValue;    
}

defaultproperties
{
    MaxTriggerCount=0
    OutputLinks[0]=(Links=none,LinkDesc="Forward",bHasImpulse=false,bDisabled=false,bDisabledPIE=false,LinkedOp=none,ActivateDelay=0.0000000,DrawY=0,bHidden=false,bMoving=false,bClampedMax=false,bClampedMin=false,bIsActivated=false)
    OutputLinks[1]=(Links=none,LinkDesc="Backward",bHasImpulse=false,bDisabled=false,bDisabledPIE=false,LinkedOp=none,ActivateDelay=0.0000000,DrawY=0,bHidden=false,bMoving=false,bClampedMax=false,bClampedMin=false,bIsActivated=false)
    OutputLinks[2]=(Links=none,LinkDesc="Left",bHasImpulse=false,bDisabled=false,bDisabledPIE=false,LinkedOp=none,ActivateDelay=0.0000000,DrawY=0,bHidden=false,bMoving=false,bClampedMax=false,bClampedMin=false,bIsActivated=false)
    OutputLinks[3]=(Links=none,LinkDesc="Right",bHasImpulse=false,bDisabled=false,bDisabledPIE=false,LinkedOp=none,ActivateDelay=0.0000000,DrawY=0,bHidden=false,bMoving=false,bClampedMax=false,bClampedMin=false,bIsActivated=false)
    ObjName="Player Moving"
}