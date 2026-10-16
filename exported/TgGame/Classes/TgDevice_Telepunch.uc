class TgDevice_Telepunch extends TgDevice
    native(ChampDemon)
    hidecategories(Navigation)
    implements(TgDeviceInterface_MoveSpeedMultiplier);

var private native const noexport Pointer VfTable_ITgDeviceInterface_MoveSpeedMultiplier;
var TgPawn_Demon m_CachedDemon;
var TgPawn_Character m_HitCharacter;
var bool m_bLiftApplied;
var bool m_bStealthApplied;
var float m_fLerpTime;
var float m_fTeleportPreferedDistance;
var float m_fTargetLockTime;

// Export UTgDevice_Telepunch::execGetRequiredEnergyToFire(FFrame&, void* const)
native function float GetRequiredEnergyToFire();

// Export UTgDevice_Telepunch::execCanDeviceFireNow(FFrame&, void* const)
native function bool CanDeviceFireNow(byte FireModeNum, AimData Aim, bool bDeviceFailLog, out TgObject.EDeviceFailType failType);

// Export UTgDevice_Telepunch::execShouldForce3P(FFrame&, void* const)
native function bool ShouldForce3P(TgDeviceForm DeviceForm, optional bool bOnlyCheckDeviceForm = false);

// Export UTgDevice_Telepunch::execGetMoveSpeedMultiplier(FFrame&, void* const)
native function float GetMoveSpeedMultiplier();

simulated function bool ShouldConsumePowerPoolOnStartFire()
{
    return true;
    //return ReturnValue;    
}

simulated function bool HasCachedDemon()
{
    // End:0x38
    if(m_CachedDemon == none)
    {
        m_CachedDemon = TgPawn_Demon(Instigator);
        return m_CachedDemon != none;
    }
    return true;
    //return ReturnValue;    
}

simulated function ImpactInfo CalcWeaponFire(AimData Aim, optional out array<ImpactInfo> ImpactList)
{
    local ImpactInfo Impact;

    // End:0xC5
    if(((HasCachedDemon()) && m_CachedDemon.m_TelepunchTarget != none) && !m_CachedDemon.m_TelepunchTarget.IsAliveAndWell() || m_CachedDemon.m_TelepunchTarget.IsCrowdControlImmune())
    {
        return super.CalcWeaponFire(Aim, ImpactList);
    }
    Impact.bDirectHit = true;
    Impact.DeviceModeReference = GetCurrentFire();
    Impact.HitActor = m_CachedDemon.m_TelepunchTarget;
    Impact.HitLocation = m_CachedDemon.m_TelepunchTarget.Location;
    Impact.HitNormal = Normal(m_CachedDemon.Location - m_CachedDemon.m_TelepunchTarget.Location);
    Impact.StartTrace = m_CachedDemon.m_TelepunchTarget.Location;
    Impact.RayDir = -Impact.HitNormal;
    ImpactList.AddItem(Impact);
    return Impact;
    //return ReturnValue;    
}

