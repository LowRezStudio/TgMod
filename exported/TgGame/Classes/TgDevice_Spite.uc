class TgDevice_Spite extends TgDevice_Charge
    native(ChampDarklord)
    hidecategories(Navigation)
    implements(TgDeviceInterface_MoveSpeedMultiplier);

enum SpiteAnimState
{
    SAS_Intro,                      // 0
    SAS_HitChain,                   // 1
    SAS_MissOutro,                  // 2
    SAS_BounceOffOutro,             // 3
    SAS_InterruptOutro,             // 4
    SAS_MAX                         // 5
};

var private native const noexport Pointer VfTable_ITgDeviceInterface_MoveSpeedMultiplier;
var TgPawn_Darklord m_CachedDarklord;
var bool m_bWaitingForServerHit;
var bool m_bHasStartedChainAttacks;
var bool m_bHasBounced;
var bool m_bHasRefundedEnergy;
var bool r_bApplyPercentDamage;
var int m_nNumHits;
var TgPawn_Character m_HitCharacter;
var const float m_fJoinViewLerpTime;
var const float m_fJoinSeparationDistance;
var const float m_fJoinMoveTweenTime;
var const float m_fJoinMinGroundOffset;

replication
{
    // Pos:0x000
    if(int(Role) == int(ROLE_Authority))
        r_bApplyPercentDamage;
}

// Export UTgDevice_Spite::execGetTargetingAim(FFrame&, void* const)
native function GetTargetingAim(out AimData Aim);

// Export UTgDevice_Spite::execShouldForce3P(FFrame&, void* const)
native function bool ShouldForce3P(TgDeviceForm DeviceForm, optional bool bOnlyCheckDeviceForm = false);

// Export UTgDevice_Spite::execGetMoveSpeedMultiplier(FFrame&, void* const)
native function float GetMoveSpeedMultiplier();

// Export UTgDevice_Spite::execShouldLiftInterrupt(FFrame&, void* const)
native function bool ShouldLiftInterrupt();

// Export UTgDevice_Spite::execGetCachedFiringPostHitDelay(FFrame&, void* const)
native function float GetCachedFiringPostHitDelay();

simulated function bool HasCachedDarklord()
{
    // End:0x38
    if(m_CachedDarklord == none)
    {
        m_CachedDarklord = TgPawn_Darklord(Instigator);
        return m_CachedDarklord != none;
    }
    return true;
    //return ReturnValue;    
}

simulated event bool ShouldLockFiring(TgDevice Current)
{
    // End:0x2A
    if(Current.m_nDeviceType == 11077)
    {
        return false;
    }
    return (IsFiring()) || IsTimerActive('ApplyChainHit');
    //return ReturnValue;    
}

simulated function bool ShouldAbortChainAttacks()
{
    // End:0x248
    if((HasCachedDarklord()) && m_bHasStartedChainAttacks)
    {
        // End:0x129
        if(((((((m_HitCharacter == none) || !m_HitCharacter.IsAliveAndWell()) || int(m_HitCharacter.r_eCurrentStunType) == int(0)) || m_HitCharacter.IsDebuffImmune()) || m_HitCharacter.GetPropCurrentValue(132) > 0.0000000) || m_HitCharacter.GetPropCurrentValue(60) > 0.0000000) || m_HitCharacter.GetPropCurrentValue(61) > 0.0000000)
        {
            return true;
        }
        // End:0x248
        if((((((!m_CachedDarklord.IsAliveAndWell() || m_CachedDarklord.r_JoinTarget != m_HitCharacter) || int(m_CachedDarklord.r_eCurrentStunType) != int(0)) || m_CachedDarklord.r_bSilenced) || int(m_CachedDarklord.r_CurrentPolymorph) != int(0)) || m_CachedDarklord.GetPropCurrentValue(132) > 0.0000000) || m_CachedDarklord.r_bIsLifted)
        {
            return true;
        }
    }
    return false;
    //return ReturnValue;    
}

