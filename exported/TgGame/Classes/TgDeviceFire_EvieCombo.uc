class TgDeviceFire_EvieCombo extends TgDeviceFire
    native(ChampEvie);

var float m_fLifetimeScale;
var float m_fFrigidFieldMinSlow;

event SubmitEffect(ImpactInfo Impact, TgEffectGroup EffectGroup, optional bool bRemove, optional int StackCount = 1, optional Actor InstigatorOverride)
{
    local TgEffect SlowEffect;
    local float fOldSlow, fNewSlow, fMinSlow;
    local int I;

    // End:0x1C6
    if((EffectGroup != none) && EffectGroup.m_nType == 264)
    {
        I = 0;
        J0x4B:

        // End:0x127 [Loop If]
        if(I < EffectGroup.m_Effects.Length)
        {
            // End:0x119
            if(EffectGroup.m_Effects[I].m_nPropertyId == 1231)
            {
                SlowEffect = EffectGroup.m_Effects[I];
                fOldSlow = SlowEffect.m_fBase;
            }
            ++I;
            // [Loop Continue]
            goto J0x4B;
        }
        // End:0x1C6
        if(SlowEffect != none)
        {
            fMinSlow = FMax(0.0000000, m_fFrigidFieldMinSlow);
            // End:0x1C6
            if(fMinSlow >= 0.0000000)
            {
                fNewSlow = FMax(0.0000000, (fOldSlow - fMinSlow) * m_fLifetimeScale) + fMinSlow;
                SlowEffect.m_fBase = fNewSlow;
            }
        }
    }
    super.SubmitEffect(Impact, EffectGroup, bRemove, StackCount);
    // End:0x22D
    if(SlowEffect != none)
    {
        SlowEffect.m_fBase = fOldSlow;
    }
    //return;    
}

defaultproperties
{
    m_fLifetimeScale=1.0000000
}