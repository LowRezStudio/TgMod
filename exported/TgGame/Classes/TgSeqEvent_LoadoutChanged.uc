class TgSeqEvent_LoadoutChanged extends SequenceEvent
    native
    forcescriptorder(true)
    hidecategories(Object);

var int DeckIndex;

static function bool TriggerGlobal(Actor InInstigator, int InDeckIndex)
{
    local array<SequenceObject> EventsToActivate;
    local array<int> ActivateIndices;
    local Sequence GameSeq;
    local TgSeqEvent_LoadoutChanged LoadoutChangedEvent;
    local bool bResult;
    local int I;

    ActivateIndices[0] = 0;
    // End:0x27
    if(InInstigator == none)
    {
        return bResult;
    }
    GameSeq = InInstigator.WorldInfo.GetGameSequence();
    // End:0x17F
    if(GameSeq != none)
    {
        GameSeq.FindSeqObjectsByClass(Class'TgGame.TgSeqEvent_LoadoutChanged', true, EventsToActivate);
        I = 0;
        J0xB1:

        // End:0x17F [Loop If]
        if(I < EventsToActivate.Length)
        {
            LoadoutChangedEvent = TgSeqEvent_LoadoutChanged(EventsToActivate[I]);
            // End:0x171
            if(LoadoutChangedEvent != none)
            {
                LoadoutChangedEvent.DeckIndex = InDeckIndex;
                // End:0x171
                if(LoadoutChangedEvent.CheckActivate(InInstigator, InInstigator,, ActivateIndices))
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
    OutputLinks[0]=(Links=none,LinkDesc="Loadout Changed",bHasImpulse=false,bDisabled=false,bDisabledPIE=false,LinkedOp=none,ActivateDelay=0.0000000,DrawY=0,bHidden=false,bMoving=false,bClampedMax=false,bClampedMin=false,bIsActivated=false)
    VariableLinks[0]=(ExpectedType=Class'Engine.SeqVar_Object',LinkedVariables=none,LinkDesc="Instigator",LinkVar="None",PropertyName="None",bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    VariableLinks[1]=(ExpectedType=Class'Engine.SeqVar_Int',LinkedVariables=none,LinkDesc="Deck Index",LinkVar="None",PropertyName="DeckIndex",bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    ObjName="Loadout Changed"
}