class TgGame_Mission extends TgGame
    native(Game)
    config(Game)
    hidecategories(Navigation,Movement,Collision);

const SURRENDER_TIME_SECS = 60.0;
const SURRENDER_TIME_BETWEEN = 180.0;
const MISSION_TIME_SETUP_SECS = 90.0;
const PLAYER_END_GAME_DELAY = 10.0f;
const FINISH_END_MISSION_DELAY = 300.0;
const PRE_GUARDIAN_PHASE_START = 7110.0f;
const GUARDIAN_PHASE_START = 7200.0f;
const PRE_MATCH_FROZEN_TIME_SECS = 3.0f;

struct native SurrenderVote
{
    var int nPlayerId;
    var bool bSurrender;

    structdefaultproperties
    {
        nPlayerId=0
        bSurrender=false
    }
};

struct native SurrenderData
{
    var float fLastSurrenderTime;
    var array<SurrenderVote> SurrenderVotes;
    var int nSurrenderTotal;
    var int nSurrenderNeeded;
    var int nSurrenderVoteCount;
    var int nNoSurrenderVoteCount;

    structdefaultproperties
    {
        fLastSurrenderTime=0.0000000
        SurrenderVotes=none
        nSurrenderTotal=0
        nSurrenderNeeded=0
        nSurrenderVoteCount=0
        nNoSurrenderVoteCount=0
    }
};

var bool m_bSpawnInTaskForceArea;
var bool s_bPreGuardianPhasePulsed;
var bool s_bGuardianPhasePulsed;
var bool s_bWasSurrendered;
var bool m_bSurrenderAvailable;
var bool m_bFirstBloodAwarded;
var bool m_bAllowAutoUpgrades;
var bool m_bUsePlayerCharacterIntros;
var bool m_bUseKillEmotes;
var bool m_bNotifyKillCombos;
var TgObject.GameTimerState m_eTimerState;
var TgObject.GameTimerState m_eTimerStatePaused;
var float m_fMissionTime;
var float m_fSecondaryMissionTime;
var private const float m_fWaitingForPlayersTime;
var config float m_fSetupTime;
var float m_fPausedAtTime;
var float m_fGameMissionTime;
var float s_MissionTimeAccumulator;
var array<Player> s_ReadyPlayers;
var int s_nReadyMercs;
var config float m_fTickCreditsFreq;
var config float m_fCreditsToGivePerTick;
var int m_nStartingCurrency;
var int m_nStartingLevel;
var int m_nWinBonusXp;
var int m_nWinPlayerXp;
var int m_nLosePlayerXp;
var float m_fGodXpCoefficient;
var float m_fGodXpCoefficientLoss;
var float m_fGodXpWinBonus;
var float m_fFreeVIPWinPoints;
var float m_fFreeVIPLossPoints;
var float m_fPaidVIPWinPoints;
var float m_fPaidVIPLossPoints;
var float m_fBaseTokens;
var Class<TgMinimapManager> m_MinimapManagerClass;
var SurrenderData s_SurrenderData[2];
var float m_fSurrenderTime;
var int m_XPRadius;
var float m_MinionKillerBonus;
var float m_BasePlayerGoldReward;
var float m_fFirstBloodGoldReward;
var float m_fBasePlayerAssistGoldRewardMultipler;
var float m_fBasePlayerAssistXpRewardMultipler;
var float m_fBaseNPCAssistGoldRewardMultipler;
var float m_fBaseNPCAssistXpRewardMultipler;
var transient array<TgMinionGoal> m_MinionGoals;

// Export UTgGame_Mission::execBeginEndMission(FFrame&, void* const)
native function bool BeginEndMission(optional bool bClearNextMapGame = false, optional Actor EndMissionFocus, optional float fDelayOverride = 0.0000000);

// Export UTgGame_Mission::execLoadGameConfig(FFrame&, void* const)
native function LoadGameConfig();

// Export UTgGame_Mission::execSpoolCredits(FFrame&, void* const)
native function SpoolCredits();

// Export UTgGame_Mission::execSpawnPlayerCharacter(FFrame&, void* const)
native function TgPawn SpawnPlayerCharacter(Controller C, Vector vLocation);

