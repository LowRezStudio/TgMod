class TgDevice_Aegis extends TgDevice
    native(ChampFernando)
    hidecategories(Navigation);

var float m_fPreviousMinCooldown;

// Export UTgDevice_Aegis::execOnBecomeActive(FFrame&, void* const)
native function OnBecomeActive();

// Export UTgDevice_Aegis::execOnCeaseActive(FFrame&, void* const)
native function OnCeaseActive();
