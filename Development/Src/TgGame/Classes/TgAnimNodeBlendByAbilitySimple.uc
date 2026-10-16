class TgAnimNodeBlendByAbilitySimple extends TgAnimNodeBlendList
    native(Anim)
    hidecategories(Object,Object,Object,Object)
    config(Engine)
    dependson(TgObject);

enum EBlendSimpleAbility {
    BLENDSA_Inactive,  // 0
    BLENDSA_Firing,  // 1
};

var () bool m_bBlendToActiveOnStartFire;
var () bool m_bBlendToActiveOnFire;
var () bool m_bDelayBlendToActiveUntilAnimEnd;
var () bool m_bDelayBlendToActiveUntilReplay;
var () bool m_bDelayBlendToIdleUntilAnimEnd;
var () bool m_bDelayBlendToIdleUntilReplay;
var () bool m_bBlendToIdleImmediatelyOnInterrupt;
var transient bool m_bIsAbilityFiring;
var () TgObject.TG_EQUIP_POINT m_EqpPoint;

function SetAbilityFiring(bool bIsFiring, bool bIsOnFire, optional bool bIsInterrupted=false) { }

native function PlayAnim(optional bool bLoop=false, optional float InRate=1.0000000, optional float StartTime=0.0000000);  // Export UTgAnimNodeBlendByAbilitySimple::execPlayAnim(FFrame&, void* const)

native function ReplayAnim();  // Export UTgAnimNodeBlendByAbilitySimple::execReplayAnim(FFrame&, void* const)

defaultproperties
{
    m_bBlendToActiveOnStartFire=true
    m_EqpPoint=EQP_AUTO
    TargetWeight=/* Array type was not detected. */
    Children=/* Array type was not detected. */
    bFixNumChildren=true
    NodeName="SimpleAbilityBlendNode"
}