// Export UTgGame_Mission::execSendMissionTimerEvent(FFrame&, void* const)
native function SendMissionTimerEvent(int nEventId);

// Export UTgGame_Mission::execUpdateMissionTimerEventWinVar(FFrame&, void* const)
native function UpdateMissionTimerEventWinVar();

// Export UTgGame_Mission::execMissionTimeRemaining(FFrame&, void* const)
native function float MissionTimeRemaining();

// Export UTgGame_Mission::execMissionTimeElapsed(FFrame&, void* const)
native function float MissionTimeElapsed();

// Export UTgGame_Mission::execMarkAsReady(FFrame&, void* const)
native function MarkAsReady(Player P);

// Export UTgGame_Mission::execAllPlayersRevive(FFrame&, void* const)
native function AllPlayersRevive();

// Export UTgGame_Mission::execAllPlayersFullVitals(FFrame&, void* const)
native function AllPlayersFullVitals();

// Export UTgGame_Mission::execAllPlayersRecall(FFrame&, void* const)
native function AllPlayersRecall();

// Export UTgGame_Mission::execPlayerSurrender(FFrame&, void* const)
native function PlayerSurrender(int nPlayerId, optional bool bSurrender = true);

// Export UTgGame_Mission::execSurrenderCompleteTimer1(FFrame&, void* const)
native function SurrenderCompleteTimer1();

// Export UTgGame_Mission::execSurrenderCompleteTimer2(FFrame&, void* const)
native function SurrenderCompleteTimer2();

// Export UTgGame_Mission::execSurrenderComplete(FFrame&, void* const)
native function SurrenderComplete(int nTaskForce);

// Export UTgGame_Mission::execEndGameBySurrender(FFrame&, void* const)
native function EndGameBySurrender(int SurrenderingTaskForce);

// Export UTgGame_Mission::execCapturedPoint(FFrame&, void* const)
native function CapturedPoint(TgPawn_Character PC);

// Export UTgGame_Mission::execCapturePointReclaimed(FFrame&, void* const)
native function CapturePointReclaimed(TgPawn_Character PC);

// Export UTgGame_Mission::execGetMinIntroWait(FFrame&, void* const)
native final function float GetMinIntroWait();

// Export UTgGame_Mission::execScoreKill(FFrame&, void* const)
native function ScoreKill(Controller Killer, Controller Other);

// Export UTgGame_Mission::execScoreKillCommon(FFrame&, void* const)
native function ScoreKillCommon(out ScoreKillData Data);

// Export UTgGame_Mission::execScoreKillGameType(FFrame&, void* const)
native function ScoreKillGameType(out ScoreKillData Data);

// Export UTgGame_Mission::execScoreKillAchievements(FFrame&, void* const)
native function ScoreKillAchievements(out ScoreKillData Data);

// Export UTgGame_Mission::execGetScoreKillData(FFrame&, void* const)
native function bool GetScoreKillData(Controller Killer, Controller Other, out ScoreKillData Data);

// Export UTgGame_Mission::execNativeUpdateTimerState(FFrame&, void* const)
native function NativeUpdateTimerState();

// Export UTgGame_Mission::execIsFlankKill(FFrame&, void* const)
native function bool IsFlankKill(out ScoreKillData Data);

event PostBeginPlay()
{
    local TgMinionGoal Goal;

    super.PostBeginPlay();
    CreateMinimapManagers(m_MinimapManagerClass);
    // End:0x4D
    foreach AllActors(Class'TgGame.TgMinionGoal', Goal)
    {
        m_MinionGoals.AddItem(Goal);        
    }    
    //return;    
}

function CreateMinimapManagers(Class<TgMinimapManager> managerClass)
{
    local TgRepInfo_TaskForce tfri;
    local TgRepInfo_Game GRI;

    GRI = TgRepInfo_Game(GameReplicationInfo);
    tfri = GRI.GetTaskForce(1);
    tfri.CreateMinimap(0, managerClass);
    tfri = GRI.GetTaskForce(2);
    tfri.CreateMinimap(1, managerClass);
    //return;    
}

event PostLogin(PlayerController NewPlayer)
{
    StartGameTimer();
    super.PostLogin(NewPlayer);
    //return;    
}

