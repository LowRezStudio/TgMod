class TgInventoryObject_Listen_Stack extends TgInvListener
    native(Inventory);

// Export UTgInventoryObject_Listen_Stack::execAddStackCount(FFrame&, void* const)
native function AddStackCount(int nStackCount);
