class TgDevice_HyperBeam extends TgDevice
    native(ChampGauntlet)
    hidecategories(Navigation)
    implements(TgDeviceInterface_MoveSpeedMultiplier)
    config(Engine);

native function float GetMoveSpeedMultiplier();  // Export UTgDevice_HyperBeam::execGetMoveSpeedMultiplier(FFrame&, void* const)

simulated event bool CanBeCanceled() { }

simulated event bool IsFunctionallyToggleDevice() { }

simulated function bool ShouldStopActionOnOffhandSlotReleased() { }

simulated function FiringDuration() { }

simulated function bool ShouldConsumePowerPoolOnStartFire() { }

simulated function bool ShouldConsumePowerPoolAfterFire() { }

state DeviceFiring {}

defaultproperties
{
    m_AimAssistKeyframesMagnetVert=none
    m_AimAssistKeyframesMagnetHoriz=none
    m_nAimAssistPriorityWhileFiring=2
}
