class TgAnimNodeToggleWithTransition extends TgAnimNodeBlendList
    native(Anim)
    hidecategories(Object,Object,Object,Object);

var float m_fTransitionStartTime;
var float m_fTransitionTimeRemaining;

function StartTransition(float transitionPercent, float totalTransitionTime, bool transitionToActive)
{
    local WorldInfo World;
    local AnimNodeSequence AnimNodeSeq;
    local AnimSequence AnimSeq;

    // End:0x1E7
    if(transitionToActive)
    {
        // End:0x1D0
        if((Children[2].Anim != none) && totalTransitionTime > float(0))
        {
            SetActiveChild(2, GetBlendTime(2));
            AnimNodeSeq = AnimNodeSequence(Children[2].Anim);
            // End:0x1A8
            if(AnimNodeSeq != none)
            {
                // End:0xFF
                if(AnimNodeSeq.AnimSeq == none)
                {
                    AnimNodeSeq.SetAnim(AnimNodeSeq.AnimSeqName);
                }
                AnimSeq = AnimNodeSeq.AnimSeq;
                // End:0x1A8
                if(AnimSeq != none)
                {
                    AnimNodeSeq.PlayAnim(false, AnimSeq.SequenceLength / totalTransitionTime, transitionPercent * AnimSeq.SequenceLength);
                }
            }
            m_fTransitionTimeRemaining = (1.0000000 - transitionPercent) * totalTransitionTime;            
        }
        else
        {
            SetActiveChild(1, totalTransitionTime);
        }        
    }
    else
    {
        // End:0x3AA
        if((Children[3].Anim != none) && totalTransitionTime > float(0))
        {
            SetActiveChild(3, GetBlendTime(3));
            AnimNodeSeq = AnimNodeSequence(Children[3].Anim);
            // End:0x389
            if(AnimNodeSeq != none)
            {
                // End:0x2D9
                if(AnimNodeSeq.AnimSeq == none)
                {
                    AnimNodeSeq.SetAnim(AnimNodeSeq.AnimSeqName);
                }
                AnimSeq = AnimNodeSeq.AnimSeq;
                // End:0x389
                if(AnimSeq != none)
                {
                    AnimNodeSeq.PlayAnim(false, AnimSeq.SequenceLength / totalTransitionTime, (1.0000000 - transitionPercent) * AnimSeq.SequenceLength);
                }
            }
            m_fTransitionTimeRemaining = transitionPercent * totalTransitionTime;            
        }
        else
        {
            SetActiveChild(0, totalTransitionTime);
        }
    }
    World = Class'Engine.WorldInfo'.static.GetWorldInfo();
    m_fTransitionStartTime = World.TimeSeconds;
    //return;    
}

function SetToggleState(bool IsActive)
{
    m_fTransitionTimeRemaining = 0.0000000;
    // End:0x35
    if(IsActive)
    {
        SetActiveChild(1, GetBlendTime(1));        
    }
    else
    {
        SetActiveChild(0, GetBlendTime(0));
    }
    //return;    
}

defaultproperties
{
    TargetWeight=/* Array type was not detected. */
    Children=/* Array type was not detected. */
    bFixNumChildren=true
}