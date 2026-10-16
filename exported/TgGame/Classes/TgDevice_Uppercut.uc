class TgDevice_Uppercut extends TgDevice_Charge
    native(ChampDemon)
    hidecategories(Navigation);

// Export UTgDevice_Uppercut::execGetTargetingAim(FFrame&, void* const)
native function GetTargetingAim(out AimData Aim);

simulated function bool IsUltActive()
{
    local TgPawn_Demon PawnOwner;

    PawnOwner = TgPawn_Demon(Owner);
    // End:0x4B
    if(PawnOwner != none)
    {
        return PawnOwner.r_bIsUltActive;
    }
    return false;
    //return ReturnValue;    
}

simulated event DeliverHit(ImpactInfo Impact)
{
    local ImpactInfo ModifiedImpact;
    local AimData Aim;

    ModifiedImpact = Impact;
    GetTargetingAim(Aim);
    ModifiedImpact.HitNormal = -Aim.AimVector;
    super(TgDevice).DeliverHit(ModifiedImpact);
    //return;    
}

simulated event bool CanBeInterrupted()
{
    return false;
    //return ReturnValue;    
}

simulated state DeviceFiring
{
    simulated function OnStoppedChargeOnHit(Actor Other)
    {
        ClearTimer('FirePreHitDelay');
        FirePreHitDelay();
        //return;        
    }

    simulated event EndCharge()
    {
        local TgDeviceFire FireMode;

        super.EndCharge();
        FireMode = GetCurrentFire();
        // End:0x7D
        if((Owner != none) && FireMode != none)
        {
            Owner.Velocity *= FireMode.GetCustomValue1();
        }
        //return;        
    }
    stop;    
}

defaultproperties
{
    m_bStopOnHitType=ChargeStopOnHitType.CSHT_GodOnly
    m_ChargeTimingType=ChargeFiringType.CFT_PreFire
    m_bApplyHitOnTouch=false
    m_bForce3PViewWhileFiring=false
}