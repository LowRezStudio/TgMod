class TgDevice_Charge extends TgDevice_ChainSequence
    native(Devices)
    hidecategories(Navigation);

enum ChargeFiringType
{
    CFT_Fire,                       // 0
    CFT_PreFire,                    // 1
    CFT_PostFire,                   // 2
    CFT_MAX                         // 3
};

enum ChargeStopOnHitType
{
    CSHT_None,                      // 0
    CSHT_AnyValidTarget,            // 1
    CSHT_GodOnly,                   // 2
    CSHT_NotGod,                    // 3
    CSHT_MAX                        // 4
};

var TgPawn.EChargeState m_eChargeState;
var TgDevice_Charge.ChargeStopOnHitType m_bStopOnHitType;
var TgDevice_Charge.ChargeFiringType m_ChargeTimingType;
var bool m_bUsePhysFlying;
var bool m_bUseDamageRadiusForHitProxy;
var bool m_bIgnoreHumanoids;
var bool m_bHitOnce;
var bool m_bApplyHitOnTouch;
var bool m_bApplyHitSpecialOnTouch;
var bool m_bIgnoreRange;
var bool m_bCharging;
var bool m_bStopOnAttachedForcefield;
var bool m_bInterruptDeviceIfChargeEnds;
var bool m_bUseDirectHitSpecial;
var bool m_bChargeBackward;
var bool m_bCanLeftClickCancel;
var bool m_bIgnoreMovementCorrection;
var TgCollisionProxy_Cylinder m_HitProxy;
var Vector m_vHitProxyRelativeLocation;
var Vector m_vHitProxySizeOffset;
var float s_fServerValidationSizeMultiplier;
var Rotator m_rLastChargeDirection;
var array<Actor> s_AppliedList;
var array<Actor> s_HitActors;

// Export UTgDevice_Charge::execSetFireMode(FFrame&, void* const)
native function SetFireMode(int nFireModeNum, optional bool ForceSet = false);

// Export UTgDevice_Charge::execGetTargetingAim(FFrame&, void* const)
native function GetTargetingAim(out AimData Aim);

// Export UTgDevice_Charge::execServerValidateChargeHit(FFrame&, void* const)
native function bool ServerValidateChargeHit(Actor Other);

simulated event ChargeTouch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal)
{
    //return;    
}

simulated event ChargeUnTouch(Actor Other)
{
    //return;    
}

simulated event StartCharge()
{
    //return;    
}

simulated event EndCharge()
{
    //return;    
}

simulated event bool CanBeCanceled()
{
    return false;
    //return ReturnValue;    
}

simulated event bool CanBeInterrupted()
{
    return true;
    //return ReturnValue;    
}

simulated event float GetChargeRange()
{
    return ((m_bIgnoreRange) ? 0.0000000 : GetRange());
    //return ReturnValue;    
}

simulated event float GetChargeTime()
{
    local float fChargeTime;

    fChargeTime = 0.0000000;
    switch(m_ChargeTimingType)
    {
        // End:0x3F
        case 0:
            fChargeTime = GetRefireTime();
            // End:0x7C
            break;
        // End:0x5C
        case 1:
            fChargeTime = GetFiringPreHitDelay();
            // End:0x7C
            break;
        // End:0x79
        case 2:
            fChargeTime = GetFiringPostHitDelay();
            // End:0x7C
            break;
        // End:0xFFFF
        default:
            break;
    }
    return fChargeTime;
    //return ReturnValue;    
}

simulated function float GetChargeSpeed()
{
    local float fRange, fChargeTime;

    fChargeTime = GetChargeTime();
    // End:0x50
    if(fChargeTime > 0.0000000)
    {
        fRange = GetChargeRange();
        return fRange / fChargeTime;
    }
    return 500.0000000;
    //return ReturnValue;    
}

simulated function bool ShouldStopOnThisHit(Actor Other)
{
    local TgPawn OtherPawn;

    // End:0x29
    if((TgDeploy_ShieldFernando(Other) != none) && m_bStopOnAttachedForcefield)
    {
        return true;
    }
    switch(m_bStopOnHitType)
    {
        // End:0x46
        case 1:
            return true;
            // End:0xF5
            break;
        // End:0x9B
        case 2:
            OtherPawn = TgPawn(Other);
            return (OtherPawn != none) && OtherPawn.IsGod();
            // End:0xF5
            break;
        // End:0xF2
        case 3:
            OtherPawn = TgPawn(Other);
            return (OtherPawn == none) || !OtherPawn.IsGod();
            // End:0xF5
            break;
        // End:0xFFFF
        default:
            break;
    }
    return false;
    //return ReturnValue;    
}

