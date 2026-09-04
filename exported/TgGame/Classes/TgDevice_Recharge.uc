class TgDevice_Recharge extends TgDevice
    native(ChampGauntlet)
    hidecategories(Navigation);

var TgPawn_Gauntlet m_CachedGauntletPawn;

simulated event bool ShouldLockFiring(TgDevice Current)
{
    // End:0x3B
    if((Current != none) && Current.r_nDeviceId == 15793)
    {
        return false;
    }
    return super.ShouldLockFiring(Current);
    //return ReturnValue;    
}

simulated event bool IsFunctionallyToggleDevice()
{
    return true;
    //return ReturnValue;    
}

simulated function bool ShouldStopActionOnOffhandSlotReleased()
{
    return false;
    //return ReturnValue;    
}

simulated event bool CanBeCanceled()
{
    return super.CanBeCanceled() && !IsTimerActive('CancelSafetyTimer');
    //return ReturnValue;    
}

simulated function CancelSafetyTimer()
{
    //return;    
}

function StartCooldownTimer()
{
    SetTimer(GetCurrentFire().GetPersistTime(), false, 'CooldownTimer');
    ClientStartCooldownTimer();
    //return;    
}

reliable client simulated function ClientStartCooldownTimer()
{
    SetTimer(GetCurrentFire().GetPersistTime(), false, 'CooldownTimer');
    //return;    
}

simulated function CooldownTimer()
{
    // End:0x1E
    if(int(Role) == int(ROLE_Authority))
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

simulated function UpdateHitTargetInfo(Actor HitActor, Vector HitLocation)
{
    local TgDeployable deployTarget;

    // End:0x1C1
    if(HasCachedGauntlet())
    {
        // End:0x61
        if(m_CachedGauntletPawn.r_RechargeTarget != HitActor)
        {
            m_CachedGauntletPawn.r_RechargeTarget = HitActor;
        }
        // End:0x1A0
        if(m_CachedGauntletPawn.r_RechargeTarget != none)
        {
            deployTarget = TgDeployable(HitActor);
            // End:0x14E
            if((deployTarget != none) && int(deployTarget.m_CollisionSettings.mCollisionMode) != int(0))
            {
                m_CachedGauntletPawn.r_RechargeHitOffset = HitLocation - m_CachedGauntletPawn.r_RechargeTarget.Location;                
            }
            else
            {
                // End:0x1A0
                if(!IsZero(m_CachedGauntletPawn.r_RechargeHitOffset))
                {
                    m_CachedGauntletPawn.r_RechargeHitOffset = vect(0.0000000, 0.0000000, 0.0000000);
                }
            }
        }
        m_CachedGauntletPawn.bNetDirty = true;
    }
    //return;    
}

simulated function bool HasCachedGauntlet()
{
    // End:0x2B
    if(m_CachedGauntletPawn == none)
    {
        m_CachedGauntletPawn = TgPawn_Gauntlet(Instigator);
    }
    return m_CachedGauntletPawn != none;
    //return ReturnValue;    
}

simulated state DeviceFiring
{
    simulated function StartFiringLogic()
    {
        // End:0x46
        if((Instigator != none) && Instigator.IsLocallyControlled())
        {
            SetTimer(0.5000000, false, 'CancelSafetyTimer');
        }
        // End:0x7F
        if((int(Role) == int(ROLE_Authority)) && !IsTimerActive('CooldownTimer'))
        {
            StartCooldownTimer();
        }
        super.StartFiringLogic();
        //return;        
    }

    simulated function StopFiringLogic()
    {
        ClearTimer('CooldownTimer');
        super.StopFiringLogic();
        //return;        
    }
    stop;    
}
