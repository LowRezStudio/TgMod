class TgSeqEvent_Tutorial extends SequenceEvent
    forcescriptorder(true)
    hidecategories(Object);

enum EPaladinsTutorialEvent
{
    PTE_Started,                    // 0
    PTE_HelperSpawned,              // 1
    PTE_MovingToAutoShootingRange,  // 2
    PTE_PlayerReachedAutoShootingRange,// 3
    PTE_WaitingForMovementAbility,  // 4
    PTE_ReceivedMovementAbility,    // 5
    PTE_PlayerReachedUltimateShootingRange,// 6
    PTE_PlayerUltimateComplete,     // 7
    PTE_PlayerReachedLowerJumpArea, // 8
    PTE_PlayerReachedUpperJumpArea, // 9
    PTE_PlayerReachedObjective,     // 10
    PTE_MoveBotToCapturePoint,      // 11
    PTE_MoveBotToPayload,           // 12
    PTE_Complete,                   // 13
    PTE_MAX                         // 14
};

static function bool TriggerGlobal(Actor InInstigator, TgSeqEvent_Tutorial.EPaladinsTutorialEvent TutEvent)
{
    local array<SequenceObject> EventsToActivate;
    local array<int> ActivateIndices;
    local Sequence GameSeq;
    local TgSeqEvent_Tutorial Event;
    local bool bResult;
    local int I;

    ActivateIndices.AddItem(int(TutEvent));
    // End:0x49
    if((InInstigator == none) || ActivateIndices[0] == -1)
    {
        return bResult;
    }
    GameSeq = InInstigator.WorldInfo.GetGameSequence();
    // End:0x17B
    if(GameSeq != none)
    {
        GameSeq.FindSeqObjectsByClass(Class'TgGame.TgSeqEvent_Tutorial', true, EventsToActivate);
        I = 0;
        J0xD3:

        // End:0x17B [Loop If]
        if(I < EventsToActivate.Length)
        {
            Event = TgSeqEvent_Tutorial(EventsToActivate[I]);
            // End:0x16D
            if((Event != none) && Event.CheckActivate(InInstigator, InInstigator,, ActivateIndices))
            {
                bResult = true;
            }
            I++;
            // [Loop Continue]
            goto J0xD3;
        }
    }
    return bResult;
    //return ReturnValue;    
}

defaultproperties
{
    MaxTriggerCount=0
    bPlayerOnly=false
    OutputLinks[0]=(Links=none,LinkDesc="Tutorial Started",bHasImpulse=false,bDisabled=false,bDisabledPIE=false,LinkedOp=none,ActivateDelay=0.0000000,DrawY=0,bHidden=false,bMoving=false,bClampedMax=false,bClampedMin=false,bIsActivated=false)
    OutputLinks[1]=(Links=none,LinkDesc="Helper Bot Spawned",bHasImpulse=false,bDisabled=false,bDisabledPIE=false,LinkedOp=none,ActivateDelay=0.0000000,DrawY=0,bHidden=false,bMoving=false,bClampedMax=false,bClampedMin=false,bIsActivated=false)
    OutputLinks[2]=(Links=none,LinkDesc="Moving to Auto Shooting Range",bHasImpulse=false,bDisabled=false,bDisabledPIE=false,LinkedOp=none,ActivateDelay=0.0000000,DrawY=0,bHidden=false,bMoving=false,bClampedMax=false,bClampedMin=false,bIsActivated=false)
    OutputLinks[3]=(Links=none,LinkDesc="Player Reached Auto Shooting Range",bHasImpulse=false,bDisabled=false,bDisabledPIE=false,LinkedOp=none,ActivateDelay=0.0000000,DrawY=0,bHidden=false,bMoving=false,bClampedMax=false,bClampedMin=false,bIsActivated=false)
    OutputLinks[4]=(Links=none,LinkDesc="Waiting for Movement Ability",bHasImpulse=false,bDisabled=false,bDisabledPIE=false,LinkedOp=none,ActivateDelay=0.0000000,DrawY=0,bHidden=false,bMoving=false,bClampedMax=false,bClampedMin=false,bIsActivated=false)
    OutputLinks[5]=(Links=none,LinkDesc="Received Movement Ability",bHasImpulse=false,bDisabled=false,bDisabledPIE=false,LinkedOp=none,ActivateDelay=0.0000000,DrawY=0,bHidden=false,bMoving=false,bClampedMax=false,bClampedMin=false,bIsActivated=false)
    OutputLinks[6]=(Links=none,LinkDesc="Player reached Ultimate Shooting Range",bHasImpulse=false,bDisabled=false,bDisabledPIE=false,LinkedOp=none,ActivateDelay=0.0000000,DrawY=0,bHidden=false,bMoving=false,bClampedMax=false,bClampedMin=false,bIsActivated=false)
    OutputLinks[7]=(Links=none,LinkDesc="Player completed Ultimate",bHasImpulse=false,bDisabled=false,bDisabledPIE=false,LinkedOp=none,ActivateDelay=0.0000000,DrawY=0,bHidden=false,bMoving=false,bClampedMax=false,bClampedMin=false,bIsActivated=false)
    OutputLinks[8]=(Links=none,LinkDesc="Player reached lower jump area",bHasImpulse=false,bDisabled=false,bDisabledPIE=false,LinkedOp=none,ActivateDelay=0.0000000,DrawY=0,bHidden=false,bMoving=false,bClampedMax=false,bClampedMin=false,bIsActivated=false)
    OutputLinks[9]=(Links=none,LinkDesc="Player reached upper jump area",bHasImpulse=false,bDisabled=false,bDisabledPIE=false,LinkedOp=none,ActivateDelay=0.0000000,DrawY=0,bHidden=false,bMoving=false,bClampedMax=false,bClampedMin=false,bIsActivated=false)
    OutputLinks[10]=(Links=none,LinkDesc="Player reached capture point",bHasImpulse=false,bDisabled=false,bDisabledPIE=false,LinkedOp=none,ActivateDelay=0.0000000,DrawY=0,bHidden=false,bMoving=false,bClampedMax=false,bClampedMin=false,bIsActivated=false)
    OutputLinks[11]=(Links=none,LinkDesc="Move Bot to contest capture point",bHasImpulse=false,bDisabled=false,bDisabledPIE=false,LinkedOp=none,ActivateDelay=0.0000000,DrawY=0,bHidden=false,bMoving=false,bClampedMax=false,bClampedMin=false,bIsActivated=false)
    OutputLinks[12]=(Links=none,LinkDesc="Move Bot to contest payload",bHasImpulse=false,bDisabled=false,bDisabledPIE=false,LinkedOp=none,ActivateDelay=0.0000000,DrawY=0,bHidden=false,bMoving=false,bClampedMax=false,bClampedMin=false,bIsActivated=false)
    OutputLinks[13]=(Links=none,LinkDesc="Tutorial Complete",bHasImpulse=false,bDisabled=false,bDisabledPIE=false,LinkedOp=none,ActivateDelay=0.0000000,DrawY=0,bHidden=false,bMoving=false,bClampedMax=false,bClampedMin=false,bIsActivated=false)
    ObjName="Paladins Tutorial"
}