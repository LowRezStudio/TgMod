class TgInventoryObject_Listen_Stack extends TgInvListener
    native(Inventory)
    config(Engine);

native function AddStackCount(int nStackCount);  // Export UTgInventoryObject_Listen_Stack::execAddStackCount(FFrame&, void* const)