simulated event DeliverHit(ImpactInfo Impact)
{
    local TeleportParams TelParams;
    local AimData Aim;
    local float fCollisionRadius, fLerpTime;
    local TgDeviceFire FireMode;
    local Vector vTemp, vTeleportLocation;
    local TgPawn_Character Target;
    local bool bValidTeleportLocation;

    FireMode = GetCurrentFire();
    Target = TgPawn_Character(Impact.HitActor);
    // End:0x557
    if((((m_HitCharacter == none) && FireMode != none) && Target != none) && HasCachedDemon())
    {
        // End:0x557
        if(int(Role) == int(ROLE_Authority))
        {
            GetCachedAim(Aim);
            fCollisionRadius = m_CachedDemon.GetCollisionRadius();
            vTemp = Impact.HitActor.Location - m_CachedDemon.Location;
            vTemp.Z = 0.0000000;
            vTemp = Normal(vTemp);
            TelParams.vTargetLocation = Target.Location - ((vTemp * m_fTeleportPreferedDistance) * float(16));
            TelParams.vTargetLocation.Z += (m_fTeleportPreferedDistance / 6.0000000);
            TelParams.rTargetRotation = Rotator(vTemp);
            TelParams.bPlayFx = true;
            TelParams.bDoBackTrace = true;
            TelParams.vBackTraceDir = Normal(Impact.HitActor.Location - TelParams.vTargetLocation);
            TelParams.fBackTraceIncrement = fCollisionRadius;
            TelParams.fBackTraceMaxDist = fCollisionRadius * 20.0000000;
            TelParams.fMovementCorrectionDisableTime = 0.3000000;
            bValidTeleportLocation = m_CachedDemon.AdvancedTeleport(TelParams, vTeleportLocation, true);
            // End:0x3EB
            if(!bValidTeleportLocation)
            {
                bValidTeleportLocation = true;
                vTeleportLocation = Target.Location + (TelParams.vBackTraceDir * 0.1000000);
            }
            // End:0x4ED
            if(bValidTeleportLocation)
            {
                m_CachedDemon.Velocity = vect(0.0000000, 0.0000000, 0.0000000);
                m_HitCharacter = Target;
                fLerpTime = GetLerpToTargetTime(vTeleportLocation);
                LerpToTarget(m_HitCharacter, vTeleportLocation, fLerpTime);
                // End:0x4C7
                if(int(WorldInfo.NetMode) == int(NM_DedicatedServer))
                {
                    ClientLerpToTarget(m_HitCharacter, vTeleportLocation, fLerpTime);
                }
                ApplyLift(m_HitCharacter);
                ApplyStealth(m_CachedDemon);
            }
            m_CachedDemon.ConsumePowerPool(self, 10014, m_CachedDemon.GetMaxEnergy() - FireMode.GetShotPowerCost(10014));
        }
    }
    //return;    
}

simulated function float GetLerpToTargetTime(Vector vTargetLocation)
{
    local TgDeviceFire FireMode;
    local float fDist, fTime, fMinTime, fMaxTime, fMinDist, fMaxDist;

    FireMode = GetCurrentFire();
    // End:0x1BD
    if((HasCachedDemon()) && FireMode != none)
    {
        fMinTime = FireMode.GetCustomValue1();
        fMaxTime = FireMode.GetCustomValue2();
        fMinDist = FireMode.GetCustomValue3();
        fMaxDist = FireMode.GetCustomValue4();
        fDist = VSize(m_CachedDemon.Location - vTargetLocation) / float(16);
        // End:0x13E
        if(fDist <= fMinTime)
        {
            fTime = fMinTime;            
        }
        else
        {
            // End:0x16B
            if(fDist >= fMaxDist)
            {
                fTime = fMaxTime;                
            }
            else
            {
                fTime = Lerp(fMinTime, fMaxTime, (fDist - fMinDist) / (fMaxDist - fMinDist));
            }
        }
        return fTime;
    }
    return 0.5000000;
    //return ReturnValue;    
}

simulated function LerpToTarget(TgPawn_Character Target, Vector vTargetLocation, float fLerpTime)
{
    local TgDeviceFire FireMode;

    m_fLerpTime = fLerpTime;
    SetTimer(m_fLerpTime - 0.2500000, false, 'FadeOutUltFx');
    FireMode = GetCurrentFire();
    // End:0x162
    if(((HasCachedDemon()) && Target != none) && FireMode != none)
    {
        ClearTimer('AltFirePostHitDelay');
        SetTimer(m_fLerpTime + FireMode.GetCustomValue5(), false, 'AltFirePostHitDelay');
        SetTimer(0.0100000, false, 'ResetPostHitDelay');
        SetTimer(m_fLerpTime, false, 'PostTeleportPreHit');
        m_CachedDemon.AddForcedViewTarget(Target, 0.2500000, 0.2500000 + m_fLerpTime, self, 0.0000000);
        m_CachedDemon.StartPhysTween(vTargetLocation, m_fLerpTime, 2, false, true);
    }
    //return;    
}

simulated function FadeOutUltFx()
{
    m_CachedDemon.FlashGeneric2(r_nDeviceInstanceId, int(CurrentFireMode), true, 0);
    // End:0x66
    if(c_DeviceForm != none)
    {
        c_DeviceForm.Generic2(0);
    }
    //return;    
}

simulated function AltFirePostHitDelay()
{
    //return;    
}

reliable client simulated function ClientLerpToTarget(TgPawn_Character Target, Vector vTargetLocation, float fLerpTime)
{
    LerpToTarget(Target, vTargetLocation, fLerpTime);
    //return;    
}

