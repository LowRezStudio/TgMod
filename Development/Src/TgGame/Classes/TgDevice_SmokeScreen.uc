class TgDevice_SmokeScreen extends TgDevice
    native(ChampSkye)
    hidecategories(Navigation)
    config(Engine);

native function bool ShouldInterruptStealth();  // Export UTgDevice_SmokeScreen::execShouldInterruptStealth(FFrame&, void* const)
