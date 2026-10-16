class TgDevice_HyperBeam extends TgDevice
    native(ChampGauntlet)
    hidecategories(Navigation)
    implements(TgDeviceInterface_MoveSpeedMultiplier);

var private native const noexport Pointer VfTable_ITgDeviceInterface_MoveSpeedMultiplier;

// Export UTgDevice_HyperBeam::execGetMoveSpeedMultiplier(FFrame&, void* const)
native function float GetMoveSpeedMultiplier();

simulated event bool CanBeCanceled()
{
    return false;
    //return ReturnValue;    
}

simulated event bool IsFunctionallyToggleDevice()
{
    return true;
    //return ReturnValue;    
}

simulated function bool ShouldStopActionOnOffhandSlotReleased()
{
    return false;
    //return ReturnValue;    
}

simulated function FiringDuration()
{
    // End:0x1E
    if(int(Role) == int(ROLE_Authority))
    {
        InterruptFiring();
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
    simulated function StartFiringLogic()
    {
        SetTimer(GetCurrentFire().GetPersistTime(), false, 'FiringDuration');
        super.StartFiringLogic();
        //return;        
    }

    simulated function StopFiringLogic()
    {
        ClearTimer('FiringTimer');
        // End:0x3B
        if(int(Role) == int(ROLE_Authority))
        {
            DeviceConsumePowerPool(CurrentFireMode);
        }
        super.StopFiringLogic();
        //return;        
    }
    stop;    
}

defaultproperties
{
    m_AimAssistKeyframesMagnetVert=none
    m_AimAssistKeyframesMagnetHoriz=none
    m_nAimAssistPriorityWhileFiring=2
}