reliable server function ServerStartChainAttacks(Actor Other)
{
    // End:0x0F
    if(m_bHasStartedChainAttacks)
    {
        return;
    }
    // End:0x4B
    if(ServerValidateChargeHit(Other))
    {
        StartChainAttacks(Other);
        ClientStartChainAttacks(Other);
    }
    //return;    
}

simulated function OnInterruptEvent()
{
    // End:0x17
    if(ShouldAbortChainAttacks())
    {
        AbortChainAttacks();
    }
    super(TgDevice).OnInterruptEvent();
    //return;    
}

function AbortChainAttacks()
{
    // End:0xD7
    if((int(Role) == int(ROLE_Authority)) && m_bHasStartedChainAttacks)
    {
        m_CachedDarklord.FlashGeneric5(r_nDeviceInstanceId, int(CurrentFireMode), true);
        // End:0x87
        if(c_DeviceForm != none)
        {
            c_DeviceForm.Generic5();
        }
        // End:0xD7
        if(m_HitCharacter != none)
        {
            FinishChainAttacks(false, false);
            // End:0xD7
            if(int(WorldInfo.NetMode) != int(NM_Standalone))
            {
                ClientFinishChainAttacks(false, false);
            }
        }
    }
    //return;    
}

function CheckForRefund()
{
    // End:0x4C
    if(((int(Role) == int(ROLE_Authority)) && !m_bHasStartedChainAttacks) && !m_bHasRefundedEnergy)
    {
        m_bHasRefundedEnergy = true;
        RefundEnergy();
    }
    //return;    
}

simulated function BounceOff()
{
    local Vector NewVel;
    local Rotator adjustedDir;
    local float Angle;
    local TgDeviceFire FireMode;

    FireMode = GetCurrentFire();
    // End:0x2DB
    if(((HasCachedDarklord()) && m_HitCharacter != none) && FireMode != none)
    {
        m_bHasBounced = true;
        NewVel = m_CachedDarklord.Location - m_HitCharacter.Location;
        NewVel.Z = 0.0000000;
        NewVel = Normal(NewVel);
        adjustedDir = Rotator(NewVel);
        Angle = (90.0000000 * float(adjustedDir.Pitch)) / float(16384);
        Angle = float(Clamp(int(Angle + FireMode.GetCustomValue2()), -90, 90));
        adjustedDir.Pitch = int((Angle / 90.0000000) * 16384.0000000);
        NewVel = Vector(adjustedDir);
        NewVel *= FireMode.GetCustomValue1();
        // End:0x21B
        if(m_CachedDarklord.IsAliveAndWell())
        {
            m_CachedDarklord.QueueBounce(NewVel);
        }
        NewVel.X = -NewVel.X;
        NewVel.Y = -NewVel.Y;
        // End:0x2DB
        if(m_HitCharacter.IsAliveAndWell())
        {
            m_HitCharacter.QueueBounce(NewVel);
        }
    }
    //return;    
}

reliable client simulated function ClientStartChainAttacks(Actor Other)
{
    // End:0x5A
    if(!m_bHasStartedChainAttacks)
    {
        m_bWaitingForServerHit = false;
        ClearTimer('FirePostHitDelay');
        StartChainAttacks(Other);
        SetTimer(GetCachedFiringPostHitDelay(), false, 'FirePostHitDelay');
    }
    //return;    
}

