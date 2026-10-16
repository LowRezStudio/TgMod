class TgInventoryManager_Player extends TgInventoryManager
    native(Inventory)
    hidecategories(Navigation);

// Export UTgInventoryManager_Player::execRemoveBurnCards(FFrame&, void* const)
native final function RemoveBurnCards();

// Export UTgInventoryManager_Player::execCountFilledBurnCardSlots(FFrame&, void* const)
native final function int CountFilledBurnCardSlots();
