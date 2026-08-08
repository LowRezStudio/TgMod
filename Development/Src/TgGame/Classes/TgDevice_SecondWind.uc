class TgDevice_SecondWind extends TgDevice
    native(ChampViktor)
    hidecategories(Navigation)
    implements(TgDeviceInterface_MoveSpeedMultiplier)
    config(Engine);

var TgDevice_Hustle m_CachedHustleDevice;
var float m_fSprintEndTimestamp;

native function float GetMoveSpeedMultiplier();  // Export UTgDevice_SecondWind::execGetMoveSpeedMultiplier(FFrame&, void* const)

simulated function CheckStartSprintBoost() { }

simulated event LinkedDeviceEquipped(TgDevice Dev) { }

simulated event LinkedDeviceUnequipped(TgDevice Dev) { }

defaultproperties
{
    m_nLinkedDeviceIDs[0]=14148
}
