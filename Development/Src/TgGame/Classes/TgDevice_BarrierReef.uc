class TgDevice_BarrierReef extends TgDevice_ShellShieldMod
    native(Devices)
    hidecategories(Navigation)
    config(Engine);

var int m_nHitsNeededOnCooldown;

native function int ApplyDamageTakenEffect(int totalDamage);  // Export UTgDevice_BarrierReef::execApplyDamageTakenEffect(FFrame&, void* const)