simulated function StartChainAttacks(Actor Other)
{
    local TgDeviceFire FireMode;
    local Vector vBackDir, vSelfLocation, vTargetLocation, vGroundLocation, vGroundNormal;

    // End:0x0F
    if(m_bHasStartedChainAttacks)
    {
        return;
    }
    m_bHasStartedChainAttacks = true;
    FireMode = GetCurrentFire();
    // End:0x44A
    if((HasCachedDarklord()) && FireMode != none)
    {
        m_HitCharacter = TgPawn_Character(Other);
        ApplyStunHit();
        SetTimer(FireMode.GetCustomValue5(), true, 'ApplyChainHit');
        vBackDir = -Vector(m_rLastChargeDirection);
        vBackDir.Z = 0.0000000;
        vBackDir = Normal(vBackDir);
        vTargetLocation = m_CachedDarklord.Location;
        vSelfLocation = vTargetLocation + (m_fJoinSeparationDistance * vBackDir);
        // End:0x217
        if(m_HitCharacter.FindGround(vTargetLocation, vGroundLocation, vGroundNormal, m_fJoinMinGroundOffset, 1.5000000))
        {
            // End:0x217
            if(vTargetLocation.Z < (vGroundLocation.Z + m_fJoinMinGroundOffset))
            {
                vTargetLocation.Z = vGroundLocation.Z + m_fJoinMinGroundOffset;
            }
        }
        // End:0x2EF
        if(m_CachedDarklord.FindGround(vSelfLocation, vGroundLocation, vGroundNormal, m_fJoinMinGroundOffset, 1.5000000))
        {
            // End:0x2EF
            if(vSelfLocation.Z < (vGroundLocation.Z + m_fJoinMinGroundOffset))
            {
                vSelfLocation.Z = vGroundLocation.Z + m_fJoinMinGroundOffset;
            }
        }
        // End:0x368
        if(vTargetLocation.Z < vSelfLocation.Z)
        {
            vTargetLocation.Z = vSelfLocation.Z;            
        }
        else
        {
            vSelfLocation.Z = vTargetLocation.Z;
        }
        m_CachedDarklord.JoinToTarget(m_HitCharacter, vSelfLocation, vTargetLocation, m_fJoinMoveTweenTime);
        m_CachedDarklord.FlashGeneric3(r_nDeviceInstanceId, int(CurrentFireMode), true, 1);
        // End:0x44A
        if(c_DeviceForm != none)
        {
            c_DeviceForm.Generic3(1);
        }
    }
    //return;    
}

function ApplyHitToTarget(int nHitSpecialSituationalType)
{
    local ImpactInfo Impact;
    local TgDeviceFire FireMode;

    FireMode = GetCurrentFire();
    // End:0x1F8
    if(((HasCachedDarklord()) && m_HitCharacter != none) && FireMode != none)
    {
        Impact.bDirectHit = true;
        Impact.DeviceModeReference = GetCurrentFire();
        Impact.HitActor = m_HitCharacter;
        Impact.HitLocation = m_HitCharacter.Location;
        Impact.HitNormal = Normal(m_HitCharacter.Location - m_CachedDarklord.Location);
        Impact.StartTrace = m_HitCharacter.Location;
        Impact.RayDir = -Impact.HitNormal;
        FireMode.ApplyHitSpecial(m_HitCharacter, Impact, nHitSpecialSituationalType);
    }
    //return;    
}

simulated function ApplyStunHit()
{
    ApplyHitToTarget(10693);
    //return;    
}

function RemoveStunHit()
{
    local TgDeviceFire FireMode;

    // End:0x6E
    if((HasCachedDarklord()) && m_HitCharacter != none)
    {
        m_CachedDarklord.RemoveForcedViewTarget(m_CachedDarklord);
        m_HitCharacter.RemoveForcedViewTarget(m_CachedDarklord);
    }
    FireMode = GetCurrentFire();
    // End:0xE0
    if(((HasCachedDarklord()) && m_HitCharacter != none) && FireMode != none)
    {
        FireMode.RemoveHitSpecial(m_HitCharacter, true, 10693);
    }
    //return;    
}

