class TgDeviceFire_EvieCombo extends TgDeviceFire
    native(ChampEvie)
    config(Engine);

var float m_fLifetimeScale;
var float m_fFrigidFieldMinSlow;

event SubmitEffect(ImpactInfo Impact, TgEffectGroup EffectGroup, optional bool bRemove, optional int StackCount=1, optional Actor InstigatorOverride) { }

defaultproperties
{
    m_fLifetimeScale=1.0000000
}
