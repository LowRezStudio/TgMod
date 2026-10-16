class TgDevice_Whirlwind2 extends TgDevice_ActiveAura
    hidecategories(Navigation)
    config(Engine);

simulated event bool ShouldLockFiring(TgDevice Current) { }

simulated event bool CanBeCanceled() { }

defaultproperties
{
    m_DeviceTimerBarType=DTBT_PostHit
}
