class TgDevice_RestoreSoul extends TgDevice
    native(ChampOracle)
    hidecategories(Navigation);

var TgPawn_Oracle m_CachedOraclePawn;
var ImpactInfo m_CachedImpact;
var bool m_bApplyCooldown;

// Export UTgDevice_RestoreSoul::execCanDeviceFireNow(FFrame&, void* const)
native function bool CanDeviceFireNow(byte FireModeNum, AimData Aim, bool bDeviceFailLog, out TgObject.EDeviceFailType failType);

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

simulated event bool CanBeInterrupted()
{
    // End:0x0F
    if(m_bPreventInterrupt)
    {
        return false;
    }
    // End:0x1E
    if(IsFiring())
    {
        return true;
    }
    return super.CanBeInterrupted();
    //return ReturnValue;    
}

simulated function bool HasCachedOracle()
{
    // End:0x2B
    if(m_CachedOraclePawn == none)
    {
        m_CachedOraclePawn = TgPawn_Oracle(Instigator);
    }
    return m_CachedOraclePawn != none;
    //return ReturnValue;    
}

simulated event DeliverQueuedPendingHits()
{
    // End:0x1A
    if(PendingImpactList.Length == 0)
    {
        InterruptFiring();
    }
    super.DeliverQueuedPendingHits();
    //return;    
}

simulated event bool ShouldCooldownAfterFire()
{
    return false;
    //return ReturnValue;    
}

simulated event DeliverHit(ImpactInfo Impact)
{
    local TgDeviceFire_RestoreSoul FireMode;

    FireMode = TgDeviceFire_RestoreSoul(GetCurrentFire());
    m_CachedImpact = Impact;
    // End:0x93
    if((m_CachedImpact.HitActor != none) && FireMode != none)
    {
        SetTimer(FireMode.GetCustomValue2(), false, 'DelayedDeliverHit');        
    }
    else
    {
        InterruptFiring();
    }
    //return;    
}

simulated function DelayedDeliverHit()
{
    local TgDeviceFire_RestoreSoul FireMode;
    local TgDevice talentDevice;
    local TgDeviceFire talentFire;
    local TgPawn TargetPawn;

    FireMode = TgDeviceFire_RestoreSoul(GetCurrentFire());
    DeliverHit(m_CachedImpact);
    TargetPawn = TgPawn(m_CachedImpact.HitActor);
    // End:0x288
    if(((((FireMode != none) && TargetPawn != none) && TargetPawn.IsAliveAndWell()) && HasCachedOracle()) && !FireMode.CheckTeamPassThrough(TargetPawn, m_CachedImpact.RayDir))
    {
        m_bApplyCooldown = true;
        FireMode.ApplyHitSpecial(m_CachedImpact.HitActor, m_CachedImpact);
        m_CachedOraclePawn.r_RestoreSoulTarget = m_CachedImpact.HitActor;
        m_CachedOraclePawn.bNetDirty = true;
        // End:0x285
        if(FireMode.IsAbyssalFuryActive())
        {
            talentDevice = m_CachedOraclePawn.GetDeviceByEqPoint(26);
            // End:0x285
            if(talentDevice != none)
            {
                talentFire = talentDevice.GetCurrentFire();
                // End:0x285
                if(talentFire != none)
                {
                    talentFire.ApplyHitSpecial(m_CachedImpact.HitActor, m_CachedImpact);
                }
            }
        }        
    }
    else
    {
        InterruptFiring();
    }
    //return;    
}

simulated function ImpactInfo CalcWeaponFire(AimData Aim, optional out array<ImpactInfo> ImpactList)
{
    local ImpactInfo Impact;

    Impact = super.CalcWeaponFire(Aim, ImpactList);
    UpdateHitTargetInfo(Impact.HitActor, Impact.HitLocation);
    return Impact;
    //return ReturnValue;    
}

function OnInstantShotVerified(ImpactInfo VerifiedPrimaryImpact)
{
    UpdateHitTargetInfo(VerifiedPrimaryImpact.HitActor, VerifiedPrimaryImpact.HitLocation);
    //return;    
}

function OnInstantShotRejected(ImpactToValidate RejectedPrimaryImpact)
{
    UpdateHitTargetInfo(none, RejectedPrimaryImpact.Impact.HitLocation);
    m_bApplyCooldown = false;
    //return;    
}

