class TgDevice_BarrierTankInhand extends TgDevice
    native(ChampBarrierTank)
    hidecategories(Navigation)
    implements(TgDeviceInterface_MoveSpeedMultiplier);

var private native const noexport Pointer VfTable_ITgDeviceInterface_MoveSpeedMultiplier;
var TgPawn_BarrierTank m_CachedBarrierTankPawn;
var Vector m_vProjectileSpawnOffset2;
var Vector m_vProjectileSpawnOffset3;
//var delegate<InterruptFiringDelegate> __InterruptFiringDelegate__Delegate;

// Export UTgDevice_BarrierTankInhand::execCanDeviceFireNow(FFrame&, void* const)
native function bool CanDeviceFireNow(byte FireModeNum, AimData Aim, bool bDeviceFailLog, out TgObject.EDeviceFailType failType);

// Export UTgDevice_BarrierTankInhand::execGetMoveSpeedMultiplier(FFrame&, void* const)
native function float GetMoveSpeedMultiplier();

simulated event Vector GetProjectileSpawnOffset()
{
    // End:0x1C
    if(m_nBurstShotsRemaining == 0)
    {
        return m_vProjectileSpawnOffset3;        
    }
    else
    {
        // End:0x38
        if(m_nBurstShotsRemaining == 1)
        {
            return m_vProjectileSpawnOffset2;            
        }
        else
        {
            return m_vProjectileSpawnOffset;
        }
    }
    //return ReturnValue;    
}

simulated function int GetProjectileIDOverride(int ProjectileIndex)
{
    // End:0x18
    if(m_nBurstShotsRemaining == 0)
    {
        return 628;        
    }
    else
    {
        // End:0x30
        if(m_nBurstShotsRemaining == 1)
        {
            return 627;            
        }
        else
        {
            return 620;
        }
    }
    //return ReturnValue;    
}

simulated event SetAmmo(int AmmoCount, optional int ClipSize = -1, optional bool bShouldValidate = false, optional int ValidationIDOverride = 0)
{
    super.SetAmmo(AmmoCount, ClipSize);
    // End:0x9E
    if((int(Role) == int(ROLE_Authority)) && HasCachedBarrierTankPawn())
    {
        m_CachedBarrierTankPawn.r_nInhandAmmoRemaining = GetCurrentAmmoAmount();
        m_CachedBarrierTankPawn.bNetDirty = true;
    }
    //return;    
}

simulated function bool HasCachedBarrierTankPawn()
{
    // End:0x2B
    if(m_CachedBarrierTankPawn == none)
    {
        m_CachedBarrierTankPawn = TgPawn_BarrierTank(Instigator);
    }
    return m_CachedBarrierTankPawn != none;
    //return ReturnValue;    
}

simulated function InterruptLockoutTime()
{
    //return;    
}

simulated delegate InterruptFiringDelegate()
{
    local TgDeviceFire FireMode;
    local float fTruePostHitDelay;

    // End:0xD6
    if((IsFiring()) && m_nBurstShotsRemaining > 0)
    {
        // End:0x3C
        if(int(Role) == int(ROLE_AutonomousProxy))
        {
            ClientInterrupt();
        }
        InterruptFiring();
        m_nBurstShotsRemaining = 0;
        FireMode = GetCurrentFire();
        // End:0x9D
        if(FireMode != none)
        {
            fTruePostHitDelay = FireMode.GetPostHitDelay();
        }
        // End:0xBF
        if(fTruePostHitDelay <= 0.0000000)
        {
            fTruePostHitDelay = 0.8000000;
        }
        SetTimer(fTruePostHitDelay, false, 'InterruptLockoutTime');
    }
    //return;    
}

simulated event LinkedDeviceEquipped(TgDevice Dev)
{
    // End:0x11
    if(Dev == none)
    {
        return;
    }
    super.LinkedDeviceEquipped(Dev);
    switch(Dev.r_nDeviceId)
    {
        // End:0x54
        case 16251:
        // End:0x5C
        case 16250:
        // End:0x64
        case 16248:
        // End:0xA1
        case 16252:
            Dev.RegisterDelegate(2, InterruptFiringDelegate);
            // End:0xA4
            break;
        // End:0xFFFF
        default:
            break;
    }
    //return;    
}

simulated event LinkedDeviceUnequipped(TgDevice Dev)
{
    // End:0x11
    if(Dev == none)
    {
        return;
    }
    super.LinkedDeviceUnequipped(Dev);
    switch(Dev.r_nDeviceId)
    {
        // End:0x54
        case 16251:
        // End:0x5C
        case 16250:
        // End:0x64
        case 16248:
        // End:0xA1
        case 16252:
            Dev.UnregisterDelegate(2, InterruptFiringDelegate);
            // End:0xA4
            break;
        // End:0xFFFF
        default:
            break;
    }
    //return;    
}

simulated function SelfSlowTimer()
{
    //return;    
}

simulated state DeviceFiring
{
    simulated function FirePreHitDelay()
    {
        local TgDeviceFire FireMode;
        local float fDuration;

        super.FirePreHitDelay();
        FireMode = GetCurrentFire();
        // End:0x6D
        if(FireMode != none)
        {
            fDuration = FireMode.GetCustomValue4();
            SetTimer(fDuration, false, 'SelfSlowTimer');
        }
        //return;        
    }
    stop;    
}

defaultproperties
{
    m_vProjectileSpawnOffset2=(X=30.0000000,Y=16.0000000,Z=-8.0000000)
    m_vProjectileSpawnOffset3=(X=30.0000000,Y=9.6000000,Z=-9.6000000)
    m_AltFireType=EAltFireType.ALTFIRE_AlternateDevice
    m_ReticuleType=EReticuleType.RETICULE_Precise
    m_bAimThroughReticule=true
    m_bAltFireEnabled=true
    m_bUsesBurstFire=true
    m_bOnlyFirstBurstCostsAmmo=true
    m_vMeshViewOffset=(X=17.0000000,Y=0.0000000,Z=-5.0000000)
    m_fWeaponBob=0.0000000
    m_fMeshFOV=90.0000000
    m_vProjectileSpawnOffset=(X=30.0000000,Y=11.2000000,Z=-6.4000000)
    m_fAltFireLockOutTime=0.0000000
    m_nBurstTotalShots=3
    m_WeaponMeshActorClass=Class'TgGame.TgWeaponMeshActor_BarrierTankInhand'
    m_nLinkedDeviceIDs[0]=16251
    m_nLinkedDeviceIDs[1]=16250
    m_nLinkedDeviceIDs[2]=16248
    m_nLinkedDeviceIDs[3]=16252
    m_AimAssistKeyframesMagnetHoriz[0]=(KeyframeName="H10ft",Distance=160.0000000)
    m_AimAssistKeyframesMagnetHoriz[1]=(KeyframeName="H50ft",Distance=800.0000000)
    m_AimAssistKeyframesMagnetHoriz[2]=(KeyframeName="H100ftLowMag",Distance=1600.0000000)
    m_AimAssistKeyframesMagnetHoriz[3]=(KeyframeName="H200ftLowMag",Distance=3200.0000000)
    m_GameplayCurvesDeprecated=TgGameplayCurves'GP_Inara.DeviceInhand'
    m_ForceFeedbackStartFire=ForceFeedbackWaveform'gp_forcefeedback.BasicForceFeedback'
}