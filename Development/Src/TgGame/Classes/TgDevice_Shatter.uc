class TgDevice_Shatter extends TgDevice
    native(ChampYing)
    hidecategories(Navigation)
    config(Engine)
    dependson(TgObject);

var TgPawn_Ying m_CachedYingPawn;

native function bool CanDeviceFireNow(byte FireModeNum, AimData Aim, bool bDeviceFailLog, out TgObject.EDeviceFailType failType);  // Export UTgDevice_Shatter::execCanDeviceFireNow(FFrame&, void* const)

simulated function CustomFire() { }

simulated function bool HasYingPawn() { }
