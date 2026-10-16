class TgDevice_Hustle extends TgDevice
    native(ChampViktor)
    hidecategories(Navigation)
    implements(TgDeviceInterface_MoveSpeedMultiplier)
    config(Engine)
    dependson(TgObject);

var () float m_fMinSprintSpeedSq;
var () float m_fAllowableSprintAngle;
var () float m_fSprintFailSafetyTime;
var float m_fSprintFailTimeAccumulator;

native function bool ShouldBlockReload(TgDevice Dev, bool bIsAutoReload);  // Export UTgDevice_Hustle::execShouldBlockReload(FFrame&, void* const)

native function float GetMoveSpeedMultiplier();  // Export UTgDevice_Hustle::execGetMoveSpeedMultiplier(FFrame&, void* const)

native function bool IsDeviceFiringLockedForUI();  // Export UTgDevice_Hustle::execIsDeviceFiringLockedForUI(FFrame&, void* const)

native function bool CanDeviceFireNow(byte FireModeNum, AimData Aim, bool bDeviceFailLog, out TgObject.EDeviceFailType failType);  // Export UTgDevice_Hustle::execCanDeviceFireNow(FFrame&, void* const)

native function bool ShouldInterruptLift();  // Export UTgDevice_Hustle::execShouldInterruptLift(FFrame&, void* const)

simulated event bool ShouldLockFiring(TgDevice Current) { }

simulated event bool CanBeCanceled() { }

simulated event bool CanBeInterrupted() { }

function OnCripple() { }

simulated event bool CanFiringBeCanceledByReactivation() { }

simulated function bool InterceptSlotReleased(TgPlayerController TgController) { }

simulated event bool ShouldInterruptReloadOnFire() { }

simulated event bool CanSprint() { }

simulated function FiringEndTransition() { }

simulated function CancelSafetyTimer() { }

simulated function CompleteInterrupt() { }

simulated event LinkedDeviceEquipped(TgDevice Dev) { }

simulated event LinkedDeviceUnequipped(TgDevice Dev) { }

state DeviceFiring {}

defaultproperties
{
    m_fMinSprintSpeedSq=30000.0000000
    m_fAllowableSprintAngle=0.5000000
    m_fSprintFailSafetyTime=0.2500000
    m_nLinkedDeviceTypes[0]=10828
    m_nLinkedDeviceTypes[1]=11041
    m_nLinkedDeviceTypes[2]=11070
    m_nLinkedDeviceTypes[3]=15052
    m_nLinkedDeviceTypes[4]=11077
}
