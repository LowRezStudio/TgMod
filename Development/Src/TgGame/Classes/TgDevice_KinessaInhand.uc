class TgDevice_KinessaInhand extends TgDevice
    native(ChampKinessa)
    hidecategories(Navigation)
    config(Engine);

var () Vector m_vSniperProjectileSpawnOffset;
var ForceFeedbackWaveform m_ForceFeedbackStartFireScout;
var ForceFeedbackWaveform m_ForceFeedbackStartFireSniper;

native function SetFireMode(int nFireModeNum, optional bool ForceSet=false);  // Export UTgDevice_KinessaInhand::execSetFireMode(FFrame&, void* const)

native function bool RequiresAmmoToFire();  // Export UTgDevice_KinessaInhand::execRequiresAmmoToFire(FFrame&, void* const)

simulated function StartSteadyInhandEffects() { }

simulated function EndSteadyInhandEffects() { }

state DeviceFiring {}

defaultproperties
{
    m_vSniperProjectileSpawnOffset=(X=30.0000000,Y=0.0000000,Z=-3.0000000)
    m_ForceFeedbackStartFireScout=ForceFeedbackWaveform'LightForceFeedback'
    m_ForceFeedbackStartFireSniper=ForceFeedbackWaveform'HeavyForceFeedback'
    m_AltFireType=ALTFIRE_AlternateDevice
    m_ReticuleType=RETICULE_None
    m_bAimThroughReticule=true
    m_bAltFireEnabled=true
    m_vMeshViewOffset=(X=17.0000000,Y=0.0000000,Z=-5.0000000)
    m_fWeaponBob=0.0000000
    m_vProjectileSpawnOffset=(X=30.0000000,Y=9.0000000,Z=-10.0000000)
    m_WeaponMeshActorClass=Class'TgWeaponMeshActor_Sniper'
    m_AimAssistKeyframesMagnetHoriz[0]=(KeyframeName="H10ft",Distance=160.0000000)
    m_AimAssistKeyframesMagnetHoriz[1]=(KeyframeName="H50ft",Distance=800.0000000)
    m_AimAssistKeyframesMagnetHoriz[2]=(KeyframeName="H100ftLowMag",Distance=1600.0000000)
    m_AimAssistKeyframesMagnetHoriz[3]=(KeyframeName="H200ftLowMag",Distance=3200.0000000)
    m_GameplayCurvesDeprecated=TgGameplayCurves'DeviceInhand'
    m_AccuracySettings=(bUsesAdvancedAccuracy=true,fMaxAccuracy=0.9800000,fMinAccuracy=0.8500000,fAccuracyLossPerShot=0.0400000,fAccuracyGainPerSec=0.5000000,fAccuracyGainDelay=0.2000000)
}
