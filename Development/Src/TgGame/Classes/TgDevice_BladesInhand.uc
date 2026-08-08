class TgDevice_BladesInhand extends TgDevice
    native(ChampBlades)
    hidecategories(Navigation)
    config(Engine);

var bool m_bFirstShotInBurst;

simulated event bool ShouldLockFiring(TgDevice Current) { }

simulated function FireAmmunition() { }

simulated function int GetProjectileIDOverride(int ProjectileIndex) { }

state DeviceFiring {}

defaultproperties
{
    m_AltFireType=ALTFIRE_AlternateDevice
    m_ReticuleType=RETICULE_Maeve
    m_bAimThroughReticule=true
    m_bAltFireEnabled=true
    m_bUsesBurstFire=true
    m_vMeshViewOffset=(X=15.0000000,Y=0.0000000,Z=-4.0000000)
    m_fWeaponBob=0.0000000
    m_fMeshFOV=77.0000000
    m_vProjectileSpawnOffset=(X=21.0000000,Y=0.0000000,Z=-4.0000000)
    m_nBurstTotalShots=2
    m_WeaponMeshActorClass=Class'TgWeaponMeshActor_SkyeInHand'
    m_AimAssistKeyframesMagnetVert[0]=(KeyframeName="V150ftnull",Distance=2400.0000000)
    m_AimAssistKeyframesMagnetHoriz[0]=(KeyframeName="H10ft",Distance=160.0000000)
    m_AimAssistKeyframesMagnetHoriz[1]=(KeyframeName="H50ft",Distance=800.0000000)
    m_AimAssistKeyframesMagnetHoriz[2]=(KeyframeName="H100ft",Distance=1600.0000000)
    m_AimAssistKeyframesMagnetHoriz[3]=(KeyframeName="H150ftnull",Distance=2400.0000000)
    m_AimAssistKeyframesTrackingAccHoriz[0]=(KeyframeName="trackacc10ftx",Distance=160.0000000)
    m_AimAssistKeyframesTrackingAccHoriz[1]=(KeyframeName="BasicX",Distance=1600.0000000)
    m_AimAssistKeyframesTrackingAccHoriz[2]=(KeyframeName="trackacc150ftnull",Distance=2400.0000000)
    m_AimAssistKeyframesTrackingAngleHoriz[0]=(KeyframeName="trackang10ftx",Distance=160.0000000)
    m_AimAssistKeyframesTrackingAngleHoriz[1]=(KeyframeName="BasicX",Distance=1600.0000000)
    m_AimAssistKeyframesTrackingAngleHoriz[2]=(KeyframeName="trackang150ftnull",Distance=2400.0000000)
    m_AimAssistKeyframesTrackingAccVert[0]=(KeyframeName="BasicY",Distance=1600.0000000)
    m_AimAssistKeyframesTrackingAccVert[1]=(KeyframeName="trackacc150ftnull",Distance=2400.0000000)
    m_AimAssistKeyframesTrackingAngleVert[0]=(KeyframeName="BasicY",Distance=1600.0000000)
    m_AimAssistKeyframesTrackingAngleVert[1]=(KeyframeName="trackang150ftnull",Distance=2400.0000000)
    m_ForceFeedbackStartFire=ForceFeedbackWaveform'BasicForceFeedback'
    m_ForceFeedbackStopReload=ForceFeedbackWaveform'StandardReload'
    m_AccuracySettings=(bUsesAdvancedAccuracy=true,fMaxAccuracy=1.0000000,fMinAccuracy=0.9000000,fAccuracyLossPerShot=0.0100000,fAccuracyGainPerSec=0.6000000,fAccuracyGainDelay=0.2000000)
}
