class TgDevice_RendSoul extends TgDevice
    native(ChampOracle)
    hidecategories(Navigation)
    config(Engine)
    dependson(TgObject);

var bool m_bApplyCooldown;

native function bool CanDeviceFireNow(byte FireModeNum, AimData Aim, bool bDeviceFailLog, out TgObject.EDeviceFailType failType);  // Export UTgDevice_RendSoul::execCanDeviceFireNow(FFrame&, void* const)

simulated event bool ShouldCooldownAfterFire() { }

state DeviceFiring {}
