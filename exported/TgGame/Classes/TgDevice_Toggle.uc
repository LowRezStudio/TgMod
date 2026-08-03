class TgDevice_Toggle extends TgDevice
    native(Devices)
    hidecategories(Navigation);

var bool m_bIsToggle;

// Export UTgDevice_Toggle::execUpdateUIToggleState(FFrame&, void* const)
native function UpdateUIToggleState();

// Export UTgDevice_Toggle::execCanDeviceFireNow(FFrame&, void* const)
native function bool CanDeviceFireNow(byte FireModeNum, AimData Aim, bool bDeviceFailLog, out TgObject.EDeviceFailType failType);

simulated function bool CanDeviceFireInTargetingMode()
{
    return true;
    //return ReturnValue;    
}

simulated function FireAmmunition()
{
    // End:0x19
    if(r_Deployable == none)
    {
        super.FireAmmunition();
    }
    //return;    
}

simulated event bool StartFire()
{
    // End:0x0D
    if(LogDebugInfo())
    {
    }
    // End:0x3B
    if((IsFiring()) && m_nDeviceType != 11077)
    {
        StopFire();
        return true;
    }
    return super.StartFire();
    //return ReturnValue;    
}

simulated function ConsumeAmmoFromFiring(optional int nAmmoConsumptionOverride = -1, optional int nFireRequestIDOverride = -1)
{
    //return;    
}

simulated event bool IsToggleDevice()
{
    return m_bIsToggle;
    //return ReturnValue;    
}

simulated function bool ShouldInterruptReload()
{
    return false;
    //return ReturnValue;    
}

simulated state DeviceFiring
{
    simulated function RefireCheckTimer()
    {
        bPendingFire = true;
        super(TgDevice).RefireCheckTimer();
        //return;        
    }

    simulated function BeginState(name PrevStateName)
    {
        UpdateUIToggleState();
        super.BeginState(PrevStateName);
        //return;        
    }

    simulated function EndState(name NextStateName)
    {
        super.EndState(NextStateName);
        // End:0x4C
        if(r_Deployable != none)
        {
            r_Deployable.SpawningDeviceToggledOff();
            r_Deployable = none;
        }
        ConsumeAmmo();
        SetTimer(0.1000000, false, 'UpdateUIToggleState');
        //return;        
    }
    stop;    
}

defaultproperties
{
    m_bIsToggle=true
    m_bPostFireShouldInterruptStealth=false
}