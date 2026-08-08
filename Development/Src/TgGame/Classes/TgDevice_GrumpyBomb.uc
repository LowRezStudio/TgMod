class TgDevice_GrumpyBomb extends TgDevice
    native(ChampBombKing)
    hidecategories(Navigation)
    config(Engine)
    dependson(TgObject);

var () float m_fPostTargetingLockInDuration;

native function bool UsesTargetingMode();  // Export UTgDevice_GrumpyBomb::execUsesTargetingMode(FFrame&, void* const)

native function EnterTargetingMode();  // Export UTgDevice_GrumpyBomb::execEnterTargetingMode(FFrame&, void* const)

native function bool IsTargetingModeReady(optional out TgObject.EDeviceFailType failType);  // Export UTgDevice_GrumpyBomb::execIsTargetingModeReady(FFrame&, void* const)

native function DeviceAdjustDamage(const out ImpactInfo Impact, out float fDamage, int nPropertyId);  // Export UTgDevice_GrumpyBomb::execDeviceAdjustDamage(FFrame&, void* const)

native function bool CanDeviceFireNow(byte FireModeNum, AimData Aim, bool bDeviceFailLog, out TgObject.EDeviceFailType failType);  // Export UTgDevice_GrumpyBomb::execCanDeviceFireNow(FFrame&, void* const)

simulated function bool InterceptRightMousePressed(TgPlayerController TgController) { }

simulated function PutAway() { }

simulated event bool ShouldInterruptReloadOnBeginTargeting() { }

simulated event bool CanBeInterrupted() { }

simulated function bool CanToggleTargetingOff() { }

simulated function PostTargetingLockIn() { }

defaultproperties
{
    m_eCastModeOverride=CM_Instant
    m_bUseCustomCastMode=true
    m_bDisableLagCompensation=true
    m_GameplayCurvesDeprecated=TgGameplayCurves'DeviceGrumpyBomb'
}
