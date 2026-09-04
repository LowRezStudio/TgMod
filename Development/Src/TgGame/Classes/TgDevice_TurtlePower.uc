class TgDevice_TurtlePower extends TgDevice_Toggle
    hidecategories(Navigation)
    config(Engine);

simulated event bool ShouldLockFiring(TgDevice Current) { }

function CancelSafetyPeriodTimer() { }

simulated event bool CanBeCanceled() { }

simulated function InterruptOtherAbilities() { }

state DeviceFiring {}

defaultproperties
{
    m_DeviceTimerBarType=DTBT_PostHit
    m_bUsesOutroLockout=true
    m_fOutroLockoutTime=0.6000000
}
