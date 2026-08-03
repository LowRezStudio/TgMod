class TgSeqEvent_SpectatorReady extends SequenceEvent
    forcescriptorder(true)
    hidecategories(Object);

static function bool TriggerGlobal(TgSpectatorController InInstigator)
{
    local array<SequenceObject> EventsToActivate;
    local array<int> ActivateIndices;
    local Sequence GameSeq;
    local TgSeqEvent_SpectatorReady Event;
    local bool bResult;
    local int I;

    ActivateIndices[0] = 0;
    // End:0x27
    if(InInstigator == none)
    {
        return bResult;
    }
    GameSeq = InInstigator.WorldInfo.GetGameSequence();
    // End:0x157
    if(GameSeq != none)
    {
        GameSeq.FindSeqObjectsByClass(Class'TgGame.TgSeqEvent_SpectatorReady', true, EventsToActivate);
        I = 0;
        J0xB1:

        // End:0x157 [Loop If]
        if(I < EventsToActivate.Length)
        {
            Event = TgSeqEvent_SpectatorReady(EventsToActivate[I]);
            // End:0x149
            if(Event != none)
            {
                // End:0x149
                if(Event.CheckActivate(InInstigator, InInstigator,, ActivateIndices))
                {
                    bResult = true;
                }
            }
            I++;
            // [Loop Continue]
            goto J0xB1;
        }
    }
    return bResult;
    //return ReturnValue;    
}

defaultproperties
{
    MaxTriggerCount=0
    OutputLinks[0]=(Links=none,LinkDesc="Ready",bHasImpulse=false,bDisabled=false,bDisabledPIE=false,LinkedOp=none,ActivateDelay=0.0000000,DrawY=0,bHidden=false,bMoving=false,bClampedMax=false,bClampedMin=false,bIsActivated=false)
    ObjName="Spectator Ready"
}