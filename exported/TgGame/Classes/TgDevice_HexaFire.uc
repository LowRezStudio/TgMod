class TgDevice_HexaFire extends TgDevice_HitPulse
    native(ChampRuckus)
    hidecategories(Navigation)
    implements(TgDeviceInterface_MoveSpeedMultiplier);

var private native const noexport Pointer VfTable_ITgDeviceInterface_MoveSpeedMultiplier;
var() Vector m_vProjectileSpawnOffset2;
var bool m_bFireLeftWeapon;
var TgPawn_Ruckus m_CachedRuckus;

// Export UTgDevice_HexaFire::execGetCachedAim(FFrame&, void* const)
native function GetCachedAim(out AimData Aim);

// Export UTgDevice_HexaFire::execGetMoveSpeedMultiplier(FFrame&, void* const)
native function float GetMoveSpeedMultiplier();

simulated function bool HasCachedRuckus()
{
    // End:0x2B
    if(m_CachedRuckus == none)
    {
        m_CachedRuckus = TgPawn_Ruckus(Instigator);
    }
    return m_CachedRuckus != none;
    //return ReturnValue;    
}

simulated event Vector GetProjectileSpawnOffset()
{
    // End:0x1A
    if(m_bFireLeftWeapon)
    {
        return m_vProjectileSpawnOffset2;        
    }
    else
    {
        return m_vProjectileSpawnOffset;
    }
    //return ReturnValue;    
}

simulated event bool CanJumpWhileFiring()
{
    return false;
    //return ReturnValue;    
}

simulated event bool CanBeCanceled()
{
    return (IsFiring()) && !IsTimerActive('FirePreHitDelay');
    //return ReturnValue;    
}

simulated function FireAmmunition()
{
    super(TgDevice).FireAmmunition();
    m_bFireLeftWeapon = !m_bFireLeftWeapon;
    //return;    
}

simulated event bool ShouldLockFiring(TgDevice Current)
{
    // End:0x3B
    if((Current != none) && Current.r_nDeviceId == 13219)
    {
        return false;
    }
    // End:0x54
    if(IsTimerActive('FirePreHitDelay'))
    {
        return true;
    }
    // End:0x171
    if((IsFiring()) && Current != none)
    {
        // End:0x16F
        if(HasCachedRuckus())
        {
            // End:0xCF
            if(m_CachedRuckus.HasCachedHexaFireGuns())
            {
                // End:0xCF
                if(Current == m_CachedRuckus.m_CachedHexaFireGuns)
                {
                    return false;
                }
            }
            // End:0x11F
            if(m_CachedRuckus.HasCachedEmitter())
            {
                // End:0x11F
                if(Current == m_CachedRuckus.m_CachedEmitter)
                {
                    return false;
                }
            }
            // End:0x16F
            if(m_CachedRuckus.HasCachedRepulsorField())
            {
                // End:0x16F
                if(Current == m_CachedRuckus.m_CachedRepulsorField)
                {
                    return false;
                }
            }
        }
        return true;
    }
    return false;
    //return ReturnValue;    
}

simulated function bool ShouldInterruptReloadOnFire()
{
    return true;
    //return ReturnValue;    
}

simulated state DeviceFiring
{
    simulated function StartFiringLogic()
    {
        // End:0x85
        if(HasCachedRuckus())
        {
            m_CachedRuckus.PlayHexaFireEffects(true);
            // End:0x85
            if(m_CachedRuckus.HasCachedRuckusInhand())
            {
                m_CachedRuckus.m_cachedRuckusInhand.m_bHexaFireSpinning = true;
            }
        }
        super.StartFiringLogic();
        //return;        
    }

    simulated function FirePreHitDelay()
    {
        local TgPawn PawnOwner;
        local TgDevice hexaFireGunsDevice;

        super.FirePreHitDelay();
        PawnOwner = TgPawn(Instigator);
        // End:0x8B
        if(PawnOwner != none)
        {
            hexaFireGunsDevice = PawnOwner.c_CurrentTargetingDevice;
            // End:0x8B
            if(hexaFireGunsDevice != none)
            {
                hexaFireGunsDevice.StartFire();
            }
        }
        //return;        
    }

    simulated function PulseHit()
    {
        local float fPersistPulseTime, pulseVariance;

        super.PulseHit();
        ClearTimer('PulseHit');
        fPersistPulseTime = GetPersistPulseHitTime();
        pulseVariance = (FRand() * fPersistPulseTime) - (fPersistPulseTime / 2.0000000);
        SetTimer(fPersistPulseTime + pulseVariance, true, 'PulseHit');
        //return;        
    }

    simulated function StopFiringLogic()
    {
        // End:0x85
        if(HasCachedRuckus())
        {
            m_CachedRuckus.PlayHexaFireEffects(false);
            // End:0x85
            if(m_CachedRuckus.HasCachedRuckusInhand())
            {
                m_CachedRuckus.m_cachedRuckusInhand.m_bHexaFireSpinning = false;
            }
        }
        super.StopFiringLogic();
        //return;        
    }
    stop;    
}

defaultproperties
{
    m_vProjectileSpawnOffset2=(X=30.0000000,Y=-30.0000000,Z=15.0000000)
    m_DeviceTimerBarType=DeviceTimerBarType.DTBT_PersistTime
    m_bAlwaysStartCooldown=false
    m_bAimThroughReticule=true
    m_vProjectileSpawnOffset=(X=30.0000000,Y=30.0000000,Z=15.0000000)
    m_ForceFeedbackStartFire=ForceFeedbackWaveform'gp_forcefeedback.LightForceFeedback'
}