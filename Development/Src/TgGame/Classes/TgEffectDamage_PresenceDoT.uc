class TgEffectDamage_PresenceDoT extends TgEffectDamage
    native(Effects)
    config(Engine);

struct PresenceDoTInstanceInfo {
    var float fTimestamp;
    var float fDamageValue;
    structdefaultproperties {}
};

var array<float> m_EffectTimeStamps;
var array<float> m_EffectDamageValues;
var native Pointer m_DamageInstances;

native function bool ApplyEffect(Actor Target, optional ImpactInfo Impact, optional bool bLatent);  // Export UTgEffectDamage_PresenceDoT::execApplyEffect(FFrame&, void* const)

native function TgEffect CloneEffect();  // Export UTgEffectDamage_PresenceDoT::execCloneEffect(FFrame&, void* const)
