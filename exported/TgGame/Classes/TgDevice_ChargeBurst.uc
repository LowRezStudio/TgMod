class TgDevice_ChargeBurst extends TgDevice
    native(ChampLazarus)
    hidecategories(Navigation);

// Export UTgDevice_ChargeBurst::execCanDeviceFireNow(FFrame&, void* const)
native function bool CanDeviceFireNow(byte FireModeNum, AimData Aim, bool bDeviceFailLog, out TgObject.EDeviceFailType failType);

simulated state DeviceFiring
{
    simulated function StartFiringLogic()
    {
        local TgPawn_Lazarus pLazarus;

        pLazarus = TgPawn_Lazarus(Instigator);
        // End:0x53
        if(pLazarus != none)
        {
            m_nBurstTotalShots = pLazarus.m_nChargeNumber;
        }
        super.StartFiringLogic();
        //return;        
    }

    simulated function StopFiringLogic()
    {
        local TgPawn_Lazarus pLazarus;
        local TgDeviceFire pFireMode;

        pFireMode = GetCurrentFire();
        pLazarus = TgPawn_Lazarus(Instigator);
        // End:0xDD
        if(pLazarus != none)
        {
            // End:0xDD
            if(m_nBurstTotalShots > 1)
            {
                pLazarus.r_fAccumulatedDamage -= (float(m_nBurstTotalShots - 1) * pFireMode.GetCustomValue2());
                pLazarus.UpdateChargeNumber();
                pLazarus.bNetDirty = true;
            }
        }
        //return;        
    }
    stop;    
}

defaultproperties
{
    m_bCarryPreFireToPostFire=false
    m_bUsesBurstFire=true
    m_nBurstTotalShots=1
}