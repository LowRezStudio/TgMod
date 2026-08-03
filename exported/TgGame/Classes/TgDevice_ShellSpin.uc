class TgDevice_ShellSpin extends TgDevice_Charge
    native(ChampMakoa)
    hidecategories(Navigation);

var TgPawn r_PawnTarget;
var float m_fWalkableFloorZ;
var float m_fZoomDurationOverride;
var bool m_bCarryEnemies;

replication
{
    // Pos:0x000
    if(int(Role) == int(ROLE_Authority))
        r_PawnTarget;
}

// Export UTgDevice_ShellSpin::execTurnTargetToOwner(FFrame&, void* const)
native function TurnTargetToOwner();

// Export UTgDevice_ShellSpin::execPredictChargeInterrupt(FFrame&, void* const)
native function bool PredictChargeInterrupt(Vector StartLocation, Vector endLocation);

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

        // End:0x404
        if(m_bCarryEnemies)
        {
            // End:0x404
            if((((int(Role) == int(ROLE_Authority)) && r_PawnTarget == none) && Other != none) && Instigator != none)
            {
                TargetPawn = TgPawn(Other);
                InstigatorPawn = TgPawn(Instigator);
                fChargeTimeRemaining = GetRemainingTimeForTimer('FirePostHitDelay');
                FireMode = GetCurrentFire();
                // End:0x404
                if((((TargetPawn != none) && InstigatorPawn != none) && fChargeTimeRemaining > 0.0000000) && FireMode != none)
                {
                    // End:0x1A7
                    if(TargetPawn.IsCrowdControlImmune() || TargetPawn.SpecialAOEImmunity(m_HitProxy.Location, FireMode))
                    {
                        // End:0x1A4
                        if(TargetPawn.GetPropCurrentValue(116) == float(0))
                        {
                            InterruptFiring();
                        }                        
                    }
                    else
                    {
                        // End:0x404
                        if(TargetPawn.CanBeGrabbed())
                        {
                            vLocationOffset = Normal(InstigatorPawn.GetChargeDirection());
                            vLocationOffset *= (1.1000000 * (InstigatorPawn.NativeGetCollisionRadius() + TargetPawn.NativeGetCollisionRadius()));
                            vLocationOffset.Z = InstigatorPawn.NativeGetCollisionHeight() * 0.6600000;
                            rRotationOffset = Rotator(vect(-1.0000000, 0.0000000, 0.0000000));
                            r_PawnTarget = TargetPawn;
                            bNetDirty = true;
                            // End:0x404
                            if(!PredictChargeInterrupt(r_PawnTarget.Location, InstigatorPawn.Location + vLocationOffset))
                            {
                                r_PawnTarget.StartPhysGrab(InstigatorPawn, fChargeTimeRemaining, 1,, vLocationOffset, rRotationOffset);
                                Impact.bDirectHit = m_bUseDirectHitSpecial;
                                Impact.DeviceModeReference = FireMode;
                                Impact.HitActor = r_PawnTarget;
                                FireMode.ApplyHitSpecial(r_PawnTarget, Impact);
                            }
                        }
                    }
                }
            }
        }
        //return;        
    }

    simulated event ChargeTouch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal)
    {
        local TgDeviceFire FireMode;
        local ImpactInfo Impact;

        // End:0x22F
        if(int(Role) == int(ROLE_Authority))
        {
            // End:0x54
            if(r_PawnTarget == none)
            {
                super.ChargeTouch(Other, OtherComp, HitLocation, HitNormal);                
            }
            else
            {
                // End:0x22F
                if(Other != r_PawnTarget)
                {
                    // End:0x22F
                    if(m_bCarryEnemies)
                    {
                        FireMode = GetCurrentFire();
                        // End:0x22F
                        if((FireMode != none) && FireMode.IsValidTarget(Other))
                        {
                            Impact.bDirectHit = true;
                            Impact.DeviceModeReference = FireMode;
                            Impact.HitActor = Other;
                            Impact.HitLocation = HitLocation;
                            Impact.HitNormal = HitNormal;
                            Impact.StartTrace = Owner.Location;
                            Impact.RayDir = -Impact.HitNormal;
                            FireMode.ApplyHitSpecial(Other, Impact, 10693);
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

        // End:0xB7
        if((int(Role) == int(ROLE_Authority)) && r_PawnTarget != none)
        {
            // End:0xB7
            if(m_bCarryEnemies)
            {
                r_PawnTarget.EndPhysGrab();
                FireMode = GetCurrentFire();
                // End:0xA0
                if(FireMode != none)
                {
                    FireMode.RemoveHitSpecial(r_PawnTarget, true);
                }
                r_PawnTarget = none;
                bNetDirty = true;
            }
        }
        super.EndCharge();
        //return;        
    }

    simulated function StartFiringLogic()
    {
        local TgPawn_Makoa makoaOwner;

        super.StartFiringLogic();
        makoaOwner = TgPawn_Makoa(Instigator);
        // End:0x59
        if(makoaOwner != none)
        {
            makoaOwner.m_fShellSpinZoomOverride = 1.5000000;
        }
        //return;        
    }

    simulated function EndState(name NextStateName)
    {
        local TgPawn_Makoa makoaOwner;

        super.EndState(NextStateName);
        makoaOwner = TgPawn_Makoa(Instigator);
        // End:0x8A
        if(makoaOwner != none)
        {
            makoaOwner.m_fZoomDurationOverride = m_fZoomDurationOverride;
            makoaOwner.m_fShellSpinZoomOverride = 0.0000000;
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
    m_vHitProxyRelativeLocation=(X=30.0000000,Y=0.0000000,Z=0.0000000)
    m_bUsesOutroLockout=true
    m_fOutroLockoutTime=0.3000000
}