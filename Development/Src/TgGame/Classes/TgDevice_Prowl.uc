class TgDevice_Prowl extends TgDevice_Stim
    native(ChampBlades)
    hidecategories(Navigation)
    implements(TgDeviceInterface_MoveSpeedMultiplier)
    config(Engine);

native function bool ShouldInterruptLift();  // Export UTgDevice_Prowl::execShouldInterruptLift(FFrame&, void* const)

simulated event bool CanBeInterrupted() { }

simulated event bool CanBeCanceled() { }

simulated event bool CanFiringBeCanceledByReactivation() { }

native function float GetMoveSpeedMultiplier();  // Export UTgDevice_Prowl::execGetMoveSpeedMultiplier(FFrame&, void* const)

simulated delegate InterruptFiringDelegate();

simulated event LinkedDeviceEquipped(TgDevice Dev) { }

simulated event LinkedDeviceUnequipped(TgDevice Dev) { }

state DeviceFiring {}

defaultproperties
{
    m_nLinkedDeviceIDs[0]=16218
    m_nLinkedDeviceIDs[1]=16229
    m_nLinkedDeviceIDs[2]=16235
    m_nLinkedDeviceIDs[3]=16241
    m_nLinkedDeviceIDs[4]=16306
}
