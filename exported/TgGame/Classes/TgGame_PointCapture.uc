class TgGame_PointCapture extends TgGame_Battle
    native(Game)
    config(Game)
    hidecategories(Navigation,Movement,Collision);

var float s_TicketCheckInterval;
var int s_nCaptureHostilePointXP;
var int s_nCaptureHostilePointGold;
var int s_nReclaimPointXP;
var int s_nReclaimPointGold;
var transient int s_nCurrentPhase;
var int s_nPhase2Threshold;
var int s_nPhase3Threshold;
var int m_nSpawnWaveTime;
var int m_nSpawnWaveDominatingTime;
var int m_nMaxDominatingPoints;
var int s_nAboutToLoseThreshold;

// Export UTgGame_PointCapture::execGetRespawnTime(FFrame&, void* const)
native function float GetRespawnTime(int TaskForceNum);

// Export UTgGame_PointCapture::execMarkAsReady(FFrame&, void* const)
native function MarkAsReady(Player P);

// Export UTgGame_PointCapture::execEndGameBySurrender(FFrame&, void* const)
native function EndGameBySurrender(int SurrenderingTaskForce);

// Export UTgGame_PointCapture::execBeginEndMission(FFrame&, void* const)
native function bool BeginEndMission(optional bool bClearNextMapGame = false, optional Actor EndMissionFocus, optional float fDelayOverride = 0.0000000);

// Export UTgGame_PointCapture::execScoreKillGameType(FFrame&, void* const)
native function ScoreKillGameType(out ScoreKillData Data);

// Export UTgGame_PointCapture::execCapturedPoint(FFrame&, void* const)
native function CapturedPoint(TgPawn_Character PC);

// Export UTgGame_PointCapture::execCapturePointReclaimed(FFrame&, void* const)
native function CapturePointReclaimed(TgPawn_Character PC);

// Export UTgGame_PointCapture::execAlertAboutToLose(FFrame&, void* const)
native function AlertAboutToLose(int nTaskForce);

// Export UTgGame_PointCapture::execUpdateGameWinState(FFrame&, void* const)
native function UpdateGameWinState(TgPawn nexus);

// Export UTgGame_PointCapture::execSendBonusMinionAlerts(FFrame&, void* const)
native function SendBonusMinionAlerts(TgRepInfo_TaskForce tf, int nLane);

// Export UTgGame_PointCapture::execStructureDied(FFrame&, void* const)
native function StructureDied(TgPawn_Structure theStructure);

// Export UTgGame_PointCapture::execApplyTowerImmunity(FFrame&, void* const)
native function ApplyTowerImmunity();

// Export UTgGame_PointCapture::execGetNextVulnerableTowerId(FFrame&, void* const)
native function int GetNextVulnerableTowerId(int nBotId);

// Export UTgGame_PointCapture::execShouldSpawnSuperMinions(FFrame&, void* const)
native function bool ShouldSpawnSuperMinions(TgBotFactory_Minions minionFactory);

event Actor GetEndFocusActor()
{
    return ((int(m_GameWinState) == int(1)) ? TgMapInfo(WorldInfo.GetMapInfo()).m_EndFocusActor_TF2 : TgMapInfo(WorldInfo.GetMapInfo()).m_EndFocusActor_TF1);
    //return ReturnValue;    
}

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
    return super.StartGameTimer();
    //return ReturnValue;    
}

function SpawnNeutralBots()
{
    local TgRepInfo_Game GRI;
    local int Idx;

    GRI = TgRepInfo_Game(GameReplicationInfo);
    // End:0x107
    if(GRI != none)
    {
        Idx = 0;
        J0x36:

        // End:0x107 [Loop If]
        if(Idx < GRI.m_CPRIArray.Length)
        {
            // End:0xF9
            if(GRI.m_CPRIArray[Idx].r_OwningCapturePoint != none)
            {
                GRI.m_CPRIArray[Idx].r_OwningCapturePoint.SpawnNeutralBot();
            }
            Idx++;
            // [Loop Continue]
            goto J0x36;
        }
    }
    //return;    
}

