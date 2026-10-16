class TgDevice_Soar extends TgDevice
    native(ChampEvie)
    hidecategories(Navigation)
    config(Engine);

simulated event bool CanBeCanceled() { }

simulated event bool CanBeInterrupted() { }

simulated event bool ShouldMountCancelFiring() { }

simulated event bool ShouldLockFiring(TgDevice Current) { }

state DeviceFiring {}

defaultproperties
{
    m_DeviceTimerBarType=DTBT_PostHit
    m_bPostFireShouldInterruptStealth=false
    m_AimAssistKeyframesMagnetVert=none
    m_AimAssistKeyframesMagnetHoriz=none
    m_AimAssistKeyframesFriction=none
    m_AimAssistKeyframesTrackingAccHoriz=none
    m_AimAssistKeyframesTrackingAngleHoriz=none
    m_AimAssistKeyframesTrackingAccVert=none
    m_AimAssistKeyframesTrackingAngleVert=none
    m_nAimAssistPriorityWhileFiring=2
}
