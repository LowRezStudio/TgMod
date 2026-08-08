class TgEffectDamage_AstroDOT extends TgEffectDamage
    native(Effects)
    config(Engine);

struct EffectInstanceInfo {
    var float fTimestamp;
    var float fDamageValue;
    structdefaultproperties {}
};

var array<float> m_EffectTimeStamps;
var array<float> m_EffectDamageValues;
var native Pointer m_EffectInfo;

native function bool ApplyEffect(Actor Target, optional ImpactInfo Impact, optional bool bLatent);  // Export UTgEffectDamage_AstroDOT::execApplyEffect(FFrame&, void* const)

native function AddDamageStamp(float Damage);  // Export UTgEffectDamage_AstroDOT::execAddDamageStamp(FFrame&, void* const)

native function TgEffect CloneEffect();  // Export UTgEffectDamage_AstroDOT::execCloneEffect(FFrame&, void* const)

native function InitializeEffectInfo();  // Export UTgEffectDamage_AstroDOT::execInitializeEffectInfo(FFrame&, void* const)

defaultproperties
{
    m_bCanBeBuffed=false
}
