class TgEffectHeal extends TgEffect
    native(Effects)
    config(Engine);

var float m_fMissingHealthInitial;
var int m_nIntervalCount;
var int m_nSimplifiedPropertyId;

native function bool CanBeApplied(Actor Target);  // Export UTgEffectHeal::execCanBeApplied(FFrame&, void* const)

native function bool ApplyEffect(Actor Target, optional ImpactInfo Impact, optional bool bLatent);  // Export UTgEffectHeal::execApplyEffect(FFrame&, void* const)

native function bool ApplyStacks(Actor Target, int nNumStacks);  // Export UTgEffectHeal::execApplyStacks(FFrame&, void* const)

native function bool RemoveStacks(Actor Target, int nNumStacks);  // Export UTgEffectHeal::execRemoveStacks(FFrame&, void* const)

native function PostHealHandler(Actor pTarget, TgPawn pInstigator, ImpactInfo Impact, float fHealthChange, float fHealAmount);  // Export UTgEffectHeal::execPostHealHandler(FFrame&, void* const)

native function TgEffect CloneEffect();  // Export UTgEffectHeal::execCloneEffect(FFrame&, void* const)
