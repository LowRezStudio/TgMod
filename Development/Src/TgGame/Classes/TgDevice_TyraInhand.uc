class TgDevice_TyraInhand extends TgDevice
    native(ChampTyra)
    hidecategories(Navigation)
    config(Engine);

var bool m_bUltIsActive;

native function bool CheckAutoReload();  // Export UTgDevice_TyraInhand::execCheckAutoReload(FFrame&, void* const)

native function bool RequiresAmmoToFire();  // Export UTgDevice_TyraInhand::execRequiresAmmoToFire(FFrame&, void* const)

native function bool ShouldShowAmmoCount();  // Export UTgDevice_TyraInhand::execShouldShowAmmoCount(FFrame&, void* const)

simulated event SetAmmo(int AmmoCount, optional int ClipSize=-1, optional bool bShouldValidate=false, optional int ValidationIDOverride=0) { }

simulated function TgGameplayCurvesSet_RecoilSimple GetRecoilCurve() { }

defaultproperties
{
    m_AltFireType=ALTFIRE_AlternateDevice
    m_ReticuleType=RETICULE_Precise
    m_bAimThroughReticule=true
    m_bAltFireEnabled=true
    m_vMeshViewOffset=(X=17.0000000,Y=0.0000000,Z=-5.0000000)
    m_fWeaponBob=0.0000000
    m_fMeshFOV=77.0000000
    m_vProjectileSpawnOffset=(X=30.0000000,Y=9.0000000,Z=-10.0000000)
    m_fAltFireLockOutTime=0.0000000
    m_WeaponMeshActorClass=Class'TgWeaponMeshActor_TyraInhand'
    m_GameplayCurvesDeprecated=TgGameplayCurves'DeviceInhand'
    m_ForceFeedbackStartFire=ForceFeedbackWaveform'LightForceFeedback'
    m_AccuracySettings=(bUsesAdvancedAccuracy=true,fMaxAccuracy=1.0000000,fMinAccuracy=0.8900000,fAccuracyLossPerShot=0.0300000,fAccuracyGainPerSec=2.0000000,fAccuracyGainDelay=0.1500000,nNumFreeShots=5)
    m_fReticleBloomScale=0.5000000
    m_RecoilSettings=(bUsesRecoil=true,fRecoilReductionPerSec=100.0000000,fRecoilCenterDelay=0.1000000,fRecoilSmoothRate=7.0000000)
}