event ApplyDamageReduction(out ImpactInfo Impact)
{
    local TgDeviceFire FireMode;

    FireMode = GetCurrentFire();
    // End:0x84
    if((FireMode != none) && Instigator != none)
    {
        FireMode.AddEffectiveRangeReduction(Impact, Instigator, Instigator.Location);
    }
    //return;    
}

simulated function OnValidTargetTouched(Actor Other)
{
    //return;    
}

simulated function OnStoppedChargeOnHit(Actor Other)
{
    //return;    
}

simulated function Rotator GetChargeDirection()
{
    local AimData Aim;

    GetCachedAim(Aim);
    // End:0x44
    if(m_bChargeBackward)
    {
        return Rotator(-Aim.AimVector);        
    }
    else
    {
        return Rotator(Aim.AimVector);
    }
    //return ReturnValue;    
}

simulated function EnableCorrection()
{
    local TgPlayerController pController;

    pController = TgPlayerController(Instigator.Controller);
    // End:0x61
    if(pController != none)
    {
        pController.bAcceptSendCorrections = true;
    }
    //return;    
}

function ApplyTouchHit(TgPawn InstigatorPawn, Vector vHitLocation, Vector vHitNormal, Actor Target)
{
    local ImpactInfo Impact;
    local TgDeviceFire FireMode;

    // End:0x291
    if(m_bApplyHitSpecialOnTouch || m_bApplyHitOnTouch)
    {
        FireMode = GetCurrentFire();
        Impact.bDirectHit = m_bUseDirectHitSpecial;
        Impact.DeviceModeReference = FireMode;
        Impact.HitActor = Target;
        Impact.HitLocation = vHitLocation;
        Impact.HitNormal = vHitNormal;
        Impact.StartTrace = ((Instigator != none) ? Instigator.Location : vect(0.0000000, 0.0000000, 0.0000000));
        Impact.RayDir = -Impact.HitNormal;
        // End:0x1DA
        if(m_bApplyHitSpecialOnTouch)
        {
            FireMode.ApplyHitSpecial(Target, Impact);
            s_AppliedList.AddItem(Target);
        }
        // End:0x291
        if(m_bApplyHitOnTouch)
        {
            // End:0x291
            if(!m_bHitOnce || s_HitActors.Find(Target) == -1)
            {
                Impact.bDirectHit = true;
                ApplyDamageReduction(Impact);
                FireMode.ApplyHit(Impact, Instigator);
                s_HitActors.AddItem(Target);
            }
        }
    }
    //return;    
}

simulated event bool CanFiringBeCanceledByLeftMouse()
{
    return m_bCanLeftClickCancel && CanBeCanceled();
    //return ReturnValue;    
}

simulated event bool ShouldLockFiring(TgDevice Current)
{
    // End:0x2A
    if(Current.m_nDeviceType == 11077)
    {
        return false;
    }
    return super(TgDevice).ShouldLockFiring(Current);
    //return ReturnValue;    
}

