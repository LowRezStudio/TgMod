class TgAnimNodeSlot extends AnimNodeSlot
    native(Anim)
    hidecategories(Object,Object,Object,Object);

var transient TgPawn m_TgPawn;
var transient bool m_bBlendOutIfVelocityIsGreaterThanZero;
var transient bool m_bIsTransitionAnim;
var() bool m_bNotifyActorOnChildAnimEnd;
var(Hacking) name m_nmHackingTransitionAnimName;
var(Hacking) name m_nmHackingLoopingAnimName;
var(AFK) name m_nmAFKTransitionAnimName;
var(AFK) name m_nmAFKLoopingAnimName;
var transient name m_nmQueuedAnim;

// Export UTgAnimNodeSlot::execPlayLoopingCustomAnimWithTransition(FFrame&, void* const)
native function float PlayLoopingCustomAnimWithTransition(name TransitionAnimName, name LoopingAnimName, float Rate, optional float BlendInTime, optional float BlendOutTime);

function SetPlayRate(float fPlayRate)
{
    local AnimNodeSequence SeqNode;

    // End:0x2B
    if((CustomChildIndex < 1) || CustomChildIndex >= Children.Length)
    {
        return;
    }
    SeqNode = AnimNodeSequence(Children[CustomChildIndex].Anim);
    // End:0x9B
    if(SeqNode != none)
    {
        SeqNode.Rate = fPlayRate;
    }
    //return;    
}

// Export UTgAnimNodeSlot::execPlayAFK(FFrame&, void* const)
native function PlayAFK();

// Export UTgAnimNodeSlot::execStopAFK(FFrame&, void* const)
native function StopAFK();

// Export UTgAnimNodeSlot::execPlayHacking(FFrame&, void* const)
native function PlayHacking();

// Export UTgAnimNodeSlot::execStopHacking(FFrame&, void* const)
native function StopHacking();

// Export UTgAnimNodeSlot::execStopCustomAnim(FFrame&, void* const)
native function StopCustomAnim(float BlendOutTime);

defaultproperties
{
    m_bNotifyActorOnChildAnimEnd=true
}