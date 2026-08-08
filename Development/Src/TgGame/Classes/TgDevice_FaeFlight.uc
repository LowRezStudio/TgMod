class TgDevice_FaeFlight extends TgDevice
    native(ChampFairy)
    hidecategories(Navigation)
    implements(TgDeviceInterface_MoveSpeedMultiplier)
    config(Engine);

native function float GetMoveSpeedMultiplier();  // Export UTgDevice_FaeFlight::execGetMoveSpeedMultiplier(FFrame&, void* const)

simulated event bool ShouldLockFiring(TgDevice Current) { }

simulated event bool ShouldMountCancelFiring() { }

simulated event bool CanBeCanceled() { }

state DeviceFiring {}

defaultproperties
{
    m_DeviceTimerBarType=DTBT_PostHit
}
