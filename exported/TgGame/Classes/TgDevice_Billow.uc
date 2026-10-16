class TgDevice_Billow extends TgDevice
    native(ChampDarklord)
    hidecategories(Navigation)
    implements(TgDeviceInterface_MoveSpeedMultiplier);

var private native const noexport Pointer VfTable_ITgDeviceInterface_MoveSpeedMultiplier;

// Export UTgDevice_Billow::execGetMoveSpeedMultiplier(FFrame&, void* const)
native function float GetMoveSpeedMultiplier();

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

simulated event bool ShouldMountCancelFiring()
{
    return true;
    //return ReturnValue;    
}

simulated event bool CanJumpWhileFiring()
{
    return true;
    //return ReturnValue;    
}

simulated event bool ShouldLockFiring(TgDevice Current)
{
    // End:0x39
    if((IsFiring()) && Current.m_nDeviceType == 11077)
    {
        return true;
    }
    return super.ShouldLockFiring(Current);
    //return ReturnValue;    
}

simulated function UpdateOutroLockoutTime()
{
    local TgDeviceFire FireMode;

    FireMode = GetCurrentFire();
    // End:0x4C
    if(FireMode != none)
    {
        m_fOutroLockoutTime = FireMode.GetCustomValue1();
    }
    //return;    
}

simulated state DeviceFiring
{
    simulated function EndState(name NextStateName)
    {
        super.EndState(NextStateName);
        // End:0x59
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
    m_DeviceTimerBarType=DeviceTimerBarType.DTBT_PostHit
    m_bUsesOutroLockout=true
    m_fOutroLockoutTime=0.4000000
}