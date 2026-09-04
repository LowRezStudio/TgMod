class TgDevice_Thrust extends TgDevice_Charge
    native(ChampDrogoz)
    hidecategories(Navigation);

// Export UTgDevice_Thrust::execGetTargetingAim(FFrame&, void* const)
native function GetTargetingAim(out AimData Aim);

simulated event bool ShouldLockFiring(TgDevice Current)
{
    // End:0x35
    if((Current != none) && Current.m_bHandDevice)
    {
        return false;
    }
    return super.ShouldLockFiring(Current);
    //return ReturnValue;    
}

simulated event float GetChargeRange()
{
    local float upwardsDistUU, forwardsDistUU;

    upwardsDistUU = GetCurrentFire().GetCustomValue2() * float(16);
    forwardsDistUU = GetCurrentFire().GetCustomValue1() * float(16);
    return Sqrt((upwardsDistUU * upwardsDistUU) + (forwardsDistUU * forwardsDistUU));
    //return ReturnValue;    
}

simulated function bool ShouldInterruptReloadOnFire()
{
    return false;
    //return ReturnValue;    
}

simulated state DeviceFiring
{
    simulated function StartFiringLogic()
    {
        local TgPawn_Drogoz drogozOwner;

        drogozOwner = TgPawn_Drogoz(Owner);
        // End:0x4C
        if(drogozOwner != none)
        {
            drogozOwner.m_bThrusterIsBlocking = true;
        }
        super.StartFiringLogic();
        //return;        
    }

    simulated function StopFiringLogic()
    {
        local TgPawn_Drogoz drogozOwner;

        drogozOwner = TgPawn_Drogoz(Owner);
        // End:0x4C
        if(drogozOwner != none)
        {
            drogozOwner.m_bThrusterIsBlocking = false;
        }
        super.StopFiringLogic();
        //return;        
    }

    simulated event EndCharge()
    {
        local TgPawn PawnOwner;

        super.EndCharge();
        PawnOwner = TgPawn(Owner);
        // End:0x4F
        if(PawnOwner != none)
        {
            PawnOwner.SetPhysics(2);
        }
        //return;        
    }
    stop;    
}

defaultproperties
{
    m_bUsePhysFlying=true
    m_bIgnoreRange=true
    m_bForce3PViewWhileFiring=false
    m_bAbilityRequiresInhandResync=false
}