class TgDevice_Scope extends TgDevice_ToggleWithLockout
    native(ChampOwl)
    hidecategories(Navigation)
    implements(TgDeviceInterface_MoveSpeedMultiplier)
    config(Engine);

var bool m_bDelayMoveSpeedPenalty;
var bool m_bIsZoomed;

native function float GetMoveSpeedMultiplier();  // Export UTgDevice_Scope::execGetMoveSpeedMultiplier(FFrame&, void* const)

simulated event bool ShouldLockFiring(TgDevice Current) { }

simulated function StartFireDescopeTimer() { }

simulated function FireDescopeTimer() { }

simulated event bool CanBeCanceled() { }

simulated event bool CanBeInterrupted() { }

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
    m_nLinkedDeviceTypes[0]=11077
    m_nLinkedDeviceTypes[1]=10828
    m_nLinkedDeviceTypes[2]=11041
    m_nLinkedDeviceTypes[3]=15052
    m_AimAssistKeyframesMagnetVert=none
    m_AimAssistKeyframesMagnetHoriz=none
    m_AimAssistKeyframesTrackingAngleHoriz[0]=(KeyframeName="trackang10ftlowx",Distance=160.0000000)
    m_AimAssistKeyframesTrackingAngleHoriz[1]=(KeyframeName="BasicX",Distance=1600.0000000)
    m_nAimAssistPriorityWhileFiring=2
}
