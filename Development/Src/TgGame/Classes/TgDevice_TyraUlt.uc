class TgDevice_TyraUlt extends TgDevice_Stim
    hidecategories(Navigation)
    config(Engine);

simulated event bool CanBeCanceled() { }

simulated event bool ShouldLockFiring(TgDevice Current) { }

simulated function TransitionOut() { }

state DeviceFiring {}
