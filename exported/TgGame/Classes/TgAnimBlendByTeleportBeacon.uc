class TgAnimBlendByTeleportBeacon extends TgAnimNodeBlendList
    hidecategories(Object,Object,Object,Object);

var bool m_bDeployed;

simulated function Deploy(float fDeployTime)
{
    local AnimNodeSequence AnimSeqNode;
    local AnimSequence AnimSeq;
    local float AnimLength, InputTime, CurrentGlobalRate;

    // End:0x336
    if(ActiveChildIndex != 2)
    {
        AnimSeqNode = AnimNodeSequence(Children[1].Anim);
        // End:0x123
        if(AnimSeqNode != none)
        {
            // End:0x9F
            if(AnimSeqNode.AnimSeq != none)
            {
                AnimSeq = AnimSeqNode.AnimSeq;                
            }
            else
            {
                // End:0x123
                if((AnimSeqNode.AnimSeqName != 'None') && SkelComponent != none)
                {
                    AnimSeq = SkelComponent.FindAnimSequence(AnimSeqNode.AnimSeqName);
                }
            }
        }
        // End:0x2B8
        if(((fDeployTime > 0.0000000) && AnimSeqNode != none) && AnimSeq != none)
        {
            // End:0x17D
            if(ActiveChildIndex != 1)
            {
                SetActiveChild(1, GetBlendTime(1));
            }
            AnimSeqNode.bNoNotifies = false;
            AnimLength = AnimSeq.SequenceLength;
            CurrentGlobalRate = AnimSeqNode.GetGlobalPlayRate() / AnimSeqNode.Rate;
            InputTime = ((!AnimSeqNode.bPlaying) ? 0.0000000 : AnimSeqNode.CurrentTime);
            AnimSeqNode.PlayAnim(false, (AnimLength - InputTime) / (CurrentGlobalRate * fDeployTime), InputTime);            
        }
        else
        {
            SetActiveChild(2, GetBlendTime(2));
            // End:0x32A
            if(Children[2].Anim != none)
            {
                Children[2].Anim.ReplayAnim();
            }
        }
        m_bDeployed = true;
    }
    //return;    
}

simulated function Undeploy(float fUndeployTime)
{
    local AnimNodeSequence AnimSeqNode;
    local AnimSequence AnimSeq;
    local float AnimLength, InputTime, CurrentGlobalRate;

    // End:0x337
    if(ActiveChildIndex != 0)
    {
        AnimSeqNode = AnimNodeSequence(Children[1].Anim);
        // End:0x122
        if(AnimSeqNode != none)
        {
            // End:0x9E
            if(AnimSeqNode.AnimSeq != none)
            {
                AnimSeq = AnimSeqNode.AnimSeq;                
            }
            else
            {
                // End:0x122
                if((AnimSeqNode.AnimSeqName != 'None') && SkelComponent != none)
                {
                    AnimSeq = SkelComponent.FindAnimSequence(AnimSeqNode.AnimSeqName);
                }
            }
        }
        // End:0x2BD
        if(((fUndeployTime > 0.0000000) && AnimSeqNode != none) && AnimSeq != none)
        {
            // End:0x17C
            if(ActiveChildIndex != 1)
            {
                SetActiveChild(1, GetBlendTime(1));
            }
            AnimSeqNode.bNoNotifies = true;
            AnimLength = AnimSeq.SequenceLength;
            CurrentGlobalRate = AnimSeqNode.GetGlobalPlayRate() / AnimSeqNode.Rate;
            InputTime = ((!AnimSeqNode.bPlaying) ? AnimLength : AnimSeqNode.CurrentTime);
            AnimSeqNode.PlayAnim(false, -InputTime / (CurrentGlobalRate * fUndeployTime), AnimLength - InputTime);            
        }
        else
        {
            SetActiveChild(0, GetBlendTime(0));
            // End:0x32B
            if(Children[0].Anim != none)
            {
                Children[0].Anim.ReplayAnim();
            }
        }
        m_bDeployed = false;
    }
    //return;    
}

defaultproperties
{
    Children=/* Array type was not detected. */
    bFixNumChildren=true
}