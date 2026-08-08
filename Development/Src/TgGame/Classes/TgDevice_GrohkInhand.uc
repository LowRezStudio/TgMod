class TgDevice_GrohkInhand extends TgDevice_ArcingBeam
    native(ChampGrohk)
    hidecategories(Navigation)
    config(Engine)
    dependson(TgObject);

var TgPawn_Grohk m_CachedGrohkPawn;

native function DeviceAdjustDamage(const out ImpactInfo Impact, out float fDamage, int nPropertyId);  // Export UTgDevice_GrohkInhand::execDeviceAdjustDamage(FFrame&, void* const)

native function bool IsValidArcTarget(Actor TestActor, ArcingInfo Info);  // Export UTgDevice_GrohkInhand::execIsValidArcTarget(FFrame&, void* const)

simulated function bool HasCachedGrohkPawn() { }

simulated function ImpactInfo CalcWeaponFire(vector StartTrace, vector EndTrace, optional out array<ImpactInfo> ImpactList, optional vector Extent) { }

function OnInstantShotVerified(ImpactInfo VerifiedPrimaryImpact) { }

simulated function UpdateInhandTargetInfo(Actor HitActor, Vector HitLocation) { }

defaultproperties
{
    m_nMaxNumArcsPerTarget=0
    m_AltFireType=ALTFIRE_AlternateDevice
    m_bAimThroughReticule=true
    m_bAltFireEnabled=true
    m_bCanReloadEarly=false
    m_bDoNotAllowHeadShots=true
    m_vMeshViewOffset=(X=10.0000000,Y=2.0000000,Z=-2.0000000)
    m_fWeaponBob=0.0000000
    m_vProjectileSpawnOffset=(X=0.0000000,Y=4.0000000,Z=-9.0000000)
    m_fAltFireLockOutTime=0.0000000
    m_WeaponMeshActorClass=Class'TgWeaponMeshActor_Orb'
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
    m_ForceFeedbackStartFire=ForceFeedbackWaveform'LightForceFeedback'
}
