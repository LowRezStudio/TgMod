class TgDevice_AccursedArm extends TgDevice_HitPulse
    native(ChampAndroxus)
    hidecategories(Navigation);

const TG_DEVICE_ACCURSED_ARM_GUN_ID = 13255;
const TG_DEVICE_NETHER_STEP_ID = 12658;

// Export UTgDevice_AccursedArm::execShouldInterruptStealth(FFrame&, void* const)
native function bool ShouldInterruptStealth();

simulated event bool CanBeCanceled()
{
    local float fPersistTimerTime;

    // End:0x4A
    if(IsTimerActive('PersistTimer'))
    {
        fPersistTimerTime = GetTimerCount('PersistTimer');
        // End:0x4A
        if(fPersistTimerTime > 0.5000000)
        {
            return true;
        }
    }
    return false;
    //return ReturnValue;    
}

simulated event bool ShouldLockFiring(TgDevice Current)
{
    // End:0x32
    if(IsTimerActive('FirePreHitDelay') || IsTimerActive('FirePostHitDelay'))
    {
        return true;
    }
    // End:0x7C
    if((IsFiring()) && Current != none)
    {
        // End:0x7A
        if(Current.r_nDeviceId == 13255)
        {
            return false;
        }
        return true;
    }
    return false;
    //return ReturnValue;    
}

simulated function PersistTimer()
{
    local float fPostHitDelay;
    local TgPawn_Androxus androxus;

    androxus = TgPawn_Androxus(Instigator);
    // End:0x4C
    if(androxus != none)
    {
        androxus.ToggleAccursedArm(false);
    }
    // End:0x6A
    if(int(Role) < int(ROLE_Authority))
    {
        ServerForcePersistTimer();
    }
    bPendingFire = false;
    ClearTimer('PersistTimer');
    ClearTimer('PulseHit');
    fPostHitDelay = GetCachedFiringPostHitDelay();
    // End:0xDF
    if(fPostHitDelay > 0.0000000)
    {
        SetTimer(fPostHitDelay, false, 'FirePostHitDelay');        
    }
    else
    {
        FirePostHitDelay();
    }
    //return;    
}

singular simulated function OnGunEmptied()
{
    // End:0x21
    if(IsTimerActive('FirePreHitDelay'))
    {
        FirePreHitDelay();
    }
    // End:0x42
    if(IsTimerActive('PersistTimer'))
    {
        PersistTimer();
    }
    // End:0x59
    if(HasRemoteOwner())
    {
        ClientOnGunEmptied();
    }
    //return;    
}

unreliable client simulated function ClientOnGunEmptied()
{
    OnGunEmptied();
    //return;    
}

reliable server function ServerForcePersistTimer()
{
    //return;    
}

simulated state DeviceFiring
{
    reliable server function ServerForcePersistTimer()
    {
        // End:0x21
        if(IsTimerActive('PersistTimer'))
        {
            PersistTimer();
        }
        //return;        
    }

    simulated function BeginState(name PreviousStateName)
    {
        // End:0xB4
        if(Instigator != none)
        {
            Instigator.Velocity.X = 0.0000000;
            Instigator.Velocity.Y = 0.0000000;
            Instigator.Velocity.Z = 0.0000000;
        }
        super.BeginState(PreviousStateName);
        //return;        
    }

    simulated function StartFiringLogic()
    {
        local TgPawn_Androxus androxus;
        local float SpeedModifier;

        SpeedModifier = 1.0000000;
        androxus = TgPawn_Androxus(Instigator);
        // End:0xC6
        if(androxus != none)
        {
            SpeedModifier = GetCurrentFire().GetCustomValue1();
            // End:0x9D
            if(SpeedModifier > float(0))
            {
                androxus.m_fAccursedArmSpeedModifier = SpeedModifier;
            }
            androxus.ToggleAccursedArm(true, SpeedModifier);
        }
        super.StartFiringLogic();
        //return;        
    }

    simulated function StopFiringLogic()
    {
        local TgPawn_Androxus androxus;

        androxus = TgPawn_Androxus(Instigator);
        // End:0x4C
        if(androxus != none)
        {
            androxus.ToggleAccursedArm(false);
        }
        super.StopFiringLogic();
        //return;        
    }

    simulated function EndState(name NextStateName)
    {
        ClearTimer('PersistTimer');
        ClearTimer('PulseHit');
        super.EndState(NextStateName);
        //return;        
    }
    stop;    
}

defaultproperties
{
    m_DeviceTimerBarType=DeviceTimerBarType.DTBT_PersistTime
    m_bPostFireShouldInterruptStealth=false
}