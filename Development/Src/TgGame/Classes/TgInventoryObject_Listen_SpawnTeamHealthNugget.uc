class TgInventoryObject_Listen_SpawnTeamHealthNugget extends TgInvListener
    native(Inventory)
    config(Engine);

var TgSpecialFx m_NuggetSpawnFX;
var int m_NuggetSpawnFXID;
var bool m_bUseCV1ForSpawnChance;

native function SpawnTeamHealthNugget(TgPawn Target, Vector SpawnDirection);  // Export UTgInventoryObject_Listen_SpawnTeamHealthNugget::execSpawnTeamHealthNugget(FFrame&, void* const)

defaultproperties
{
    m_NuggetSpawnFXID=6488
    m_bUseCV1ForSpawnChance=true
}
