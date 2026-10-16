class TgAnimBlendByPhase extends TgAnimNodeBlendList
    native(Anim)
    hidecategories(Object,Object,Object,Object);

struct native m_PhaseTransitionAnimSet
{
    var() int m_TransitionToPhase;
    var() name m_TransitionAnimName;

    structdefaultproperties
    {
        m_TransitionToPhase=0
        m_TransitionAnimName="None"
    }
};

struct native m_PhaseProfile
{
    var() int m_Phase;
    var() array<m_PhaseTransitionAnimSet> m_TransitionAnimSets;

    structdefaultproperties
    {
        m_Phase=0
        m_TransitionAnimSets=none
    }
};

var TgPawn m_TgPawn;
var int m_LastPhase;
var int m_CurrentPhase;
var() bool m_bEnableTransitionAnims;
var() array<m_PhaseProfile> m_PhaseProfiles;

defaultproperties
{
    m_bEnableTransitionAnims=true
    DefaultBlendTime=0.2000000
    ActiveChildIndex=1
    Children=/* Array type was not detected. */
}