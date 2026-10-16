class TgDevice_Drag extends TgDevice
    native(ChampMakoa)
    hidecategories(Navigation);

const DRAG_END_LOCATION_LOCK_DIST_SQ = 16384;

var TgPawn m_PullTarget;
var Rotator m_TargetInitialRotation;
var float m_fPullStartTime;
var TgPawn m_StunnedTarget;
var TgPawn r_ClientPullTarget;
var float m_fTruePostfireTime;
var float m_fPullVelocityBreakFactor;
var const float m_fPullVerticalEndOffset;
var const float m_fMaxPullTime;
var float m_fPrePullTime;
var float m_fPullEndOffset;
var float m_fPullSpeed;
var float m_fPullEndStunDuration;
var float m_fPullInterruptDistance;
var bool m_bCanStillPull;
var bool m_bNeedsDelayedServerEndPull;
var bool m_bNeedsDelayedClientEndPull;
var bool m_bHasPulledOnce;
var bool m_bSpecialUnlockInterrupt;
var Vector m_vEndLocation;
var TgPawn m_CachedPawnOwner;

replication
{
    // Pos:0x000
    if(int(Role) == int(ROLE_Authority))
        r_ClientPullTarget;
}

simulated event bool StartFire()
{
    // End:0x4B
    if(HasRemoteOwner() && IsFiring())
    {
        // End:0x3C
        if(DeviceSpawnsClientProjectilesFirst())
        {
            ClientRemoveSpawnedProjectile(m_CachedFireRequestId);
        }
        InterruptFiring();
        return false;        
    }
    else
    {
        return super.StartFire();
    }
    //return ReturnValue;    
}

function bool PullTarget(Actor Target, Vector HitLocation)
{
    local TgPawn PawnTarget;
    local TgPawn_Character charPawnTarget;
    local TgDeviceFire FireMode;

    // End:0x33
    if(((m_PullTarget != none) || !IsFiring()) || !m_bCanStillPull)
    {
        return false;
    }
    // End:0x74
    if((m_CachedPawnOwner == none) || !m_CachedPawnOwner.IsAliveAndWell())
    {
        InterruptFiring();
        return false;
    }
    PawnTarget = TgPawn(Target);
    FireMode = GetCurrentFire();
    // End:0x15E
    if(((((PawnTarget == none) || !PawnTarget.CanBePulled()) || FireMode == none) || !FireMode.IsValidTarget(Target)) || PawnTarget.SpecialAOEImmunity(HitLocation, FireMode))
    {
        MissInvalidTarget();
        return false;
    }
    SetPullTarget(PawnTarget);
    m_bHasPulledOnce = false;
    SetTimer(m_fPrePullTime, false, 'PrePullTimer');
    // End:0x1C5
    if(m_CachedPawnOwner != none)
    {
        m_CachedPawnOwner.FlashPlayEmote(13, 0);
    }
    charPawnTarget = TgPawn_Character(PawnTarget);
    // End:0x265
    if(charPawnTarget != none)
    {
        charPawnTarget.AddForcedViewTarget(m_CachedPawnOwner, 0.4000000, 3.0000000, self);
        // End:0x265
        if(charPawnTarget.IsJoined())
        {
            charPawnTarget.AbortJoin();
        }
    }
    return true;
    //return ReturnValue;    
}

function PrePullTimer()
{
    // End:0x11
    if(!m_bCanStillPull)
    {
        return;
    }
    // End:0x40
    if(c_DeviceForm != none)
    {
        c_DeviceForm.Generic1();
    }
    // End:0x84
    if(m_CachedPawnOwner != none)
    {
        m_CachedPawnOwner.FlashGeneric1(r_nDeviceInstanceId, int(CurrentFireMode));
    }
    //return;    
}

function MissPull()
{
    // End:0x11
    if(!m_bCanStillPull)
    {
        return;
    }
    // End:0x40
    if(c_DeviceForm != none)
    {
        c_DeviceForm.Generic2();
    }
    // End:0x84
    if(m_CachedPawnOwner != none)
    {
        m_CachedPawnOwner.FlashGeneric2(r_nDeviceInstanceId, int(CurrentFireMode));
    }
    ClearPullTarget();
    ServerEndPull();
    //return;    
}

function MissInvalidTarget()
{
    // End:0x11
    if(!m_bCanStillPull)
    {
        return;
    }
    // End:0x40
    if(c_DeviceForm != none)
    {
        c_DeviceForm.Generic3();
    }
    // End:0x84
    if(m_CachedPawnOwner != none)
    {
        m_CachedPawnOwner.FlashGeneric3(r_nDeviceInstanceId, int(CurrentFireMode));
    }
    ClearPullTarget();
    ServerEndPull();
    //return;    
}

