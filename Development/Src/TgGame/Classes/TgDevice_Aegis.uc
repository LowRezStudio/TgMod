class TgDevice_Aegis extends TgDevice
    native(ChampFernando)
    hidecategories(Navigation)
    config(Engine);

var float m_fPreviousMinCooldown;

native function OnBecomeActive();  // Export UTgDevice_Aegis::execOnBecomeActive(FFrame&, void* const)

native function OnCeaseActive();  // Export UTgDevice_Aegis::execOnCeaseActive(FFrame&, void* const)
