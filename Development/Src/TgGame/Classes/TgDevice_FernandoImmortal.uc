class TgDevice_FernandoImmortal extends TgDevice_ActiveAura
    hidecategories(Navigation)
    config(Engine);

simulated event bool CanBeCanceled() { }

simulated event bool ShouldLockFiring(TgDevice Current) { }

simulated event bool CanJumpWhileFiring() { }

simulated function EndLockOutEarly() { }

state DeviceFiring {}

defaultproperties
{
    m_DeviceTimerBarType=DTBT_PostHit
}