simulated function ApplyChainHit()
{
    local TgDeviceFire FireMode;

    // End:0x4D
    if((((int(Role) == int(ROLE_Authority)) && HasCachedDarklord()) && m_bHasStartedChainAttacks) && ShouldAbortChainAttacks())
    {
        AbortChainAttacks();
        return;
    }
    FireMode = GetCurrentFire();
    // End:0xF3
    if((HasCachedDarklord()) && FireMode != none)
    {
        m_nNumHits++;
        // End:0xA9
        if(r_bApplyPercentDamage)
        {
            ApplyHitToTarget(11081);            
        }
        else
        {
            ApplyHitToTarget(10694);
        }
        // End:0xF3
        if(float(m_nNumHits) >= FireMode.GetCustomValue4())
        {
            FinishChainAttacks(true, true);
        }
    }
    //return;    
}

reliable client simulated function ClientAbortWaitingForServerHit()
{
    // End:0x23
    if(m_bWaitingForServerHit)
    {
        m_bWaitingForServerHit = false;
        InterruptFiring();
    }
    //return;    
}

reliable client simulated function ClientFinishChainAttacks(bool bBounceOff, bool bApplyFinalHit)
{
    // End:0x2B
    if(m_bHasStartedChainAttacks)
    {
        FinishChainAttacks(bBounceOff, bApplyFinalHit);
    }
    //return;    
}

simulated function FinishChainAttacks(bool bBounceOff, bool bApplyFinalHit)
{
    local bool bTargetDied;

    RemoveStunHit();
    bTargetDied = !m_HitCharacter.IsAliveAndWell();
    // End:0x4F
    if(bTargetDied)
    {
        bBounceOff = false;
    }
    // End:0x66
    if(bBounceOff)
    {
        BounceOff();
    }
    m_bHasStartedChainAttacks = false;
    m_CachedDarklord.UnjoinFromTarget();
    // End:0xA8
    if(bApplyFinalHit)
    {
        ApplyFinalHit();
    }
    InterruptFiring();
    ClearTimer('ApplyChainHit');
    m_HitCharacter = none;
    // End:0x1F2
    if(HasCachedDarklord())
    {
        m_CachedDarklord.FlashGeneric3(r_nDeviceInstanceId, int(CurrentFireMode), true, byte(((bBounceOff) ? 3 : 4)));
        // End:0x16A
        if(c_DeviceForm != none)
        {
            c_DeviceForm.Generic3(byte(((bBounceOff) ? 3 : 4)));
        }
        m_CachedDarklord.FlashGeneric4(r_nDeviceInstanceId, int(CurrentFireMode), true, ((bTargetDied) ? 1 : 0));
        // End:0x1F2
        if(c_DeviceForm != none)
        {
            c_DeviceForm.Generic4(((bTargetDied) ? 1 : 0));
        }
    }
    //return;    
}

simulated function ApplyFinalHit()
{
    ApplyHitToTarget(11080);
    //return;    
}

function RefundEnergy()
{
    local TgDeviceFire FireMode;
    local ImpactInfo Impact;

    FireMode = GetCurrentFire();
    // End:0xC5
    if(FireMode != none)
    {
        Impact.bDirectHit = true;
        Impact.DeviceModeReference = FireMode;
        Impact.HitActor = Instigator;
        FireMode.ApplyHitSpecial(Instigator, Impact, 11082);
    }
    //return;    
}

simulated state DeviceBuildup
{
    simulated function BeginState(name PreviousStateName)
    {
        m_bHasBounced = false;
        m_bHasStartedChainAttacks = false;
        m_bHasRefundedEnergy = false;
        m_nNumHits = 0;
        super.BeginState(PreviousStateName);
        // End:0xB5
        if(HasCachedDarklord())
        {
            m_CachedDarklord.FlashGeneric3(r_nDeviceInstanceId, int(CurrentFireMode), true, 0);
            // End:0xB5
            if(c_DeviceForm != none)
            {
                c_DeviceForm.Generic3(0);
            }
        }
        //return;        
    }
    stop;    
}