simulated state DeviceFiring
{
    ignores OnValidTargetTouched;

    simulated function RestartFireLoop(bool bRefire)
    {
        super.RestartFireLoop(bRefire);
        // End:0x79
        if(((!bRefire && IsFiring()) && (int(m_ChargeTimingType) == int(0)) || int(m_ChargeTimingType) == int(1)) && !m_bIsFireHoldDevice)
        {
            StartCharge();
        }
        //return;        
    }

    simulated function FirePreHitDelay()
    {
        super.FirePreHitDelay();
        // End:0x19
        if(m_bIsFireHoldDevice)
        {
            return;
        }
        // End:0x3A
        if(int(m_ChargeTimingType) == int(1))
        {
            EndCharge();            
        }
        else
        {
            // End:0x58
            if(int(m_ChargeTimingType) == int(2))
            {
                StartCharge();
            }
        }
        //return;        
    }

    simulated function StopFiringLogic()
    {
        EndCharge();
        super.StopFiringLogic();
        //return;        
    }

    simulated event StartCharge()
    {
        local TgPawn InstigatorPawn;
        local float fSpeed, fRange, fChargeTime;

        s_AppliedList.Length = 0;
        s_HitActors.Length = 0;
        InstigatorPawn = TgPawn(Instigator);
        fChargeTime = GetChargeTime();
        // End:0x8A
        if(m_bIgnoreMovementCorrection && InstigatorPawn != none)
        {
            InstigatorPawn.DisableMovementCorrection(5.0000000);
        }
        // End:0x230
        if((InstigatorPawn != none) && fChargeTime > 0.0000000)
        {
            m_bCharging = true;
            fRange = GetChargeRange();
            fSpeed = GetChargeSpeed();
            m_rLastChargeDirection = GetChargeDirection();
            InstigatorPawn.StartPhysCharge(m_eChargeState, m_rLastChargeDirection,, fSpeed, fRange, m_bIgnoreHumanoids, m_bUsePhysFlying);
            // End:0x230
            if(m_HitProxy != none)
            {
                m_HitProxy.SetTickIsDisabled(false);
                // End:0x215
                if(m_HitProxy.Base != InstigatorPawn)
                {
                    m_HitProxy.SetBase(InstigatorPawn);
                    m_HitProxy.SetHardAttach(true);
                    m_HitProxy.SetRelativeLocation(m_vHitProxyRelativeLocation);
                }
                m_HitProxy.SetCollision(true, false, false);
            }
        }
        //return;        
    }

    simulated event EndCharge()
    {
        local TgPawn InstigatorPawn;
        local TgDeviceFire FireMode;
        local Actor IteratorA;

        // End:0x11
        if(!m_bCharging)
        {
            return;
        }
        InstigatorPawn = TgPawn(Instigator);
        // End:0x6F
        if(m_bIgnoreMovementCorrection && InstigatorPawn != none)
        {
            InstigatorPawn.DisableMovementCorrection(0.3000000);
        }
        // End:0xA7
        if(InstigatorPawn != none)
        {
            InstigatorPawn.EndPhysCharge(m_IsBeingInterrupted);
        }
        // End:0xF1
        if(m_HitProxy != none)
        {
            m_HitProxy.SetTickIsDisabled(true);
            m_HitProxy.SetCollision(false, false, false);
        }
        // End:0x184
        if(int(Role) == int(ROLE_Authority))
        {
            FireMode = GetCurrentFire();
            // End:0x16C
            if(FireMode != none)
            {
                // End:0x16B
                foreach s_AppliedList(IteratorA)
                {
                    FireMode.RemoveHitSpecial(IteratorA, true);                    
                }                
            }
            s_AppliedList.Length = 0;
            s_HitActors.Length = 0;
        }
        m_bCharging = false;
        //return;        
    }

    simulated function Tick(float DeltaSeconds)
    {
        local TgPawn InstigatorPawn;

        super(Actor).Tick(DeltaSeconds);
        InstigatorPawn = TgPawn(Instigator);
        // End:0xBB
        if(((((int(Role) == int(ROLE_Authority)) && m_bCharging) && m_bInterruptDeviceIfChargeEnds) && InstigatorPawn != none) && int(InstigatorPawn.r_eChargeState) != int(m_eChargeState))
        {
            // End:0xB1
            if(LogDebugInfo())
            {
            }
            InterruptFiring();
        }
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
                ApplyTouchHit(InstigatorPawn, HitLocation, HitNormal, Other);
                OnValidTargetTouched(Other);
                // End:0x15A
                if(ShouldStopOnThisHit(Other))
                {
                    OnStoppedChargeOnHit(Other);
                }
            }
        }
        //return;        
    }

    simulated event ChargeUnTouch(Actor Other)
    {
        local int nIndex;
        local TgDeviceFire FireMode;

        // End:0xB9
        if((int(Role) == int(ROLE_Authority)) && m_bApplyHitSpecialOnTouch)
        {
            nIndex = s_AppliedList.Find(Other);
            // End:0xB9
            if(nIndex != -1)
            {
                FireMode = GetCurrentFire();
                // End:0xA4
                if(FireMode != none)
                {
                    FireMode.RemoveHitSpecial(Other, true);
                }
                s_AppliedList.Remove(nIndex, 1);
            }
        }
        //return;        
    }

    simulated function OnStoppedChargeOnHit(Actor Other)
    {
        // End:0x21
        if(int(Role) < int(ROLE_Authority))
        {
            ClientInterrupt();            
        }
        else
        {
            InterruptFiring();
        }
        //return;        
    }
    stop;    
}

defaultproperties
{
    m_eChargeState=EChargeState.CHARGE_NoTurn
    m_bUseDamageRadiusForHitProxy=true
    m_bIgnoreHumanoids=true
    m_bHitOnce=true
    m_bApplyHitOnTouch=true
    m_bInterruptDeviceIfChargeEnds=true
    m_bCanLeftClickCancel=true
    s_fServerValidationSizeMultiplier=2.0000000
    m_bConsumePowerPoolOnStartFire=true
    m_bAlwaysStartCooldown=true
    m_bForce3PViewWhileFiring=true
}