event BreakPull()
{
    local TgDeviceFire FireMode;

    // End:0x61
    if(m_PullTarget != none)
    {
        FireMode = GetCurrentFire();
        // End:0x61
        if(FireMode != none)
        {
            FireMode.ApplyHitSpecial(m_PullTarget,, 10693);
        }
    }
    MissInvalidTarget();
    //return;    
}

event EndPull()
{
    // End:0x82
    if(m_PullTarget != none)
    {
        // End:0x3E
        if(c_DeviceForm != none)
        {
            c_DeviceForm.Generic4();
        }
        // End:0x82
        if(m_CachedPawnOwner != none)
        {
            m_CachedPawnOwner.FlashGeneric4(r_nDeviceInstanceId, int(CurrentFireMode));
        }
    }
    ClearPullTarget();
    m_bSpecialUnlockInterrupt = true;
    ServerEndPull();
    //return;    
}

function ServerEndPull()
{
    // End:0x3B
    if(IsTimerActive('FirePostHitDelay'))
    {
        SetTimer(m_fTruePostfireTime, false, 'FirePostHitDelay');
        ClientEndPull();        
    }
    else
    {
        // End:0x54
        if(IsFiring())
        {
            m_bNeedsDelayedServerEndPull = true;
        }
    }
    m_bCanStillPull = false;
    m_bHasPulledOnce = false;
    m_vEndLocation = vect(0.0000000, 0.0000000, 0.0000000);
    //return;    
}

reliable client simulated function ClientEndPull()
{
    // End:0x31
    if(IsTimerActive('FirePostHitDelay'))
    {
        SetTimer(m_fTruePostfireTime, false, 'FirePostHitDelay');        
    }
    else
    {
        // End:0x4A
        if(IsFiring())
        {
            m_bNeedsDelayedClientEndPull = true;
        }
    }
    m_bCanStillPull = false;
    m_bHasPulledOnce = false;
    m_vEndLocation = vect(0.0000000, 0.0000000, 0.0000000);
    //return;    
}

function SetPullTargetNoServerCorrectCameraSmoothing(bool bDisallowSmoothing)
{
    local TgPlayerController TgPC;

    // End:0x79
    if(m_PullTarget != none)
    {
        TgPC = TgPlayerController(m_PullTarget.Controller);
        // End:0x79
        if(TgPC != none)
        {
            TgPC.SetNoSmoothedMovementCorrection(bDisallowSmoothing, true);
        }
    }
    //return;    
}

function SetPullTarget(TgPawn Target)
{
    local TgDeviceFire FireMode;
    local ImpactInfo Impact;
    local TgEffectManager pEffectManager;

    // End:0x245
    if(Target != none)
    {
        SetPullTargetNoServerCorrectCameraSmoothing(false);
        m_PullTarget = Target;
        SetPullTargetNoServerCorrectCameraSmoothing(true);
        m_PullTarget.Velocity = vect(0.0000000, 0.0000000, 0.0000000);
        m_TargetInitialRotation = m_PullTarget.Rotation;
        m_fPullStartTime = WorldInfo.TimeSeconds;
        r_ClientPullTarget = m_PullTarget;
        bNetDirty = true;
        FireMode = GetCurrentFire();
        // End:0x194
        if(FireMode != none)
        {
            Impact.bDirectHit = true;
            Impact.DeviceModeReference = FireMode;
            Impact.HitActor = m_PullTarget;
            FireMode.ApplyHitSpecial(m_PullTarget, Impact);
        }
        // End:0x1E7
        if((m_CachedPawnOwner != none) && TgPawn_Makoa(m_CachedPawnOwner) != none)
        {
            TgPawn_Makoa(m_CachedPawnOwner).r_bAbility1CanEmote = true;
        }
        pEffectManager = Target.GetEffectManager();
        // End:0x245
        if(pEffectManager != none)
        {
            pEffectManager.RemoveEffectGroupsByCategory(16657);
        }
    }
    //return;    
}

