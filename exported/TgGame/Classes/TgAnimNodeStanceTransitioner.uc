class TgAnimNodeStanceTransitioner extends AnimNodeBlendList
    native(Anim)
    hidecategories(Object,Object,Object,Object);

struct native CachedTgAnimNodeStanceInfo
{
    var int Index;
    var TgAnimNodeStance Node;

    structdefaultproperties
    {
        Index=0
        Node=none
    }
};

struct native CachedTgAnimNodeStanceTransitionInfo
{
    var int Index;
    var TgAnimNodeStanceTransition Node;

    structdefaultproperties
    {
        Index=0
        Node=none
    }
};

var() int m_DefaultStance;
var() int m_CurrentStance;
var bool m_bIsPlayingTransition;
var() float m_BlendTransitionDuration;
var array<CachedTgAnimNodeStanceInfo> m_StanceNodeInfos;
var array<CachedTgAnimNodeStanceTransitionInfo> m_TransitionNodeInfos;

event int GetCurrentStance()
{
    return m_CurrentStance;
    //return ReturnValue;    
}

event GetStances(out array<int> Stances)
{
    local CachedTgAnimNodeStanceInfo Stance;

    // End:0x56
    foreach m_StanceNodeInfos(Stance)
    {
        Stances.AddItem(Stance.Node.m_Stance);        
    }    
    //return;    
}

// Export UTgAnimNodeStanceTransitioner::execPlayAnim(FFrame&, void* const)
native function PlayAnim(optional bool bLoop = false, optional float InRate = 1.0000000, optional float StartTime = 0.0000000);

// Export UTgAnimNodeStanceTransitioner::execReplayAnim(FFrame&, void* const)
native function ReplayAnim();

// Export UTgAnimNodeStanceTransitioner::execSetStance(FFrame&, void* const)
native function bool SetStance(int Stance);

// Export UTgAnimNodeStanceTransitioner::execGetTransitionableStances(FFrame&, void* const)
native function GetTransitionableStances(int SourceStance, out array<int> DestinationStances);

// Export UTgAnimNodeStanceTransitioner::execTransitionToStance(FFrame&, void* const)
native function bool TransitionToStance(int DestinationStance);

// Export UTgAnimNodeStanceTransitioner::execBlendToStance(FFrame&, void* const)
native function bool BlendToStance(int DestinationStance);

defaultproperties
{
    m_BlendTransitionDuration=0.1000000
}