class TgAnimNodeBlendByAndroxusDrift extends TgAnimNodeBlendList
    native(Anim)
    hidecategories(Object,Object,Object,Object);

enum EBlendAndroxusDrift
{
    BLENDDRIFT_NotDrifting,         // 0
    BLENDDRIFT_Drifting,            // 1
    BLENDDRIFT_TransitionToNotDrifting,// 2
    BLENDDRIFT_TransitionToDrifting,// 3
    BLENDDRIFT_MAX                  // 4
};

struct native DriftInfo
{
    var float fStartTime;
    var float fEndTime;

    structdefaultproperties
    {
        fStartTime=0.0000000
        fEndTime=0.0000000
    }
};

var array<DriftInfo> m_DriftRecords;
var TgPawn_Androxus m_CachedAndroxusOwner;
var bool m_bInDrift;
var() bool m_bTransitionsCanBeInterrupted;
var float m_fDriftStartTime;
var() float m_fDriftRelevancyWindow;
var() float m_fDriftTriggerPercent;
var() float m_fMaxFallSpeed;

// Export UTgAnimNodeBlendByAndroxusDrift::execGetDriftUsePercent(FFrame&, void* const)
native function float GetDriftUsePercent();

// Export UTgAnimNodeBlendByAndroxusDrift::execStartedDrift(FFrame&, void* const)
native function StartedDrift();

// Export UTgAnimNodeBlendByAndroxusDrift::execStoppedDrift(FFrame&, void* const)
native function StoppedDrift();

defaultproperties
{
    m_bTransitionsCanBeInterrupted=true
    m_fDriftRelevancyWindow=1.0000000
    m_fDriftTriggerPercent=0.5000000
    m_fMaxFallSpeed=-400.0000000
    Children=/* Array type was not detected. */
    NodeName="AndroxusDriftBlendNode"
}