class TgAnimNodeBlendByAbilitySimple extends TgAnimNodeBlendList
    native(Anim)
    hidecategories(Object,Object,Object,Object);

enum EBlendSimpleAbility
{
    BLENDSA_Inactive,               // 0
    BLENDSA_Firing,                 // 1
    BLENDSA_MAX                     // 2
};

var() bool m_bBlendToActiveOnStartFire;
var() bool m_bBlendToActiveOnFire;
var() bool m_bDelayBlendToActiveUntilAnimEnd;
var() bool m_bDelayBlendToActiveUntilReplay;
var() bool m_bDelayBlendToIdleUntilAnimEnd;
var() bool m_bDelayBlendToIdleUntilReplay;
var() bool m_bBlendToIdleImmediatelyOnInterrupt;
var transient bool m_bIsAbilityFiring;
var() TgObject.TG_EQUIP_POINT m_EqpPoint;

function SetAbilityFiring(bool bIsFiring, bool bIsOnFire, optional bool bIsInterrupted = false)
{
    // End:0x5F
    if(bIsFiring && (m_bBlendToActiveOnStartFire && !bIsOnFire) || m_bBlendToActiveOnFire && bIsOnFire)
    {
        m_bIsAbilityFiring = true;        
    }
    else
    {
        // End:0x7A
        if(!bIsFiring)
        {
            m_bIsAbilityFiring = false;
        }
    }
    // End:0xD3
    if(m_bIsAbilityFiring && (!m_bDelayBlendToActiveUntilReplay && !m_bDelayBlendToActiveUntilAnimEnd) || !bRelevant)
    {
        SetActiveChild(1, GetBlendTime(1));        
    }
    else
    {
        // End:0x149
        if(!m_bIsAbilityFiring && ((!m_bDelayBlendToIdleUntilReplay && !m_bDelayBlendToIdleUntilAnimEnd) || !bRelevant) || bIsInterrupted && m_bBlendToIdleImmediatelyOnInterrupt)
        {
            SetActiveChild(0, GetBlendTime(0));
        }
    }
    //return;    
}

// Export UTgAnimNodeBlendByAbilitySimple::execPlayAnim(FFrame&, void* const)
native function PlayAnim(optional bool bLoop = false, optional float InRate = 1.0000000, optional float StartTime = 0.0000000);

// Export UTgAnimNodeBlendByAbilitySimple::execReplayAnim(FFrame&, void* const)
native function ReplayAnim();

defaultproperties
{
    m_bBlendToActiveOnStartFire=true
    m_EqpPoint=TG_EQUIP_POINT.EQP_AUTO
    TargetWeight=/* Array type was not detected. */
    Children=/* Array type was not detected. */
    bFixNumChildren=true
    NodeName="SimpleAbilityBlendNode"
}