function StartMatch()
{
    super.StartMatch();
    SetTimer(m_fTickCreditsFreq, true, 'SpoolCredits');
    //return;    
}

function AddObjectiveScore(PlayerReplicationInfo Scorer, int Score)
{
    //return;    
}

function OnPointCaptureOwnershipChanged(TgCapturePoint Point, int NewTaskForceOwner, int PreviousTaskForceOwner)
{
    //return;    
}

function UpdateLockedPointStatus()
{
    //return;    
}

function bool CheckScore(PlayerReplicationInfo Scorer)
{
    return false;
    //return ReturnValue;    
}

event QuickEndGame(int nWinnerTF)
{
    local TgRepInfo_Game GRI;
    local TgPlayerController TgPC;

    GRI = TgRepInfo_Game(GameReplicationInfo);
    GRI.r_Winner = GRI.GetTaskForce(nWinnerTF);
    // End:0x83
    if(nWinnerTF == 2)
    {
        m_GameWinState = 1;        
    }
    else
    {
        m_GameWinState = 2;
    }
    // End:0xEC
    foreach WorldInfo.AllControllers(Class'TgGame.TgPlayerController', TgPC)
    {
        TgPC.SendClientSetGameWinState(m_GameWinState);        
    }    
    UpdateMissionTimerEventWinVar();
    BeginEndMission();
    //return;    
}

event TgTimer(out string sTimerCommand)
{
    local int Time;
    local bool bTimerIsPaused;
    local int oldTime;

    oldTime = int(MissionTimeRemaining());
    bTimerIsPaused = m_fPausedAtTime > float(0);
    Time = int(sTimerCommand);
    // End:0x73
    if(Time != 0)
    {
        MissionTimerModify(bTimerIsPaused, Time);        
    }
    else
    {
        // End:0xC4
        if((InStr(sTimerCommand, "start") > 0) || InStr(sTimerCommand, "unpause") > 0)
        {
            MissionTimerModify(false, oldTime);            
        }
        else
        {
            // End:0x112
            if((InStr(sTimerCommand, "stop") > 0) || InStr(sTimerCommand, "pause") > 0)
            {
                MissionTimerModify(true, oldTime);                
            }
        }
    }
    //return;    
}

function bool StartGameTimer()
{
    local float fPlayerWaitTime;

    // End:0x85
    if((m_fGameMissionTime > 0.0000000) && int(m_eTimerState) == int(0))
    {
        fPlayerWaitTime = GetPlayerWaitTime();
        SetMissionTime(fPlayerWaitTime);
        ChangeTimerState(1);
        UpdateMissionTimerEventWinVar();
        MissionTimerStart();
        SetTimer(1.0000000, true, 'KeepClientsInSync');
        return true;
    }
    return false;
    //return ReturnValue;    
}

function KeepClientsInSync()
{
    SendMissionTimerNotify(TgRepInfo_Game(GameReplicationInfo).r_nMissionTimerState, MissionTimeRemaining());
    //return;    
}

event SetMissionTime(float fTime)
{
    m_fMissionTime = fTime;
    //return;    
}

event SetSecondaryMissionTime(float fTime)
{
    m_fSecondaryMissionTime = fTime;
    //return;    
}

event MissionTimerStart()
{
    local float fTime;

    // End:0x91
    if(m_fMissionTime > 0.0000000)
    {
        fTime = ((m_fPausedAtTime > float(0)) ? m_fPausedAtTime : m_fMissionTime);
        ClearTimer('MissionTimer');
        SetTimer(fTime, false, 'MissionTimer');
        m_fPausedAtTime = 0.0000000;
        SendMissionTimerNotify(1, fTime);
    }
    // End:0xB8
    if(int(m_eTimerState) == int(6))
    {
        ChangeTimerState(m_eTimerStatePaused);
    }
    //return;    
}

event MissionTimerStop()
{
    ClearTimer('MissionTimer');
    m_fPausedAtTime = 0.0000000;
    // End:0x4A
    if(int(m_eTimerState) == int(6))
    {
        ChangeTimerState(m_eTimerStatePaused);
    }
    MissionTimer();
    //return;    
}

