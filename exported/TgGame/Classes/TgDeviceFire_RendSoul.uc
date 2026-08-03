class TgDeviceFire_RendSoul extends TgDeviceFire
    native(ChampOracle);

var int s_nStacksConsumed;

// Export UTgDeviceFire_RendSoul::execCustomFire(FFrame&, void* const)
native function CustomFire();

event SubmitEffect(ImpactInfo Impact, TgEffectGroup EffectGroup, optional bool bRemove, optional int StackCount = 1, optional Actor InstigatorOverride)
{
    local TgEffectHeal HealEffect;
    local int oldHeal, I;

    // End:0x125
    if((EffectGroup != none) && EffectGroup.m_nType == 10681)
    {
        I = 0;
        J0x4B:

        // End:0x125 [Loop If]
        if(I < EffectGroup.m_Effects.Length)
        {
            HealEffect = TgEffectHeal(EffectGroup.m_Effects[I]);
            // End:0x117
            if(HealEffect != none)
            {
                oldHeal = int(HealEffect.m_fBase);
                HealEffect.m_fBase *= float(s_nStacksConsumed);
            }
            ++I;
            // [Loop Continue]
            goto J0x4B;
        }
    }
    super.SubmitEffect(Impact, EffectGroup, bRemove, StackCount);
    // End:0x18E
    if(HealEffect != none)
    {
        HealEffect.m_fBase = float(oldHeal);
    }
    //return;    
}

event bool IsAgonyActive()
{
    return (GetCustomValue1()) > 0.0000000;
    //return ReturnValue;    
}

event bool IsSoulCollectorActive()
{
    return (GetCustomValue2()) > 0.0000000;
    //return ReturnValue;    
}

defaultproperties
{
    m_bCanTriggerCounter=false
}