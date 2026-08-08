class TgEffectModifyProperty extends TgEffect
    abstract
    native(Effects)
    config(Engine);

var TgDeviceFire m_TargetDeviceFire;
var int m_eEquipPointTarget;
var array<float> m_fStaticValueOffsets;

native function bool CanBeApplied(Actor Target);  // Export UTgEffectModifyProperty::execCanBeApplied(FFrame&, void* const)

native function SetProperty(Actor Target, int nPropertyId, float fNewValue);  // Export UTgEffectModifyProperty::execSetProperty(FFrame&, void* const)

native function bool ApplyEffect(Actor Target, optional ImpactInfo Impact, optional bool bLatent);  // Export UTgEffectModifyProperty::execApplyEffect(FFrame&, void* const)

native function ApplyToProperty(Actor Target, int nPropertyId, float fProratedAmount, optional bool bRemove=false);  // Export UTgEffectModifyProperty::execApplyToProperty(FFrame&, void* const)

native function Remove(Actor Target, optional bool bResetToFollow);  // Export UTgEffectModifyProperty::execRemove(FFrame&, void* const)

native function TgProperty GetTargetProperty(Actor Target, int nPropertyId);  // Export UTgEffectModifyProperty::execGetTargetProperty(FFrame&, void* const)

defaultproperties
{
    m_bApplyToProperty=true
}