simulated state DeviceFiring
{
    simulated function OnStoppedChargeOnHit(Actor Other)
    {
        // End:0xDB
        if(!m_bHasStartedChainAttacks)
        {
            // End:0x67
            if(((int(Role) < int(ROLE_Authority)) && !m_bWaitingForServerHit) && !m_bHasStartedChainAttacks)
            {
                ServerStartChainAttacks(Other);
                m_bWaitingForServerHit = true;                
            }
            else
            {
                // End:0xDB
                if((int(Role) == int(ROLE_Authority)) && !m_bHasStartedChainAttacks)
                {
                    StartChainAttacks(Other);
                    // End:0xDB
                    if(int(WorldInfo.NetMode) != int(NM_Standalone))
                    {
                        ClientStartChainAttacks(Other);
                    }
                }
            }
        }
        ClearTimer('FirePreHitDelay');
        FirePreHitDelay();
        //return;        
    }

    simulated event StartCharge()
    {
        // End:0x71
        if(HasCachedDarklord())
        {
            m_CachedDarklord.FlashGeneric1(r_nDeviceInstanceId, int(CurrentFireMode), true);
            // End:0x71
            if(c_DeviceForm != none)
            {
                c_DeviceForm.Generic1();
            }
        }
        SetTimer((GetChargeTime()) * 0.8000000, false, 'PreStopCharge');
        super.StartCharge();
        //return;        
    }

    simulated function PreStopCharge()
    {
        // End:0x71
        if(HasCachedDarklord())
        {
            m_CachedDarklord.FlashGeneric2(r_nDeviceInstanceId, int(CurrentFireMode), true);
            // End:0x71
            if(c_DeviceForm != none)
            {
                c_DeviceForm.Generic2();
            }
        }
        //return;        
    }

    simulated event EndCharge()
    {
        // End:0x11
        if(!m_bCharging)
        {
            return;
        }
        // End:0x46
        if(IsTimerActive('PreStopCharge'))
        {
            ClearTimer('PreStopCharge');
            PreStopCharge();
        }
        // End:0x64
        if(int(Role) == int(ROLE_Authority))
        {
            CheckForRefund();
        }
        // End:0xF9
        if(((HasCachedDarklord()) && !m_bHasStartedChainAttacks) && !m_bWaitingForServerHit)
        {
            m_CachedDarklord.FlashGeneric3(r_nDeviceInstanceId, int(CurrentFireMode), true, 2);
            // End:0xF9
            if(c_DeviceForm != none)
            {
                c_DeviceForm.Generic3(2);
            }
        }
        super.EndCharge();
        //return;        
    }

    simulated function FirePostHitDelay()
    {
        // End:0x17
        if(m_bWaitingForServerHit)
        {
            AbortChainAttacks();
        }
        super.FirePostHitDelay();
        //return;        
    }

    simulated function Tick(float DeltaSeconds)
    {
        super.Tick(DeltaSeconds);
        // End:0x5E
        if((((int(Role) == int(ROLE_Authority)) && HasCachedDarklord()) && m_bHasStartedChainAttacks) && ShouldAbortChainAttacks())
        {
            AbortChainAttacks();
        }
        //return;        
    }

    simulated function OnInterruptEvent()
    {
        // End:0x17
        if(ShouldAbortChainAttacks())
        {
            AbortChainAttacks();
        }
        super(TgDevice).OnInterruptEvent();
        //return;        
    }
    stop;    
}

defaultproperties
{
    m_fJoinViewLerpTime=0.4000000
    m_fJoinSeparationDistance=75.0000000
    m_fJoinMoveTweenTime=0.2500000
    m_fJoinMinGroundOffset=160.0000000
    m_bStopOnHitType=ChargeStopOnHitType.CSHT_GodOnly
    m_ChargeTimingType=ChargeFiringType.CFT_PreFire
    m_bUsePhysFlying=true
    m_bIgnoreHumanoids=false
    m_bIgnoreMovementCorrection=true
    m_vHitProxySizeOffset=(X=0.0000000,Y=12.0000000,Z=0.0000000)
    s_fServerValidationSizeMultiplier=3.0000000
    s_bIgnoreReceivedAim=true
}