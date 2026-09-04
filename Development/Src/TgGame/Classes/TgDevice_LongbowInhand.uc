class TgDevice_LongbowInhand extends TgDevice
    native(ChampLongbow)
    hidecategories(Navigation)
    config(Engine);

var TgPawn_Longbow m_CachedLongbow;
var float s_fLastFireHoldPct;
var float m_fFireReleasePercent;
var float m_fImpalerReticleAnimationTimer;
var (Reticle) float m_fReticleReleaseAnimationDuration;
var (Reticle) float m_fImpalerReticleFadeInDuration;
var (Reticle) float m_fImpalerReticleFadeOutDuration;
var (Reticle) float m_fImpalerReticleGrowth;
var () Vector m_vProjectileSpawnOffsetPlanted;

native function bool ShouldAutoFire();  // Export UTgDevice_LongbowInhand::execShouldAutoFire(FFrame&, void* const)

native function bool HasCachedLongbow();  // Export UTgDevice_LongbowInhand::execHasCachedLongbow(FFrame&, void* const)

simulated event Vector GetProjectileSpawnOffset() { }

native function bool CanFireIfLeftMouseDown();  // Export UTgDevice_LongbowInhand::execCanFireIfLeftMouseDown(FFrame&, void* const)

simulated function bool ReleaseHoldOnRightMouseReleased() { }

simulated event bool CanBeCanceled() { }

simulated function Projectile ProjectileFire() { }

simulated function int GetProjectileIDOverride(int ProjectileIndex) { }

simulated function SetFireHoldAmt(float fFireHoldTime) { }

simulated function AdjustSpawnedProjectile(out TgProj_Simulated SpawnedProjectile) { }

simulated function ReleaseFireHoldInternal() { }

simulated function bool StartFireHold() { }

simulated event bool CanBeInterrupted() { }

defaultproperties
{
    m_fReticleReleaseAnimationDuration=0.1500000
    m_fImpalerReticleFadeInDuration=0.1000000
    m_fImpalerReticleFadeOutDuration=0.1000000
    m_fImpalerReticleGrowth=10.0000000
    m_vProjectileSpawnOffsetPlanted=(X=15.0000000,Y=5.0000000,Z=-45.0000000)
    m_AltFireType=ALTFIRE_AlternateDevice
    m_ReticuleType=RETICULE_ShaLin
    m_bBuildupShouldInterruptStealth=false
    m_bPreFireShouldInterruptStealth=false
    m_bPostFireShouldInterruptStealth=false
    m_bStartFireShouldEnterCombat=false
    m_bAimThroughReticule=true
    m_bNoReticleBloom=true
    m_bAltFireEnabled=true
    m_bIsFireHoldDevice=true
    m_vMeshViewOffset=(X=12.0000000,Y=1.0000000,Z=-5.0000000)
    m_fWeaponBob=0.0000000
    m_fMeshFOV=90.0000000
    m_vProjectileSpawnOffset=(X=15.0000000,Y=0.0000000,Z=-5.0000000)
    m_fAltFireLockOutTime=0.0000000
    m_WeaponMeshActorClass=Class'TgWeaponMeshActor_LongbowInhand'
    m_AimAssistKeyframesMagnetVert[0]=(KeyframeName="V150ftnull",Distance=2400.0000000)
    m_AimAssistKeyframesMagnetHoriz[0]=(KeyframeName="H10ft",Distance=160.0000000)
    m_AimAssistKeyframesMagnetHoriz[1]=(KeyframeName="H50ft",Distance=800.0000000)
    m_AimAssistKeyframesMagnetHoriz[2]=(KeyframeName="H100ftLowMag",Distance=1600.0000000)
    m_AimAssistKeyframesMagnetHoriz[3]=(KeyframeName="H200ftLowMag",Distance=3200.0000000)
    m_ForceFeedbackStopHold=ForceFeedbackWaveform'HeavyForceFeedback'
    m_ForceFeedbackStopReload=ForceFeedbackWaveform'StandardReload'
}