simulated function ResetPostHitDelay()
{
    ClearTimer('FirePostHitDelay');
    SetTimer(GetTimerRate('AltFirePostHitDelay') - GetTimerCount('AltFirePostHitDelay'), false, 'FirePostHitDelay');
    ClearTimer('AltFirePostHitDelay');
    //return;    
}

simulated event bool ShouldLockFiring(TgDevice Current)
{
    // End:0x2A
    if(Current.m_nDeviceType == 11077)
    {
        return false;
    }
    return ((IsFiring()) || IsPostTeleportPreHitActive()) || IsPostTeleportLockOutActive();
    //return ReturnValue;    
}

simulated function bool IsPostTeleportPreHitActive()
{
    return IsTimerActive('PostTeleportPreHit');
    //return ReturnValue;    
}

simulated function PostTeleportPreHit()
{
    local TgDeviceFire FireMode;

    FireMode = GetCurrentFire();
    // End:0x7C
    if(((HasCachedDemon()) && m_HitCharacter != none) && FireMode != none)
    {
        RemoveLift(m_HitCharacter);
        RemoveStealth(m_CachedDemon);
        SetTimer(0.0100000, false, 'DelayedSlam');
    }
    SetTimer(FireMode.GetCustomValue5() + 0.0100000, false, 'PostTeleportLockOut');
    //return;    
}

simulated function bool IsPostTeleportLockOutActive()
{
    return IsTimerActive('PostTeleportLockOut');
    //return ReturnValue;    
}

simulated function PostTeleportLockOut()
{
    // End:0x9F
    if(HasCachedDemon())
    {
        m_HitCharacter = none;
        m_CachedDemon.RemoveForcedViewTarget(self);
        // End:0x9F
        if(m_CachedDemon.IsAliveAndWell() && int(m_CachedDemon.Physics) == int(13))
        {
            m_CachedDemon.SetPhysics(2);
        }
    }
    //return;    
}

function ApplyLift(TgPawn_Character Target)
{
    local TgDeviceFire FireMode;

    // End:0xC0
    if(!m_bLiftApplied)
    {
        m_bLiftApplied = true;
        ApplyHitToTarget(Target, 10693);
        FireMode = GetCurrentFire();
        // End:0xC0
        if((Target != none) && FireMode != none)
        {
            Target.AddForcedViewTarget(m_CachedDemon, 0.2500000, m_fLerpTime + FireMode.GetCustomValue5(), self);
        }
    }
    //return;    
}

function RemoveLift(TgPawn_Character Target)
{
    // End:0x31
    if(m_bLiftApplied)
    {
        m_bLiftApplied = false;
        RemoveHitFromTarget(Target, 10693);
    }
    //return;    
}

function ApplyStealth(TgPawn_Character Target)
{
    // End:0x33
    if(!m_bStealthApplied)
    {
        m_bStealthApplied = true;
        ApplyHitToTarget(Target, 11080);
    }
    //return;    
}

function RemoveStealth(TgPawn_Character Target)
{
    // End:0x31
    if(m_bStealthApplied)
    {
        m_bStealthApplied = false;
        RemoveHitFromTarget(Target, 11080);
    }
    //return;    
}

function DelayedSlam()
{
    ApplySlam(m_HitCharacter);
    //return;    
}

function ApplySlam(TgPawn_Character Target)
{
    ApplyHitToTarget(Target, 10694);
    //return;    
}

function ApplyHitToTarget(TgPawn_Character Target, int nHitSpecialSituationalType)
{
    local ImpactInfo Impact;
    local TgDeviceFire FireMode;

    FireMode = GetCurrentFire();
    // End:0x20E
    if((((int(Role) == int(ROLE_Authority)) && HasCachedDemon()) && Target != none) && FireMode != none)
    {
        Impact.bDirectHit = true;
        Impact.DeviceModeReference = GetCurrentFire();
        Impact.HitActor = Target;
        Impact.HitLocation = Target.Location;
        Impact.HitNormal = Normal(m_CachedDemon.Location - Target.Location);
        Impact.StartTrace = Target.Location;
        Impact.RayDir = -Impact.HitNormal;
        FireMode.ApplyHitSpecial(Target, Impact, nHitSpecialSituationalType);
    }
    //return;    
}

