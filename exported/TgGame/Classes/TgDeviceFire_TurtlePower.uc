class TgDeviceFire_TurtlePower extends TgDeviceFire;

event SubmitEffect(ImpactInfo Impact, TgEffectGroup EffectGroup, optional bool bRemove, optional int StackCount = 1, optional Actor InstigatorOverride)
{
    local TgEffect maxHealthEffect;
    local TgPawn PawnTarget;
    local int I;

    // End:0xFC
    if((EffectGroup != none) && Impact.HitActor != none)
    {
        I = 0;
        J0x45:

        // End:0xFC [Loop If]
        if(I < EffectGroup.m_Effects.Length)
        {
            // End:0xEE
            if(EffectGroup.m_Effects[I].m_nPropertyId == 304)
            {
                maxHealthEffect = EffectGroup.m_Effects[I];
                // [Explicit Break]
                goto J0xFC;
            }
            ++I;
            // [Loop Continue]
            goto J0x45;
        }
    }
    J0xFC:

    super.SubmitEffect(Impact, EffectGroup, bRemove, StackCount);
    // End:0x1CA
    if(maxHealthEffect != none)
    {
        PawnTarget = TgPawn(Impact.HitActor);
        // End:0x1CA
        if((PawnTarget != none) && !bRemove)
        {
            PawnTarget.SetHealth(int(PawnTarget.GetMaxHealth()));
        }
    }
    //return;    
}
