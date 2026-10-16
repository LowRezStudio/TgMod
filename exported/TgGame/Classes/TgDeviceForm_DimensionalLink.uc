class TgDeviceForm_DimensionalLink extends TgDeviceForm;

var TgPawn_Ying m_CachedYingPawn;

event Fire(Vector HitLocation, int nFireMode, optional int nEquipSlot = 0, optional int nSocketIndex = 0, optional bool bSuccessfulHit = false, optional float fRefireTime)
{
    local int I;

    super.Fire(HitLocation, nFireMode, nEquipSlot, nSocketIndex, bSuccessfulHit, fRefireTime);
    // End:0x62
    if(!HasCachedYingPawn())
    {
        return;
    }
    // End:0x9E
    if(m_CachedYingPawn != none)
    {
        m_CachedYingPawn.FxReactivateGroupBody('YingDimensionalLink', 0);
    }
    // End:0x185
    if(m_CachedYingPawn.PopulateActiveDecoyList())
    {
        I = 0;
        J0xCC:

        // End:0x185 [Loop If]
        if(I < m_CachedYingPawn.m_ActiveIllusions.Length)
        {
            // End:0x177
            if(NotEqual_InterfaceInterface(m_CachedYingPawn.m_ActiveIllusions[I], TgInterface_YingIllusion(none)))
            {
                m_CachedYingPawn.m_ActiveIllusions[I].PlayDimensionalLinkFX();
            }
            I++;
            // [Loop Continue]
            goto J0xCC;
        }
    }
    //return;    
}

simulated function bool HasCachedYingPawn()
{
    // End:0x38
    if(m_CachedYingPawn == none)
    {
        m_CachedYingPawn = TgPawn_Ying(PawnOwner);
        return m_CachedYingPawn != none;
    }
    return true;
    //return ReturnValue;    
}
