class TgDevice_DemonTeleport extends TgDevice
    native(ChampDemon)
    hidecategories(Navigation)
    implements(TgDeviceInterface_MoveSpeedMultiplier);

var private native const noexport Pointer VfTable_ITgDeviceInterface_MoveSpeedMultiplier;
var bool m_bCancelled;
var bool m_bPhaseApplied;
var float m_fTeleportDelayTimer;

// Export UTgDevice_DemonTeleport::execGetMoveSpeedMultiplier(FFrame&, void* const)
native function float GetMoveSpeedMultiplier();

// Export UTgDevice_DemonTeleport::execShouldForce3P(FFrame&, void* const)
native function bool ShouldForce3P(TgDeviceForm DeviceForm, optional bool bOnlyCheckDeviceForm = false);

// Export UTgDevice_DemonTeleport::execIsDeviceFiringForUI(FFrame&, void* const)
native function bool IsDeviceFiringForUI();

simulated function bool ShouldTeleportOnTimeout()
{
    local TgDeviceFire FireMode;

    FireMode = GetCurrentFire();
    // End:0x50
    if((FireMode != none) && FireMode.GetCustomValue4() > 0.0000000)
    {
        return false;
    }
    return true;
    //return ReturnValue;    
}

simulated event bool ShouldCooldownAfterFire()
{
    return false;
    //return ReturnValue;    
}

simulated function bool CanFiringBeCanceledByLeftMouse()
{
    return false;
    //return ReturnValue;    
}

simulated function bool InterceptSlotPressed(TgPlayerController TgController)
{
    // End:0x32
    if(IsFiring())
    {
        // End:0x30
        if(CanBeCanceled())
        {
            m_bCancelled = true;
            InterruptFiring();
        }
        return true;
    }
    return false;
    //return ReturnValue;    
}

simulated event bool CanBeInterrupted()
{
    // End:0x1E
    if(m_bCancelled && super.CanBeInterrupted())
    {
        return true;
    }
    return false;
    //return ReturnValue;    
}

simulated event bool CanBeCanceled()
{
    local float firePostHitTime;
    local TgPawn_Demon OwnerPawn;

    OwnerPawn = TgPawn_Demon(Owner);
    // End:0x7C
    if((OwnerPawn != none) && OwnerPawn.r_bCrippled || int(OwnerPawn.r_eCurrentStunType) != int(0))
    {
        return false;
    }
    // End:0xC6
    if(IsTimerActive('FirePostHitDelay'))
    {
        firePostHitTime = GetTimerCount('FirePostHitDelay');
        // End:0xC6
        if(firePostHitTime > 0.5000000)
        {
            return true;
        }
    }
    return false;
    //return ReturnValue;    
}

event OnDeployableDestroyed(TgDeployable deployable)
{
    // End:0x39
    if(deployable == r_Deployable)
    {
        r_Deployable = none;
        // End:0x39
        if(IsFiring())
        {
            InterruptFiring();
        }
    }
    //return;    
}

simulated event bool ShouldLockFiring(TgDevice Current)
{
    local float firePostHitTime;
    local TgDeviceFire FireMode;

    FireMode = GetCurrentFire();
    // End:0x30
    if(IsTimerActive('FirePreHitDelay'))
    {
        return true;        
    }
    else
    {
        // End:0x4C
        if(IsTimerActive('FinishPhaseIn'))
        {
            return true;            
        }
        else
        {
            // End:0xC3
            if(IsTimerActive('FirePostHitDelay'))
            {
                firePostHitTime = GetTimerCount('FirePostHitDelay');
                // End:0xC1
                if((FireMode != none) && firePostHitTime > FireMode.GetCustomValue1())
                {
                    return false;
                }
                return true;
            }
        }
    }
    return false;
    //return ReturnValue;    
}

simulated event bool CanTeleportNow()
{
    local TgPawn_Demon OwnerPawn;

    OwnerPawn = TgPawn_Demon(Owner);
    // End:0x51
    if((OwnerPawn != none) && OwnerPawn.r_bIsUltActive)
    {
        return false;
    }
    return true;
    //return ReturnValue;    
}

