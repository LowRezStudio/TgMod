class TgEffectDamage_AstroDOT extends TgEffectDamage
    native(Effects);

struct native EffectInstanceInfo
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
var native Pointer m_EffectInfo;

// Export UTgEffectDamage_AstroDOT::execApplyEffect(FFrame&, void* const)
native function bool ApplyEffect(Actor Target, optional ImpactInfo Impact, optional bool bLatent);

// Export UTgEffectDamage_AstroDOT::execAddDamageStamp(FFrame&, void* const)
native function AddDamageStamp(float Damage);

// Export UTgEffectDamage_AstroDOT::execCloneEffect(FFrame&, void* const)
native function TgEffect CloneEffect();

// Export UTgEffectDamage_AstroDOT::execInitializeEffectInfo(FFrame&, void* const)
native function InitializeEffectInfo();

defaultproperties
{
    m_bCanBeBuffed=false
}