class TgDevice_LongbowInhand extends TgDevice
    native(ChampLongbow)
    hidecategories(Navigation);

var TgPawn_Longbow m_CachedLongbow;
var float s_fLastFireHoldPct;
var float m_fFireReleasePercent;
var float m_fImpalerReticleAnimationTimer;
var(Reticle) float m_fReticleReleaseAnimationDuration;
var(Reticle) float m_fImpalerReticleFadeInDuration;
var(Reticle) float m_fImpalerReticleFadeOutDuration;
var(Reticle) float m_fImpalerReticleGrowth;
var() Vector m_vProjectileSpawnOffsetPlanted;

// Export UTgDevice_LongbowInhand::execShouldAutoFire(FFrame&, void* const)
native function bool ShouldAutoFire();

// Export UTgDevice_LongbowInhand::execHasCachedLongbow(FFrame&, void* const)
native function bool HasCachedLongbow();

simulated event Vector GetProjectileSpawnOffset()
{
    // End:0x1E
    if(int(CurrentFireMode) == int(1))
    {
        return m_vProjectileSpawnOffsetPlanted;
    }
    return m_vProjectileSpawnOffset;
    //return ReturnValue;    
}

// Export UTgDevice_LongbowInhand::execCanFireIfLeftMouseDown(FFrame&, void* const)
native function bool CanFireIfLeftMouseDown();

simulated function bool ReleaseHoldOnRightMouseReleased()
{
    return false;
    //return ReturnValue;    
}

simulated event bool CanBeCanceled()
{
    return false;
    //return ReturnValue;    
}

simulated function Projectile ProjectileFire(optional int ProjectileIndex = 0)
{
    local Projectile Proj;
    local TgDevice_ImpalerArrow impalerArrowDevice;

    Proj = super.ProjectileFire(ProjectileIndex);
    // End:0x13A
    if((HasCachedLongbow()) && m_CachedLongbow.r_bImpalerArrowIsActive)
    {
        m_CachedLongbow.ToggleImpalerArrow(false);
        impalerArrowDevice = TgDevice_ImpalerArrow(m_CachedLongbow.GetDeviceById(14928));
        // End:0x13A
        if(impalerArrowDevice != none)
        {
            // End:0x119
            if(impalerArrowDevice.IsFiring())
            {
                impalerArrowDevice.InterruptFiring();
                impalerArrowDevice.ClientInterrupt();
            }
            impalerArrowDevice.StartCooldown();
        }
    }
    return Proj;
    //return ReturnValue;    
}

simulated function int GetProjectileIDOverride(int ProjectileIndex)
{
    // End:0x37
    if((HasCachedLongbow()) && m_CachedLongbow.r_bImpalerArrowIsActive)
    {
        return 609;
    }
    return 0;
    //return ReturnValue;    
}

simulated function SetFireHoldAmt(float fFireHoldTime)
{
    local TgRepInfo_Player PRI;
    local TgDeviceFire FireMode;

    // End:0x199
    if(Instigator != none)
    {
        PRI = TgRepInfo_Player(Instigator.PlayerReplicationInfo);
        FireMode = GetCurrentFire();
        // End:0x186
        if((PRI != none) && FireMode != none)
        {
            PRI.SetSimProjSpeed(FireMode.m_nId, Lerp(FireMode.GetCustomValue4(), FireMode.GetProjectileSpeed() / float(16), fFireHoldTime));
            PRI.SetSimProjGravityScale(FireMode.m_nId, Lerp(FireMode.GetCustomValue2(), FireMode.GetCustomValue3(), fFireHoldTime));
        }
        s_fLastFireHoldPct = fFireHoldTime;
    }
    //return;    
}

simulated function AdjustSpawnedProjectile(out TgProj_Simulated SpawnedProjectile)
{
    super.AdjustSpawnedProjectile(SpawnedProjectile);
    // End:0x8D
    if((int(Role) == int(ROLE_Authority)) && m_bIsFireHoldDevice)
    {
        // End:0x7E
        if(SpawnedProjectile != none)
        {
            SpawnedProjectile.m_fBaseDamageMultiplier = Lerp(GetFireHoldDamageLow(), 1.0000000, s_fLastFireHoldPct);
        }
        s_fLastFireHoldPct = 0.0000000;
    }
    //return;    
}

