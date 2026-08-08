class TgDevice_BuckInhand extends TgDevice
    hidecategories(Navigation)
    config(Engine);

enum ReloadAnimType {
    RAT_FirstShell,  // 0
    RAT_LoopingShells,  // 1
    RAT_PostReload,  // 2
};

var float m_fReloadScaleUsed;
var float m_fStartReloadTimestamp;
var float m_fFirstShellReloadTime;
var float m_fShellReloadTime;
var float m_fPostReloadTime;
var float m_fReloadTimer;
var int m_nProgressiveReloadTransactionID;
var bool m_bIsReloadingFirstShell;
var bool s_bPendingServerEndReload;

simulated event bool Use() { }

reliable server function ServerEndReloadForInhandFire() { }

simulated event bool StartReload(optional bool bIgnoreCurrentAmmo=false) { }

simulated function PreReloadTimer() { }

simulated function PlayReloadAnim(TgDevice_BuckInhand.ReloadAnimType rat, float ReloadTime) { }

simulated function PostReloadTimer() { }

reliable server function ServerStartReload() { }

reliable client simulated function ClientInterruptReload(optional bool bAllowAmmoFill=false) { }

defaultproperties
{
    m_AltFireType=ALTFIRE_AlternateDevice
    m_bAimThroughReticule=true
    m_bAltFireEnabled=true
    m_bConsolidateMultipleShots=true
    m_vMeshViewOffset=(X=17.0000000,Y=0.0000000,Z=-5.0000000)
    m_fWeaponBob=0.0000000
    m_fMeshFOV=77.0000000
    m_vProjectileSpawnOffset=(X=0.0000000,Y=15.0000000,Z=-20.0000000)
    m_WeaponMeshActorClass=Class'TgWeaponMeshActor_BuckInhand'
    m_AimAssistKeyframesMagnetVert[0]=(KeyframeName="V10ft",Distance=160.0000000)
    m_AimAssistKeyframesMagnetVert[1]=(KeyframeName="V100ft",Distance=1600.0000000)
    m_AimAssistKeyframesMagnetVert[2]=(KeyframeName="V150ftnull",Distance=2400.0000000)
    m_AimAssistKeyframesMagnetHoriz[0]=(KeyframeName="H10ft",Distance=160.0000000)
    m_AimAssistKeyframesMagnetHoriz[1]=(KeyframeName="H50ft",Distance=800.0000000)
    m_AimAssistKeyframesMagnetHoriz[2]=(KeyframeName="H100ft",Distance=1600.0000000)
    m_AimAssistKeyframesMagnetHoriz[3]=(KeyframeName="H150ftnull",Distance=2400.0000000)
    m_AimAssistKeyframesTrackingAccHoriz[0]=(KeyframeName="trackacc10ftx",Distance=160.0000000)
    m_AimAssistKeyframesTrackingAccHoriz[1]=(KeyframeName="BasicX",Distance=1600.0000000)
    m_AimAssistKeyframesTrackingAccHoriz[2]=(KeyframeName="trackacc150ftnull",Distance=2400.0000000)
    m_AimAssistKeyframesTrackingAngleHoriz[0]=(KeyframeName="trackang10ftlowx",Distance=160.0000000)
    m_AimAssistKeyframesTrackingAngleHoriz[1]=(KeyframeName="BasicX",Distance=1600.0000000)
    m_AimAssistKeyframesTrackingAngleHoriz[2]=(KeyframeName="trackang150ftnull",Distance=2400.0000000)
    m_AimAssistKeyframesTrackingAccVert[0]=(KeyframeName="BasicY",Distance=1600.0000000)
    m_AimAssistKeyframesTrackingAccVert[1]=(KeyframeName="trackacc150ftnull",Distance=2400.0000000)
    m_AimAssistKeyframesTrackingAngleVert[0]=(KeyframeName="BasicY",Distance=1600.0000000)
    m_AimAssistKeyframesTrackingAngleVert[1]=(KeyframeName="trackang150ftnull",Distance=2400.0000000)
    m_GameplayCurvesDeprecated=TgGameplayCurves'DeviceInhand'
    m_ForceFeedbackStartFire=ForceFeedbackWaveform'HeavyForceFeedback'
}
