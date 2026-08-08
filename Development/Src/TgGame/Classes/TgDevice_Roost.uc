class TgDevice_Roost extends TgDevice
    native(ChampOwl)
    hidecategories(Navigation)
    config(Engine);

var TgDevice m_ScopeDevice;

native function float GetStealthJuiceDiscount();  // Export UTgDevice_Roost::execGetStealthJuiceDiscount(FFrame&, void* const)

simulated event LinkedDeviceEquipped(TgDevice Dev) { }

simulated event LinkedDeviceUnequipped(TgDevice Dev) { }

defaultproperties
{
    m_nLinkedDeviceIDs[0]=19111
}
