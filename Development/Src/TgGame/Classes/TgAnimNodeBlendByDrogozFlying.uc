class TgAnimNodeBlendByDrogozFlying extends TgAnimNodeBlendList
    native(Anim)
    hidecategories(Object,Object,Object,Object)
    config(Engine);

enum EBlendDrogozFlying {
    BLENDDROGOZ_NotFlying,  // 0
    BLENDDROGOZ_Flying,  // 1
    BLENDDROGOZ_TransitionToNotFlying,  // 2
    BLENDDROGOZ_TransitionToFlying,  // 3
};

struct BoosterFlightInfo {
    var float fStartTime;
    var float fEndTime;
    structdefaultproperties {}
};

var array<BoosterFlightInfo> m_BoosterRecords;
var TgPawn_Drogoz m_CachedDrogozOwner;
var bool m_bInThrust;
var bool m_bInBooster;
var () bool m_bTransitionsCanBeInterrupted;
var float m_fBoosterStartTime;
var () float m_fBoosterRelevancyWindow;
var () float m_fBoosterTriggerPercent;
var () float m_fMaxFlightFallSpeed;

native function float GetBoosterUsePercent();  // Export UTgAnimNodeBlendByDrogozFlying::execGetBoosterUsePercent(FFrame&, void* const)

native function StartedBooster();  // Export UTgAnimNodeBlendByDrogozFlying::execStartedBooster(FFrame&, void* const)

native function StoppedBooster();  // Export UTgAnimNodeBlendByDrogozFlying::execStoppedBooster(FFrame&, void* const)

defaultproperties
{
    m_bTransitionsCanBeInterrupted=true
    m_fBoosterRelevancyWindow=1.0000000
    m_fBoosterTriggerPercent=0.5000000
    m_fMaxFlightFallSpeed=-400.0000000
    Children=/* Array type was not detected. */
    NodeName="DrogozFlyingBlendNode"
}
