class TgDevice_ItemStoreBeacon extends TgDevice_TeamDevice
    native(Devices)
    hidecategories(Navigation)
    config(Engine)
    dependson(TgObject);

native function TgRespawnBeaconExit GetBeaconExit();  // Export UTgDevice_ItemStoreBeacon::execGetBeaconExit(FFrame&, void* const)

native function bool IsBeaconEnabled();  // Export UTgDevice_ItemStoreBeacon::execIsBeaconEnabled(FFrame&, void* const)

native function bool IsTeamBeaconActive();  // Export UTgDevice_ItemStoreBeacon::execIsTeamBeaconActive(FFrame&, void* const)

native function bool IsTargetingModeReady(optional out TgObject.EDeviceFailType failType);  // Export UTgDevice_ItemStoreBeacon::execIsTargetingModeReady(FFrame&, void* const)

native function bool CanDeviceFireNow(byte FireModeNum, AimData Aim, bool bDeviceFailLog, out TgObject.EDeviceFailType failType);  // Export UTgDevice_ItemStoreBeacon::execCanDeviceFireNow(FFrame&, void* const)

simulated function CustomFire() { }

defaultproperties
{
    m_fBottomlessPitCheck=48.0000000
}
