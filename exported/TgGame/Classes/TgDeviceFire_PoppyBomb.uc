class TgDeviceFire_PoppyBomb extends TgDeviceFire;

event SubmitEffect(ImpactInfo Impact, TgEffectGroup EffectGroup, optional bool bRemove, optional int StackCount = 1, optional Actor InstigatorOverride)
{
    local TgEffect KnockupEffect;
    local float oldKnockup;
    local int I;
    local TgPawn_BombKing BombKing;

    // End:0x21B
    if((((m_Owner != none) && m_Owner.Instigator != none) && EffectGroup != none) && EffectGroup.m_nType == 264)
    {
        I = 0;
        J0x82:

        // End:0x15E [Loop If]
        if(I < EffectGroup.m_Effects.Length)
        {
            // End:0x150
            if(EffectGroup.m_Effects[I].m_nPropertyId == 1507)
            {
                KnockupEffect = EffectGroup.m_Effects[I];
                oldKnockup = KnockupEffect.m_fBase;
            }
            ++I;
            // [Loop Continue]
            goto J0x82;
        }
        // End:0x21B
        if(KnockupEffect != none)
        {
            BombKing = TgPawn_BombKing(m_Owner.Instigator);
            // End:0x21B
            if(BombKing != none)
            {
                // End:0x21B
                if(EffectGroup.m_nTargetType != 214)
                {
                    KnockupEffect.m_fBase += (oldKnockup * BombKing.r_fJoltKnockback);
                }
            }
        }
    }
    super.SubmitEffect(Impact, EffectGroup, bRemove, StackCount);
    // End:0x282
    if(KnockupEffect != none)
    {
        KnockupEffect.m_fBase = oldKnockup;
    }
    //return;    
}
