class TgDevice_ViktorInhand extends TgDevice
    native(ChampViktor)
    hidecategories(Navigation)
    config(Engine);

var bool m_bIsADS;
var () Vector m_vADSProjectileSpawnOffset;
var (Recoil) float m_fADSRecoilMultiplier;
var float m_fMinAccuracyDefault;
var float m_fMinAccuracyADS;
var float m_fAccuracyLossPerShotDefault;
var float m_fAccuracyLossPerShotADS;
var TgPawn_Character m_CachedPawnOwner;

simulated event Vector GetProjectileSpawnOffset() { }

simulated event SetAmmo(int AmmoCount, optional int ClipSize=-1, optional bool bShouldValidate=false, optional int ValidationIDOverride=0) { }

simulated function ShowReticle(bool bShow) { }

simulated function StartADSBonuses() { }

simulated function EndADSBonuses() { }

simulated event LinkedDeviceEquipped(TgDevice Dev) { }

simulated event LinkedDeviceUnequipped(TgDevice Dev) { }

simulated function bool HasCachedCharacter() { }

simulated function TgGameplayCurvesSet_RecoilSimple GetRecoilCurve() { }

simulated function float GetRecoilMultiplier() { }

defaultproperties
{
    m_vADSProjectileSpawnOffset=(X=30.0000000,Y=0.0000000,Z=-3.0000000)
    m_fADSRecoilMultiplier=1.0000000
    m_fMinAccuracyADS=1.0000000
    m_fAccuracyLossPerShotADS=0.0090000
    m_AltFireType=ALTFIRE_AlternateDevice
    m_ReticuleType=RETICULE_Precise
    m_bAimThroughReticule=true
    m_bAltFireEnabled=true
    m_vMeshViewOffset=(X=17.0000000,Y=0.0000000,Z=-5.0000000)
    m_fWeaponBob=0.0000000
    m_vProjectileSpawnOffset=(X=30.0000000,Y=9.0000000,Z=-10.0000000)
    m_fAltFireLockOutTime=0.0000000
    m_WeaponMeshActorClass=Class'TgWeaponMeshActor_ViktorInhand'
    m_nLinkedDeviceIDs[0]=14157
    m_AimAssistKeyframesMagnetHoriz[0]=(KeyframeName="H10ft",Distance=160.0000000)
    m_AimAssistKeyframesMagnetHoriz[1]=(KeyframeName="H50ft",Distance=800.0000000)
    m_AimAssistKeyframesMagnetHoriz[2]=(KeyframeName="H100ftLowMag",Distance=1600.0000000)
    m_AimAssistKeyframesMagnetHoriz[3]=(KeyframeName="H200ftLowMag",Distance=3200.0000000)
    m_GameplayCurvesDeprecated=TgGameplayCurves'DeviceInhand'
    m_ForceFeedbackStartFire=ForceFeedbackWaveform'LightForceFeedback'
    m_AccuracySettings=(bUsesAdvancedAccuracy=true,fMaxAccuracy=1.0000000,fMinAccuracy=0.8400000,fAccuracyLossPerShot=0.0300000,fAccuracyGainPerSec=0.4800000,fAccuracyGainDelay=0.2000000)
    m_RecoilSettings=(bUsesRecoil=true,fRecoilReductionPerSec=6.0000000,fRecoilCenterDelay=0.3000000,fRecoilSmoothRate=15.0000000)
}
