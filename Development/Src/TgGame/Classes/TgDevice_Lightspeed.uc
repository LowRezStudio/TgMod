class TgDevice_Lightspeed extends TgDevice
    native(ChampAstro)
    hidecategories(Navigation)
    implements(TgDeviceInterface_MoveSpeedMultiplier)
    config(Engine);

native function float GetMoveSpeedMultiplier();  // Export UTgDevice_Lightspeed::execGetMoveSpeedMultiplier(FFrame&, void* const)

native function bool ShouldInterruptLift();  // Export UTgDevice_Lightspeed::execShouldInterruptLift(FFrame&, void* const)

native function bool ShouldBlockReload(TgDevice Dev, bool bIsAutoReload);  // Export UTgDevice_Lightspeed::execShouldBlockReload(FFrame&, void* const)

simulated event bool ShouldLockFiring(TgDevice Current) { }

simulated event bool CanBeCanceled() { }

simulated event bool CanBeInterrupted() { }

simulated event bool CanFiringBeCanceledByReactivation() { }

simulated function bool InterceptSlotReleased(TgPlayerController TgController) { }

simulated event bool ShouldInterruptReloadOnFire() { }

simulated function CancelSafetyTimer() { }

state DeviceFiring {}
