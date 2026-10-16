class TgDevice_Barrage extends TgDevice
    native(ChampViktor)
    hidecategories(Navigation)
    config(Engine)
    dependson(TgObject);

var TgDevice_BarrageFire m_BarrageFireDevice;

native function float GetRequiredEnergyToFire();  // Export UTgDevice_Barrage::execGetRequiredEnergyToFire(FFrame&, void* const)

native function bool CanDeviceFireNow(byte FireModeNum, AimData Aim, bool bDeviceFailLog, out TgObject.EDeviceFailType failType);  // Export UTgDevice_Barrage::execCanDeviceFireNow(FFrame&, void* const)

native function bool UsesTargetingMode();  // Export UTgDevice_Barrage::execUsesTargetingMode(FFrame&, void* const)

native function TickTargetingMode(float DeltaSeconds);  // Export UTgDevice_Barrage::execTickTargetingMode(FFrame&, void* const)

native function ExitTargetingMode();  // Export UTgDevice_Barrage::execExitTargetingMode(FFrame&, void* const)

simulated event bool CanBeCanceled() { }

simulated function CustomFire() { }

simulated function bool ShouldConsumePowerPoolOnStartFire() { }

native function bool CanFireIfLeftMouseDown();  // Export UTgDevice_Barrage::execCanFireIfLeftMouseDown(FFrame&, void* const)

simulated event bool ShouldInterruptReloadOnFire() { }

simulated event bool ShouldLockFiring(TgDevice Current) { }

simulated function float GetLockoutExtensionTime() { }

simulated event bool CanBeInterrupted() { }

simulated function LastShotCancelTimer() { }

simulated function bool IsToggleDevice() { }

simulated event LinkedDeviceEquipped(TgDevice Dev) { }

state DeviceFiring {}

defaultproperties
{
    m_eCastModeOverride=CM_Instant
    c_bUsesTargetingReticle=false
    m_bUseCustomCastMode=true
    m_nLinkedDeviceIDs[0]=14462
}
