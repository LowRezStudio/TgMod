class TgDevice_KingBomb extends TgDevice_Charge
    native(ChampBombKing)
    hidecategories(Navigation);

var(Lockout) float m_fEndFireZoomDurationOverride;

// Export UTgDevice_KingBomb::execShouldInstigatorCollideWith(FFrame&, void* const)
native function bool ShouldInstigatorCollideWith(Actor Other);

simulated function float GetChargeSpeed()
{
    local float CV1;
    local TgDeviceFire FireMode;
    local TgPawn_Character TgP;
    local float BaseSpeed;

    FireMode = GetCurrentFire();
    // End:0x12E
    if(FireMode != none)
    {
        CV1 = FireMode.GetCustomValue1();
        // End:0x12E
        if(CV1 > 0.0000000)
        {
            TgP = TgPawn_Character(Instigator);
            // End:0x124
            if(TgP != none)
            {
                BaseSpeed = TgP.GetBaseSpeed();
                // End:0x124
                if((TgP.GroundSpeed > 0.0000000) && BaseSpeed > 0.0000000)
                {
                    CV1 *= (TgP.GroundSpeed / BaseSpeed);
                }
            }
            return CV1;
        }
    }
    return super.GetChargeSpeed();
    //return ReturnValue;    
}

simulated event float GetChargeRange()
{
    local float CV1;
    local TgDeviceFire FireMode;
    local float fChargeTime;

    FireMode = GetCurrentFire();
    // End:0x88
    if(FireMode != none)
    {
        CV1 = FireMode.GetCustomValue1();
        // End:0x88
        if(CV1 > 0.0000000)
        {
            fChargeTime = GetChargeTime();
            return CV1 * fChargeTime;
        }
    }
    return super.GetChargeRange();
    //return ReturnValue;    
}

simulated event bool CanBeCanceled()
{
    // End:0x32
    if(IsTimerActive('FirePreHitDelay') || IsTimerActive('FirePostHitDelay'))
    {
        return true;
    }
    return false;
    //return ReturnValue;    
}

simulated function FireAmmunition()
{
    super(TgDevice_ChainSequence).FireAmmunition();
    // End:0x28
    if(int(Role) == int(ROLE_Authority))
    {
        ApplyPostExplodeKnockback();
    }
    //return;    
}

simulated function OutroLockoutTime()
{
    local TgPawn_BombKing BombKing;

    BombKing = TgPawn_BombKing(Instigator);
    // End:0x70
    if(BombKing != none)
    {
        BombKing.m_fZoomDurationOverride = 0.0000000;
        BombKing.m_bForced3PDuringKingBomb = false;
    }
    //return;    
}

function ApplyPostExplodeKnockback()
{
    local TgDeviceFire FireMode;
    local ImpactInfo Impact;

    FireMode = GetCurrentFire();
    // End:0x12C
    if(FireMode != none)
    {
        Impact.bDirectHit = true;
        Impact.DeviceModeReference = FireMode;
        Impact.HitActor = Instigator;
        Instigator.Velocity = vect(0.0000000, 0.0000000, 0.0000000);
        Impact.HitNormal = Normal2D(Vector(Instigator.Rotation));
        FireMode.ApplyHitSpecial(Instigator, Impact);
    }
    //return;    
}

simulated event bool ShouldLockFiring(TgDevice Current)
{
    // End:0x19
    if(IsTimerActive('OutroLockoutTime'))
    {
        return true;
    }
    return super.ShouldLockFiring(Current);
    //return ReturnValue;    
}

simulated function ImpactInfo CalcWeaponFire(AimData Aim, optional out array<ImpactInfo> ImpactList)
{
    Aim.EndTrace = Instigator.Location;
    return super(TgDevice).CalcWeaponFire(Aim, ImpactList);
    //return ReturnValue;    
}

simulated state DeviceBuildup
{
    simulated function BeginState(name PreviousStateName)
    {
        local TgPawn PawnOwner;

        super.BeginState(PreviousStateName);
        LockInput(true);
        PawnOwner = TgPawn(Owner);
        // End:0x68
        if(PawnOwner != none)
        {
            PawnOwner.SwitchBackToInhandInstantly();
        }
        //return;        
    }

    simulated function EndState(name NextStateName)
    {
        super.EndState(NextStateName);
        LockInput(false);
        //return;        
    }
    stop;    
}

simulated state DeviceFiring
{
    simulated function BeginState(name PreviousStateName)
    {
        local TgPawn_BombKing BombKing;

        super.BeginState(PreviousStateName);
        BombKing = TgPawn_BombKing(Instigator);
        // End:0x5F
        if(BombKing != none)
        {
            BombKing.m_bForced3PDuringKingBomb = true;
        }
        //return;        
    }

    simulated function bool ShouldStopOnThisHit(Actor Other)
    {
        return super(TgDevice_Charge).ShouldStopOnThisHit(Other) && ShouldInstigatorCollideWith(Other);
        //return ReturnValue;        
    }

    simulated function OnStoppedChargeOnHit(Actor Other)
    {
        // End:0x56
        if(IsTimerActive('FirePreHitDelay'))
        {
            // End:0x38
            if(int(Role) < int(ROLE_Authority))
            {
                ClientInitiatedInterrupt();                
            }
            else
            {
                InterruptFiring();
            }
            ClearTimer('FirePreHitDelay');
        }
        //return;        
    }

    simulated function EndState(name NextStateName)
    {
        local TgPawn TgP;
        local TgPawn_BombKing BombKing;

        super.EndState(NextStateName);
        TgP = TgPawn(Instigator);
        // End:0x66
        if(TgP != none)
        {
            TgP.m_fZoomDurationOverride = m_fEndFireZoomDurationOverride;
        }
        BombKing = TgPawn_BombKing(Instigator);
        // End:0xD6
        if(BombKing != none)
        {
            BombKing.m_fZoomDurationOverride = 0.0000000;
            BombKing.m_bForced3PDuringKingBomb = false;
        }
        //return;        
    }

    simulated function OnInterruptEvent()
    {
        // End:0x21
        if(IsTimerActive('FirePreHitDelay'))
        {
            FireAmmunition();
        }
        super(TgDevice).OnInterruptEvent();
        //return;        
    }
    stop;    
}

defaultproperties
{
    m_fEndFireZoomDurationOverride=0.1000000
    m_eChargeState=EChargeState.CHARGE_Turn
    m_bStopOnHitType=ChargeStopOnHitType.CSHT_GodOnly
    m_ChargeTimingType=ChargeFiringType.CFT_PreFire
    m_bUseDamageRadiusForHitProxy=false
    m_bIgnoreHumanoids=false
    m_bApplyHitOnTouch=false
    m_vHitProxyRelativeLocation=(X=15.0000000,Y=0.0000000,Z=0.0000000)
    m_vHitProxySizeOffset=(X=20.0000000,Y=10.0000000,Z=0.0000000)
    m_DeviceTimerBarType=DeviceTimerBarType.DTBT_PreHit
    m_bCarryPreFireToPostFire=false
    m_bForce3PViewWhileFiring=false
    m_bDisableLagCompensation=true
    m_bUsesOutroLockout=true
    m_GameplayCurvesDeprecated=TgGameplayCurves'GP_BombKing.DeviceKingBomb'
    m_fOutroLockoutTime=0.7500000
}