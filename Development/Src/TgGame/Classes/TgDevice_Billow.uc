class TgDevice_Billow extends TgDevice
    native(ChampDarklord)
    hidecategories(Navigation)
    implements(TgDeviceInterface_MoveSpeedMultiplier)
    config(Engine);

native function float GetMoveSpeedMultiplier();  // Export UTgDevice_Billow::execGetMoveSpeedMultiplier(FFrame&, void* const)

simulated event bool CanBeCanceled() { }

simulated event bool CanBeInterrupted() { }

simulated event bool ShouldMountCancelFiring() { }

simulated event bool CanJumpWhileFiring() { }

simulated event bool ShouldLockFiring(TgDevice Current) { }

simulated function UpdateOutroLockoutTime() { }

state DeviceFiring {}

defaultproperties
{
    m_DeviceTimerBarType=DTBT_PostHit
    m_bUsesOutroLockout=true
    m_fOutroLockoutTime=0.4000000
}
