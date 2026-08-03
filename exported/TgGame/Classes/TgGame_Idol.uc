class TgGame_Idol extends TgGame_Mission
    native(Game)
    config(Game)
    hidecategories(Navigation,Movement,Collision);

var transient TgIdol m_Idols[2];
var int m_nSpawnWaveTime;

// Export UTgGame_Idol::execGetRespawnTime(FFrame&, void* const)
native function float GetRespawnTime(int TaskForceNum);

// Export UTgGame_Idol::execScoreKillGameType(FFrame&, void* const)
native function ScoreKillGameType(out ScoreKillData Data);

function float GetSetupTime()
{
    return 45.0000000;
    //return ReturnValue;    
}

function bool StartGameTimer()
{
    m_fGameMissionTime = 14400.0000000;
    return super.StartGameTimer();
    //return ReturnValue;    
}

event MissionTimer()
{
    // End:0x2D
    if(int(m_eTimerState) == int(2))
    {
        SetTimer(float(m_nSpawnWaveTime), true, 'SpawnWaveTimer');
    }
    super.MissionTimer();
    //return;    
}

function SpawnWaveTimer()
{
    //return;    
}

defaultproperties
{
    m_nSpawnWaveTime=60
    m_nStartingCurrency=5000
    m_nWinPlayerXp=20
    m_nLosePlayerXp=20
    m_fBaseTokens=1.5000000
    m_GameType=TG_GAME_TYPE.TGT_IDOL
}