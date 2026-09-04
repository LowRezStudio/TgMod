class TgDevice_NetherStep extends TgDevice_DoubleCharge
    native(ChampAndroxus)
    hidecategories(Navigation);

// Export UTgDevice_NetherStep::execGetTargetingAim(FFrame&, void* const)
native function GetTargetingAim(out AimData Aim);

// Export UTgDevice_NetherStep::execShouldInterruptStealth(FFrame&, void* const)
native function bool ShouldInterruptStealth();

// Export UTgDevice_NetherStep::execSetFireMode(FFrame&, void* const)
native function SetFireMode(int nFireModeNum, optional bool ForceSet = false);

simulated event bool ShouldLockFiring(TgDevice Current)
{
    // End:0x2A
    if(Current.m_nDeviceType == 11077)
    {
        return false;
    }
    return m_bCharging;
    //return ReturnValue;    
}

simulated function int GetTotalNumberOfShots()
{
    local int nTotalNumShots;
    local TgDeviceFire deviceFire;

    nTotalNumShots = 0;
    deviceFire = GetCurrentFire();
    // End:0x59
    if(deviceFire != none)
    {
        nTotalNumShots = int(deviceFire.GetCustomValue1());
    }
    return nTotalNumShots;
    //return ReturnValue;    
}

simulated event bool CanFiringBeCanceledByLeftMouse()
{
    return false;
    //return ReturnValue;    
}

simulated event bool CanFiringBeCanceledByRightMouse()
{
    return false;
    //return ReturnValue;    
}

simulated event bool CanFiringBeCanceledByReactivation()
{
    return false;
    //return ReturnValue;    
}

simulated state DeviceFiring
{
    simulated event EndCharge()
    {
        local TgDeviceFire deviceFire;

        super.EndCharge();
        // End:0x87
        if(Instigator != none)
        {
            Instigator.Velocity.X = 0.0000000;
            Instigator.Velocity.Y = 0.0000000;
        }
        // End:0xED
        if(m_nShotsFired < (GetTotalNumberOfShots()))
        {
            deviceFire = GetCurrentFire();
            // End:0xED
            if(deviceFire != none)
            {
                deviceFire.ApplyHitSpecial(Instigator);
            }
        }
        //return;        
    }
    stop;    
}

defaultproperties
{
    m_nTotalNumShots=3
    m_bSetAsTargetingDeviceForMultiFire=false
    m_bStopOnHitType=ChargeStopOnHitType.CSHT_GodOnly
    m_bUsePhysFlying=true
    m_DeviceTimerBarType=DeviceTimerBarType.DTBT_RefireTime
    s_bIgnoreReceivedAim=true
    m_bForce3PViewWhileFiring=false
}