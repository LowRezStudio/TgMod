class TgEffectDamage extends TgEffect
    native(Effects)
    config(Engine)
    dependson(TgObject);

var int m_nSimplifiedPropertyId;
var Class<TgDamageType> m_DamageTypeClass;
var Class<TgDamageType> m_DefaultDamageTypeClass;
var float m_fDamageInitial;
var float m_fBonusDamageToShields;
var bool m_bAllowLifeSteal;
var bool m_bCanBeBuffed;

native function TgEffect CloneEffect();  // Export UTgEffectDamage::execCloneEffect(FFrame&, void* const)

native function PostDamageHandler(Actor pTarget, TgPawn pInstigator, ImpactInfo Impact, float fPrevHealth, float fHealthChange, float fBuffedDamage, float fMitigatedDamage, const out ExtraDamageInfo ExtraInfo);  // Export UTgEffectDamage::execPostDamageHandler(FFrame&, void* const)

native function SendDamageMessages(Actor Source, Actor Target, float fDamage, float fMitigated, ImpactInfo thisImpact, const out ExtraDamageInfo ExtraInfo);  // Export UTgEffectDamage::execSendDamageMessages(FFrame&, void* const)

native function bool CanBeApplied(Actor Target);  // Export UTgEffectDamage::execCanBeApplied(FFrame&, void* const)

native function bool ApplyEffect(Actor Target, optional ImpactInfo Impact, optional bool bLatent);  // Export UTgEffectDamage::execApplyEffect(FFrame&, void* const)

native function PerformLifeSteal(TgPawn InstigatorPawn, ImpactInfo Impact, float fDamageAmount);  // Export UTgEffectDamage::execPerformLifeSteal(FFrame&, void* const)

native function bool ApplyStacks(Actor Target, int nNumStacks);  // Export UTgEffectDamage::execApplyStacks(FFrame&, void* const)

native function bool RemoveStacks(Actor Target, int nNumStacks);  // Export UTgEffectDamage::execRemoveStacks(FFrame&, void* const)

native function bool ApplyOnThisInterval();  // Export UTgEffectDamage::execApplyOnThisInterval(FFrame&, void* const)

native function float GetProratedValue();  // Export UTgEffectDamage::execGetProratedValue(FFrame&, void* const)

defaultproperties
{
    m_DefaultDamageTypeClass=Class'TgDamageType'
    m_fDamageInitial=-1.0000000
    m_bAllowLifeSteal=true
    m_bCanBeBuffed=true
}
