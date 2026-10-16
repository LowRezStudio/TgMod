class TgDeviceFire_RendSoul extends TgDeviceFire
    native(ChampOracle)
    config(Engine);

var int s_nStacksConsumed;

native function CustomFire();  // Export UTgDeviceFire_RendSoul::execCustomFire(FFrame&, void* const)

event SubmitEffect(ImpactInfo Impact, TgEffectGroup EffectGroup, optional bool bRemove, optional int StackCount=1, optional Actor InstigatorOverride) { }

event bool IsAgonyActive() { }

event bool IsSoulCollectorActive() { }

defaultproperties
{
    m_bCanTriggerCounter=false
}