event MissionTimerPause()
{
    // End:0xA7
    if(IsTimerActive('MissionTimer'))
    {
        m_fPausedAtTime = GetTimerRate('MissionTimer') - GetTimerCount('MissionTimer');
        ClearTimer('MissionTimer');
        SendMissionTimerNotify(2, m_fPausedAtTime);
        // End:0x9B
        if(int(m_eTimerState) != int(6))
        {
            m_eTimerStatePaused = m_eTimerState;
        }
        ChangeTimerState(6);
    }
    //return;    
}

event MissionTimer()
{
    SendMissionTimerNotify(0, 0.0000000);
    // End:0x5C
    if(int(m_eTimerState) == int(2))
    {
        SetMissionTime(m_fGameMissionTime);
        MissionTimerStart();
        ChangeTimerState(3);
        SendMissionTimerEvent(1);        
    }
    else
    {
        // End:0x7A
        if(int(m_eTimerState) == int(1))
        {
            AllPlayersReady();
        }
    }
    //return;    
}

event AllPlayersReady()
{
    local TgPlayerController PC;
    local float fSetupTime;

    // End:0x86
    if(m_bUsePlayerCharacterIntros)
    {
        // End:0x85
        foreach WorldInfo.AllControllers(Class'TgGame.TgPlayerController', PC)
        {
            // End:0x84
            if(!PC.IsSpectating())
            {
                PC.SetupIntro();
            }            
        }        
    }
    TgRepInfo_Game(GameReplicationInfo).r_bIntroPlayed = true;
    // End:0x101
    if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
    {
        TgRepInfo_Game(GameReplicationInfo).UpdateGameTransitionUI();
    }
    // End:0x17C
    if((m_fGameMissionTime > 0.0000000) && int(m_eTimerState) == int(1))
    {
        fSetupTime = GetSetupTime();
        SetMissionTime(fSetupTime);
        ChangeTimerState(2);
        UpdateMissionTimerEventWinVar();
        MissionTimerStart();
        SendMissionTimerEvent(0);
    }
    //return;    
}

event ChangeTimerState(TgObject.GameTimerState eTimerState)
{
    local TgRepInfo_Game GRI;
    local TgObject.GameTimerState oldTimerState, newTimerState;

    oldTimerState = m_eTimerState;
    newTimerState = eTimerState;
    // End:0x43
    if(int(oldTimerState) == int(newTimerState))
    {
        return;
    }
    GRI = TgRepInfo_Game(GameReplicationInfo);
    m_eTimerState = eTimerState;
    GRI.r_eGameTimerState = eTimerState;
    // End:0xE2
    if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
    {
        GRI.GameStateChanged();
    }
    NativeUpdateTimerState();
    //return;    
}

event bool MissionTimerActive()
{
    return (IsTimerActive('MissionTimer') || m_fPausedAtTime > 0.0000000) || (int(m_eTimerState) > int(2)) && int(m_eTimerState) < int(5);
    //return ReturnValue;    
}

event float ElapsedTime()
{
    // End:0x2C
    if(IsTimerActive('MissionTimer'))
    {
        return GetTimerCount('MissionTimer');
    }
    return 0.0000000;
    //return ReturnValue;    
}

event MissionTimerModify(bool bPause, int nNewTime)
{
    // End:0x8D
    if(m_fPausedAtTime > float(0))
    {
        // End:0x71
        if(nNewTime > 0)
        {
            m_fPausedAtTime = float(nNewTime);
            SendMissionTimerNotify(TgRepInfo_Game(GameReplicationInfo).r_nMissionTimerState, float(nNewTime));
        }
        // End:0x8A
        if(!bPause)
        {
            MissionTimerStart();
        }        
    }
    else
    {
        // End:0x119
        if(m_fPausedAtTime == float(0))
        {
            // End:0x102
            if(nNewTime > 0)
            {
                SetTimer(float(nNewTime), false, 'MissionTimer');
                SendMissionTimerNotify(TgRepInfo_Game(GameReplicationInfo).r_nMissionTimerState, float(nNewTime));
            }
            // End:0x119
            if(bPause)
            {
                MissionTimerPause();
            }
        }
    }
    //return;    
}

