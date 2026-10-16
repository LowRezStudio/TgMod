class TgGame_Arena extends TgGame_Battle
    native(Game)
    config(Game)
    hidecategories(Navigation,Movement,Collision);

var float s_fLastDespawnTime[2];
var float s_fDespawnNotificationDelay;
var int m_nKillValueHero;
var int m_nKillValueMinion;
var int m_nKillValueTower;
var int m_MinScoreToTrackMinionKills;
var int m_nSpawnWaveTime;
var int m_nSpawnWaveDominatingTime;
var int m_nMaxDominatingPoints;
var transient bool m_bIsCrowdOnFeet;

// Export UTgGame_Arena::execScoreKillGameType(FFrame&, void* const)
native function ScoreKillGameType(out ScoreKillData Data);

// Export UTgGame_Arena::execMarkAsReady(FFrame&, void* const)
native function MarkAsReady(Player P);

// Export UTgGame_Arena::execGetRespawnTime(FFrame&, void* const)
native function float GetRespawnTime(int TaskForceNum);

// Export UTgGame_Arena::execEndGameBySurrender(FFrame&, void* const)
native function EndGameBySurrender(int SurrenderingTaskForce);

// Export UTgGame_Arena::execBeginEndMission(FFrame&, void* const)
native function bool BeginEndMission(optional bool bClearNextMapGame = false, optional Actor EndMissionFocus, optional float fDelayOverride = 0.0000000);

// Export UTgGame_Arena::execApplyTowerImmunity(FFrame&, void* const)
native function ApplyTowerImmunity();

// Export UTgGame_Arena::execSendDespawnAlert(FFrame&, void* const)
native function SendDespawnAlert(TgRepInfo_TaskForce tfri);

function float GetSetupTime()
{
    return 45.0000000;
    //return ReturnValue;    
}

function bool StartGameTimer()
{
    m_fGameMissionTime = 14400.0000000;
    SetTimer(float(m_nSpawnWaveTime), false, 'SpawnWaveTeam1Timer');
    SetTimer(float(m_nSpawnWaveTime), false, 'SpawnWaveTeam2Timer');
    SetTimer(1.0000000, false, 'ApplyTowerImmunity');
    return super.StartGameTimer();
    //return ReturnValue;    
}

function OnMinionDespawn(int Taskforce)
{
    local TgRepInfo_Game GRI;
    local TgRepInfo_TaskForce tf;

    GRI = TgRepInfo_Game(GameReplicationInfo);
    // End:0x2B7
    if(GRI != none)
    {
        tf = GRI.GetTaskForce(((Taskforce == 2) ? 1 : 2));
        // End:0x2B7
        if(tf != none)
        {
            tf.r_nScore -= m_nKillValueMinion;
            tf.r_nScorePercent = int((float(tf.r_nScore) / float(WorldInfo.Game.GoalScore)) * float(100));
            tf.bNetDirty = true;
            // End:0x1A5
            if(tf.r_nScore < 0)
            {
                tf.r_nScore = 0;
                tf.r_nScorePercent = 0;
            }
            // End:0x1ED
            if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
            {
                tf.ReceivedScoringChanges();
            }
            // End:0x2AD
            if(WorldInfo.TimeSeconds > (s_fLastDespawnTime[int(tf.r_nTaskForce) - int(1)] + s_fDespawnNotificationDelay))
            {
                SendDespawnAlert(tf);
                s_fLastDespawnTime[int(tf.r_nTaskForce) - int(1)] = WorldInfo.TimeSeconds;
            }
            CheckGameState();
        }
    }
    //return;    
}