simulated function ReleaseFireHoldInternal()
{
    // End:0xAB
    if(m_bFireHoldFull || IsTimerActive('FireHoldTimer'))
    {
        // End:0x55
        if(c_DeviceForm != none)
        {
            c_DeviceForm.Generic1();
        }
        // End:0x97
        if(HasCachedLongbow())
        {
            m_CachedLongbow.FlashGeneric1(r_nDeviceInstanceId, int(CurrentFireMode), true);
        }
        m_fFireReleasePercent = GetFireHoldPct();
    }
    super.ReleaseFireHoldInternal();
    //return;    
}

simulated function bool StartFireHold()
{
    local float fFireHoldTime;

    // End:0x11
    if(!super.StartFireHold())
    {
        return false;
    }
    fFireHoldTime = (GetFireHoldTime()) / (GetFireHoldRate());
    // End:0x6E
    if(c_DeviceForm != none)
    {
        c_DeviceForm.PlayToggleTransitionAnimations(0.0000000, fFireHoldTime, true);
    }
    // End:0xBC
    if(HasCachedLongbow())
    {
        m_CachedLongbow.FlashTransitionIn(r_nDeviceInstanceId, int(CurrentFireMode), 0.0000000, fFireHoldTime);
    }
    return true;
    //return ReturnValue;    
}

simulated event bool CanBeInterrupted()
{
    return (IsFiring()) && !IsTimerActive('FirePostHitDelay');
    //return ReturnValue;    
}

defaultproperties
{
    m_fReticleReleaseAnimationDuration=0.1500000
    m_fImpalerReticleFadeInDuration=0.1000000
    m_fImpalerReticleFadeOutDuration=0.1000000
    m_fImpalerReticleGrowth=10.0000000
    m_vProjectileSpawnOffsetPlanted=(X=15.0000000,Y=5.0000000,Z=-45.0000000)
    m_AltFireType=EAltFireType.ALTFIRE_AlternateDevice
    m_ReticuleType=EReticuleType.RETICULE_ShaLin
    m_bBuildupShouldInterruptStealth=false
    m_bPreFireShouldInterruptStealth=false
    m_bPostFireShouldInterruptStealth=false
    m_bStartFireShouldEnterCombat=false
    m_bAimThroughReticule=true
    m_bNoReticleBloom=true
    m_bAltFireEnabled=true
    m_bIsFireHoldDevice=true
    m_vMeshViewOffset=(X=12.0000000,Y=1.0000000,Z=-5.0000000)
    m_fWeaponBob=0.0000000
    m_fMeshFOV=90.0000000
    m_vProjectileSpawnOffset=(X=15.0000000,Y=0.0000000,Z=-5.0000000)
    m_fAltFireLockOutTime=0.0000000
    m_WeaponMeshActorClass=Class'TgGame.TgWeaponMeshActor_LongbowInhand'
    m_AimAssistKeyframesMagnetVert[0]=(KeyframeName="V150ftnull",Distance=2400.0000000)
    m_AimAssistKeyframesMagnetHoriz[0]=(KeyframeName="H10ft",Distance=160.0000000)
    m_AimAssistKeyframesMagnetHoriz[1]=(KeyframeName="H50ft",Distance=800.0000000)
    m_AimAssistKeyframesMagnetHoriz[2]=(KeyframeName="H100ftLowMag",Distance=1600.0000000)
    m_AimAssistKeyframesMagnetHoriz[3]=(KeyframeName="H200ftLowMag",Distance=3200.0000000)
    m_ForceFeedbackStopHold=ForceFeedbackWaveform'gp_forcefeedback.HeavyForceFeedback'
    m_ForceFeedbackStopReload=ForceFeedbackWaveform'gp_forcefeedback.StandardReload'
}