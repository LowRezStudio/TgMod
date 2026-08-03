class TgDevice_Tempest extends TgDevice_HitPulse
    native(ChampGrohk)
    hidecategories(Navigation);

// Export UTgDevice_Tempest::execCanFireIfLeftMouseDown(FFrame&, void* const)
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

simulated event DeliverQueuedPendingHits()
{
    local TgDeviceFire FireMode;
    local TgPawn_Character TgP;
    local int I;

    // End:0x184
    if(PendingImpactList.Length > 0)
    {
        TgP = TgPawn_Character(Owner);
        FireMode = GetCurrentFire();
        // End:0x184
        if((TgP != none) && FireMode != none)
        {
            I = 0;
            J0x6B:

            // End:0x184 [Loop If]
            if(I < PendingImpactList.Length)
            {
                // End:0x176
                if(PendingImpactList[I].HitActor != none)
                {
                    TgP.FlashArcing(r_nDeviceInstanceId, int(CurrentFireMode), PendingImpactList[I].HitActor.Location, TgP.Location, PendingImpactList[I].HitActor, int(r_eEquippedAt), m_nSocketIndex, false);
                }
                ++I;
                // [Loop Continue]
                goto J0x6B;
            }
        }
    }
    super(TgDevice).DeliverQueuedPendingHits();
    //return;    
}

simulated function PersistTimer()
{
    local float fTimingError, fPostHitDelay;
    local TgDeviceFire FireMode;

    // End:0x19
    if(m_IsBeingInterrupted)
    {
        super.PersistTimer();
        return;
    }
    // End:0x49
    if(LogDebugInfo())
    {
        FireMode = GetCurrentFire();
        // End:0x49
        if(FireMode != none)
        {
        }
    }
    ClearTimer('PersistTimer');
    ClearTimer('PulseHit');
    // End:0xB4
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
    // End:0x194
    if(LogDebugInfo())
    {
    }
    // End:0x1D2
    if(s_WhileFiringDeviceMode != none)
    {
        s_WhileFiringDeviceMode.ApplyEffectType(Instigator, 10456);
    }
    // End:0x1FF
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

simulated function bool ShouldInterruptReloadOnFire()
{
    return false;
    //return ReturnValue;    
}

simulated state DeviceFiring
{
    simulated function BeginState(name PreviousStateName)
    {
        local TgPawn TgP;

        super.BeginState(PreviousStateName);
        TgP = TgPawn_Character(Instigator);
        // End:0x8A
        if(TgP != none)
        {
            TgP.m_fZoomDistOverride = self.GetCurrentFire().GetCustomValue1();
        }
        //return;        
    }

    simulated function bool ShouldRefire(TgDeviceFire FireMode, const out AimData Aim)
    {
        return false;
        //return ReturnValue;        
    }

    simulated function FirePreHitDelay()
    {
        super.FirePreHitDelay();
        // End:0x73
        if(s_WhileFiringDeviceMode != none)
        {
            s_WhileFiringDeviceMode.RemoveEffectType(Instigator, false, 10455);
            s_WhileFiringDeviceMode.ApplyHitSpecial(Instigator);
        }
        //return;        
    }

    simulated function StopFiringLogic()
    {
        // End:0x3A
        if(s_WhileFiringDeviceMode != none)
        {
            s_WhileFiringDeviceMode.RemoveHitSpecial(Instigator, true);
        }
        super.StopFiringLogic();
        //return;        
    }

    simulated function EndState(name NextStateName)
    {
        local TgPawn TgP;

        super.EndState(NextStateName);
        TgP = TgPawn(Instigator);
        // End:0x62
        if(TgP != none)
        {
            TgP.m_fZoomDistOverride = 0.0000000;
        }
        //return;        
    }
    stop;    
}

defaultproperties
{
    m_DeviceTimerBarType=DeviceTimerBarType.DTBT_PersistTime
    m_bAlwaysStartCooldown=false
    m_bDisableLagCompensation=true
}