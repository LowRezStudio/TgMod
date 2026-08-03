class TgDevice_FaeFlight extends TgDevice
    native(ChampFairy)
    hidecategories(Navigation)
    implements(TgDeviceInterface_MoveSpeedMultiplier);

var private native const noexport Pointer VfTable_ITgDeviceInterface_MoveSpeedMultiplier;

// Export UTgDevice_FaeFlight::execGetMoveSpeedMultiplier(FFrame&, void* const)
native function float GetMoveSpeedMultiplier();

simulated event bool ShouldLockFiring(TgDevice Current)
{
    // End:0x73
    if(Current != none)
    {
        // End:0x45
        if(Current.m_nDeviceType == 11077)
        {
            return IsFiring();            
        }
        else
        {
            // End:0x73
            if(Current.IsA('TgDevice_Flutter'))
            {
                return IsFiring();
            }
        }
    }
    return IsTimerActive('FirePreHitDelay') || IsTimerActive('OutroLockoutTime');
    //return ReturnValue;    
}

simulated event bool ShouldMountCancelFiring()
{
    return false;
    //return ReturnValue;    
}

simulated event bool CanBeCanceled()
{
    return false;
    //return ReturnValue;    
}

simulated state DeviceFiring
{
    simulated function StartFiringLogic()
    {
        local TgPawn_Fairy Fairy;
        local float fCustomValue;

        fCustomValue = 0.0000000;
        Fairy = TgPawn_Fairy(Instigator);
        // End:0x1CE
        if(Fairy != none)
        {
            fCustomValue = GetCurrentFire().GetCustomValue2();
            // End:0x9F
            if(fCustomValue > 0.0000000)
            {
                Fairy.m_fFairyFlySpeedModifier = fCustomValue;
            }
            fCustomValue = GetCurrentFire().GetCustomValue3();
            // End:0x104
            if(fCustomValue > 0.0000000)
            {
                Fairy.m_fFlightAccelerationPerSecond = fCustomValue;
            }
            fCustomValue = GetCurrentFire().GetCustomValue4();
            // End:0x169
            if(fCustomValue > 0.0000000)
            {
                Fairy.m_fFlightDecelerationPerSecond = fCustomValue;
            }
            fCustomValue = GetCurrentFire().GetCustomValue5();
            // End:0x1CE
            if(fCustomValue > 0.0000000)
            {
                Fairy.m_fAscentDecelerationPerSecond = fCustomValue;
            }
        }
        super.StartFiringLogic();
        //return;        
    }

    simulated function StopFiringLogic()
    {
        local TgPawn_Fairy Fairy;

        Fairy = TgPawn_Fairy(Instigator);
        // End:0x4F
        if(Fairy != none)
        {
            Fairy.m_fFairyFlySpeedModifier = 1.0000000;
        }
        super.StopFiringLogic();
        //return;        
    }
    stop;    
}

defaultproperties
{
    m_DeviceTimerBarType=DeviceTimerBarType.DTBT_PostHit
}