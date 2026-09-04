class TgDevice_BarrageFire extends TgDevice
    native(ChampViktor)
    hidecategories(Navigation)
    config(Engine)
    dependson(TgObject);

var int m_nChainedBarrageNum;
var TgDevice_Barrage m_BarrageDevice;

native function GetTargetingAim(out AimData Aim);  // Export UTgDevice_BarrageFire::execGetTargetingAim(FFrame&, void* const)

native function float GetConePullbackDistance();  // Export UTgDevice_BarrageFire::execGetConePullbackDistance(FFrame&, void* const)

native function AimData ValidateReceivedAim(float ClientMovementTimeStamp, AimData Aim);  // Export UTgDevice_BarrageFire::execValidateReceivedAim(FFrame&, void* const)

native function bool CanDeviceFireNow(byte FireModeNum, AimData Aim, bool bDeviceFailLog, out TgObject.EDeviceFailType failType);  // Export UTgDevice_BarrageFire::execCanDeviceFireNow(FFrame&, void* const)

native function float GetCurrentShotCost();  // Export UTgDevice_BarrageFire::execGetCurrentShotCost(FFrame&, void* const)

native function bool UpdateUltChargePercent();  // Export UTgDevice_BarrageFire::execUpdateUltChargePercent(FFrame&, void* const)

simulated function ResetBarrage() { }

simulated function bool InterceptLeftMousePressed(TgPlayerController TgController) { }

simulated function bool InterceptLeftMouseReleased(TgPlayerController TgController) { }

simulated function bool ShouldConsumePowerPoolOnStartFire() { }

simulated function bool ShouldConsumePowerPoolAfterFire() { }

simulated function CustomFire() { }

simulated function HandleDeviceFormStartFire(int nDeviceModeNum, float fRefireTime, const out AimData Aim) { }

simulated event LinkedDeviceEquipped(TgDevice Dev) { }

simulated event LinkedDeviceUnequipped(TgDevice Dev) { }

state DeviceFiring {}

defaultproperties
{
    m_nLinkedDeviceIDs[0]=14351
}