event ChangeTimerState(TgObject.GameTimerState eTimerState)
{
    super.ChangeTimerState(eTimerState);
    UpdateLockedPointStatus();
    // End:0x52
    if(int(eTimerState) == int(3))
    {
        SpawnNeutralBots();
        SetTimer(s_TicketCheckInterval, true, 'CheckTickets');
    }
    //return;    
}

function CheckTickets()
{
    local TgRepInfo_Game GRI;
    local int Idx, ScoreToSubTF1, ScoreToSubTF2, OldScore;
    local TgRepInfo_TaskForce TF1, TF2;

    GRI = TgRepInfo_Game(GameReplicationInfo);
    // End:0x661
    if(GRI != none)
    {
        Idx = 0;
        J0x36:

        // End:0x111 [Loop If]
        if(Idx < GRI.m_CPRIArray.Length)
        {
            // End:0xB4
            if(GRI.m_CPRIArray[Idx].r_nControlledByTaskForce == 1)
            {
                ScoreToSubTF1++;                
            }
            else
            {
                // End:0x103
                if(GRI.m_CPRIArray[Idx].r_nControlledByTaskForce == 2)
                {
                    ScoreToSubTF2++;
                }
            }
            Idx++;
            // [Loop Continue]
            goto J0x36;
        }
        // End:0x136
        if(ScoreToSubTF1 > ScoreToSubTF2)
        {
            ScoreToSubTF2 = 0;            
        }
        else
        {
            // End:0x15B
            if(ScoreToSubTF2 > ScoreToSubTF1)
            {
                ScoreToSubTF1 = 0;                
            }
            else
            {
                ScoreToSubTF1 = 0;
                ScoreToSubTF2 = 0;
            }
        }
        // End:0x661
        if((ScoreToSubTF1 > 1) || ScoreToSubTF2 > 1)
        {
            TF1 = GRI.GetTaskForce(1);
            // End:0x375
            if(TF1 != none)
            {
                OldScore = TF1.r_nScore;
                TF1.r_nScore = Max(0, TF1.r_nScore - ScoreToSubTF2);
                TF1.r_nScorePercent = int((float(TF1.r_nScore) / float(WorldInfo.Game.GoalScore)) * float(100));
                TF1.bNetDirty = true;
                // End:0x325
                if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
                {
                    TF1.ReceivedScoringChanges();
                }
                // End:0x375
                if((OldScore > s_nAboutToLoseThreshold) && TF1.r_nScore < s_nAboutToLoseThreshold)
                {
                    AlertAboutToLose(1);
                }
            }
            TF2 = GRI.GetTaskForce(2);
            // End:0x55B
            if(TF2 != none)
            {
                OldScore = TF2.r_nScore;
                TF2.r_nScore = Max(0, TF2.r_nScore - ScoreToSubTF1);
                TF2.r_nScorePercent = int((float(TF2.r_nScore) / float(WorldInfo.Game.GoalScore)) * float(100));
                TF2.bNetDirty = true;
                // End:0x50A
                if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
                {
                    TF2.ReceivedScoringChanges();
                }
                // End:0x55B
                if((OldScore > s_nAboutToLoseThreshold) && TF2.r_nScore < s_nAboutToLoseThreshold)
                {
                    AlertAboutToLose(2);
                }
            }
            CheckWinCondition();
            // End:0x5DF
            if((s_nCurrentPhase <= 1) && (TF1.r_nScore <= s_nPhase2Threshold) || TF2.r_nScore <= s_nPhase2Threshold)
            {
                s_nCurrentPhase = 2;                
            }
            else
            {
                // End:0x657
                if((s_nCurrentPhase == 2) && (TF1.r_nScore <= s_nPhase3Threshold) || TF2.r_nScore <= s_nPhase3Threshold)
                {
                    s_nCurrentPhase = 3;
                }
            }
            CheckWinState();
        }
    }
    //return;    
}

