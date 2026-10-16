class TgDevice_AstroQ extends TgDevice
    native(ChampAstro)
    hidecategories(Navigation);

var bool m_bApplyCooldown;

// Export UTgDevice_AstroQ::execCanDeviceFireNow(FFrame&, void* const)
native function bool CanDeviceFireNow(byte FireModeNum, AimData Aim, bool bDeviceFailLog, out TgObject.EDeviceFailType failType);

simulated event DeliverHit(ImpactInfo Impact)
{
    local TgPawn_Astro pAstro;
    local TgDeviceFire pFireMode;

    super.DeliverHit(Impact);
    pAstro = TgPawn_Astro(Owner);
    // End:0xE3
    if(pAstro != none)
    {
        pFireMode = GetCurrentFire();
        // End:0xE3
        if(pFireMode.IsValidTarget(Impact.HitActor))
        {
            pAstro.m_HitGravityLiftTarget = TgPawn_Character(Impact.HitActor);
            m_bApplyCooldown = true;
        }
    }
    //return;    
}

simulated function InterruptOtherDevices(TgPawn TgP)
{
    super.InterruptOtherDevices(TgP);
    // End:0x5F
    if(int(Role) == int(ROLE_Authority))
    {
        // End:0x5F
        if(TgP != none)
        {
            TgP.InterruptDeviceFiringByClass(Class'TgGame.TgDevice_Lightspeed', true);
        }
    }
    //return;    
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

function OnInstantShotRejected(ImpactToValidate RejectedPrimaryImpact)
{
    m_bApplyCooldown = false;
    //return;    
}

simulated state DeviceFiring
{
    simulated function StartFiringLogic()
    {
        m_bApplyCooldown = false;
        super.StartFiringLogic();
        //return;        
    }

    simulated function StopFiringLogic()
    {
        local TgPawn_Astro pAstro;
        local TgDevice pDeadSpaceCard;

        super.StopFiringLogic();
        pAstro = TgPawn_Astro(Owner);
        // End:0x97
        if(pAstro != none)
        {
            pDeadSpaceCard = pAstro.GetDeviceByClass(Class'TgGame.TgDevice_DeadSpace');
            // End:0x97
            if(pDeadSpaceCard != none)
            {
                pAstro.m_bDeadSpaceTimerActive = true;
            }
        }
        // End:0xC6
        if(m_bApplyCooldown && int(Role) == int(ROLE_Authority))
        {
            StartCooldown();
        }
        //return;        
    }
    stop;    
}
