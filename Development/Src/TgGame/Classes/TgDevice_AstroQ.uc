class TgDevice_AstroQ extends TgDevice
    native(ChampAstro)
    hidecategories(Navigation)
    config(Engine)
    dependson(TgObject);

var bool m_bApplyCooldown;

native function bool CanDeviceFireNow(byte FireModeNum, AimData Aim, bool bDeviceFailLog, out TgObject.EDeviceFailType failType);  // Export UTgDevice_AstroQ::execCanDeviceFireNow(FFrame&, void* const)

simulated event DeliverHit(ImpactInfo Impact) { }

simulated function InterruptOtherDevices(TgPawn TgP) { }

simulated event DeliverQueuedPendingHits() { }

simulated event bool ShouldCooldownAfterFire() { }

function OnInstantShotRejected(ImpactToValidate RejectedPrimaryImpact) { }

state DeviceFiring {}
