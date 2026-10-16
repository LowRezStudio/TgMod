class TgDevice_PassiveAura extends TgDevice_Aura
    native(Devices)
    hidecategories(Navigation);

// Export UTgDevice_PassiveAura::execShouldAuraBeActive(FFrame&, void* const)
native function bool ShouldAuraBeActive();
