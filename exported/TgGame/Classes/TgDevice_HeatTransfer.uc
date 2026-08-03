class TgDevice_HeatTransfer extends TgDevice_ShieldMod
    native(Devices)
    hidecategories(Navigation);

var int m_nAccumulatedDamage;
var int m_nActivationDamage;

// Export UTgDevice_HeatTransfer::execRespondToDamageTaken(FFrame&, void* const)
native function RespondToDamageTaken(int Damage);
