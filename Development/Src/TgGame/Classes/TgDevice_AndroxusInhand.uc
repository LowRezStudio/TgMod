class TgDevice_AndroxusInhand extends TgDevice
    native(ChampAndroxus)
    hidecategories(Navigation)
    config(Engine)
    dependson(TgObject);

struct BurstShotAmmoInfo {
    var int ClientRequestId;
    var byte nShotsRemaining;
    var bool bFirstInBurst;
    structdefaultproperties {}
};

var bool m_bWantsAltFire;
var bool m_bFirstShotInBurst;
var bool m_bApplyLiftOff;
var int m_nShotsRemaining;
var array<BurstShotAmmoInfo> s_BurstShotAmmoQueue;

native function bool CanReload(optional bool bIsAutoReload=false);  // Export UTgDevice_AndroxusInhand::execCanReload(FFrame&, void* const)

native function float GetAccuracy(optional int nMode=-1);  // Export UTgDevice_AndroxusInhand::execGetAccuracy(FFrame&, void* const)

native function TgGameplayCurvesSet GetShotSpreadTendencyCurvesSet();  // Export UTgDevice_AndroxusInhand::execGetShotSpreadTendencyCurvesSet(FFrame&, void* const)

reliable server function ServerAltUse(bool bEnable) { }

simulated event SetAltFireSecondModeNow(bool bEnable) { }

simulated function FireAmmunition() { }

simulated function UpdateDesiredFireMode() { }

reliable server function ServerUpdateBurstShotsRemaining(byte nShotsRemaining, bool bFirstInBurst, int nClientRequestId) { }

simulated function CallServerStartFire(AimData Aim, optional bool bPendingUpdate) { }

simulated function CallServerRestartFireLoop(AimData Aim) { }

simulated function HandleDeviceFormStartFire(int nDeviceModeNum, float fRefireTime, const out AimData Aim) { }

simulated function float GetEstimatedTotalBurstTime(int nShotsRemaining) { }

simulated function float GetLongBulletRefireTime() { }

simulated function float GetShortBulletRefireTime() { }

state DeviceFiring {}

defaultproperties
{
    m_AltFireType=ALTFIRE_SecondMode
    m_ReticuleType=RETICULE_Precise
    m_bAimThroughReticule=true
    m_bAltFireEnabled=true
    m_vMeshViewOffset=(X=17.0000000,Y=0.0000000,Z=-5.0000000)
    m_fWeaponBob=0.0000000
    m_fMeshFOV=77.0000000
    m_vProjectileSpawnOffset=(X=30.0000000,Y=17.5000000,Z=-12.5000000)
    m_WeaponMeshActorClass=Class'TgWeaponMeshActor_AndroxusInhand'
    m_AimAssistKeyframesMagnetHoriz[0]=(KeyframeName="H10ft",Distance=160.0000000)
    m_AimAssistKeyframesMagnetHoriz[1]=(KeyframeName="H50ft",Distance=800.0000000)
    m_AimAssistKeyframesMagnetHoriz[2]=(KeyframeName="H100ft",Distance=1600.0000000)
    m_AimAssistKeyframesMagnetHoriz[3]=(KeyframeName="H200ftLowMag",Distance=3200.0000000)
    m_AimAssistKeyframesTrackingAccHoriz[0]=(KeyframeName="trackacc10ftx",Distance=160.0000000)
    m_AimAssistKeyframesTrackingAccHoriz[1]=(KeyframeName="BasicX",Distance=1600.0000000)
    m_AimAssistKeyframesTrackingAccHoriz[2]=(KeyframeName="trackacc200ftnull",Distance=3200.0000000)
    m_AimAssistKeyframesTrackingAngleHoriz[0]=(KeyframeName="trackang10ftx",Distance=160.0000000)
    m_AimAssistKeyframesTrackingAngleHoriz[1]=(KeyframeName="BasicX",Distance=1600.0000000)
    m_AimAssistKeyframesTrackingAngleHoriz[2]=(KeyframeName="trackang200ftnull",Distance=3200.0000000)
    m_AimAssistKeyframesTrackingAccVert[0]=(KeyframeName="BasicY",Distance=1600.0000000)
    m_AimAssistKeyframesTrackingAccVert[1]=(KeyframeName="trackacc200ftnull",Distance=3200.0000000)
    m_AimAssistKeyframesTrackingAngleVert[0]=(KeyframeName="BasicY",Distance=1600.0000000)
    m_AimAssistKeyframesTrackingAngleVert[1]=(KeyframeName="trackang200ftnull",Distance=3200.0000000)
    m_GameplayCurvesDeprecated=TgGameplayCurves'DeviceInhand'
    m_ForceFeedbackStartFire=ForceFeedbackWaveform'BasicForceFeedback'
}