event MissionTimeIncrement(float fInc)
{
    local float fTime;

    // End:0x26
    if(!MissionTimerActive() || fInc <= 0.0000000)
    {
        return;
    }
    // End:0x65
    if(m_fPausedAtTime > 0.0000000)
    {
        m_fPausedAtTime += fInc;
        SendMissionTimerNotify(2, m_fPausedAtTime);        
    }
    else
    {
        fTime = 0.0000000;
        // End:0x9D
        if(int(m_eTimerState) != int(4))
        {
            fTime += (MissionTimeRemaining());
        }
        fTime += fInc;
        ClearTimer('MissionTimer');
        SetTimer(fTime, false, 'MissionTimer');
        SendMissionTimerNotify(1, fTime);
    }
    // End:0x138
    if(int(m_eTimerState) != int(7))
    {
        // End:0x125
        if(m_fPausedAtTime > float(0))
        {
            ChangeTimerState(6);            
        }
        else
        {
            ChangeTimerState(m_eTimerState);
        }
    }
    //return;    
}

event SendMissionTimerNotify(TgRepInfo_Game.MissionTimerState eState, float fRemainingSecs)
{
    local TgRepInfo_Game GRI;

    GRI = TgRepInfo_Game(GameReplicationInfo);
    // End:0x10B
    if(GRI != none)
    {
        GRI.r_fMissionTime = m_fMissionTime;
        GRI.r_nMissionTimerState = eState;
        GRI.r_fMissionRemainingTime = fRemainingSecs;
        GRI.r_nMissionTimerStateChange++;
        // End:0x10B
        if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
        {
            GRI.InitMissionTime();
        }
    }
    //return;    
}

event SendSecondaryMissionTimerNotify(TgRepInfo_Game.MissionTimerState eState, float fRemainingSecs)
{
    local TgRepInfo_Game GRI;

    GRI = TgRepInfo_Game(GameReplicationInfo);
    // End:0x10B
    if(GRI != none)
    {
        GRI.r_fSecondaryTime = m_fSecondaryMissionTime;
        GRI.r_nSecondaryTimerState = eState;
        GRI.r_fSecondaryRemainingTime = fRemainingSecs;
        GRI.r_nSecondaryTimerStateChange++;
        // End:0x10B
        if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
        {
            GRI.InitSecondaryMissionTime();
        }
    }
    //return;    
}

function float GetSetupTime()
{
    return m_fSetupTime;
    //return ReturnValue;    
}

private final function float GetPlayerWaitTime()
{
    return m_fWaitingForPlayersTime;
    //return ReturnValue;    
}

event TgObject.GameTimerState GetMissionTimerStatus()
{
    return m_eTimerState;
    //return ReturnValue;    
}

defaultproperties
{
    m_bSpawnInTaskForceArea=true
    m_bSurrenderAvailable=true
    m_bAllowAutoUpgrades=true
    m_bUsePlayerCharacterIntros=true
    m_bUseKillEmotes=true
    m_bNotifyKillCombos=true
    m_fWaitingForPlayersTime=90.0000000
    m_fSetupTime=90.0000000
    m_fGameMissionTime=14400.0000000
    m_fTickCreditsFreq=1.0000000
    m_fCreditsToGivePerTick=1.0000000
    m_nStartingLevel=1
    m_fFreeVIPWinPoints=2700.0000000
    m_fFreeVIPLossPoints=1350.0000000
    m_fPaidVIPWinPoints=8100.0000000
    m_fPaidVIPLossPoints=3240.0000000
    m_MinimapManagerClass=Class'TgGame.TgMinimapManager'
    m_fSurrenderTime=600.0000000
    m_XPRadius=1280
    m_MinionKillerBonus=0.5000000
    m_BasePlayerGoldReward=300.0000000
    m_fFirstBloodGoldReward=200.0000000
    m_fBasePlayerAssistGoldRewardMultipler=0.5000000
    m_fBasePlayerAssistXpRewardMultipler=0.5000000
    m_fBaseNPCAssistGoldRewardMultipler=1.0000000
    m_fBaseNPCAssistXpRewardMultipler=1.0000000
}