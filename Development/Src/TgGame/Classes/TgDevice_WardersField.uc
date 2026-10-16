class TgDevice_WardersField extends TgDevice
    hidecategories(Navigation)
    config(Engine);

const WARDERSFIELD_POST_DEPLOY_LOCKOUT_TIME = 0.3f;

simulated function bool InterceptSlotPressed(TgPlayerController TgController) { }

simulated event bool CanBeCanceled() { }

event OnDeployableDestroyed(TgDeployable deployable) { }

simulated event bool ShouldLockFiring(TgDevice Current) { }

state DeviceFiring {}

defaultproperties
{
    m_bDeployAtFeetOnFailure=true
}