simulated function UpdateHitTargetInfo(Actor HitActor, Vector HitLocation)
{
    // End:0xF8
    if(HasCachedOracle())
    {
        // End:0x61
        if(m_CachedOraclePawn.r_RestoreSoulTarget != HitActor)
        {
            m_CachedOraclePawn.r_RestoreSoulTarget = HitActor;
        }
        // End:0xD7
        if(m_CachedOraclePawn.r_RestoreSoulTarget != none)
        {
            // End:0xD7
            if(!IsZero(m_CachedOraclePawn.r_RestoreSoulHitOffset))
            {
                m_CachedOraclePawn.r_RestoreSoulHitOffset = vect(0.0000000, 0.0000000, 0.0000000);
            }
        }
        m_CachedOraclePawn.bNetDirty = true;
    }
    //return;    
}

simulated state DeviceFiring
{
    simulated function Tick(float DeltaTime)
    {
        local TgPawn Pawn;

        super(Actor).Tick(DeltaTime);
        // End:0x90
        if(HasCachedOracle())
        {
            Pawn = TgPawn(m_CachedOraclePawn.r_RestoreSoulTarget);
            // End:0x90
            if((Pawn == none) || !Pawn.IsAliveAndWell())
            {
                InterruptFiring();
            }
        }
        //return;        
    }

    simulated function StartFiringLogic()
    {
        local TgDeviceForm_OracleInhand inhandDeviceForm;

        super.StartFiringLogic();
        m_bApplyCooldown = false;
        // End:0x12B
        if(HasCachedOracle())
        {
            m_CachedOraclePawn.r_bRestoreSoulActive = true;
            m_CachedOraclePawn.bNetDirty = true;
            // End:0x12B
            if(int(WorldInfo.NetMode) == int(NM_Standalone))
            {
                inhandDeviceForm = TgDeviceForm_OracleInhand(m_CachedOraclePawn.c_EquipForm[1]);
                // End:0x12B
                if(inhandDeviceForm != none)
                {
                    inhandDeviceForm.UpdateAmmoCountFx(inhandDeviceForm.m_fPreviousAmmoPerc, inhandDeviceForm.m_fCurrentAmmoPerc);
                }
            }
        }
        //return;        
    }

    simulated function StopFiringLogic()
    {
        local TgDeviceFire_RestoreSoul FireMode;
        local TgDevice talentDevice;
        local TgDeviceFire talentFire;
        local TgDeviceForm_OracleInhand inhandDeviceForm;

        FireMode = TgDeviceFire_RestoreSoul(GetCurrentFire());
        super.StopFiringLogic();
        // End:0x19A
        if((FireMode != none) && HasCachedOracle())
        {
            FireMode.RemoveHitSpecial(m_CachedOraclePawn.r_RestoreSoulTarget, true);
            // End:0x159
            if(FireMode.IsAbyssalFuryActive())
            {
                talentDevice = m_CachedOraclePawn.GetDeviceByEqPoint(26);
                // End:0x159
                if(talentDevice != none)
                {
                    talentFire = talentDevice.GetCurrentFire();
                    // End:0x159
                    if(talentFire != none)
                    {
                        talentFire.RemoveHitSpecial(m_CachedOraclePawn.r_RestoreSoulTarget, true);
                    }
                }
            }
            m_CachedOraclePawn.r_RestoreSoulTarget = none;
            m_CachedOraclePawn.bNetDirty = true;
        }
        ClearTimer('DelayedDeliverHit');
        // End:0x1DD
        if(m_bApplyCooldown && int(Role) == int(ROLE_Authority))
        {
            StartCooldown();
        }
        // End:0x2F2
        if(HasCachedOracle())
        {
            m_CachedOraclePawn.r_bRestoreSoulActive = false;
            m_CachedOraclePawn.bNetDirty = true;
            // End:0x2F2
            if(int(WorldInfo.NetMode) == int(NM_Standalone))
            {
                inhandDeviceForm = TgDeviceForm_OracleInhand(m_CachedOraclePawn.c_EquipForm[1]);
                // End:0x2F2
                if(inhandDeviceForm != none)
                {
                    inhandDeviceForm.UpdateAmmoCountFx(inhandDeviceForm.m_fPreviousAmmoPerc, inhandDeviceForm.m_fCurrentAmmoPerc);
                }
            }
        }
        //return;        
    }
    stop;    
}

defaultproperties
{
    m_DeviceTimerBarType=DeviceTimerBarType.DTBT_PostHit
}