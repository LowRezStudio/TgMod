class TgDevice_Weightless extends TgDevice
    native(ChampPip)
    hidecategories(Navigation);

var float r_fSprintHorizontalSpeedMod;
var float r_fSprintJumpSpeedMod;

replication
{
    // Pos:0x000
    if(int(Role) == int(ROLE_Authority))
        r_fSprintHorizontalSpeedMod, r_fSprintJumpSpeedMod;
}

// Export UTgDevice_Weightless::execShouldInterruptLift(FFrame&, void* const)
native function bool ShouldInterruptLift();

simulated function float GetHorizontalSpeedMultiplier()
{
    local TgDeviceFire FireMode;

    FireMode = GetCurrentFire();
    // End:0x51
    if(FireMode != none)
    {
        return FMax(FireMode.GetCustomValue1() / 100.0000000, 0.0000000);
    }
    return 0.0000000;
    //return ReturnValue;    
}

simulated function float GetJumpSpeedMultiplier()
{
    local TgDeviceFire FireMode;

    FireMode = GetCurrentFire();
    // End:0x51
    if(FireMode != none)
    {
        return FMax(FireMode.GetCustomValue2() / 100.0000000, 0.0000000);
    }
    return 0.0000000;
    //return ReturnValue;    
}

final simulated function float CalcWeightlessHorizontalMultiplier()
{
    return (1.0000000 + (GetHorizontalSpeedMultiplier())) + r_fSprintHorizontalSpeedMod;
    //return ReturnValue;    
}

final simulated function float CalcWeightlessJumpMultiplier()
{
    return (1.0000000 + (GetJumpSpeedMultiplier())) + r_fSprintJumpSpeedMod;
    //return ReturnValue;    
}

simulated event bool CanBeCanceled()
{
    local float firePostHitTime;

    // End:0x4A
    if(IsTimerActive('FirePostHitDelay'))
    {
        firePostHitTime = GetTimerCount('FirePostHitDelay');
        // End:0x4A
        if(firePostHitTime > 0.5000000)
        {
            return true;
        }
    }
    return false;
    //return ReturnValue;    
}

simulated function bool ShouldInterruptReloadOnFire()
{
    return false;
    //return ReturnValue;    
}

simulated state DeviceFiring
{
    simulated function StartFiringLogic()
    {
        local TgPawn_Pip Pip;

        Pip = TgPawn_Pip(Instigator);
        // End:0x5E
        if(Pip != none)
        {
            Pip.StartWeightless(CalcWeightlessHorizontalMultiplier(), CalcWeightlessJumpMultiplier());
        }
        super.StartFiringLogic();
        //return;        
    }

    simulated function StopFiringLogic()
    {
        local TgPawn_Pip Pip;

        Pip = TgPawn_Pip(Instigator);
        // End:0x4A
        if(Pip != none)
        {
            Pip.EndWeightless();
        }
        super.StopFiringLogic();
        //return;        
    }
    stop;    
}

defaultproperties
{
    m_DeviceTimerBarType=DeviceTimerBarType.DTBT_PostHit
    m_bPostFireShouldInterruptStealth=false
    m_bAbilityRequiresInhandResync=false
}