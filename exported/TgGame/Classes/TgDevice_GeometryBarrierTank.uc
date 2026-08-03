class TgDevice_GeometryBarrierTank extends TgDevice
    native(ChampBarrierTank)
    hidecategories(Navigation);

const IMPASSE_POST_TARGET_LOCKOUT_TIME = 0.7f;

var float r_fTremorsCooldownReduction;
var float m_fCachedWallHealthPercent;

replication
{
    // Pos:0x000
    if(int(Role) == int(ROLE_Authority))
        r_fTremorsCooldownReduction;
}

// Export UTgDevice_GeometryBarrierTank::execGetGroundTargetAim(FFrame&, void* const)
native function GetGroundTargetAim(out AimData Aim);

// Export UTgDevice_GeometryBarrierTank::execMustBeOnGroundToFire(FFrame&, void* const)
native function bool MustBeOnGroundToFire();

// Export UTgDevice_GeometryBarrierTank::execShouldAltFireOnTick(FFrame&, void* const)
native function bool ShouldAltFireOnTick();

// Export UTgDevice_GeometryBarrierTank::execUpdateTargetingModeStatus(FFrame&, void* const)
native function UpdateTargetingModeStatus(const out AimData Aim);

simulated function bool InterceptSlotPressed(TgPlayerController TgController)
{
    local TgPawn PawnOwner;
    local WeaponMeshSwapStrategy SwapStrategy;

    // End:0x27
    if(IsFiring())
    {
        // End:0x24
        if(CanBeCanceled())
        {
            InterruptFiring();
        }        
    }
    else
    {
        // End:0xEE
        if(!m_bInTargetingMode && IsActive())
        {
            PawnOwner = TgPawn(Owner);
            // End:0xEE
            if(PawnOwner != none)
            {
                // End:0xEE
                if(PawnOwner.StartAction(self))
                {
                    PawnOwner.SetTargetingDevice(self, SwapStrategy);
                    // End:0xEE
                    if(PawnOwner.c_CurrentTargetingDevice != self)
                    {
                        InterruptFiring();
                    }
                }
            }
        }
    }
    return true;
    //return ReturnValue;    
}

simulated function bool InterceptSlotReleased(TgPlayerController TgController)
{
    local AimData Aim;

    // End:0x72
    if(IsInState('DeviceBuildup') && m_bInTargetingMode)
    {
        GetTargetingAim(Aim);
        // End:0x5F
        if(Aim.bResult)
        {
            EndCustomTargeting();            
        }
        else
        {
            InterceptRightMousePressed(TgController);
        }
    }
    return true;
    //return ReturnValue;    
}

simulated function bool InterceptLeftMousePressed(TgPlayerController TgController)
{
    local AimData Aim;

    // End:0x95
    if(IsInState('DeviceBuildup') && m_bInTargetingMode)
    {
        GetTargetingAim(Aim);
        // End:0x5F
        if(Aim.bResult)
        {
            EndCustomTargeting();            
        }
        else
        {
            InterceptRightMousePressed(TgController);
        }
        TgController.bPressingLeftMouseButton = false;
        return true;
    }
    return false;
    //return ReturnValue;    
}

simulated event EndCustomTargeting()
{
    local TgPawn PawnOwner;
    local WeaponMeshSwapStrategy SwapStrategy;

    ClearTimer('DeviceBuildupTimer');
    DeviceBuildupTimer();
    PawnOwner = TgPawn(Owner);
    // End:0x91
    if(PawnOwner != none)
    {
        PawnOwner.SetTargetingDevice(PawnOwner.GetDeviceByEqPoint(1), SwapStrategy);
    }
    ServerEndCustomTargeting();
    //return;    
}

reliable server function ServerEndCustomTargeting()
{
    // End:0x2E
    if(IsInState('DeviceBuildup'))
    {
        ClearTimer('DeviceBuildupTimer');
        DeviceBuildupTimer();
    }
    //return;    
}

simulated event bool CanFireWithoutAimResult()
{
    return true;
    //return ReturnValue;    
}

simulated event OnDeployableSpawned(TgDeployable deployable)
{
    r_OverrideUsesTargetingModeAsFalse = true;
    m_fCachedWallHealthPercent = -1.0000000;
    //return;    
}

event OnDeployableDestroyed(TgDeployable deployable)
{
    // End:0x7A
    if(deployable == r_Deployable)
    {
        m_fCachedWallHealthPercent = r_Deployable.GetHealthPercent();
        r_Deployable = none;
        r_OverrideUsesTargetingModeAsFalse = false;
        // End:0x6E
        if(IsFiring())
        {
            InterruptFiring();
        }
        StartCooldown();
    }
    //return;    
}

simulated event bool ShouldLockFiring(TgDevice Current)
{
    local float firePostHitTime;

    // End:0x4C
    if(IsTimerActive('FirePostHitDelay'))
    {
        firePostHitTime = GetTimerCount('FirePostHitDelay');
        // End:0x4A
        if(firePostHitTime > 0.7000000)
        {
            return false;
        }
        return true;
    }
    return super.ShouldLockFiring(Current);
    //return ReturnValue;    
}

simulated event bool CanBeCanceled()
{
    local float firePostHitTime;

    // End:0x4A
    if(IsTimerActive('FirePostHitDelay'))
    {
        firePostHitTime = GetTimerCount('FirePostHitDelay');
        // End:0x4A
        if(firePostHitTime > 0.5000000)
        {
            return true;
        }
    }
    return false;
    //return ReturnValue;    
}

simulated function int GetAimAssistPriority()
{
    // End:0x13
    if(IsInState('DeviceBuildup'))
    {
        return 2;
    }
    return 0;
    //return ReturnValue;    
}

simulated state DeviceBuildup
{
    simulated function BeginState(name PreviousStateName)
    {
        super.BeginState(PreviousStateName);
        ClearTimer('DeviceBuildupTimer');
        //return;        
    }

    simulated function EndState(name NextStateName)
    {
        CacheAim();
        m_fFiringTimer = WorldInfo.TimeSeconds;
        super.EndState(NextStateName);
        //return;        
    }
    stop;    
}

simulated state DeviceFiring
{
    simulated function StartFiringLogic()
    {
        local TgPawn PawnOwner;
        local WeaponMeshSwapStrategy SwapStrategy;

        super.StartFiringLogic();
        PawnOwner = TgPawn(Owner);
        // End:0x7D
        if(PawnOwner != none)
        {
            PawnOwner.SetTargetingDevice(PawnOwner.GetDeviceByEqPoint(1), SwapStrategy);
        }
        //return;        
    }

    simulated function StopFiringLogic()
    {
        super.StopFiringLogic();
        // End:0x44
        if(r_Deployable != none)
        {
            r_Deployable.DestroyIt();
            r_Deployable = none;
        }
        r_OverrideUsesTargetingModeAsFalse = false;
        //return;        
    }
    stop;    
}

defaultproperties
{
    r_fTremorsCooldownReduction=-1.0000000
    m_fCachedWallHealthPercent=-1.0000000
    m_DeviceEmoteAt=DeviceEmoteAt.DEA_StartFire
    m_bAimThroughReticule=true
    m_AimAssistKeyframesMagnetVert=none
    m_AimAssistKeyframesMagnetHoriz=none
    m_AimAssistKeyframesFriction=none
    m_AimAssistKeyframesTrackingAccHoriz=none
    m_AimAssistKeyframesTrackingAngleHoriz=none
    m_AimAssistKeyframesTrackingAccVert=none
    m_AimAssistKeyframesTrackingAngleVert=none
}