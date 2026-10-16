class TgDevice_Shatter extends TgDevice
    native(ChampYing)
    hidecategories(Navigation);

var TgPawn_Ying m_CachedYingPawn;

// Export UTgDevice_Shatter::execCanDeviceFireNow(FFrame&, void* const)
native function bool CanDeviceFireNow(byte FireModeNum, AimData Aim, bool bDeviceFailLog, out TgObject.EDeviceFailType failType);

simulated function CustomFire()
{
    local int I;
    local float fTimeUntilShatter;
    local TgDeviceFire FireMode;
    local byte bHasShatterableIllusions;

    // End:0x56
    if((!HasYingPawn() || !m_CachedYingPawn.PopulateActiveDecoyList(bHasShatterableIllusions)) || int(bHasShatterableIllusions) == int(0))
    {
        return;
    }
    FireMode = GetCurrentFire();
    // End:0xA2
    if(FireMode != none)
    {
        fTimeUntilShatter = FireMode.GetCustomValue1();
    }
    I = 0;
    J0xAD:

    // End:0x130 [Loop If]
    if(I < m_CachedYingPawn.m_ActiveIllusions.Length)
    {
        m_CachedYingPawn.m_ActiveIllusions[I].TriggerShatter(fTimeUntilShatter);
        I++;
        // [Loop Continue]
        goto J0xAD;
    }
    //return;    
}

simulated function bool HasYingPawn()
{
    // End:0x2B
    if(m_CachedYingPawn == none)
    {
        m_CachedYingPawn = TgPawn_Ying(Owner);
    }
    return m_CachedYingPawn != none;
    //return ReturnValue;    
}
