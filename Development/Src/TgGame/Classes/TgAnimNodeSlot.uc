class TgAnimNodeSlot extends AnimNodeSlot
    native(Anim)
    hidecategories(Object,Object,Object,Object)
    config(Engine);

var transient TgPawn m_TgPawn;
var transient bool m_bBlendOutIfVelocityIsGreaterThanZero;
var transient bool m_bIsTransitionAnim;
var () bool m_bNotifyActorOnChildAnimEnd;
var (Hacking) name m_nmHackingTransitionAnimName;
var (Hacking) name m_nmHackingLoopingAnimName;
var (AFK) name m_nmAFKTransitionAnimName;
var (AFK) name m_nmAFKLoopingAnimName;
var transient name m_nmQueuedAnim;

native function float PlayLoopingCustomAnimWithTransition(name TransitionAnimName, name LoopingAnimName, float Rate, optional float BlendInTime, optional float BlendOutTime);  // Export UTgAnimNodeSlot::execPlayLoopingCustomAnimWithTransition(FFrame&, void* const)

function SetPlayRate(float fPlayRate) { }

native function PlayAFK();  // Export UTgAnimNodeSlot::execPlayAFK(FFrame&, void* const)

native function StopAFK();  // Export UTgAnimNodeSlot::execStopAFK(FFrame&, void* const)

native function PlayHacking();  // Export UTgAnimNodeSlot::execPlayHacking(FFrame&, void* const)

native function StopHacking();  // Export UTgAnimNodeSlot::execStopHacking(FFrame&, void* const)


defaultproperties
{
    m_bNotifyActorOnChildAnimEnd=true
}
