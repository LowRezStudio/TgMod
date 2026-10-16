class TgGame_Battle_Conquest_Erez extends TgGame_Battle_Conquest
    native(Game)
    config(Game)
    hidecategories(Navigation,Movement,Collision)
    dependson(TgObject);

const LANE_PUSHER_BOT_ID = 2004;

var int m_nSpawnSiegeWeaponThreshold;

native function int GetNextVulnerableTowerId(int nBotId);  // Export UTgGame_Battle_Conquest_Erez::execGetNextVulnerableTowerId(FFrame&, void* const)

native function ScoreKillGameType(out ScoreKillData Data);  // Export UTgGame_Battle_Conquest_Erez::execScoreKillGameType(FFrame&, void* const)

native function float GetRespawnTime(int TaskForceNum);  // Export UTgGame_Battle_Conquest_Erez::execGetRespawnTime(FFrame&, void* const)

event PostBeginPlay() { }

event TriggerLanePusher(TgRepInfo_TaskForce tf, int nLane) { }

defaultproperties
{
    m_nSpawnSiegeWeaponThreshold=100
    m_MultiLaneXpBonus=0.0000000
    m_nStartingCurrency=2000
    m_nStartingLevel=3
}
