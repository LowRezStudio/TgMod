class TgDeviceFire_MirrorDamageToHeal extends TgDeviceFire
    native(Devices)
    config(Engine);

var float m_fHealAmount;

event SubmitEffect(ImpactInfo Impact, TgEffectGroup EffectGroup, optional bool bRemove, optional int StackCount=1, optional Actor InstigatorOverride) { }
