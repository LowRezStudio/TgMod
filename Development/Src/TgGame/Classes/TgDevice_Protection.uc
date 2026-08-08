class TgDevice_Protection extends TgDevice
    native(ChampGauntlet)
    hidecategories(Navigation)
    config(Engine)
    dependson(TgObject);

var TgPawn_Gauntlet m_Gauntlet;

native function bool CanDeviceFireNow(byte FireModeNum, AimData Aim, bool bDeviceFailLog, out TgObject.EDeviceFailType failType);  // Export UTgDevice_Protection::execCanDeviceFireNow(FFrame&, void* const)

simulated event DeliverQueuedPendingHits() { }

simulated event bool ShouldCooldownAfterFire() { }

simulated event bool ShouldLockFiring(TgDevice Current) { }
