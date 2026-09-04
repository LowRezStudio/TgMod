class TgDevice_SelfResurrection extends TgDevice
    native(ChampLazarus)
    hidecategories(Navigation);

enum ResurrectionState
{
    RS_NONE,                        // 0
    RS_STANDBY,                     // 1
    RS_BUILDUP,                     // 2
    RS_ACTIVE,                      // 3
    RS_END,                         // 4
    RS_MAX                          // 5
};

var repnotify TgDevice_SelfResurrection.ResurrectionState r_mCurrentState;

replication
{
    // Pos:0x000
    if((int(Role) == int(ROLE_Authority)) && bNetDirty)
        r_mCurrentState;
}

// Export UTgDevice_SelfResurrection::execCanFiringBeLocked(FFrame&, void* const)
native function bool CanFiringBeLocked();

// Export UTgDevice_SelfResurrection::execCanFireWhileMounted(FFrame&, void* const)
native function bool CanFireWhileMounted();

// Export UTgDevice_SelfResurrection::execCanDeviceFireNow(FFrame&, void* const)
native function bool CanDeviceFireNow(byte FireModeNum, AimData Aim, bool bDeviceFailLog, out TgObject.EDeviceFailType failType);

// Export UTgDevice_SelfResurrection::execEnterBuildupState(FFrame&, void* const)
native function EnterBuildupState();

// Export UTgDevice_SelfResurrection::execSuicide(FFrame&, void* const)
native function Suicide();

// Export UTgDevice_SelfResurrection::execFinishResurrection(FFrame&, void* const)
native function FinishResurrection();

// Export UTgDevice_SelfResurrection::execApplyActiveEffects(FFrame&, void* const)
native function ApplyActiveEffects();

// Export UTgDevice_SelfResurrection::execUpdateState(FFrame&, void* const)
native function UpdateState(byte NewState);

// Export UTgDevice_SelfResurrection::execOnBecomeActive(FFrame&, void* const)
native function OnBecomeActive();

simulated event ReplicatedEvent(name VarName)
{
    switch(VarName)
    {
        // End:0x35
        case 'r_mCurrentState':
            UpdateState(r_mCurrentState);
            // End:0x4B
            break;
        // End:0xFFFF
        default:
            super.ReplicatedEvent(VarName);
            break;
    }
    //return;    
}

simulated function bool ShouldInterruptMount()
{
    return false;
    //return ReturnValue;    
}

simulated event bool CanBeCanceled()
{
    return false;
    //return ReturnValue;    
}

simulated event bool CanBeInterrupted()
{
    return false;
    //return ReturnValue;    
}

simulated function FireAmmunition()
{
    local TgPawn_Lazarus pLazarus;

    super.FireAmmunition();
    pLazarus = TgPawn_Lazarus(Instigator);
    // End:0xAA
    if(int(r_mCurrentState) == int(2))
    {
        pLazarus.TermRagdoll();
        // End:0xAA
        if(int(Role) == int(ROLE_Authority))
        {
            ClearTimer('Suicide');
            UpdateState(ROLE_Authority);
            ApplyActiveEffects();
            SetTimer(3.0000000, false, 'FinishResurrection');
        }
    }
    //return;    
}

simulated function bool ShouldConsumePowerPoolOnStartFire()
{
    return false;
    //return ReturnValue;    
}

simulated function bool ShouldConsumePowerPoolAfterFire()
{
    return false;
    //return ReturnValue;    
}

simulated state DeviceFiring
{
    simulated function StopFiringLogic()
    {
        local TgPawn_Lazarus pLazarus;

        super.StopFiringLogic();
        pLazarus = TgPawn_Lazarus(Instigator);
        // End:0xA5
        if((int(Role) == int(ROLE_Authority)) && int(r_mCurrentState) == int(0))
        {
            DeviceConsumePowerPool(CurrentFireMode);
            pLazarus.r_bShouldRez = false;
            pLazarus.bNetDirty = true;
        }
        //return;        
    }
    stop;    
}
