class TgEffectModifyEffect extends TgEffect
    native(Effects)
    config(Engine);

native function bool CanBeApplied(Actor Target);  // Export UTgEffectModifyEffect::execCanBeApplied(FFrame&, void* const)

native function SetProperty(Actor Target, int nPropertyId, float fNewValue);  // Export UTgEffectModifyEffect::execSetProperty(FFrame&, void* const)

native function bool ApplyEffect(Actor Target, optional ImpactInfo Impact, optional bool bLatent);  // Export UTgEffectModifyEffect::execApplyEffect(FFrame&, void* const)

native function ApplyToProperty(Actor Target, int nPropertyId, float fProratedAmount, optional bool bRemove=false);  // Export UTgEffectModifyEffect::execApplyToProperty(FFrame&, void* const)

native function float GetProratedValue();  // Export UTgEffectModifyEffect::execGetProratedValue(FFrame&, void* const)

native function Remove(Actor Target, optional bool bResetToFollow);  // Export UTgEffectModifyEffect::execRemove(FFrame&, void* const)

native function TgProperty GetTargetProperty(Actor Target, int nPropertyId);  // Export UTgEffectModifyEffect::execGetTargetProperty(FFrame&, void* const)