event CheckGameState()
{
    local TgRepInfo_Game GRI;
    local TgPlayerController PC;
    local TgRepInfo_TaskForce TF1, TF2;

    GRI = TgRepInfo_Game(GameReplicationInfo);
    // End:0x43
    if((GRI == none) || int(m_GameWinState) != int(0))
    {
        return;
    }
    TF1 = GRI.GetTaskForce(1);
    TF2 = GRI.GetTaskForce(2);
    // End:0x12F
    if(TF1.r_nScore <= 0)
    {
        m_GameWinState = 1;
        GRI.r_Winner = GRI.GetTaskForce(2);
        GRI.bNetDirty = true;        
    }
    else
    {
        // End:0x1C0
        if(TF2.r_nScore <= 0)
        {
            m_GameWinState = 2;
            GRI.r_Winner = GRI.GetTaskForce(1);
            GRI.bNetDirty = true;
        }
    }
    // End:0x23F
    if(int(m_GameWinState) != int(0))
    {
        // End:0x231
        foreach WorldInfo.AllControllers(Class'TgGame.TgPlayerController', PC)
        {
            PC.SendClientSetGameWinState(m_GameWinState);            
        }        
        BeginEndMission();
    }
    //return;    
}

event Actor GetEndFocusActor()
{
    return ((int(m_GameWinState) == int(1)) ? TgMapInfo(WorldInfo.GetMapInfo()).m_EndFocusActor_TF2 : TgMapInfo(WorldInfo.GetMapInfo()).m_EndFocusActor_TF1);
    //return ReturnValue;    
}

function SpawnWaveTeam1Timer()
{
    SetTimer(float(m_nSpawnWaveTime) + ((GetTaskForceDominatingFactor(1)) * float(m_nSpawnWaveDominatingTime)), false, 'SpawnWaveTeam1Timer');
    //return;    
}

function SpawnWaveTeam2Timer()
{
    SetTimer(float(m_nSpawnWaveTime) + ((GetTaskForceDominatingFactor(2)) * float(m_nSpawnWaveDominatingTime)), false, 'SpawnWaveTeam2Timer');
    //return;    
}

function float GetTaskForceDominatingFactor(int TaskForceNum)
{
    local float fFactor;
    local TgRepInfo_Game GRI;
    local TgRepInfo_TaskForce TF1, TF2;
    local TgPlayerController TgPC;

    GRI = TgRepInfo_Game(GameReplicationInfo);
    // End:0x31
    if(GRI == none)
    {
        return 0.0000000;
    }
    TF1 = GRI.GetTaskForce(1);
    TF2 = GRI.GetTaskForce(2);
    // End:0xAE
    if((TF1 == none) || TF2 == none)
    {
        return 0.0000000;
    }
    // End:0x16E
    if(((TF1.r_nScore < 50) || TF2.r_nScore < 50) && !m_bIsCrowdOnFeet)
    {
        // End:0x161
        foreach WorldInfo.AllControllers(Class'TgGame.TgPlayerController', TgPC)
        {
            TgPC.ArenaCrowdEvent(0);            
        }        
        m_bIsCrowdOnFeet = true;
    }
    // End:0x1D8
    if(TaskForceNum == 2)
    {
        fFactor = float(TF2.r_nScore - TF1.r_nScore) / float(m_nMaxDominatingPoints);        
    }
    else
    {
        fFactor = float(TF1.r_nScore - TF2.r_nScore) / float(m_nMaxDominatingPoints);
    }
    // End:0x246
    if(fFactor < float(0))
    {
        return 0.0000000;
    }
    // End:0x25D
    if(fFactor > float(1))
    {
        return 1.0000000;
    }
    return fFactor;
    //return ReturnValue;    
}

defaultproperties
{
    s_fDespawnNotificationDelay=10.0000000
    m_nKillValueHero=5
    m_nKillValueMinion=1
    m_nKillValueTower=15
    m_MinScoreToTrackMinionKills=10
    m_nSpawnWaveTime=20
    m_nSpawnWaveDominatingTime=40
    m_nMaxDominatingPoints=150
    m_bRespawnInhibitors=false
    m_bEnableCrowdEvents=true
    m_fCreditsToGivePerTick=10.0000000
    m_nStartingLevel=3
    m_MinionKillerBonus=0.2500000
    m_fFirstBloodGoldReward=100.0000000
    m_fBasePlayerAssistXpRewardMultipler=1.0000000
    m_fBaseNPCAssistXpRewardMultipler=2.0000000
    m_GameType=TG_GAME_TYPE.TGT_ARENA
    GoalScore=500
}