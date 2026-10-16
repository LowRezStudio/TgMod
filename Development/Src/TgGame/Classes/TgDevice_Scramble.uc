class TgDevice_Scramble extends TgDevice
    native(ChampViktor)
    hidecategories(Navigation)
    implements(TgDeviceInterface_MoveSpeedMultiplier)
    config(Engine);

var TgDevice_Hustle m_CachedHustleDevice;
var float m_fSprintEndTimestamp;

native function float GetMoveSpeedMultiplier();  // Export UTgDevice_Scramble::execGetMoveSpeedMultiplier(FFrame&, void* const)

reliable client simulated function ClientStartSpeedBoost() { }

event CheckStartSprintBoost() { }

simulated event LinkedDeviceEquipped(TgDevice Dev) { }

defaultproperties
{
    m_nLinkedDeviceIDs[0]=14148
}
