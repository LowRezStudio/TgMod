class TgDevice_Barrage extends TgDevice
    native(ChampViktor)
    hidecategories(Navigation);

var TgDevice_BarrageFire m_BarrageFireDevice;

// Export UTgDevice_Barrage::execGetRequiredEnergyToFire(FFrame&, void* const)
native function float GetRequiredEnergyToFire();

// Export UTgDevice_Barrage::execCanDeviceFireNow(FFrame&, void* const)
native function bool CanDeviceFireNow(byte FireModeNum, AimData Aim, bool bDeviceFailLog, out TgObject.EDeviceFailType failType);

// Export UTgDevice_Barrage::execUsesTargetingMode(FFrame&, void* const)
native function bool UsesTargetingMode();

// Export UTgDevice_Barrage::execTickTargetingMode(FFrame&, void* const)
native function TickTargetingMode(float DeltaSeconds);

// Export UTgDevice_Barrage::execExitTargetingMode(FFrame&, void* const)
native function ExitTargetingMode();

simulated event bool CanBeCanceled()
{
    // End:0x61
    if(super.CanBeCanceled())
    {
        // End:0x5F
        if((IsTimerActive('FirePreHitDelay') || IsTimerActive('LastShotCancelTimer')) || GetTimerCount('FirePostHitDelay') < 0.2000000)
        {
            return false;
        }
        return true;
    }
    return false;
    //return ReturnValue;    
}

simulated function CustomFire()
{
    local AimData Aim;

    UpdateIndex();
    GetCachedAim(Aim);
    TgPawn(Instigator).FlashFire(r_nDeviceInstanceId, int(CurrentFireMode), Aim.EndTrace, int(r_eEquippedAt), m_nSocketIndex, false, GetRefireTime());
    // End:0x10A
    if(c_DeviceForm != none)
    {
        c_DeviceForm.Fire(Aim.EndTrace, int(CurrentFireMode), int(r_eEquippedAt), m_nSocketIndex, false, GetRefireTime());
    }
    // End:0x13E
    if(int(Role) == int(ROLE_Authority))
    {
        GetCurrentFire().CustomFire();
    }
    //return;    
}

simulated function bool ShouldConsumePowerPoolOnStartFire()
{
    return true;
    //return ReturnValue;    
}

// Export UTgDevice_Barrage::execCanFireIfLeftMouseDown(FFrame&, void* const)
native function bool CanFireIfLeftMouseDown();

simulated event bool ShouldInterruptReloadOnFire()
{
    return true;
    //return ReturnValue;    
}

simulated event bool ShouldLockFiring(TgDevice Current)
{
    // End:0x2A
    if((Current != none) && Current == m_BarrageFireDevice)
    {
        return false;
    }
    // End:0x87
    if(!super.ShouldLockFiring(Current))
    {
        return (IsFiring()) || (WorldInfo.TimeSeconds - m_EndOfLastFireTimeStamp) < (GetLockoutExtensionTime());
    }
    return true;
    //return ReturnValue;    
}

simulated function float GetLockoutExtensionTime()
{
    return GetCurrentFire().GetCustomValue1();
    //return ReturnValue;    
}

simulated event bool CanBeInterrupted()
{
    return super.CanBeInterrupted() || IsFiring();
    //return ReturnValue;    
}

simulated function LastShotCancelTimer()
{
    // End:0x35
    if(IsTimerActive('FirePostHitDelay'))
    {
        ClearTimer('FirePostHitDelay');
        FirePostHitDelay();
    }
    //return;    
}

simulated function bool IsToggleDevice()
{
    return true;
    //return ReturnValue;    
}

simulated event LinkedDeviceEquipped(TgDevice Dev)
{
    // End:0x11
    if(Dev == none)
    {
        return;
    }
    super.LinkedDeviceEquipped(Dev);
    switch(Dev.r_nDeviceId)
    {
        // End:0x72
        case 14462:
            m_BarrageFireDevice = TgDevice_BarrageFire(Dev);
            return;
        // End:0xFFFF
        default:
            //return;
            break;
    }    
}

simulated state DeviceFiring
{
    simulated function FirePostHitDelay()
    {
        super.FirePostHitDelay();
        ClearTimer('LastShotCancelTimer');
        //return;        
    }
    stop;    
}

defaultproperties
{
    m_eCastModeOverride=ECastMode.CM_Instant
    c_bUsesTargetingReticle=false
    m_bUseCustomCastMode=true
    m_nLinkedDeviceIDs[0]=14462
}