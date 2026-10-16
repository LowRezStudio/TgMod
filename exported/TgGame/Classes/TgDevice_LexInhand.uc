class TgDevice_LexInhand extends TgDevice
    native(ChampLex)
    hidecategories(Navigation);

var TgPawn_Lex m_CachedLexPawn;
var TgDevice_InPursuit m_CachedInPursuitDevice;
var TgDevice_Vengeance_Lex m_CachedVengeanceDevice;
var bool m_bShouldAutoFire;
var float m_fQueueFireTime;
var const float m_fQueueFireTimeThreshold;

// Export UTgDevice_LexInhand::execGetTargetingAim(FFrame&, void* const)
native function GetTargetingAim(out AimData Aim);

// Export UTgDevice_LexInhand::execValidateReceivedAim(FFrame&, void* const)
native function AimData ValidateReceivedAim(float ClientMovementTimeStamp, AimData Aim);

// Export UTgDevice_LexInhand::execCanFireIfLeftMouseDown(FFrame&, void* const)
native function bool CanFireIfLeftMouseDown();

// Export UTgDevice_LexInhand::execShouldAutoFire(FFrame&, void* const)
native function bool ShouldAutoFire();

// Export UTgDevice_LexInhand::execDeviceAdjustDamage(FFrame&, void* const)
native function DeviceAdjustDamage(const out ImpactInfo Impact, out float fDamage, int nPropertyId);

simulated function bool InterceptLeftMousePressed(TgPlayerController TgController)
{
    // End:0x40
    if(IsFiring())
    {
        m_fQueueFireTime = WorldInfo.TimeSeconds + m_fQueueFireTimeThreshold;
    }
    return false;
    //return ReturnValue;    
}

simulated event SetAmmo(int AmmoCount, optional int ClipSize = -1, optional bool bShouldValidate = false, optional int ValidationIDOverride = 0)
{
    super.SetAmmo(AmmoCount, ClipSize);
    // End:0xE9
    if((int(Role) == int(ROLE_Authority)) && HasCachedLexPawn())
    {
        m_CachedLexPawn.r_nInhandAmmoRemaining = GetCurrentAmmoAmount();
        // End:0xC8
        if(int(WorldInfo.NetMode) == int(NM_Standalone))
        {
            m_CachedLexPawn.OnAmmoChange();            
        }
        else
        {
            m_CachedLexPawn.bNetDirty = true;
        }
    }
    //return;    
}

simulated function bool HasCachedLexPawn()
{
    // End:0x2B
    if(m_CachedLexPawn == none)
    {
        m_CachedLexPawn = TgPawn_Lex(Instigator);
    }
    return m_CachedLexPawn != none;
    //return ReturnValue;    
}

simulated state DeviceFiring
{
    simulated function RestartFireLoop(bool bRefire)
    {
        m_fQueueFireTime = -1.0000000;
        super.RestartFireLoop(bRefire);
        //return;        
    }

    simulated function bool ShouldRefire(TgDeviceFire FireMode, const out AimData Aim)
    {
        local TgObject.EDeviceFailType failType;

        // End:0x72
        if(int(Role) < int(ROLE_Authority))
        {
            return (m_fQueueFireTime > WorldInfo.TimeSeconds) && CanDeviceFireNow(CurrentFireMode, Aim, LogDebugInfo(), failType);
        }
        return super.ShouldRefire(FireMode, Aim);
        //return ReturnValue;        
    }
    stop;    
}

defaultproperties
{
    m_fQueueFireTime=-1.0000000
    m_fQueueFireTimeThreshold=0.2500000
    m_AltFireType=EAltFireType.ALTFIRE_AlternateDevice
    m_bAltFireEnabled=true
    m_fMeshFOV=77.0000000
    m_WeaponMeshActorClass=Class'TgGame.TgWeaponMeshActor_LexInhand'
    m_GameplayCurvesDeprecated=TgGameplayCurves'GP_Lex.DeviceInhand'
    m_ForceFeedbackStartFire=ForceFeedbackWaveform'gp_forcefeedback.HeavyForceFeedback'
    m_AccuracySettings=(bUsesAdvancedAccuracy=true,fMaxAccuracy=1.0800000,fMinAccuracy=0.7800000,fAccuracyLossPerShot=0.0500000,fAccuracyGainPerSec=0.6000000,fAccuracyGainDelay=0.3000000)
    m_RecoilSettings=(bUsesRecoil=true,fRecoilReductionPerSec=15.0000000,fRecoilSmoothRate=40.0000000)
}