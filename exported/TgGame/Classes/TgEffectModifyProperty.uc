class TgEffectModifyProperty extends TgEffect
    abstract
    native(Effects);

var TgDeviceFire m_TargetDeviceFire;
var int m_eEquipPointTarget;
var array<float> m_fStaticValueOffsets;

// Export UTgEffectModifyProperty::execCanBeApplied(FFrame&, void* const)
native function bool CanBeApplied(Actor Target);

// Export UTgEffectModifyProperty::execSetProperty(FFrame&, void* const)
native function SetProperty(Actor Target, int nPropertyId, float fNewValue);

// Export UTgEffectModifyProperty::execApplyEffect(FFrame&, void* const)
native function bool ApplyEffect(Actor Target, optional ImpactInfo Impact, optional bool bLatent);

// Export UTgEffectModifyProperty::execApplyToProperty(FFrame&, void* const)
native function ApplyToProperty(Actor Target, int nPropertyId, float fProratedAmount, optional bool bRemove = false);

// Export UTgEffectModifyProperty::execRemove(FFrame&, void* const)
native function Remove(Actor Target, optional bool bResetToFollow);

// Export UTgEffectModifyProperty::execGetTargetProperty(FFrame&, void* const)
native function TgProperty GetTargetProperty(Actor Target, int nPropertyId);

defaultproperties
{
    m_bApplyToProperty=true
}