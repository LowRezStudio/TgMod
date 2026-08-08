class TgAnimBlendByPhase extends TgAnimNodeBlendList
    native(Anim)
    hidecategories(Object,Object,Object,Object)
    config(Engine);

struct m_PhaseTransitionAnimSet {
    var () int m_TransitionToPhase;
    var () name m_TransitionAnimName;
    structdefaultproperties {}
};

struct m_PhaseProfile {
    var () int m_Phase;
    var () array<m_PhaseTransitionAnimSet> m_TransitionAnimSets;
    structdefaultproperties {}
};

var TgPawn m_TgPawn;
var int m_LastPhase;
var int m_CurrentPhase;
var () bool m_bEnableTransitionAnims;
var () array<m_PhaseProfile> m_PhaseProfiles;

defaultproperties
{
    m_bEnableTransitionAnims=true
    DefaultBlendTime=0.2000000
    ActiveChildIndex=1
    Children=/* Array type was not detected. */
}
