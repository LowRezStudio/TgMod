class TgDevice_Prowl extends TgDevice_Stim
    native(ChampBlades)
    hidecategories(Navigation)
    implements(TgDeviceInterface_MoveSpeedMultiplier);

var private native const noexport Pointer VfTable_ITgDeviceInterface_MoveSpeedMultiplier;
//var delegate<InterruptFiringDelegate> __InterruptFiringDelegate__Delegate;

// Export UTgDevice_Prowl::execShouldInterruptLift(FFrame&, void* const)
native function bool ShouldInterruptLift();

simulated event bool CanBeInterrupted()
{
    return true;
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

simulated event bool CanFiringBeCanceledByReactivation()
{
    return true;
    //return ReturnValue;    
}

// Export UTgDevice_Prowl::execGetMoveSpeedMultiplier(FFrame&, void* const)
native function float GetMoveSpeedMultiplier();

simulated delegate InterruptFiringDelegate()
{
    // End:0x1E
    if(int(Role) == int(ROLE_AutonomousProxy))
    {
        ClientInterrupt();
    }
    InterruptFiring();
    //return;    
}

simulated event LinkedDeviceEquipped(TgDevice Dev)
{
    // End:0x11
    if(Dev == none)
    {
        return;
    }
    super(TgDevice).LinkedDeviceEquipped(Dev);
    switch(Dev.r_nDeviceId)
    {
        // End:0x54
        case 16218:
        // End:0x5C
        case 16229:
        // End:0x64
        case 16235:
        // End:0x6C
        case 16241:
        // End:0xA9
        case 16306:
            Dev.RegisterDelegate(2, InterruptFiringDelegate);
            // End:0xAC
            break;
        // End:0xFFFF
        default:
            break;
    }
    //return;    
}

simulated event LinkedDeviceUnequipped(TgDevice Dev)
{
    // End:0x11
    if(Dev == none)
    {
        return;
    }
    super(TgDevice).LinkedDeviceUnequipped(Dev);
    switch(Dev.r_nDeviceId)
    {
        // End:0x54
        case 16218:
        // End:0x5C
        case 16229:
        // End:0x64
        case 16235:
        // End:0x6C
        case 16241:
        // End:0xA9
        case 16306:
            Dev.UnregisterDelegate(2, InterruptFiringDelegate);
            // End:0xAC
            break;
        // End:0xFFFF
        default:
            break;
    }
    //return;    
}

simulated state DeviceFiring
{
    simulated function StartFiringLogic()
    {
        local TgDeviceFire FireMode;
        local TgPawn_Blades Blades;

        Blades = TgPawn_Blades(Instigator);
        // End:0x225
        if(Blades != none)
        {
            FireMode = GetCurrentFire();
            // End:0x225
            if(FireMode != none)
            {
                Blades.r_bProwlActive = true;
                Blades.r_fProwlAccelMultiplier = FireMode.GetCustomValue1();
                Blades.r_fProwlGroundSpeedMultiplier = FireMode.GetCustomValue2();
                Blades.r_fProwlJumpHeightMultiplier = FireMode.GetCustomValue3();
                Blades.r_fProwlAirControlMultiplier = FireMode.GetCustomValue4();
                Blades.r_fProwlFadeOutDuration = FireMode.GetCustomValue5();
                Blades.m_fProwlFadeOutTimer = FireMode.GetCustomValue5();
                Blades.bNetDirty = true;
                Blades.SetGemEmissiveAnim(3);
            }
        }
        super.StartFiringLogic();
        //return;        
    }

    simulated function EndState(name NextStateName)
    {
        local TgPawn_Blades Blades;

        Blades = TgPawn_Blades(Instigator);
        // End:0x8E
        if(Blades != none)
        {
            Blades.r_bProwlActive = false;
            Blades.bNetDirty = true;
            Blades.SetGemEmissiveEndAnim(3);
        }
        super.EndState(NextStateName);
        //return;        
    }
    stop;    
}

defaultproperties
{
    m_nLinkedDeviceIDs[0]=16218
    m_nLinkedDeviceIDs[1]=16229
    m_nLinkedDeviceIDs[2]=16235
    m_nLinkedDeviceIDs[3]=16241
    m_nLinkedDeviceIDs[4]=16306
}