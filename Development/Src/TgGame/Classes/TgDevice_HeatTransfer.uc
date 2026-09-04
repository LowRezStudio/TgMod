class TgDevice_HeatTransfer extends TgDevice_ShieldMod
    native(Devices)
    hidecategories(Navigation)
    config(Engine);

var int m_nAccumulatedDamage;
var int m_nActivationDamage;

native function RespondToDamageTaken(int Damage);  // Export UTgDevice_HeatTransfer::execRespondToDamageTaken(FFrame&, void* const)
