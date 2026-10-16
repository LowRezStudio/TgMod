class TgEffectModifyDeployable extends TgEffect
    native(Effects);

// Export UTgEffectModifyDeployable::execCanBeApplied(FFrame&, void* const)
native function bool CanBeApplied(Actor Target);

// Export UTgEffectModifyDeployable::execSetProperty(FFrame&, void* const)
native function SetProperty(Actor Target, int nPropertyId, float fNewValue);

// Export UTgEffectModifyDeployable::execApplyEffect(FFrame&, void* const)
native function bool ApplyEffect(Actor Target, optional ImpactInfo Impact, optional bool bLatent);

// Export UTgEffectModifyDeployable::execApplyToProperty(FFrame&, void* const)
native function ApplyToProperty(Actor Target, int nPropertyId, float fProratedAmount, optional bool bRemove = false);

// Export UTgEffectModifyDeployable::execGetProratedValue(FFrame&, void* const)
native function float GetProratedValue();

// Export UTgEffectModifyDeployable::execRemove(FFrame&, void* const)
native function Remove(Actor Target, optional bool bResetToFollow);

// Export UTgEffectModifyDeployable::execGetTargetProperty(FFrame&, void* const)
native function TgProperty GetTargetProperty(Actor Target, int nPropertyId);
