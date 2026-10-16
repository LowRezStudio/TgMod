class TgDevice_Vine extends TgDevice
    native(ChampGrover)
    hidecategories(Navigation);

var Actor m_PullTarget;
var Vector m_vPullLocation;
var float m_fPullSpeed;
var float m_fTruePostfireTime;
var float m_fPullEndOffset;
var bool m_bCanBeCanceled;
var bool m_bMissedPull;
var bool m_bIsPulling;
var bool m_bHasPulledOnce;
var bool m_bTeleportedAfterFiring;
var float m_fMomentumAfterPull;

event PullToTarget(Actor Target, Vector targetPos)
{
    local TgDeviceFire FireMode;
    local TgPawn TgP;

    m_PullTarget = Target;
    m_vPullLocation = targetPos;
    TgP = TgPawn(Instigator);
    FireMode = GetCurrentFire();
    // End:0x114
    if(((((TgP == none) || !TgP.IsAliveAndWell()) || m_bTeleportedAfterFiring) || !IsFiring()) || (TgPawn(m_PullTarget) != none) && (FireMode == none) || !FireMode.IsValidTarget(m_PullTarget))
    {
        MissPull();
        return;
    }
    SetIsPullingHitSpecial(true);
    m_bIgnoreSecondaryFireLogic = false;
    m_bMissedPull = false;
    TgP.AirSpeed = m_fPullSpeed;
    TgP.SetProperty(32, TgP.GetPropCurrentValue(32) + float(1));
    m_bHasPulledOnce = false;
    m_bIsPulling = true;
    //return;    
}

event MissPull()
{
    m_bMissedPull = true;
    m_bIgnoreSecondaryFireLogic = true;
    // End:0x33
    if(!m_bIsSecondaryFire)
    {
        HasAlreadyFiredOnce = false;
    }
    m_PullTarget = none;
    EndPull();
    //return;    
}

function EndPull()
{
    local TgPawn TgP;

    TgP = TgPawn(Instigator);
    // End:0x60
    if(TgP != none)
    {
        TgP.FlashGeneric1(r_nDeviceInstanceId, int(CurrentFireMode));
    }
    // End:0xDA
    if(m_bIsPulling)
    {
        // End:0xC3
        if(TgP != none)
        {
            TgP.SetProperty(32, TgP.GetPropCurrentValue(32) - float(1));
        }
        SetIsPullingHitSpecial(false);
        m_bIsPulling = false;
    }
    m_PullTarget = none;
    LockInput(false);
    ClientEndPull();
    SetTimer(m_fTruePostfireTime, false, 'FirePostHitDelay');
    //return;    
}

reliable client simulated function ClientEndPull()
{
    m_bIsPulling = false;
    m_PullTarget = none;
    LockInput(false);
    // End:0x57
    if(IsTimerActive('FirePreHitDelay'))
    {
        ClearTimer('FirePreHitDelay');
        FirePreHitDelay();
    }
    SetTimer(m_fTruePostfireTime, false, 'FirePostHitDelay');
    //return;    
}

function SetIsPullingHitSpecial(bool bIsPulling)
{
    local TgDeviceFire FireMode;

    FireMode = GetCurrentFire();
    // End:0x89
    if(FireMode != none)
    {
        // End:0x5E
        if(bIsPulling)
        {
            FireMode.ApplyHitSpecial(Instigator);            
        }
        else
        {
            FireMode.RemoveHitSpecial(Instigator, false);
        }
    }
    //return;    
}

simulated function Tick(float DeltaSeconds)
{
    super(Actor).Tick(DeltaSeconds);
    //return;    
}

simulated event bool ShouldCooldownAfterFire()
{
    return true;
    //return ReturnValue;    
}

function AuthStartCooldown(optional int nMode = -1, optional float fCooldownTimeOverride = -1.0000000)
{
    local TgDeviceFire FireMode;

    // End:0xAF
    if(m_bMissedPull && fCooldownTimeOverride < 0.0000000)
    {
        // End:0x63
        if(nMode >= 0)
        {
            FireMode = GetDeviceFire(nMode);            
        }
        else
        {
            FireMode = GetCurrentFire();
        }
        // End:0xAF
        if(FireMode != none)
        {
            fCooldownTimeOverride = FireMode.GetCustomValue5();
        }
    }
    super.AuthStartCooldown(nMode, fCooldownTimeOverride);
    //return;    
}

simulated event bool CanBeCanceled()
{
    return false;
    //return ReturnValue;    
}

simulated state DeviceFiring
{
    simulated function FirePreHitDelay()
    {
        LockInput(true);
        m_bTeleportedAfterFiring = false;
        super.FirePreHitDelay();
        //return;        
    }

    simulated function Tick(float DeltaSeconds)
    {
        local TgPawn TgP;
        local TgDeviceFire FireMode;

        super(Actor).Tick(DeltaSeconds);
        // End:0x2D8
        if(int(Role) == int(ROLE_Authority))
        {
            // End:0x27D
            if(m_bIsPulling)
            {
                FireMode = GetCurrentFire();
                // End:0xC0
                if(((m_PullTarget != none) && FireMode != none) && FireMode.IsValidTarget(m_PullTarget))
                {
                    m_vPullLocation = m_PullTarget.Location;
                }
                TgP = TgPawn(Instigator);
                // End:0x27A
                if(TgP != none)
                {
                    // End:0x190
                    if(VSizeSq(m_vPullLocation - TgP.Location) < (((m_fPullEndOffset * m_fPullEndOffset) * float(16)) * float(16)))
                    {
                        TgP.Velocity = TgP.Velocity * m_fMomentumAfterPull;
                        EndPull();                        
                    }
                    else
                    {
                        // End:0x217
                        if((m_bHasPulledOnce && (((m_fPullSpeed * m_fPullSpeed) * 0.2000000) * 0.2000000) > VSizeSq(TgP.Velocity)) || TgP.bJustTeleported)
                        {
                            EndPull();                            
                        }
                        else
                        {
                            m_bHasPulledOnce = true;
                            TgP.Velocity = -Normal(TgP.Location - m_vPullLocation) * m_fPullSpeed;
                        }
                    }
                }                
            }
            else
            {
                TgP = TgPawn(Instigator);
                // End:0x2D8
                if((TgP != none) && TgP.bJustTeleported)
                {
                    m_bTeleportedAfterFiring = true;
                }
            }
        }
        //return;        
    }

    simulated function StopFiringLogic()
    {
        local TgPawn TgP;

        super.StopFiringLogic();
        LockInput(false);
        // End:0xA0
        if(m_bIsPulling)
        {
            TgP = TgPawn(Instigator);
            // End:0x94
            if(TgP != none)
            {
                TgP.SetProperty(32, TgP.GetPropCurrentValue(32) - float(1));
            }
            m_bIsPulling = false;
        }
        m_PullTarget = none;
        //return;        
    }
    stop;    
}

defaultproperties
{
    m_fPullSpeed=2000.0000000
    m_fTruePostfireTime=0.3000000
    m_fPullEndOffset=7.0000000
    m_fMomentumAfterPull=1.0000000
}