class TgDeviceFire_MirrorDamageToHeal extends TgDeviceFire
    native(Devices);

var float m_fHealAmount;

event SubmitEffect(ImpactInfo Impact, TgEffectGroup EffectGroup, optional bool bRemove, optional int StackCount = 1, optional Actor InstigatorOverride)
{
    local TgEffectHeal HealEffect;
    local int oldHeal, I;

    // End:0x15A
    if((((m_fHealAmount > 0.0000000) && m_Owner != none) && EffectGroup != none) && EffectGroup.m_nType == 264)
    {
        I = 0;
        J0x71:

        // End:0x123 [Loop If]
        if(I < EffectGroup.m_Effects.Length)
        {
            HealEffect = TgEffectHeal(EffectGroup.m_Effects[I]);
            // End:0x115
            if(HealEffect != none)
            {
                oldHeal = int(HealEffect.m_fBase);
                // [Explicit Break]
                goto J0x123;
            }
            ++I;
            // [Loop Continue]
            goto J0x71;
        }
        J0x123:

        // End:0x15A
        if(HealEffect != none)
        {
            HealEffect.m_fBase = m_fHealAmount;
        }
    }
    super.SubmitEffect(Impact, EffectGroup, bRemove, StackCount);
    // End:0x1C3
    if(HealEffect != none)
    {
        HealEffect.m_fBase = float(oldHeal);
    }
    //return;    
}
