class TgDevice_SniperMode extends TgDevice_ToggleModeWithLockout
    native(ChampKinessa)
    hidecategories(Navigation)
    config(Engine)
    dependson(TgObject);

var TgPawn_Kinessa m_CachedKinessaOwner;
var TgDevice_KinessaInhand m_CachedKinessaInhandDev;
var bool m_bIsZoomed;

native function bool CanDeviceFireNow(byte FireModeNum, AimData Aim, bool bDeviceFailLog, out TgObject.EDeviceFailType failType);  // Export UTgDevice_SniperMode::execCanDeviceFireNow(FFrame&, void* const)

simulated function bool ShouldInterruptMount() { }

simulated event bool CanBeInterrupted() { }

simulated event bool ShouldInterruptInhand() { }

simulated function RefreshZoomState(bool bZoomOn) { }

simulated event LinkedDeviceEquipped(TgDevice Dev) { }

simulated event LinkedDeviceUnequipped(TgDevice Dev) { }

simulated function bool IsPlayerToggleZoomSet() { }

simulated function CompleteInterrupt() { }

simulated function bool InterceptSlotReleased(TgPlayerController TgController) { }

simulated event bool IsFunctionallyToggleDevice() { }

simulated function bool ShouldStopActionOnOffhandSlotReleased() { }

state DeviceFiring {}

defaultproperties
{
    m_bBuildupShouldInterruptStealth=false
    m_bPreFireShouldInterruptStealth=false
    m_bFireShouldInterruptStealth=false
    m_bCancelingShouldInterruptStealth=false
    m_nLinkedDeviceTypes[0]=11077
    m_nLinkedDeviceTypes[1]=10828
    m_nLinkedDeviceTypes[2]=10828
    m_nLinkedDeviceTypes[3]=11041
    m_nLinkedDeviceTypes[4]=11070
    m_AimAssistKeyframesMagnetVert=none
    m_AimAssistKeyframesMagnetHoriz=none
    m_nAimAssistPriorityWhileFiring=2
}
