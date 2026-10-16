class TgDeviceFire_Reversal extends TgDeviceFire;

event SubmitEffect(ImpactInfo Impact, TgEffectGroup EffectGroup, optional bool bRemove, optional int StackCount = 1, optional Actor InstigatorOverride)
{
    local TgEffectDamage DamageEffect;
    local TgProj_Reversal ReversalProjectile;
    local int oldDamage, I;

    // End:0x1CE
    if(((Impact.Projectile != none) && EffectGroup != none) && EffectGroup.m_nType == 264)
    {
        I = 0;
        J0x6F:

        // End:0x11E [Loop If]
        if(I < EffectGroup.m_Effects.Length)
        {
            DamageEffect = TgEffectDamage(EffectGroup.m_Effects[I]);
            // End:0x110
            if(DamageEffect != none)
            {
                oldDamage = int(DamageEffect.m_fBase);
            }
            ++I;
            // [Loop Continue]
            goto J0x6F;
        }
        // End:0x1CE
        if(DamageEffect != none)
        {
            ReversalProjectile = TgProj_Reversal(Impact.Projectile);
            // End:0x1CE
            if(ReversalProjectile != none)
            {
                // End:0x1CE
                if(ReversalProjectile.m_fDamageOverride > float(0))
                {
                    DamageEffect.m_fBase = ReversalProjectile.m_fDamageOverride;
                }
            }
        }
    }
    super.SubmitEffect(Impact, EffectGroup, bRemove, StackCount);
    // End:0x237
    if(DamageEffect != none)
    {
        DamageEffect.m_fBase = float(oldDamage);
    }
    //return;    
}
