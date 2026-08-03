class TgDevice_BarrierReef extends TgDevice_ShellShieldMod
    native(Devices)
    hidecategories(Navigation);

var int m_nHitsNeededOnCooldown;

// Export UTgDevice_BarrierReef::execApplyDamageTakenEffect(FFrame&, void* const)
native function int ApplyDamageTakenEffect(int totalDamage);
