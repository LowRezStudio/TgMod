class TgDevice_SmokeScreen extends TgDevice
    native(ChampSkye)
    hidecategories(Navigation);

// Export UTgDevice_SmokeScreen::execShouldInterruptStealth(FFrame&, void* const)
native function bool ShouldInterruptStealth();
