class TgGame_Idol extends TgGame_Mission
    native(Game)
    config(Game)
    hidecategories(Navigation,Movement,Collision)
    dependson(TgObject);

var transient TgIdol m_Idols[2];
var int m_nSpawnWaveTime;

native function float GetRespawnTime(int TaskForceNum);  // Export UTgGame_Idol::execGetRespawnTime(FFrame&, void* const)

native function ScoreKillGameType(out ScoreKillData Data);  // Export UTgGame_Idol::execScoreKillGameType(FFrame&, void* const)

function float GetSetupTime() { }

function bool StartGameTimer() { }

event MissionTimer() { }

function SpawnWaveTimer() { }

defaultproperties
{
    m_nSpawnWaveTime=60
    m_nStartingCurrency=5000
    m_nWinPlayerXp=20
    m_nLosePlayerXp=20
    m_fBaseTokens=1.5000000
    m_GameType=TGT_IDOL
}
