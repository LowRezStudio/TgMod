class TgDevice_OwlStealth extends TgDevice
    native(ChampOwl)
    hidecategories(Navigation)
    config(Engine)
    dependson(TgObject);

var TgPawn_Owl m_CachedOwl;
var TgDevice_Roost m_RoostCard;
var bool c_bAlreadyConsumedStealthJuice;

native function bool ShouldBlockReload(TgDevice Dev, bool bIsAutoReload);  // Export UTgDevice_OwlStealth::execShouldBlockReload(FFrame&, void* const)

native function float GetStealthJuicePerSec();  // Export UTgDevice_OwlStealth::execGetStealthJuicePerSec(FFrame&, void* const)

simulated event DeviceConsumePowerPool(byte FireModeNum) { }

simulated event bool CanDeviceStartFiringNow(byte FireModeNum, AimData Aim, bool bDebugRelevant, optional out TgObject.EDeviceFailType failType) { }

simulated function ConsumeStealthJuiceOnFire() { }

reliable client simulated function ClientConsumeStealthJuiceOnFire(int nAmtModified) { }

simulated event bool CanFiringBeCanceledByReactivation() { }

simulated event bool IsFunctionallyToggleDevice() { }

simulated event bool ShouldLockFiring(TgDevice Current) { }

simulated function bool ShouldCancelStealth() { }

simulated function bool ShouldInterruptReloadOnFire() { }

simulated event LinkedDeviceUnequipped(TgDevice Dev) { }

simulated event LinkedDeviceEquipped(TgDevice Dev) { }

simulated event OnLinkDevice(TgPawn TgP) { }

simulated event OnUnlinkDevice(TgPawn TgP) { }

state DeviceBuildup {}

state DeviceFiring {}

defaultproperties
{
    m_bBuildupShouldInterruptStealth=false
    m_bPreFireShouldInterruptStealth=false
    m_bFireShouldInterruptStealth=false
    m_bPostFireShouldInterruptStealth=false
    m_bCancelingShouldInterruptStealth=false
    m_nLinkedDeviceTypes[0]=15189
    m_nLinkedDeviceTypes[1]=15188
}
