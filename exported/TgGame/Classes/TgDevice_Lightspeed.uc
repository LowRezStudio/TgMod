class TgDevice_Lightspeed extends TgDevice
    native(ChampAstro)
    hidecategories(Navigation)
    implements(TgDeviceInterface_MoveSpeedMultiplier);

var private native const noexport Pointer VfTable_ITgDeviceInterface_MoveSpeedMultiplier;

// Export UTgDevice_Lightspeed::execGetMoveSpeedMultiplier(FFrame&, void* const)
native function float GetMoveSpeedMultiplier();

// Export UTgDevice_Lightspeed::execShouldInterruptLift(FFrame&, void* const)
native function bool ShouldInterruptLift();

// Export UTgDevice_Lightspeed::execShouldBlockReload(FFrame&, void* const)
native function bool ShouldBlockReload(TgDevice Dev, bool bIsAutoReload);

simulated event bool ShouldLockFiring(TgDevice Current)
{
    // End:0x44
    if(((Current != none) && Current.m_bHandDevice) && IsFiring())
    {
        return true;
    }
    return false;
    //return ReturnValue;    
}

simulated event bool CanBeCanceled()
{
    return !IsTimerActive('CancelSafetyTimer');
    //return ReturnValue;    
}

simulated event bool CanBeInterrupted()
{
    return true;
    //return ReturnValue;    
}

simulated event bool CanFiringBeCanceledByReactivation()
{
    return !IsTimerActive('CancelSafetyTimer');
    //return ReturnValue;    
}

simulated function bool InterceptSlotReleased(TgPlayerController TgController)
{
    return IsTimerActive('CancelSafetyTimer');
    //return ReturnValue;    
}

simulated event bool ShouldInterruptReloadOnFire()
{
    return true;
    //return ReturnValue;    
}

simulated function CancelSafetyTimer()
{
    //return;    
}

simulated state DeviceFiring
{
    simulated function RestartFireLoop(bool bRefire)
    {
        local TgDeviceFire pDeviceFire;

        pDeviceFire = GetCurrentFire();
        // End:0x50
        if(pDeviceFire != none)
        {
            SetTimer(pDeviceFire.GetCustomValue1(), false, 'CancelSafetyTimer');
        }
        super.RestartFireLoop(bRefire);
        //return;        
    }

    simulated function FirePreHitDelay()
    {
        super.FirePreHitDelay();
        ClearTimer('FirePostHitDelay');
        //return;        
    }

    simulated function EndState(name NextStateName)
    {
        ClearTimer('CancelSafetyTimer');
        super.EndState(NextStateName);
        //return;        
    }
    stop;    
}
