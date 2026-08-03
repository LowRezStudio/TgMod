class TgDevice_Rush extends TgDevice_Charge
    native(ChampLazarus)
    hidecategories(Navigation);

var TgPawn r_PawnTarget;
var float m_fWalkableFloorZ;
var float m_fZoomDurationOverride;
var bool m_bHitWall;

replication
{
    // Pos:0x000
    if(int(Role) == int(ROLE_Authority))
        r_PawnTarget;
}

// Export UTgDevice_Rush::execTurnTargetToOwner(FFrame&, void* const)
native function TurnTargetToOwner();

// Export UTgDevice_Rush::execPredictChargeInterrupt(FFrame&, void* const)
native function bool PredictChargeInterrupt(Vector StartLocation, Vector endLocation);

// Export UTgDevice_Rush::execMoveTargetToSafeArea(FFrame&, void* const)
native function MoveTargetToSafeArea(TgPawn pPawnTarget);

simulated event bool ShouldLockFiring(TgDevice Current)
{
    // End:0x2A
    if(Current.m_nDeviceType == 11077)
    {
        return false;
    }
    return (IsFiring()) || IsTimerActive('OutroLockoutTime');
    //return ReturnValue;    
}

simulated function OutroLockoutTime()
{
    local TgPawn TgP;

    TgP = TgPawn(Instigator);
    // End:0x4F
    if(TgP != none)
    {
        TgP.m_fZoomDurationOverride = 0.0000000;
    }
    //return;    
}

simulated event bool CanFiringBeCanceledByReactivation()
{
    return true;
    //return ReturnValue;    
}

simulated event bool CanBeCanceled()
{
    return true;
    //return ReturnValue;    
}

simulated state DeviceFiring
{
    simulated function OnValidTargetTouched(Actor Other)
    {
        local TgPawn TargetPawn, InstigatorPawn;
        local float fChargeTimeRemaining;
        local Vector vLocationOffset;
        local Rotator rRotationOffset;
        local TgDeviceFire FireMode;
        local ImpactInfo Impact;

        m_bHitWall = false;
        // End:0x407
        if((((int(Role) == int(ROLE_Authority)) && r_PawnTarget == none) && Other != none) && Instigator != none)
        {
            TargetPawn = TgPawn(Other);
            InstigatorPawn = TgPawn(Instigator);
            fChargeTimeRemaining = GetRemainingTimeForTimer('FirePostHitDelay');
            FireMode = GetCurrentFire();
            // End:0x407
            if((((TargetPawn != none) && InstigatorPawn != none) && fChargeTimeRemaining > 0.0000000) && FireMode != none)
            {
                // End:0x1A6
                if(TargetPawn.IsCrowdControlImmune() || TargetPawn.SpecialAOEImmunity(m_HitProxy.Location, FireMode))
                {
                    // End:0x1A3
                    if(TargetPawn.GetPropCurrentValue(116) == float(0))
                    {
                        InterruptFiring();
                    }                    
                }
                else
                {
                    // End:0x407
                    if(TargetPawn.CanBeGrabbed())
                    {
                        vLocationOffset = Normal(InstigatorPawn.GetChargeDirection());
                        vLocationOffset *= (1.1000000 * (InstigatorPawn.NativeGetCollisionRadius() + TargetPawn.NativeGetCollisionRadius()));
                        vLocationOffset.Z = InstigatorPawn.NativeGetCollisionHeight() * 0.6600000;
                        rRotationOffset = Rotator(vect(-1.0000000, 0.0000000, 0.0000000));
                        r_PawnTarget = TargetPawn;
                        bNetDirty = true;
                        // End:0x407
                        if(!PredictChargeInterrupt(r_PawnTarget.Location, InstigatorPawn.Location + vLocationOffset))
                        {
                            r_PawnTarget.StartPhysGrab(InstigatorPawn, fChargeTimeRemaining, 2,, vLocationOffset, rRotationOffset);
                            Impact.bDirectHit = m_bUseDirectHitSpecial;
                            Impact.DeviceModeReference = FireMode;
                            Impact.HitActor = r_PawnTarget;
                            FireMode.ApplyHitSpecial(r_PawnTarget, Impact, 10693);
                        }
                    }
                }
            }
        }
        //return;        
    }

    simulated event EndCharge()
    {
        local TgDeviceFire FireMode;
        local ImpactInfo Impact;

        super.EndCharge();
        // End:0x1C4
        if((int(Role) == int(ROLE_Authority)) && r_PawnTarget != none)
        {
            r_PawnTarget.EndPhysGrab();
            FireMode = GetCurrentFire();
            // End:0x19A
            if(FireMode != none)
            {
                Impact.bDirectHit = true;
                Impact.DeviceModeReference = FireMode;
                Impact.HitActor = r_PawnTarget;
                Impact.HitNormal = Normal(Instigator.Location - r_PawnTarget.Location);
                FireMode.ApplyHit(Impact, Instigator);
                FireMode.RemoveHitSpecial(r_PawnTarget, true, 10693);
            }
            MoveTargetToSafeArea(r_PawnTarget);
            r_PawnTarget = none;
            bNetDirty = true;
        }
        //return;        
    }
    stop;    
}

defaultproperties
{
    m_fWalkableFloorZ=0.7000000
    m_fZoomDurationOverride=0.1000000
    m_ChargeTimingType=ChargeFiringType.CFT_PostFire
    m_bApplyHitOnTouch=false
    m_vHitProxyRelativeLocation=(X=30.0000000,Y=0.0000000,Z=0.0000000)
    m_bUsesOutroLockout=true
    m_fOutroLockoutTime=0.3000000
}