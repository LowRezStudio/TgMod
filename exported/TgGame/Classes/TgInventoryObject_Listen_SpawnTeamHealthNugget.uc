class TgInventoryObject_Listen_SpawnTeamHealthNugget extends TgInvListener
    native(Inventory);

var TgSpecialFx m_NuggetSpawnFX;
var int m_NuggetSpawnFXID;
var bool m_bUseCV1ForSpawnChance;

// Export UTgInventoryObject_Listen_SpawnTeamHealthNugget::execSpawnTeamHealthNugget(FFrame&, void* const)
native function SpawnTeamHealthNugget(TgPawn Target, Vector SpawnDirection);

defaultproperties
{
    m_NuggetSpawnFXID=6488
    m_bUseCV1ForSpawnChance=true
}