class TgDevice_Booster extends TgDevice
    native(ChampDrogoz)
    hidecategories(Navigation)
    config(Engine);

native function bool CanBeCrippled();  // Export UTgDevice_Booster::execCanBeCrippled(FFrame&, void* const)

simulated event bool ShouldLockFiring(TgDevice Current) { }

simulated event bool CanBeCanceled() { }

simulated event bool CanBeInterrupted() { }

simulated event bool IsToggleDevice() { }

state DeviceFiring {}
