class TgAnimNodeBlendByDrogozFlying extends TgAnimNodeBlendList
    native(Anim)
    hidecategories(Object,Object,Object,Object);

enum EBlendDrogozFlying
{
    BLENDDROGOZ_NotFlying,          // 0
    BLENDDROGOZ_Flying,             // 1
    BLENDDROGOZ_TransitionToNotFlying,// 2
    BLENDDROGOZ_TransitionToFlying, // 3
    BLENDDROGOZ_MAX                 // 4
};

struct native BoosterFlightInfo
{
    var float fStartTime;
    var float fEndTime;

    structdefaultproperties
    {
        fStartTime=0.0000000
        fEndTime=0.0000000
    }
};

var array<BoosterFlightInfo> m_BoosterRecords;
var TgPawn_Drogoz m_CachedDrogozOwner;
var bool m_bInThrust;
var bool m_bInBooster;
var() bool m_bTransitionsCanBeInterrupted;
var float m_fBoosterStartTime;
var() float m_fBoosterRelevancyWindow;
var() float m_fBoosterTriggerPercent;
var() float m_fMaxFlightFallSpeed;

// Export UTgAnimNodeBlendByDrogozFlying::execGetBoosterUsePercent(FFrame&, void* const)
native function float GetBoosterUsePercent();

// Export UTgAnimNodeBlendByDrogozFlying::execStartedBooster(FFrame&, void* const)
native function StartedBooster();

// Export UTgAnimNodeBlendByDrogozFlying::execStoppedBooster(FFrame&, void* const)
native function StoppedBooster();

defaultproperties
{
    m_bTransitionsCanBeInterrupted=true
    m_fBoosterRelevancyWindow=1.0000000
    m_fBoosterTriggerPercent=0.5000000
    m_fMaxFlightFallSpeed=-400.0000000
    Children=/* Array type was not detected. */
    NodeName="DrogozFlyingBlendNode"
}