function ClearPullTarget()
{
    local TgPawn_Character charPawnTarget;

    // End:0xDB
    if(m_PullTarget != none)
    {
        SetPullTargetNoServerCorrectCameraSmoothing(false);
        m_PullTarget.Velocity = vect(0.0000000, 0.0000000, 0.0000000);
        m_StunnedTarget = m_PullTarget;
        // End:0x86
        if(m_fPullEndStunDuration > 0.0000000)
        {
            SetTimer(m_fPullEndStunDuration, false, 'EndPostPullStun');            
        }
        else
        {
            EndPostPullStun();
        }
        charPawnTarget = TgPawn_Character(m_PullTarget);
        // End:0xDB
        if(charPawnTarget != none)
        {
            charPawnTarget.RemoveForcedViewTarget(self);
        }
    }
    m_PullTarget = none;
    r_ClientPullTarget = none;
    bNetDirty = true;
    // End:0x150
    if((m_CachedPawnOwner != none) && TgPawn_Makoa(m_CachedPawnOwner) != none)
    {
        TgPawn_Makoa(m_CachedPawnOwner).r_bAbility1CanEmote = false;
    }
    //return;    
}

event EndPostPullStun()
{
    local TgDeviceFire FireMode;

    // End:0x7E
    if((int(Role) == int(ROLE_Authority)) && m_StunnedTarget != none)
    {
        FireMode = GetCurrentFire();
        // End:0x73
        if(FireMode != none)
        {
            FireMode.RemoveHitSpecial(m_StunnedTarget, true);
        }
        m_StunnedTarget = none;
    }
    //return;    
}

simulated event bool ShouldLockFiring(TgDevice Current)
{
    // End:0x0F
    if(m_bSpecialUnlockInterrupt)
    {
        return false;
    }
    return super.ShouldLockFiring(Current);
    //return ReturnValue;    
}

simulated event LinkedDeviceEquipped(TgDevice Dev)
{
    // End:0x11
    if(Dev == none)
    {
        return;
    }
    super.LinkedDeviceEquipped(Dev);
    switch(Dev.r_nDeviceId)
    {
        // End:0x54
        case 14191:
        // End:0x5C
        case 14602:
        // End:0x64
        case 14843:
        // End:0xA1
        case 14844:
            Dev.RegisterDelegate(2, InterruptFiring);
            // End:0xA4
            break;
        // End:0xFFFF
        default:
            break;
    }
    //return;    
}

simulated event LinkedDeviceUnequipped(TgDevice Dev)
{
    // End:0x11
    if(Dev == none)
    {
        return;
    }
    super.LinkedDeviceUnequipped(Dev);
    switch(Dev.r_nDeviceId)
    {
        // End:0x54
        case 14191:
        // End:0x5C
        case 14602:
        // End:0x64
        case 14843:
        // End:0xA1
        case 14844:
            Dev.UnregisterDelegate(2, InterruptFiring);
            // End:0xA4
            break;
        // End:0xFFFF
        default:
            break;
    }
    //return;    
}

simulated state DeviceFiring
{
    simulated function FirePreHitDelay()
    {
        m_bCanStillPull = true;
        super.FirePreHitDelay();
        // End:0x39
        if(m_bNeedsDelayedServerEndPull)
        {
            m_bNeedsDelayedServerEndPull = false;
            ServerEndPull();
        }
        // End:0x5C
        if(m_bNeedsDelayedClientEndPull)
        {
            m_bNeedsDelayedClientEndPull = false;
            ClientEndPull();
        }
        //return;        
    }

    simulated function StartFiringLogic()
    {
        m_bSpecialUnlockInterrupt = false;
        super.StartFiringLogic();
        //return;        
    }

    simulated function StopFiringLogic()
    {
        m_bSpecialUnlockInterrupt = false;
        super.StopFiringLogic();
        ClearTimer('FirePostHitDelay');
        ClearPullTarget();
        //return;        
    }
    stop;    
}

defaultproperties
{
    m_fTruePostfireTime=0.3000000
    m_fPullVelocityBreakFactor=0.1000000
    m_fPullVerticalEndOffset=16.0000000
    m_fMaxPullTime=1.5000000
    m_fPrePullTime=0.5000000
    m_fPullEndOffset=7.0000000
    m_fPullSpeed=1000.0000000
    m_fPullEndStunDuration=0.2000000
    m_fPullInterruptDistance=200.0000000
    m_bAimThroughReticule=true
    m_vProjectileSpawnOffset=(X=39.2000000,Y=-33.6000000,Z=42.5000000)
    m_nLinkedDeviceIDs[0]=14182
    m_nLinkedDeviceIDs[1]=14191
    m_nLinkedDeviceIDs[2]=14602
    m_nLinkedDeviceIDs[3]=14843
    m_nLinkedDeviceIDs[4]=14844
}