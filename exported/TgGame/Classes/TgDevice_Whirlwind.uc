class TgDevice_Whirlwind extends TgDevice_HitPulse
    native(ChampGrover)
    hidecategories(Navigation);

// Export UTgDevice_Whirlwind::execMustBeOnGroundToFire(FFrame&, void* const)
native function bool MustBeOnGroundToFire();

simulated event bool ShouldLockFiring(TgDevice Current)
{
    return IsFiring();
    //return ReturnValue;    
}

// Export UTgDevice_Whirlwind::execCanFireIfLeftMouseDown(FFrame&, void* const)
native function bool CanFireIfLeftMouseDown();

simulated event bool CanBeInterrupted()
{
    return false;
    //return ReturnValue;    
}

simulated event bool CanBeCanceled()
{
    return GetTimerCount('PersistTimer') > 0.5000000;
    //return ReturnValue;    
}

simulated event bool CanJumpWhileFiring()
{
    return false;
    //return ReturnValue;    
}

simulated event bool CancelledByJumping()
{
    return false;
    //return ReturnValue;    
}

simulated function PersistTimer()
{
    local TgPawn TgP;
    local float fTimingError, fPostHitDelay;
    local TgDeviceFire FireMode;

    TgP = TgPawn(Instigator);
    // End:0x9B
    if(TgP != none)
    {
        TgP.m_fZoomDistOverride = 0.0000000;
        TgP.m_fZoomDurationOverride = self.GetCurrentFire().GetCustomValue3();
    }
    // End:0xD5
    if(s_WhileFiringDeviceMode != none)
    {
        s_WhileFiringDeviceMode.RemoveHitSpecial(Instigator, true);
    }
    // End:0x104
    if(c_DeviceForm != none)
    {
        c_DeviceForm.Generic1();
    }
    // End:0x13E
    if(TgP != none)
    {
        TgP.FlashGeneric1(r_nDeviceInstanceId, 0);
    }
    // End:0x157
    if(m_IsBeingInterrupted)
    {
        super.PersistTimer();
        return;
    }
    // End:0x187
    if(LogDebugInfo())
    {
        FireMode = GetCurrentFire();
        // End:0x187
        if(FireMode != none)
        {
        }
    }
    ClearTimer('PersistTimer');
    ClearTimer('PulseHit');
    // End:0x1F2
    if(m_bCarryPreFireToPostFire)
    {
        fTimingError = WorldInfo.TimeSeconds - m_fFiringTimer;        
    }
    else
    {
        fTimingError = 0.0000000;
    }
    fPostHitDelay = GetCachedFiringPostHitDelay();
    m_fFiringTimer = (WorldInfo.TimeSeconds + (fPostHitDelay / CustomTimeDilation)) - fTimingError;
    m_fTimeStampAccountedFor = WorldInfo.TimeSeconds;
    m_fTimeAccountedFor = 0.0000000;
    fPostHitDelay = FMax(0.0000000, fPostHitDelay - (fTimingError * CustomTimeDilation));
    // End:0x2D2
    if(LogDebugInfo())
    {
    }
    // End:0x310
    if(s_WhileFiringDeviceMode != none)
    {
        s_WhileFiringDeviceMode.ApplyEffectType(Instigator, 10456);
    }
    // End:0x33D
    if(fPostHitDelay > 0.0000000)
    {
        SetTimer(fPostHitDelay, false, 'FirePostHitDelay');        
    }
    else
    {
        bPendingFire = false;
        FirePostHitDelay();
    }
    //return;    
}

simulated state DeviceFiring
{
    simulated function bool ShouldRefire(TgDeviceFire FireMode, const out AimData Aim)
    {
        return false;
        //return ReturnValue;        
    }

    simulated function FirePreHitDelay()
    {
        local TgPawn TgP;

        super.FirePreHitDelay();
        TgP = TgPawn(Instigator);
        // End:0x81
        if(TgP != none)
        {
            TgP.m_fZoomDistOverride = self.GetCurrentFire().GetCustomValue2();
        }
        // End:0xBB
        if(s_WhileFiringDeviceMode != none)
        {
            s_WhileFiringDeviceMode.ApplyHitSpecial(Instigator);
        }
        //return;        
    }

    simulated function StopFiringLogic()
    {
        local TgPawn TgP;

        super.StopFiringLogic();
        TgP = TgPawn(Instigator);
        // End:0x7D
        if(TgP != none)
        {
            TgP.m_fZoomDistOverride = 0.0000000;
            TgP.m_fZoomDurationOverride = 0.0000000;
        }
        //return;        
    }
    stop;    
}

defaultproperties
{
    m_bAlwaysStartCooldown=false
    m_bDisableLagCompensation=true
}