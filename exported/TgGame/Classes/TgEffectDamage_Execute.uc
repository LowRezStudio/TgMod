class TgEffectDamage_Execute extends TgEffectDamage
    native(Effects);

var bool m_bApplied;
var bool m_bExecute;

// Export UTgEffectDamage_Execute::execApplyEffect(FFrame&, void* const)
native function bool ApplyEffect(Actor Target, optional ImpactInfo Impact, optional bool bLatent);

// Export UTgEffectDamage_Execute::execGetProratedValue(FFrame&, void* const)
native function float GetProratedValue();