function CheckWinCondition()
{
    local TgRepInfo_Game GRI;
    local TgRepInfo_TaskForce TF1, TF2;

    GRI = TgRepInfo_Game(GameReplicationInfo);
    // End:0x355
    if(GRI != none)
    {
        TF1 = GRI.GetTaskForce(1);
        TF2 = GRI.GetTaskForce(2);
        // End:0x22F
        if((TF1.r_nScore <= 0) && TF2.r_nScore <= 0)
        {
            // End:0x17D
            if(TF1.r_nScore > TF2.r_nScore)
            {
                m_GameWinState = 2;
                GRI.r_Winner = GRI.GetTaskForce(1);
                GRI.bNetDirty = true;                
            }
            else
            {
                // End:0x22C
                if(TF2.r_nScore > TF1.r_nScore)
                {
                    m_GameWinState = 1;
                    GRI.r_Winner = GRI.GetTaskForce(2);
                    GRI.bNetDirty = true;
                }
            }            
        }
        else
        {
            // End:0x2C3
            if(TF2.r_nScore <= 0)
            {
                m_GameWinState = 2;
                GRI.r_Winner = GRI.GetTaskForce(1);
                GRI.bNetDirty = true;                
            }
            else
            {
                // End:0x355
                if(TF1.r_nScore <= 0)
                {
                    m_GameWinState = 1;
                    GRI.r_Winner = GRI.GetTaskForce(2);
                    GRI.bNetDirty = true;
                }
            }
        }
    }
    //return;    
}

event CheckWinState()
{
    local TgPlayerController PC;

    // End:0x9D
    if(int(m_GameWinState) != int(0))
    {
        ClearTimer('CheckTickets');
        // End:0x85
        foreach WorldInfo.AllControllers(Class'TgGame.TgPlayerController', PC)
        {
            PC.SendClientSetGameWinState(m_GameWinState);            
        }        
        UpdateMissionTimerEventWinVar();
        BeginEndMission();
    }
    //return;    
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
    local int ScoreTF1, ScoreTF2;

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
    ScoreTF1 = Max(100, TF1.r_nScore);
    ScoreTF2 = Max(100, TF2.r_nScore);
    // End:0x146
    if(TaskForceNum == 2)
    {
        fFactor = float(ScoreTF2 - ScoreTF1) / float(m_nMaxDominatingPoints);        
    }
    else
    {
        fFactor = float(ScoreTF1 - ScoreTF2) / float(m_nMaxDominatingPoints);
    }
    // End:0x18A
    if(fFactor < float(0))
    {
        return 0.0000000;
    }
    // End:0x1A1
    if(fFactor > float(1))
    {
        return 1.0000000;
    }
    return fFactor;
    //return ReturnValue;    
}

function UpdateLockedPointStatus()
{
    //return;    
}

function OnPointCaptureOwnershipChanged(TgCapturePoint Point, int NewTaskForceOwner, int PreviousTaskForceOwner)
{
    //return;    
}

defaultproperties
{
    s_TicketCheckInterval=3.6000000
    s_nCaptureHostilePointXP=65
    s_nCaptureHostilePointGold=20
    s_nReclaimPointXP=65
    s_nReclaimPointGold=20
    s_nCurrentPhase=1
    s_nPhase2Threshold=200
    m_nSpawnWaveTime=20
    m_nSpawnWaveDominatingTime=40
    m_nMaxDominatingPoints=150
    s_nAboutToLoseThreshold=100
    m_fCreditsToGivePerTick=5.0000000
    m_nStartingLevel=3
    m_fFirstBloodGoldReward=100.0000000
    m_GameType=TG_GAME_TYPE.TGT_POINTCAPTURE
    GoalScore=400
}