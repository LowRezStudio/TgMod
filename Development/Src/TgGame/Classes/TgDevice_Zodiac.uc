class TgDevice_Zodiac extends TgDevice
    native(ChampAstro)
    hidecategories(Navigation)
    implements(TgDeviceInterface_MoveSpeedMultiplier)
    config(Engine);

var array<float> m_EffectRemainingTime;

native function ApplyBuff();  // Export UTgDevice_Zodiac::execApplyBuff(FFrame&, void* const)

native function RemoveBuff();  // Export UTgDevice_Zodiac::execRemoveBuff(FFrame&, void* const)

simulated event bool CanBeInterrupted() { }

native function float GetMoveSpeedMultiplier();  // Export UTgDevice_Zodiac::execGetMoveSpeedMultiplier(FFrame&, void* const)
