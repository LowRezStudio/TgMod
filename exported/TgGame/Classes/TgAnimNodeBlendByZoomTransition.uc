class TgAnimNodeBlendByZoomTransition extends TgAnimNodeBlendList
    native(Anim)
    hidecategories(Object,Object,Object,Object);

var float m_fTransitionStartTime;

function StartZoomTransition(float zoomPercent, float totalTransitionTime, bool zoomIn)
{
    local WorldInfo World;
    local AnimNodeSequence AnimNodeSeq;
    local AnimSequence AnimSeq;

    // End:0x198
    if(zoomIn)
    {
        // End:0x195
        if(Children[2].Anim != none)
        {
            SetActiveChild(2, GetBlendTime(2));
            AnimNodeSeq = AnimNodeSequence(Children[2].Anim);
            // End:0x195
            if(AnimNodeSeq != none)
            {
                // End:0xEC
                if(AnimNodeSeq.AnimSeq == none)
                {
                    AnimNodeSeq.SetAnim(AnimNodeSeq.AnimSeqName);
                }
                AnimSeq = AnimNodeSeq.AnimSeq;
                // End:0x195
                if(AnimSeq != none)
                {
                    AnimNodeSeq.PlayAnim(false, AnimSeq.SequenceLength / totalTransitionTime, zoomPercent * AnimSeq.SequenceLength);
                }
            }
        }        
    }
    else
    {
        // End:0x327
        if(Children[3].Anim != none)
        {
            SetActiveChild(3, GetBlendTime(3));
            AnimNodeSeq = AnimNodeSequence(Children[3].Anim);
            // End:0x327
            if(AnimNodeSeq != none)
            {
                // End:0x277
                if(AnimNodeSeq.AnimSeq == none)
                {
                    AnimNodeSeq.SetAnim(AnimNodeSeq.AnimSeqName);
                }
                AnimSeq = AnimNodeSeq.AnimSeq;
                // End:0x327
                if(AnimSeq != none)
                {
                    AnimNodeSeq.PlayAnim(false, AnimSeq.SequenceLength / totalTransitionTime, (1.0000000 - zoomPercent) * AnimSeq.SequenceLength);
                }
            }
        }
    }
    World = Class'Engine.WorldInfo'.static.GetWorldInfo();
    m_fTransitionStartTime = World.TimeSeconds;
    //return;    
}

function SetZoomState(bool zoomIn)
{
    // End:0x26
    if(zoomIn)
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
    NodeName="ZoomTransition"
}