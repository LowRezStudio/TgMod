class TgDevice_Enlightenment extends TgDevice
    native(ChampPrincess)
    hidecategories(Navigation)
    config(Engine);

var TgPawn_Princess m_CachedPrincess;

simulated function bool HasCachedPrincess() { }

simulated event bool CanBeCanceled() { }

simulated event bool ShouldLockFiring(TgDevice Current) { }

simulated function StartTimeOut() { }

simulated function TimeOut() { }

simulated function StartWaitForResultOfFireTimer() { }

simulated function WaitForResultOfFire() { }

state DeviceBuildup {}

state DeviceFiring {}
