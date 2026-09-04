class TgDeviceFire_SelfResurrection extends TgDeviceFire;

event SubmitEffect(ImpactInfo Impact, TgEffectGroup EffectGroup, optional bool bRemove, optional int StackCount = 1, optional Actor InstigatorOverride)
{
    local TgPawn_Lazarus pLazarus;

    // End:0xD3
    if(EffectGroup.m_nEffectGroupId == 60153)
    {
        pLazarus = TgPawn_Lazarus(m_Owner.Instigator);
        // End:0xD3
        if(pLazarus != none)
        {
            super.SubmitEffect(Impact, EffectGroup, bRemove, StackCount, pLazarus.m_Killer.Pawn);
            return;
        }
    }
    super.SubmitEffect(Impact, EffectGroup, bRemove, StackCount, InstigatorOverride);
    //return;    
}
