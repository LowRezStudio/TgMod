class TgDevice_Hover extends TgDevice
    native(ChampRuckus)
    hidecategories(Navigation)
    config(Engine);

native function bool CanBeCrippled();  // Export UTgDevice_Hover::execCanBeCrippled(FFrame&, void* const)

simulated event bool ShouldLockFiring(TgDevice Current) { }

simulated event bool CanBeCanceled() { }

simulated event bool CanBeInterrupted() { }

function OnCripple() { }

state DeviceFiring {}

defaultproperties
{
    m_bPostFireShouldInterruptStealth=false
}
