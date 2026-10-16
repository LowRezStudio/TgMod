class TgGame_CTF extends TgGame_Mission
    native(Game)
    config(Game)
    hidecategories(Navigation,Movement,Collision)
    dependson(TgObject);

var transient TgCTFFlagBase m_FlagBases[2];
var float m_fRoundTime;
var float m_fRoundSetupTime;
var float m_fEndOfRoundTime;
var transient int m_nCurrentRound;
var int m_nNumRounds;
var int m_nSpawnWaveTime;

native function float GetRespawnTime(int TaskForceNum);  // Export UTgGame_CTF::execGetRespawnTime(FFrame&, void* const)

native function ScoreKillGameType(out ScoreKillData Data);  // Export UTgGame_CTF::execScoreKillGameType(FFrame&, void* const)

function float GetSetupTime() { }

function bool StartGameTimer() { }

event ChangeTimerState(TgObject.GameTimerState eTimerState) { }

event MissionTimer() { }

function RegisterFlagBase(TgCTFFlagBase FlagBase) { }

function ScoreFlag(TgPawn_Character FlagCarrier) { }

function SpawnWaveTimer() { }

defaultproperties
{
    m_fRoundTime=300.0000000
    m_fRoundSetupTime=45.0000000
    m_fEndOfRoundTime=5.0000000
    m_nCurrentRound=1
    m_nNumRounds=3
    m_nSpawnWaveTime=60
    m_nStartingCurrency=5000
    m_nStartingLevel=10
    m_nWinPlayerXp=20
    m_nLosePlayerXp=20
    m_fBaseTokens=1.5000000
    m_fFirstBloodGoldReward=100.0000000
    m_GameType=TGT_POINTCAPTURE
}
