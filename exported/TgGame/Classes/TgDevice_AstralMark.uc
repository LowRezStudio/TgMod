class TgDevice_AstralMark extends TgDevice
    native(ChampAstro)
    hidecategories(Navigation);

// Export UTgDevice_AstralMark::execCanDeviceFireNow(FFrame&, void* const)
native function bool CanDeviceFireNow(byte FireModeNum, AimData Aim, bool bDeviceFailLog, out TgObject.EDeviceFailType failType);

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
    // End:0x1C
    if(PendingImpactList.Length != 0)
    {
        StartCooldown();
    }
    super.DeliverQueuedPendingHits();
    //return;    
}

simulated event DeliverHit(ImpactInfo Impact)
{
    local TgPawn_Astro pAstro;
    local TgPawn pPawn;

    super.DeliverHit(Impact);
    pAstro = TgPawn_Astro(Instigator);
    pPawn = TgPawn(Impact.HitActor);
    // End:0x110
    if((pAstro != none) && pPawn != none)
    {
        pAstro.r_HitAstralTarget = pPawn.GetPRI();
        pAstro.bNetDirty = true;
        // End:0x110
        if(int(Role) == int(ROLE_Authority))
        {
            pAstro.AddAstralMarkTarget();
        }
    }
    //return;    
}

simulated event bool ShouldCooldownAfterFire()
{
    return false;
    //return ReturnValue;    
}

simulated state DeviceFiring
{
    simulated function StopFiringLogic()
    {
        local TgPawn_Astro pAstro;

        super.StopFiringLogic();
        pAstro = TgPawn_Astro(Owner);
        // End:0x96
        if(pAstro != none)
        {
            pAstro.r_HitAstralTarget = none;
            pAstro.r_RemoveAstralTarget = none;
            pAstro.bNetDirty = true;
        }
        //return;        
    }
    stop;    
}
