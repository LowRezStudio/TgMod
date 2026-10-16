class AnimNotify extends Object
    abstract
    native(Anim)
    editinlinenew
    collapsecategories
    hidecategories(Object);

var bool ShouldDeferIssue;
var() Scene.EDetailMode DetailMode;

simulated function bool FindNextNotifyOfClass(AnimNodeSequence AnimSeqInstigator, Class<AnimNotify> NotifyClass, out AnimNotifyEvent OutEvent)
{
    local AnimSequence Seq;
    local int I;
    local bool bFoundThis;

    // End:0x181
    if(AnimSeqInstigator.AnimSeq != none)
    {
        Seq = AnimSeqInstigator.AnimSeq;
        I = 0;
        J0x57:

        // End:0x181 [Loop If]
        if(I < Seq.Notifies.Length)
        {
            // End:0xD1
            if(Seq.Notifies[I].Notify == self)
            {
                bFoundThis = true;
            }
            // End:0x173
            if(bFoundThis && ClassIsChildOf(Seq.Notifies[I].Notify.Class, NotifyClass))
            {
                OutEvent = Seq.Notifies[I];
                return true;
            }
            I++;
            // [Loop Continue]
            goto J0x57;
        }
    }
    return false;
    //return ReturnValue;    
}

simulated event OnAnimNodeSequenceCeaseRelevant(AnimNodeSequence OwningNode)
{
    //return;    
}

simulated event OnAnimNodeSequenceBecomeRelevant(AnimNodeSequence OwningNode)
{
    //return;    
}
