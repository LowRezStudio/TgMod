class TgDeviceFire_PoppyBomb extends TgDeviceFire
    config(Engine);

event SubmitEffect(ImpactInfo Impact, TgEffectGroup EffectGroup, optional bool bRemove, optional int StackCount=1, optional Actor InstigatorOverride) { }