simulated event DoTeleport()
{
    local bool bShouldTeleport, bShouldDestroyDeployable;
    local TgDeviceFire FireMode;

    FireMode = GetCurrentFire();
    bShouldTeleport = (ShouldTeleportOnTimeout()) || m_bCancelled;
    bShouldDestroyDeployable = false;
    // End:0x13B
    if(r_Deployable != none)
    {
        // End:0xEB
        if(bShouldTeleport)
        {
            // End:0xB0
            if(CanTeleportNow())
            {
                bShouldDestroyDeployable = true;
                TeleportToDeployable(r_Deployable.Location);
                StartCooldown();                
            }
            else
            {
                // End:0xE8
                if(FireMode != none)
                {
                    m_fTeleportDelayTimer = FireMode.GetCustomValue3();
                }
            }            
        }
        else
        {
            bShouldDestroyDeployable = true;
        }
        // End:0x13B
        if(bShouldDestroyDeployable)
        {
            r_Deployable.DestroyIt();
            r_Deployable = none;
            bNetDirty = true;
        }
    }
    //return;    
}

reliable server function ServerTeleportToDeployable(Vector vDest)
{
    TeleportToDeployable(vDest);
    StartCooldown();
    //return;    
}

simulated function TeleportToDeployable(Vector vDest)
{
    local TgPawn_Demon OwnerPawn;
    local AimData Aim;
    local TeleportParams TelParams;

    OwnerPawn = TgPawn_Demon(Owner);
    // End:0x175
    if(OwnerPawn != none)
    {
        GetCachedAim(Aim);
        TelParams.vTargetLocation = vDest;
        TelParams.rTargetRotation = Rotator(Aim.AimVector);
        TelParams.bPlayFx = true;
        TelParams.fMovementCorrectionDisableTime = 0.3000000;
        // End:0x175
        if(OwnerPawn.AdvancedTeleport(TelParams))
        {
            OwnerPawn.Velocity = vect(0.0000000, 0.0000000, 0.0000000);
            // End:0x175
            if(int(Role) < int(ROLE_Authority))
            {
                ServerTeleportToDeployable(OwnerPawn.Location);
            }
        }
    }
    StartPhaseIn();
    //return;    
}

simulated function StartPhaseIn()
{
    local TgDeviceFire FireMode;
    local ImpactInfo Impact;

    // End:0x132
    if(!m_bPhaseApplied)
    {
        m_bPhaseApplied = true;
        FireMode = GetCurrentFire();
        // End:0x132
        if(FireMode != none)
        {
            // End:0x105
            if((int(Role) == int(ROLE_Authority)) && Owner != none)
            {
                Impact.bDirectHit = true;
                Impact.DeviceModeReference = FireMode;
                Impact.HitActor = Owner;
                FireMode.ApplyHitSpecial(Owner, Impact, 10693);
            }
            SetTimer(FireMode.GetCustomValue2(), false, 'FinishPhaseIn');
        }
    }
    //return;    
}

simulated function FinishPhaseIn()
{
    local TgDeviceFire FireMode;

    // End:0x81
    if(m_bPhaseApplied)
    {
        m_bPhaseApplied = false;
        FireMode = GetCurrentFire();
        // End:0x81
        if((int(Role) == int(ROLE_Authority)) && Owner != none)
        {
            FireMode.RemoveHitSpecial(Owner, true, 10693);
        }
    }
    //return;    
}

simulated event float GetCustomTimerBarCurrentTime()
{
    // End:0x4E
    if(r_Deployable != none)
    {
        return r_Deployable.r_fTimeToDeploySecs - r_Deployable.LifeSpan;
    }
    return 0.0000000;
    //return ReturnValue;    
}

simulated event float GetCustomTimerBarMaxTime()
{
    // End:0x2E
    if(r_Deployable != none)
    {
        return r_Deployable.r_fTimeToDeploySecs;
    }
    return 0.0000000;
    //return ReturnValue;    
}

simulated state DeviceFiring
{
    simulated function StartFiringLogic()
    {
        m_bCancelled = false;
        m_bPhaseApplied = false;
        super.StartFiringLogic();
        //return;        
    }

    simulated function StopFiringLogic()
    {
        super.StopFiringLogic();
        DoTeleport();
        //return;        
    }
    stop;    
}

defaultproperties
{
    m_bDeployAtFeetOnFailure=true
}