class TgDevice_LexInhand extends TgDevice
    native(ChampLex)
    hidecategories(Navigation)
    config(Engine)
    dependson(TgObject);

var TgPawn_Lex m_CachedLexPawn;
var TgDevice_InPursuit m_CachedInPursuitDevice;
var TgDevice_Vengeance_Lex m_CachedVengeanceDevice;
var bool m_bShouldAutoFire;
var float m_fQueueFireTime;
var const float m_fQueueFireTimeThreshold;

native function GetTargetingAim(out AimData Aim);  // Export UTgDevice_LexInhand::execGetTargetingAim(FFrame&, void* const)

native function AimData ValidateReceivedAim(float ClientMovementTimeStamp, AimData Aim);  // Export UTgDevice_LexInhand::execValidateReceivedAim(FFrame&, void* const)

native function bool CanFireIfLeftMouseDown();  // Export UTgDevice_LexInhand::execCanFireIfLeftMouseDown(FFrame&, void* const)

native function bool ShouldAutoFire();  // Export UTgDevice_LexInhand::execShouldAutoFire(FFrame&, void* const)

native function DeviceAdjustDamage(const out ImpactInfo Impact, out float fDamage, int nPropertyId);  // Export UTgDevice_LexInhand::execDeviceAdjustDamage(FFrame&, void* const)

simulated function bool InterceptLeftMousePressed(TgPlayerController TgController) { }

simulated event SetAmmo(int AmmoCount, optional int ClipSize=-1, optional bool bShouldValidate=false, optional int ValidationIDOverride=0) { }

simulated function bool HasCachedLexPawn() { }

state DeviceFiring {}

defaultproperties
{
    m_fQueueFireTime=-1.0000000
    m_fQueueFireTimeThreshold=0.2500000
    m_AltFireType=ALTFIRE_AlternateDevice
    m_bAltFireEnabled=true
    m_fMeshFOV=77.0000000
    m_WeaponMeshActorClass=Class'TgWeaponMeshActor_LexInhand'
    m_GameplayCurvesDeprecated=TgGameplayCurves'DeviceInhand'
    m_ForceFeedbackStartFire=ForceFeedbackWaveform'HeavyForceFeedback'
    m_AccuracySettings=(bUsesAdvancedAccuracy=true,fMaxAccuracy=1.0800000,fMinAccuracy=0.7800000,fAccuracyLossPerShot=0.0500000,fAccuracyGainPerSec=0.6000000,fAccuracyGainDelay=0.3000000)
    m_RecoilSettings=(bUsesRecoil=true,fRecoilReductionPerSec=15.0000000,fRecoilSmoothRate=40.0000000)
}
