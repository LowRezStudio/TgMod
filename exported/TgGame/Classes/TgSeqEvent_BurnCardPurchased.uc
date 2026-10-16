class TgSeqEvent_BurnCardPurchased extends SequenceEvent
    native
    forcescriptorder(true)
    hidecategories(Object);

var int nFilledSlots;
var bool bAllBurnSlotsFull;

static function bool TriggerGlobal(Actor InInstigator, int InFilledSlotsCount, bool bInAllBurnSlotsFull)
{
    local array<SequenceObject> EventsToActivate;
    local array<int> ActivateIndices;
    local Sequence GameSeq;
    local TgSeqEvent_BurnCardPurchased Event;
    local bool bResult;
    local int I;

    ActivateIndices[0] = 0;
    // End:0x27
    if(InInstigator == none)
    {
        return bResult;
    }
    GameSeq = InInstigator.WorldInfo.GetGameSequence();
    // End:0x1A9
    if(GameSeq != none)
    {
        GameSeq.FindSeqObjectsByClass(Class'TgGame.TgSeqEvent_BurnCardPurchased', true, EventsToActivate);
        I = 0;
        J0xB1:

        // End:0x1A9 [Loop If]
        if(I < EventsToActivate.Length)
        {
            Event = TgSeqEvent_BurnCardPurchased(EventsToActivate[I]);
            // End:0x19B
            if(Event != none)
            {
                Event.nFilledSlots = InFilledSlotsCount;
                Event.bAllBurnSlotsFull = bInAllBurnSlotsFull;
                // End:0x19B
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
    OutputLinks[0]=(Links=none,LinkDesc="Purchased",bHasImpulse=false,bDisabled=false,bDisabledPIE=false,LinkedOp=none,ActivateDelay=0.0000000,DrawY=0,bHidden=false,bMoving=false,bClampedMax=false,bClampedMin=false,bIsActivated=false)
    VariableLinks[0]=(ExpectedType=Class'Engine.SeqVar_Object',LinkedVariables=none,LinkDesc="Instigator",LinkVar="None",PropertyName="None",bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    VariableLinks[1]=(ExpectedType=Class'Engine.SeqVar_Int',LinkedVariables=none,LinkDesc="Filled Slots Count",LinkVar="None",PropertyName="nFilledSlots",bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    VariableLinks[2]=(ExpectedType=Class'Engine.SeqVar_Bool',LinkedVariables=none,LinkDesc="Slots Full",LinkVar="None",PropertyName="bAllBurnSlotsFull",bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    ObjName="Burn Card Purchased"
}