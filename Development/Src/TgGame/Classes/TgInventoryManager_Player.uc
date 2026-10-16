class TgInventoryManager_Player extends TgInventoryManager
    native(Inventory)
    hidecategories(Navigation)
    config(Engine);

native function RemoveBurnCards();  // Export UTgInventoryManager_Player::execRemoveBurnCards(FFrame&, void* const)

native function int CountFilledBurnCardSlots();  // Export UTgInventoryManager_Player::execCountFilledBurnCardSlots(FFrame&, void* const)
