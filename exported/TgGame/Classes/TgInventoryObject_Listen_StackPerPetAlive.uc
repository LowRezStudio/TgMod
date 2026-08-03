class TgInventoryObject_Listen_StackPerPetAlive extends TgInventoryObject_Listen_Stack
    native(Inventory);

// Export UTgInventoryObject_Listen_StackPerPetAlive::execUpdatePetCountStacks(FFrame&, void* const)
native function UpdatePetCountStacks(optional bool bEmptyStacks = false);
