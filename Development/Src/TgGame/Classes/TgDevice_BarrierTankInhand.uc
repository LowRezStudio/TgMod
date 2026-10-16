class TgDevice_BarrierTankInhand extends TgDevice
    native(ChampBarrierTank)
    hidecategories(Navigation)
    implements(TgDeviceInterface_MoveSpeedMultiplier)
    config(Engine)
    dependson(TgObject);

var TgPawn_BarrierTank m_CachedBarrierTankPawn;
var Vector m_vProjectileSpawnOffset2;
var Vector m_vProjectileSpawnOffset3;

native function bool CanDeviceFireNow(byte FireModeNum, AimData Aim, bool bDeviceFailLog, out TgObject.EDeviceFailType failType);  // Export UTgDevice_BarrierTankInhand::execCanDeviceFireNow(FFrame&, void* const)

native function float GetMoveSpeedMultiplier();  // Export UTgDevice_BarrierTankInhand::execGetMoveSpeedMultiplier(FFrame&, void* const)

simulated event Vector GetProjectileSpawnOffset() { }

simulated function int GetProjectileIDOverride(int ProjectileIndex) { }

simulated event SetAmmo(int AmmoCount, optional int ClipSize=-1, optional bool bShouldValidate=false, optional int ValidationIDOverride=0) { }

simulated function bool HasCachedBarrierTankPawn() { }

simulated function InterruptLockoutTime() { }

simulated delegate InterruptFiringDelegate();

simulated event LinkedDeviceEquipped(TgDevice Dev) { }

simulated event LinkedDeviceUnequipped(TgDevice Dev) { }

simulated function SelfSlowTimer() { }

state DeviceFiring {}

defaultproperties
{
    m_vProjectileSpawnOffset2=(X=30.0000000,Y=16.0000000,Z=-8.0000000)
    m_vProjectileSpawnOffset3=(X=30.0000000,Y=9.6000000,Z=-9.6000000)
    m_AltFireType=ALTFIRE_AlternateDevice
    m_ReticuleType=RETICULE_Precise
    m_bAimThroughReticule=true
    m_bAltFireEnabled=true
    m_bUsesBurstFire=true
    m_bOnlyFirstBurstCostsAmmo=true
    m_vMeshViewOffset=(X=17.0000000,Y=0.0000000,Z=-5.0000000)
    m_fWeaponBob=0.0000000
    m_fMeshFOV=90.0000000
    m_vProjectileSpawnOffset=(X=30.0000000,Y=11.2000000,Z=-6.4000000)
    m_fAltFireLockOutTime=0.0000000
    m_nBurstTotalShots=3
    m_WeaponMeshActorClass=Class'TgWeaponMeshActor_BarrierTankInhand'
    m_nLinkedDeviceIDs[0]=16251
    m_nLinkedDeviceIDs[1]=16250
    m_nLinkedDeviceIDs[2]=16248
    m_nLinkedDeviceIDs[3]=16252
    m_AimAssistKeyframesMagnetHoriz[0]=(KeyframeName="H10ft",Distance=160.0000000)
    m_AimAssistKeyframesMagnetHoriz[1]=(KeyframeName="H50ft",Distance=800.0000000)
    m_AimAssistKeyframesMagnetHoriz[2]=(KeyframeName="H100ftLowMag",Distance=1600.0000000)
    m_AimAssistKeyframesMagnetHoriz[3]=(KeyframeName="H200ftLowMag",Distance=3200.0000000)
    m_GameplayCurvesDeprecated=TgGameplayCurves'DeviceInhand'
    m_ForceFeedbackStartFire=ForceFeedbackWaveform'BasicForceFeedback'
}
