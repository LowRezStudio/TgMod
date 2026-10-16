class TgDevice_Toggle extends TgDevice
    native(Devices)
    hidecategories(Navigation)
    config(Engine)
    dependson(TgObject);

var bool m_bIsToggle;

native function UpdateUIToggleState();  // Export UTgDevice_Toggle::execUpdateUIToggleState(FFrame&, void* const)

native function bool CanDeviceFireNow(byte FireModeNum, AimData Aim, bool bDeviceFailLog, out TgObject.EDeviceFailType failType);  // Export UTgDevice_Toggle::execCanDeviceFireNow(FFrame&, void* const)

simulated function bool CanDeviceFireInTargetingMode() { }

simulated function FireAmmunition() { }

simulated event StartFire(byte FireModeNum) { }

simulated function ConsumeAmmoFromFiring(optional int nAmmoConsumptionOverride=-1, optional int nFireRequestIDOverride=-1) { }

simulated event bool IsToggleDevice() { }

simulated function bool ShouldInterruptReload() { }

state DeviceFiring {}

defaultproperties
{
    m_bIsToggle=true
    m_bPostFireShouldInterruptStealth=false
}
