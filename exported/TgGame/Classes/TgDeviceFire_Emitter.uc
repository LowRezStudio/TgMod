class TgDeviceFire_Emitter extends TgDeviceFire;

event SubmitEffect(ImpactInfo Impact, TgEffectGroup EffectGroup, optional bool bRemove, optional int StackCount = 1, optional Actor InstigatorOverride)
{
    local TgPawn HittingPawn;
    local TgDevice_Emitter EmitterDevice;
    local array<TgEffect> Effects;
    local array<float> oldValues;
    local int I;

    // End:0x300
    if((EffectGroup != none) && EffectGroup.m_nType == 10036)
    {
        // End:0x300
        if(((m_Owner != none) && m_Owner.Instigator != none) && Impact.HitActor != none)
        {
            HittingPawn = TgPawn(m_Owner.Instigator);
            // End:0x300
            if(HittingPawn != none)
            {
                EmitterDevice = TgDevice_Emitter(HittingPawn.GetDeviceByClass(Class'TgGame.TgDevice_Emitter'));
                // End:0x300
                if((EmitterDevice != none) && EmitterDevice.m_bHasProjector)
                {
                    I = 0;
                    J0x152:

                    // End:0x300 [Loop If]
                    if(I < EffectGroup.m_Effects.Length)
                    {
                        // End:0x2F2
                        if(EffectGroup.m_Effects[I] != none)
                        {
                            Effects.AddItem(EffectGroup.m_Effects[I]);
                            oldValues.AddItem(EffectGroup.m_Effects[I].m_fBase);
                            // End:0x2F2
                            if((EmitterDevice.m_fProjectorPercent > 0.0000000) && m_Owner.Instigator != Impact.HitActor)
                            {
                                EffectGroup.m_Effects[I].m_fBase *= EmitterDevice.m_fProjectorPercent;
                            }
                        }
                        ++I;
                        // [Loop Continue]
                        goto J0x152;
                    }
                }
            }
        }
    }
    super.SubmitEffect(Impact, EffectGroup, bRemove, StackCount);
    // End:0x3C6
    if(Effects.Length > 0)
    {
        I = 0;
        J0x34B:

        // End:0x3C6 [Loop If]
        if(I < Effects.Length)
        {
            // End:0x3B8
            if(Effects[I] != none)
            {
                Effects[I].m_fBase = oldValues[I];
            }
            ++I;
            // [Loop Continue]
            goto J0x34B;
        }
    }
    //return;    
}
