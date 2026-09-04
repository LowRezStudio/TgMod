class TgEffect extends Object
    native(Effects)
    config(Engine);

const TGCM_NA = 119;

const TGCM_ADD = 67;

const TGCM_SUBTRACT = 70;

const TGCM_PERC_INCREASE = 68;

const TGCM_PERC_DECREASE = 69;

const TGCM_SET = 11042;

const TGCM_SET_PERC = 11043;

const TGCM_ADD_PERC_MAX_HEALTH = 15033;

const TG_ROOT_GROUNDSPEED = 10000;

var TgEffectGroup m_EffectGroup;
var int m_nPropertyId;
var int m_nCalcMethodCode;
var bool m_bUseOnInterval;
var bool m_bRemovable;
var bool m_bAllowStacking;
var bool m_bApplyToProperty;
var int m_nPropertyValueId;
var float m_fCurrent;
var float m_fBase;
var float m_fMinimum;
var float m_fMaximum;
var float m_fScalingFactor;
var float m_fStaticValueOffset;
var float m_MaxKnockbackZ;
var float m_MinKnockbackZ;
var float m_KnockbackZMultiplier;

native function TgEffect CloneEffect();  // Export UTgEffect::execCloneEffect(FFrame&, void* const)

native function bool CanBeApplied(Actor Target);  // Export UTgEffect::execCanBeApplied(FFrame&, void* const)

native function SetProperty(Actor Target, int nPropertyId, float fNewValue);  // Export UTgEffect::execSetProperty(FFrame&, void* const)

native function bool ApplyEffect(Actor Target, optional ImpactInfo Impact, optional bool bLatent);  // Export UTgEffect::execApplyEffect(FFrame&, void* const)

native function bool ApplyStacks(Actor Target, int nNumStacks);  // Export UTgEffect::execApplyStacks(FFrame&, void* const)

native function bool RemoveStacks(Actor Target, int nNumStacks);  // Export UTgEffect::execRemoveStacks(FFrame&, void* const)

native function ApplyToProperty(Actor Target, int nPropertyId, float fProratedAmount, optional bool bRemove=false);  // Export UTgEffect::execApplyToProperty(FFrame&, void* const)

native function float GetProratedValue();  // Export UTgEffect::execGetProratedValue(FFrame&, void* const)

native function Reapply(Actor Target);  // Export UTgEffect::execReapply(FFrame&, void* const)

native function Remove(Actor Target, optional bool bResetToFollow);  // Export UTgEffect::execRemove(FFrame&, void* const)

native function TrackStats(TgPawn Instigator, Actor Target, ImpactInfo Impact, float fDamage, int iTargetDeviceModeId, bool bIsEnemy, optional float fMissingHealth=-1.0000000, optional float fMitigatedDamage=-1.0000000);  // Export UTgEffect::execTrackStats(FFrame&, void* const)

native function int GetTopMostDevice(TgDeviceFire devFire);  // Export UTgEffect::execGetTopMostDevice(FFrame&, void* const)

native function ApplyEnterCombatRules(Actor Instigator, Actor Target);  // Export UTgEffect::execApplyEnterCombatRules(FFrame&, void* const)

native function TgProperty GetTargetProperty(Actor Target, int nPropertyId);  // Export UTgEffect::execGetTargetProperty(FFrame&, void* const)

native function int GetDeviceIdFromMode(TgDeviceFire DeviceFireMode);  // Export UTgEffect::execGetDeviceIdFromMode(FFrame&, void* const)

defaultproperties
{
    m_bRemovable=true
    m_MaxKnockbackZ=600.0000000
    m_MinKnockbackZ=200.0000000
    m_KnockbackZMultiplier=1.3000000
}
