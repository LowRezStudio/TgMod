class TgDevice_ShoulderBash extends TgDevice_Charge
    native(ChampFlak)
    hidecategories(Navigation)
    implements(TgDeviceInterface_MoveSpeedMultiplier);

var private native const noexport Pointer VfTable_ITgDeviceInterface_MoveSpeedMultiplier;
var bool m_bHasHitTarget;

// Export UTgDevice_ShoulderBash::execUsesTargetingMode(FFrame&, void* const)
native function bool UsesTargetingMode();

// Export UTgDevice_ShoulderBash::execGetMoveSpeedMultiplier(FFrame&, void* const)
native function float GetMoveSpeedMultiplier();

reliable server function ValidateChargeHit(Actor Other)
{
    // End:0x0F
    if(m_bHasHitTarget)
    {
        return;
    }
    // End:0xB2
    if(ServerValidateChargeHit(Other))
    {
        ApplyTouchHit(TgPawn(Instigator), Other.Location, Normal(Instigator.Location - Other.Location), Other);
        InterruptFiring();
    }
    //return;    
}

function ApplyTouchHit(TgPawn InstigatorPawn, Vector vHitLocation, Vector vHitNormal, Actor Target)
{
    local ImpactInfo Impact;
    local TgDeviceFire FireMode;
    local Vector chargeDirection;

    FireMode = GetCurrentFire();
    chargeDirection = Vector(GetChargeDirection());
    Impact.bDirectHit = false;
    Impact.DeviceModeReference = FireMode;
    Impact.HitActor = Target;
    Impact.HitLocation = Target.Location - chargeDirection;
    Impact.HitNormal = vHitNormal;
    Impact.StartTrace = ((Instigator != none) ? Instigator.Location : vect(0.0000000, 0.0000000, 0.0000000));
    Impact.RayDir = -Impact.HitNormal;
    // End:0x220
    if(!m_bHitOnce || s_HitActors.Find(Target) == -1)
    {
        ApplyDamageReduction(Impact);
        FireMode.ApplyHit(Impact, Instigator);
        s_HitActors.AddItem(Target);
    }
    //return;    
}

simulated function bool ShouldStopOnThisHit(Actor Other)
{
    local TgPawn pPawn;

    pPawn = TgPawn(Other);
    // End:0x56
    if(pPawn != none)
    {
        // End:0x56
        if(int(pPawn.r_eChargeState) != int(0))
        {
            return false;
        }
    }
    return super.ShouldStopOnThisHit(Other);
    //return ReturnValue;    
}

simulated state DeviceFiring
{
    simulated function OnStoppedChargeOnHit(Actor Other)
    {
        local TgPawn_Flak pFlak;

        super.OnStoppedChargeOnHit(Other);
        // End:0x5A
        if((int(Role) < int(ROLE_Authority)) && !m_bHasHitTarget)
        {
            ValidateChargeHit(Other);
            m_bHasHitTarget = true;            
        }
        else
        {
            // End:0x7A
            if(int(Role) == int(ROLE_Authority))
            {
                m_bHasHitTarget = true;
            }
        }
        // End:0xD5
        if(Other != none)
        {
            pFlak = TgPawn_Flak(Instigator);
            // End:0xD5
            if(pFlak != none)
            {
                pFlak.m_bUseShoulderBashRetrieve = true;
            }
        }
        //return;        
    }

    simulated event StartCharge()
    {
        local TgPawn_Flak pFlak;

        pFlak = TgPawn_Flak(Instigator);
        // End:0x4C
        if(pFlak != none)
        {
            pFlak.m_bUseShoulderBashZoom = true;
        }
        m_bHasHitTarget = false;
        super.StartCharge();
        //return;        
    }

    simulated event ChargeTouch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal)
    {
        local TgDeviceFire FireMode;
        local TgPawn InstigatorPawn;
        local bool bValidHitLocation;

        FireMode = GetCurrentFire();
        InstigatorPawn = TgPawn(Instigator);
        // End:0x15A
        if(((InstigatorPawn != none) && FireMode != none) && FireMode.IsValidTarget(Other))
        {
            bValidHitLocation = InstigatorPawn.VerifyChargeHit(HitLocation, HitNormal, Other.Location, Other);
            // End:0x15A
            if(bValidHitLocation)
            {
                OnValidTargetTouched(Other);
                // End:0x15A
                if(ShouldStopOnThisHit(Other))
                {
                    OnStoppedChargeOnHit(Other);
                    ApplyTouchHit(InstigatorPawn, HitLocation, HitNormal, Other);
                }
            }
        }
        //return;        
    }
    stop;    
}

defaultproperties
{
    m_bStopOnHitType=ChargeStopOnHitType.CSHT_AnyValidTarget
    m_ChargeTimingType=ChargeFiringType.CFT_PostFire
    m_bApplyHitOnTouch=false
    m_bIgnoreMovementCorrection=true
}