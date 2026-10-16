class TgEffectDamage_Execute extends TgEffectDamage
    native(Effects)
    config(Engine);

var bool m_bApplied;
var bool m_bExecute;

native function bool ApplyEffect(Actor Target, optional ImpactInfo Impact, optional bool bLatent);  // Export UTgEffectDamage_Execute::execApplyEffect(FFrame&, void* const)

native function float GetProratedValue();  // Export UTgEffectDamage_Execute::execGetProratedValue(FFrame&, void* const)
