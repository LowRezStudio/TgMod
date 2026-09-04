class TgDevice_OppressorMineMod extends TgDevice
    native(Devices)
    hidecategories(Navigation);

var array<TgDeploy_OppressorMine> m_MinesInRage;

// Export UTgDevice_OppressorMineMod::execApplyEffect(FFrame&, void* const)
native function ApplyEffect(TgDeploy_OppressorMine mine, Actor Target);

// Export UTgDevice_OppressorMineMod::execRemoveEffect(FFrame&, void* const)
native function RemoveEffect(TgDeploy_OppressorMine mine, Actor Target);

// Export UTgDevice_OppressorMineMod::execCheckOwnerEffect(FFrame&, void* const)
native function CheckOwnerEffect(TgDeploy_OppressorMine mine);
