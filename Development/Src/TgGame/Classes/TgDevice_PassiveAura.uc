class TgDevice_PassiveAura extends TgDevice_Aura
    native(Devices)
    hidecategories(Navigation)
    config(Engine);

native function bool ShouldAuraBeActive();  // Export UTgDevice_PassiveAura::execShouldAuraBeActive(FFrame&, void* const)
