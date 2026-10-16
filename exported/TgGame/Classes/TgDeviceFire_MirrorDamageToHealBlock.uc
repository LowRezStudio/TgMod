class TgDeviceFire_MirrorDamageToHealBlock extends TgDeviceFire
    native(Devices);

var float m_fHealBlockAmount;

event SubmitEffect(ImpactInfo Impact, TgEffectGroup EffectGroup, optional bool bRemove, optional int StackCount = 1, optional Actor InstigatorOverride)
{
    local TgEffect HealBlockEffect;
    local int oldHealBlock, I;

    // End:0x189
    if((((m_fHealBlockAmount > 0.0000000) && m_Owner != none) && EffectGroup != none) && EffectGroup.m_nType == 264)
    {
        I = 0;
        J0x71:

        // End:0x152 [Loop If]
        if(I < EffectGroup.m_Effects.Length)
        {
            // End:0x144
            if(EffectGroup.m_Effects[I].m_nPropertyId == 1877)
            {
                HealBlockEffect = EffectGroup.m_Effects[I];
                oldHealBlock = int(HealBlockEffect.m_fBase);
                // [Explicit Break]
                goto J0x152;
            }
            ++I;
            // [Loop Continue]
            goto J0x71;
        }
        J0x152:

        // End:0x189
        if(HealBlockEffect != none)
        {
            HealBlockEffect.m_fBase = m_fHealBlockAmount;
        }
    }
    super.SubmitEffect(Impact, EffectGroup, bRemove, StackCount);
    // End:0x1F2
    if(HealBlockEffect != none)
    {
        HealBlockEffect.m_fBase = float(oldHealBlock);
    }
    //return;    
}
