class TgInventoryObject_Listen_EarthenGuard extends TgInvListener
    native(ChampBarrierTank)
    config(Engine);

native function bool IsValidDeployable(TgDeployable deployable);  // Export UTgInventoryObject_Listen_EarthenGuard::execIsValidDeployable(FFrame&, void* const)
