class TgDevice_WYRMJets extends TgDevice
    native(ChampDrogoz)
    hidecategories(Navigation)
    implements(TgDeviceInterface_MoveSpeedMultiplier)
    config(Engine);

var TgDevice m_CachedBoosterDevice;

native function float GetMoveSpeedMultiplier();  // Export UTgDevice_WYRMJets::execGetMoveSpeedMultiplier(FFrame&, void* const)

simulated event LinkedDeviceEquipped(TgDevice Dev) { }

simulated event LinkedDeviceUnequipped(TgDevice Dev) { }

defaultproperties
{
    m_nLinkedDeviceIDs[0]=13333
}