function RemoveHitFromTarget(TgPawn_Character Target, int nHitSpecialSituationalType)
{
    local TgDeviceFire FireMode;

    FireMode = GetCurrentFire();
    // End:0x8C
    if((((int(Role) == int(ROLE_Authority)) && HasCachedDemon()) && Target != none) && FireMode != none)
    {
        FireMode.RemoveHitSpecial(Target, true, nHitSpecialSituationalType);
    }
    //return;    
}

simulated function ConfirmTelepunchTarget()
{
    // End:0x4A
    if(HasCachedDemon())
    {
        m_CachedDemon.ServerNotifyTelepunchTarget(m_CachedDemon.m_TelepunchTarget);
    }
    //return;    
}

simulated function OnInterruptEvent()
{
    AbortTelepunch();
    super.OnInterruptEvent();
    //return;    
}

simulated function AbortTelepunch()
{
    RemoveLift(m_HitCharacter);
    // End:0xFC
    if(HasCachedDemon())
    {
        RemoveStealth(m_CachedDemon);
        m_CachedDemon.RemoveForcedViewTarget(self);
        // End:0xBA
        if(m_CachedDemon.IsAliveAndWell() && int(m_CachedDemon.Physics) == int(13))
        {
            m_CachedDemon.SetPhysics(2);
        }
        m_CachedDemon.r_bIsUltTargeting = false;
        m_CachedDemon.bNetDirty = true;
    }
    ClearTimer('PostTeleportPreHit');
    ClearTimer('FirePostHitDelay');
    ClearTimer('PostTeleportLockOut');
    //return;    
}

simulated state DeviceFiring
{
    simulated function StartFiringLogic()
    {
        local TgDeviceFire FireMode;

        // End:0x217
        if(HasCachedDemon())
        {
            m_CachedDemon.m_bUseTelepunchZoom = true;
            m_CachedDemon.FlashGeneric1(r_nDeviceInstanceId, int(CurrentFireMode), true, 1);
            // End:0x94
            if(c_DeviceForm != none)
            {
                c_DeviceForm.Generic1(1);
            }
            m_CachedDemon.FlashGeneric2(r_nDeviceInstanceId, int(CurrentFireMode), true, 1);
            // End:0xFA
            if(c_DeviceForm != none)
            {
                c_DeviceForm.Generic2(1);
            }
            m_CachedDemon.m_TelepunchTarget = none;
            m_CachedDemon.ServerNotifyTelepunchTarget(none);
            m_CachedDemon.r_bIsUltTargeting = true;
            m_CachedDemon.bNetDirty = true;
            m_CachedDemon.OnUltStarted();
            FireMode = GetCurrentFire();
            // End:0x217
            if((FireMode != none) && int(WorldInfo.NetMode) != int(NM_DedicatedServer))
            {
                SetTimer((GetFiringPreHitDelay(int(CurrentFireMode))) - m_fTargetLockTime, false, 'ConfirmTelepunchTarget');
            }
        }
        super.StartFiringLogic();
        //return;        
    }

    simulated function StopFiringLogic()
    {
        // End:0x6E
        if(HasCachedDemon())
        {
            m_CachedDemon.m_bUseTelepunchZoom = false;
            m_CachedDemon.bNetDirty = true;
            m_CachedDemon.OnUltFinished();
        }
        m_HitCharacter = none;
        super.StopFiringLogic();
        //return;        
    }

    simulated function FirePreHitDelay()
    {
        // End:0xB5
        if(HasCachedDemon())
        {
            m_CachedDemon.FlashGeneric1(r_nDeviceInstanceId, int(CurrentFireMode), true, 0);
            // End:0x73
            if(c_DeviceForm != none)
            {
                c_DeviceForm.Generic1(0);
            }
            m_CachedDemon.r_bIsUltTargeting = false;
            m_CachedDemon.bNetDirty = true;
        }
        CacheAim();
        super.FirePreHitDelay();
        //return;        
    }

    simulated function OnInterruptEvent()
    {
        AbortTelepunch();
        super(TgDevice).OnInterruptEvent();
        //return;        
    }
    stop;    
}

defaultproperties
{
    m_fTeleportPreferedDistance=6.0000000
    m_fTargetLockTime=0.2500000
    s_bIgnoreReceivedAim=true
    m_bDisableLagCompensation=true
}