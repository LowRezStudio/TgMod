class TgDevice_ToggleWithLockout extends TgDevice_Stim
    native(Devices)
    hidecategories(Navigation)
    config(Engine)
    dependson(TgObject);

var TgPawn m_CachedTgP;
var float m_fCurrentTransitionPct;

native function bool CanDeviceFireNow(byte FireModeNum, AimData Aim, bool bDeviceFailLog, out TgObject.EDeviceFailType failType);  // Export UTgDevice_ToggleWithLockout::execCanDeviceFireNow(FFrame&, void* const)

simulated function TgPawn GetCachedTgP() { }

simulated event bool ShouldLockFiring(TgDevice Current) { }

simulated event bool CanBeCanceled() { }

simulated event bool CanBeInterrupted() { }

simulated event bool IsToggleDevice() { }

simulated function FiringEndTransition() { }

simulated function SetTransitionPct() { }

reliable server event InterruptFiring() { }

reliable client simulated event ClientInterrupt() { }

simulated function StopFire(byte FireModeNum) { }

simulated function CompleteInterrupt() { }

simulated event LinkedDeviceEquipped(TgDevice Dev) { }

simulated event LinkedDeviceUnequipped(TgDevice Dev) { }

simulated function CustomFire() { }

state DeviceFiring {}

defaultproperties
{
    m_nLinkedDeviceTypes[0]=11077
}
