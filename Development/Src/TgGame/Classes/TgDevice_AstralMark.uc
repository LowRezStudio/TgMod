class TgDevice_AstralMark extends TgDevice
    native(ChampAstro)
    hidecategories(Navigation)
    config(Engine)
    dependson(TgObject);

native function bool CanDeviceFireNow(byte FireModeNum, AimData Aim, bool bDeviceFailLog, out TgObject.EDeviceFailType failType);  // Export UTgDevice_AstralMark::execCanDeviceFireNow(FFrame&, void* const)

simulated function InterruptOtherDevices(TgPawn TgP) { }

simulated event DeliverQueuedPendingHits() { }

simulated event DeliverHit(ImpactInfo Impact) { }

simulated event bool ShouldCooldownAfterFire() { }

state DeviceFiring {}
