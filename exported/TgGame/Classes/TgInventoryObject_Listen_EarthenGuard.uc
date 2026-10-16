class TgInventoryObject_Listen_EarthenGuard extends TgInvListener
    native(ChampBarrierTank);

// Export UTgInventoryObject_Listen_EarthenGuard::execIsValidDeployable(FFrame&, void* const)
native function bool IsValidDeployable(TgDeployable deployable);
