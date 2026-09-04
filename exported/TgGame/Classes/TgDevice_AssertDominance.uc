class TgDevice_AssertDominance extends TgDevice_Leap
    native(ChampFlak)
    hidecategories(Navigation);

// Export UTgDevice_AssertDominance::execGetCachedFiringPostHitDelay(FFrame&, void* const)
native function float GetCachedFiringPostHitDelay();

// Export UTgDevice_AssertDominance::execShouldLiftInterrupt(FFrame&, void* const)
native function bool ShouldLiftInterrupt();

reliable client simulated event ClientInterrupt()
{
    LockInput(false);
    super(TgDevice).ClientInterrupt();
    //return;    
}

simulated event bool ShouldLockFiring(TgDevice Current)
{
    // End:0x0F
    if(IsFiring())
    {
        return true;
    }
    return false;
    //return ReturnValue;    
}

simulated event bool ShouldMountCancelFiring()
{
    return false;
    //return ReturnValue;    
}

simulated function bool ShouldInterruptReloadOnFire()
{
    return false;
    //return ReturnValue;    
}

simulated event DeliverHit(ImpactInfo Impact)
{
    local TgDeviceFire FireMode;
    local TgDevice RallyHereCard;
    local TgPawn TgPOwner;

    TgPOwner = TgPawn(Owner);
    FireMode = GetCurrentFire();
    RallyHereCard = TgPOwner.GetDeviceById(18416);
    // End:0xEB
    if(((FireMode != none) && Impact.HitActor != none) && RallyHereCard != none)
    {
        FireMode.ApplyHitSpecial(Impact.HitActor, Impact);        
    }
    else
    {
        // End:0x14F
        if((FireMode != none) && Impact.HitActor != none)
        {
            FireMode.ApplyHit(Impact, Instigator);
        }
    }
    //return;    
}

simulated state DeviceFiring
{
    simulated function StartFiringLogic()
    {
        local TgPawn_Flak pFlak;

        super.StartFiringLogic();
        pFlak = TgPawn_Flak(Instigator);
        // End:0x75
        if(pFlak != none)
        {
            pFlak.StartZTracking();
            pFlak.m_bUseShoulderBashZoom = false;
        }
        //return;        
    }

    simulated function FirePreHitDelay()
    {
        local TgPawn_Flak pFlak;
        local TgDeviceForm_Dominance DeviceForm;

        super.FirePreHitDelay();
        LockInput(true);
        pFlak = TgPawn_Flak(Instigator);
        // End:0xDC
        if(pFlak != none)
        {
            // End:0x73
            if(int(Role) == int(ROLE_Authority))
            {
                pFlak.SpawnFlagDeployable();
            }
            DeviceForm = TgDeviceForm_Dominance(c_DeviceForm);
            // End:0xBD
            if(DeviceForm != none)
            {
                DeviceForm.HideFlag();
            }
            pFlak.ResetGravTimers();
        }
        //return;        
    }

    simulated function FirePostHitDelay()
    {
        LockInput(false);
        super.FirePostHitDelay();
        //return;        
    }
    stop;    
}

defaultproperties
{
    m_bAbilityRequiresInhandResync=false
}