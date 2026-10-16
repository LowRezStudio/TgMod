class TgDeviceFire_KinessaInhand extends TgDeviceFire;

event SubmitEffect(ImpactInfo Impact, TgEffectGroup EffectGroup, optional bool bRemove, optional int StackCount = 1, optional Actor InstigatorOverride)
{
    local TgPawn_Kinessa Kinessa;
    local TgEffectDamage DamageEffect;
    local int oldDamage, I;
    local float chargePercent, maxBonusDamage;

    // End:0x1F3
    if(((m_Owner != none) && EffectGroup != none) && EffectGroup.m_nType == 264)
    {
        I = 0;
        J0x5C:

        // End:0x10B [Loop If]
        if(I < EffectGroup.m_Effects.Length)
        {
            DamageEffect = TgEffectDamage(EffectGroup.m_Effects[I]);
            // End:0xFD
            if(DamageEffect != none)
            {
                oldDamage = int(DamageEffect.m_fBase);
            }
            ++I;
            // [Loop Continue]
            goto J0x5C;
        }
        // End:0x1F3
        if(DamageEffect != none)
        {
            Kinessa = TgPawn_Kinessa(m_Owner.Instigator);
            // End:0x1F3
            if(Kinessa != none)
            {
                maxBonusDamage = GetCustomValue2();
                chargePercent = Kinessa.GetZoomChargePercentage();
                // End:0x1F3
                if((maxBonusDamage > 0.0000000) && chargePercent > 0.0000000)
                {
                    DamageEffect.m_fBase += (chargePercent * maxBonusDamage);
                }
            }
        }
    }
    super.SubmitEffect(Impact, EffectGroup, bRemove, StackCount);
    // End:0x25C
    if(DamageEffect != none)
    {
        DamageEffect.m_fBase = float(oldDamage);
    }
    //return;    
}
