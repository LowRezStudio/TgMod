class TgDevice_HitPulse extends TgDevice
    native(Devices)
    hidecategories(Navigation);

var bool s_ShouldPayCostPerPulse;
var bool s_bCostPaid;
var bool m_bConsumeAmmoOnEachPulse;
var int m_CurrentPulseIndex;

// Export UTgDevice_HitPulse::execCanDeviceFireNow(FFrame&, void* const)
native function bool CanDeviceFireNow(byte FireModeNum, AimData Aim, bool bDeviceFailLog, out TgObject.EDeviceFailType failType);

simulated function bool ApplyGlobalOffhandCooldown()
{
    return false;
    //return ReturnValue;    
}

simulated function PersistTimer()
{
    local TgDeviceFire FireMode;

    // End:0x30
    if(LogDebugInfo())
    {
        FireMode = GetCurrentFire();
        // End:0x30
        if(FireMode != none)
        {
        }
    }
    bPendingFire = false;
    FirePostHitDelay();
    ClearTimer('PersistTimer');
    ClearTimer('PulseHit');
    //return;    
}

simulated event float GetRefireTime(optional int nMode = -1)
{
    return GetPersistPulseHitTime(nMode);
    //return ReturnValue;    
}

simulated function PulseHit()
{
    //return;    
}

simulated event float GetPersistTime(optional int nMode = -1)
{
    local TgDeviceFire FireMode;

    FireMode = GetCurrentFire();
    // End:0x63
    if((nMode >= 0) && nMode < m_FireMode.Length)
    {
        FireMode = m_FireMode[nMode];
    }
    return FireMode.GetPropertyValue(150);
    //return ReturnValue;    
}

simulated event float GetPersistPulseHitTime(optional int nMode = -1)
{
    local TgDeviceFire FireMode;

    FireMode = GetCurrentFire();
    // End:0x63
    if((nMode >= 0) && nMode < m_FireMode.Length)
    {
        FireMode = m_FireMode[nMode];
    }
    return FireMode.GetPropertyValue(151);
    //return ReturnValue;    
}

reliable server event InterruptFiring()
{
    m_IsBeingInterrupted = true;
    // End:0x102
    if(int(Role) == int(ROLE_Authority))
    {
        // End:0x2D
        if(LogDebugInfo())
        {
        }
        // End:0xDB
        if(IsFiring())
        {
            TgPawn(Instigator).FlashInterrupt(r_nDeviceInstanceId);
            // End:0xCE
            if(((c_DeviceForm != none) && Instigator.IsLocallyControlled()) && !HasRemoteOwner())
            {
                c_DeviceForm.DoInterrupt();
            }
            PersistTimer();            
        }
        else
        {
            GotoState('Active');
        }
        m_fLastDeviceCanFireTimeStamp = 0.0000000;
        ClientInterrupt();
    }
    m_IsBeingInterrupted = false;
    //return;    
}

reliable client simulated event ClientInterrupt()
{
    m_IsBeingInterrupted = true;
    // End:0x19
    if(LogDebugInfo())
    {
    }
    // End:0x56
    if((c_DeviceForm != none) && IsFiring())
    {
        c_DeviceForm.DoInterrupt();
    }
    // End:0x70
    if(IsFiring())
    {
        PersistTimer();        
    }
    else
    {
        GotoState('Active');
    }
    m_fLastDeviceCanFireTimeStamp = 0.0000000;
    m_IsBeingInterrupted = false;
    //return;    
}

simulated function bool ShouldConsumePowerPoolOnStartFire()
{
    return !s_ShouldPayCostPerPulse;
    //return ReturnValue;    
}

simulated function bool ShouldConsumePowerPoolAfterFire()
{
    return s_ShouldPayCostPerPulse;
    //return ReturnValue;    
}

simulated function int GetAmmoToConsume()
{
    // End:0x3E
    if(m_bConsumeAmmoOnEachPulse || !HasAlreadyFiredOnce)
    {
        return GetCurrentFire().m_nAmmoCostPerShot;
    }
    return 0;
    //return ReturnValue;    
}

simulated function float GetLockoutExtensionTime()
{
    // End:0x36
    if((IsOffhand()) || IsPurchasedAbility())
    {
        // End:0x36
        if(int(Role) < int(ROLE_Authority))
        {
            return 0.1000000;
        }
    }
    return 0.0000000;
    //return ReturnValue;    
}

simulated state DeviceFiring
{
    simulated function BeginState(name PreviousStateName)
    {
        s_bCostPaid = false;
        m_CurrentPulseIndex = 0;
        super.BeginState(PreviousStateName);
        HasAlreadyFiredOnce = true;
        //return;        
    }

    simulated function EndState(name NextStateName)
    {
        super.EndState(NextStateName);
        ClearTimer('PersistTimer');
        ClearTimer('PulseHit');
        m_CurrentPulseIndex = 0;
        //return;        
    }

    simulated function PulseHit()
    {
        local AimData Aim;

        UpdateAimWhileFiring(m_CachedAim);
        GetCachedAim(Aim);
        // End:0x6B
        if((int(GetTargetingMode()) == int(7)) && !Aim.bResult)
        {
            PersistTimer();
            return;
        }
        ++m_CurrentPulseIndex;
        // End:0xA9
        if(s_ShouldPayCostPerPulse && !HasEnoughPowerPool(CurrentFireMode))
        {
            PersistTimer();
            return;
        }
        HasAlreadyFiredOnce = true;
        FireAmmunition();
        c_fCachedManaAtStartFire = ((TgPawn(Instigator) != none) ? TgPawn(Instigator).GetMana() : 0.0000000);
        //return;        
    }

    simulated function FirePreHitDelay()
    {
        local float fPersistTime, fPersistPulseTime, fTimingError, fPulseToPersist;

        // End:0x0D
        if(LogDebugInfo())
        {
        }
        // End:0x4B
        if(s_WhileFiringDeviceMode != none)
        {
            s_WhileFiringDeviceMode.RemoveEffectType(Instigator, false, 10455);
        }
        FireAmmunition();
        HasAlreadyFiredOnce = true;
        fPersistTime = GetPersistTime();
        fPersistPulseTime = GetPersistPulseHitTime();
        fPulseToPersist = fPersistPulseTime / fPersistTime;
        fTimingError = WorldInfo.TimeSeconds - m_fFiringTimer;
        m_fFiringTimer = (WorldInfo.TimeSeconds + (fPersistTime / CustomTimeDilation)) - fTimingError;
        m_fTimeStampAccountedFor = WorldInfo.TimeSeconds;
        m_fTimeAccountedFor = 0.0000000;
        fPersistTime = FMax(0.0000000, fPersistTime - (fTimingError * CustomTimeDilation));
        fPersistPulseTime = fPersistTime * fPulseToPersist;
        // End:0x1B7
        if(LogDebugInfo())
        {
        }
        ClearTimer('PulseHit');
        SetTimer(fPersistPulseTime, true, 'PulseHit');
        ClearTimer('PersistTimer');
        // End:0x21E
        if(fPersistTime > float(0))
        {
            SetTimer(fPersistTime, false, 'PersistTimer');
        }
        //return;        
    }
    stop;    
}

defaultproperties
{
    m_bAlwaysStartCooldown=true
}