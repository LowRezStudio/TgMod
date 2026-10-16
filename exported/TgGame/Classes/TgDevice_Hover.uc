class TgDevice_Hover extends TgDevice
    native(ChampRuckus)
    hidecategories(Navigation);

// Export UTgDevice_Hover::execCanBeCrippled(FFrame&, void* const)
native function bool CanBeCrippled();

simulated event bool ShouldLockFiring(TgDevice Current)
{
    // End:0xB6
    if(super.ShouldLockFiring(Current))
    {
        // End:0xB4
        if(Current != none)
        {
            // End:0x52
            if(Current.r_nDeviceId == 11434)
            {
                return false;                
            }
            else
            {
                // End:0x8A
                if(Current.r_nDeviceId == 11460)
                {
                    return !IsInhandOverrideActive();                    
                }
                else
                {
                    // End:0xB4
                    if(Current.r_nDeviceId == 14582)
                    {
                        return false;
                    }
                }
            }
        }
        return true;
    }
    return false;
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

simulated event bool CanBeInterrupted()
{
    return super.CanBeInterrupted() || IsInState('DeviceFiring');
    //return ReturnValue;    
}

function OnCripple()
{
    InterruptFiring();
    //return;    
}

simulated state DeviceFiring
{
    simulated function StartFiringLogic()
    {
        local TgDeviceFire FireMode;
        local TgPawn_Ruckus Ruckus;

        Ruckus = TgPawn_Ruckus(Instigator);
        // End:0x248
        if(Ruckus != none)
        {
            Ruckus.bHoverWallClimb = false;
            FireMode = GetCurrentFire();
            // End:0x248
            if(FireMode != none)
            {
                Ruckus.m_fDesiredHeight = ((FireMode.GetCustomValue1() > 0.0000000) ? FireMode.GetCustomValue1() * float(16) : Ruckus.m_fDesiredHeight);
                Ruckus.m_fKx = ((FireMode.GetCustomValue2() > 0.0000000) ? FireMode.GetCustomValue2() : Ruckus.m_fKx);
                Ruckus.m_fKv = ((FireMode.GetCustomValue3() >= 0.0000000) ? FireMode.GetCustomValue3() : Ruckus.m_fKv);
                Ruckus.m_fHoverAccelMultiplier = FireMode.GetCustomValue4();
            }
        }
        super.StartFiringLogic();
        //return;        
    }

    simulated function EndState(name NextStateName)
    {
        local TgPawn_Ruckus Ruckus;

        Ruckus = TgPawn_Ruckus(Instigator);
        // End:0x4F
        if(Ruckus != none)
        {
            Ruckus.m_fHoverAccelMultiplier = 1.0000000;
        }
        super.EndState(NextStateName);
        // End:0xA8
        if(Instigator != none)
        {
            Instigator.Velocity.Z = 0.0000000;
        }
        //return;        
    }
    stop;    
}

defaultproperties
{
    m_bPostFireShouldInterruptStealth=false
}