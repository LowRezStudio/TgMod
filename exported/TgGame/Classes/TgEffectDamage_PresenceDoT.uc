class TgEffectDamage_PresenceDoT extends TgEffectDamage
    native(Effects);

struct native PresenceDoTInstanceInfo
{
    var float fTimestamp;
    var float fDamageValue;

    structdefaultproperties
    {
        fTimestamp=0.0000000
        fDamageValue=0.0000000
    }
};

var array<float> m_EffectTimeStamps;
var array<float> m_EffectDamageValues;
var native Pointer m_DamageInstances;

// Export UTgEffectDamage_PresenceDoT::execApplyEffect(FFrame&, void* const)
native function bool ApplyEffect(Actor Target, optional ImpactInfo Impact, optional bool bLatent);

// Export UTgEffectDamage_PresenceDoT::execCloneEffect(FFrame&, void* const)
native function TgEffect CloneEffect();
