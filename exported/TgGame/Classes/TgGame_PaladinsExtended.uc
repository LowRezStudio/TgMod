class TgGame_PaladinsExtended extends TgGame_Paladins
    native(Game)
    config(Game)
    hidecategories(Navigation,Movement,Collision);

enum ETeamStatus
{
    TEAM_WINNING,                   // 0
    TEAM_LOSING,                    // 1
    TEAM_TIED,                      // 2
    TEAM_MAX                        // 3
};

enum EVictoryType
{
    EVT_Default,                    // 0
    EVT_Capture,                    // 1
    EVT_Defend,                     // 2
    EVT_Payload,                    // 3
    EVT_Siege,                      // 4
    EVT_Survival,                   // 5
    EVT_Kill,                       // 6
    EVT_Ticket,                     // 7
    EVT_TimeLimit,                  // 8
    EVT_MAX                         // 9
};

var transient int m_nTF1Score;
var transient int m_nTF2Score;
var config transient int m_nWinningScore;
var config float m_fWinningTickets;
var config bool m_bTicketsPersist;
var bool m_bScoringEnabled;
var const config bool m_bKillLanePusherOnWallDestroyed;
var bool m_bKeepThisPointForNextRound;
var bool m_bConvergeCompletely;
var bool m_bCanCaptureDuringSurvival;
var const config bool m_bCanAutoPushForward;
var bool m_bCanSpoolCredits;
var bool m_bConvergeCompletelyAfterDelay;
var bool m_bOverrideSpawnTableID;
var config bool m_bActivateSpawnGatesAtStart;
var config bool m_bRevivePlayersWhenSiegeEngineDies;
var bool m_bStasisTimerOn;
var config bool m_bActivateAllCapturePoints;
var bool m_bPointContested;
var bool m_bPointCaptureOvertime;
var bool m_bCapturePointContestDurationEnabled;
var bool m_bTF1Backsliding;
var bool m_bTF2Backsliding;
var bool m_bEndRoundWhenPointCaptured;
var bool m_bSpawnLanePusherWhenPointCaptured;
var bool m_bCaptureSpawnAlerts;
var bool m_bResetPlayersNotInSpawnRoomDisabled;
var config bool m_bAutoMountAtRoundBegin;
var config bool m_bResetPlayersNotInSpawnRoom;
var config float m_fTicketsForKill;
var config float m_fTicketsPerCaptureTick;
var config float m_fTicketsBonusPerMultiCapture;
var config float m_fTicketsPerPointCapture;
var float m_fTF1Tickets;
var float m_fTF2Tickets;
var config float m_fTicketsPerTicketDisparity;
var config float m_fSecondsPerTicketDisparity;
var config float m_fMaximumDisparitySeconds;
var config float m_fObjectiveRepickTickets;
var float m_fLastObjectiveRepickTickets;
var config float m_fRoundLimitDuration;
var float s_fRoundLimitElapsed;
var config int m_nPointsForReachingTicketMax;
var config int m_nPointsForReachingRoundTimeLimit;
var config float m_fSecondaryGoalScore;
var const config float m_fSecondaryScoreAmount;
var const config float m_fObjectivePickTime;
var const config float m_fSetupObjectivePickTime;
var const config float m_fSpawnGateOpenTime;
var const config float m_fAttackersSpawnGateOpenTime;
var const config float m_fDefendersSpawnGateOpenTime;
var const config float m_fSetupSpawnGateOpenTime;
var const float m_fObjectiveActivationTime;
var int m_SpawnTableIndex;
var TgChaosCapturePoint m_CapturedPoint;
var TgChaosCapturePoint m_LastActiveCapturePoint;
var array<TgChaosCapturePoint> m_CapturePointQueue;
var int s_nCurrentCapturePointQueueIndex;
var array<CardInfo> m_CardVendor;
var const config int m_nRegLanePusherHPScaling;
var const config int m_nRegLanePusherPowerScaling;
var const config int m_nGuardianHPScaling;
var const config int m_nGuardianPowerScaling;
var const config int m_nOuterGateHPScaling;
var const config int m_nInnerGateHPScaling;
var const config int m_nBaseObjectiveHPScaling;
var TgPawn_SiegeWall m_TF1InnerWall;
var TgPawn_SiegeWall m_TF1OuterWall;
var TgPawn_SiegeWall m_TF1BaseObjective;
var TgPawn_SiegeWall m_TF2InnerWall;
var TgPawn_SiegeWall m_TF2OuterWall;
var TgPawn_SiegeWall m_TF2BaseObjective;
var int m_nForcedObjectiveIndex;
var int m_nCountdown;
var protected float m_fSpeedScale;
var config float m_fRespawnIncreaseOverTime;
var config float m_fDefenseRespawnIncrease;
var config float m_fAttackRespawnIncrease;
var config float m_fRespawnTimeCap;
var config float m_fNoSiegeEngineRespawnModification;
var const name m_AttackDefendState;
var const TgObject.EGameMode m_DefaultGameMode;
var() config float m_fConvergeStartDistance;
var() config float m_fConvergeRate;
var() config float m_fStartConvergeTime;
var() config float m_fConvergeSafeDistance;
var TgDevice ConvergeDevice;
var const config float m_fAutoPushForwardDelay;
var const config float m_fAutoPushForwardSpeedScale;
var const config float m_fStopAutoPushDelay;
var config int m_nCreditsForHoldingObjective;
var config int m_nCreditsBonusPerContested;
var config int m_nCreditsForHoldingPayload;
var float m_fFogCompleteConvergeDelay;
var config float m_fCapturePointsPerSecond1;
var config float m_fCapturePointsPerSecond2;
var config float m_fCapturePointsPerSecond3;
var config float m_fCapturePointsPerSecond4;
var config float m_fCapturePointsPerSecond5;
var config float m_fPointContestDuration;
var config float m_fPointOvertimeDuration;
var config float m_fPointOvertimeDrainPercPerSec;
var config float m_fPointClaimDuration;
var float m_fOvertimeActiveTime;
var config float m_fBackslidePercent;
var config float m_fBackslideDelay;
var config float m_fBackslideRate;
var int s_nCurrentActivePointIndex;
var int m_nAttackingTaskforce;
var config float m_fFlankerSoloKillRewardDistance;
var config float m_fDamageRoleMultiplier;
var config float m_fFlankRoleMultiplier;
var config float m_fFrontLineRoleMultiplier;
var config float m_fSupportRoleMultiplier;
var Vector m_SnappedWaypointIndicatorOffset;
var float m_fGamePauseDelay;

// Export UTgGame_PaladinsExtended::execGetRespawnTime(FFrame&, void* const)
native function float GetRespawnTime(int TaskForceNum);

// Export UTgGame_PaladinsExtended::execScoreObjectiveHold(FFrame&, void* const)
native function ScoreObjectiveHold(TgPawn ScorePawn, int NumContested);

// Export UTgGame_PaladinsExtended::execScorePayloadHold(FFrame&, void* const)
native function ScorePayloadHold(TgPawn ScorePawn, int NumContested);

// Export UTgGame_PaladinsExtended::execBotDied(FFrame&, void* const)
native function BotDied(TgAIController aic);

// Export UTgGame_PaladinsExtended::execLoadCardVendor(FFrame&, void* const)
native function LoadCardVendor();

// Export UTgGame_PaladinsExtended::execCaptureSpawnAlert(FFrame&, void* const)
native function CaptureSpawnAlert(float TimeRemaining);

// Export UTgGame_PaladinsExtended::execSiegeEnginePreDamageMitigation(FFrame&, void* const)
native function SiegeEnginePreDamageMitigation(TgPawn attacker, TgEffectGroup eg, out float fDamage, int nPropertyId);

// Export UTgGame_PaladinsExtended::execSiegeEngineAdjustDamage(FFrame&, void* const)
native function SiegeEngineAdjustDamage(const out AdjustDamageParams Params, out float fDamage);

// Export UTgGame_PaladinsExtended::execCacheConvergeDevice(FFrame&, void* const)
native function CacheConvergeDevice();

// Export UTgGame_PaladinsExtended::execCanSpoolCredits(FFrame&, void* const)
native function bool CanSpoolCredits();

// Export UTgGame_PaladinsExtended::execTickOvertime(FFrame&, void* const)
native function TickOvertime(float DeltaSeconds);

// Export UTgGame_PaladinsExtended::execGetRewardScale(FFrame&, void* const)
native function float GetRewardScale(Actor Rewardee, TgObject.ERewardValueType RewardType, optional bool bFlankKill = false);

// Export UTgGame_PaladinsExtended::execIsFlankKill(FFrame&, void* const)
native function bool IsFlankKill(out ScoreKillData Data);

// Export UTgGame_PaladinsExtended::execGetTaskForceObjectiveTime(FFrame&, void* const)
native function int GetTaskForceObjectiveTime(int TaskForceNum);

// Export UTgGame_PaladinsExtended::execSendStartRoundOnePointFromWinningAlert(FFrame&, void* const)
native function SendStartRoundOnePointFromWinningAlert(int nTaskForceNum);

event PostBeginPlay()
{
    local TgRepInfo_Game GRI;
    local TgRepInfo_TaskForce Taskforce1, Taskforce2;

    super.PostBeginPlay();
    m_nTF1Score = m_nWinningScore;
    m_nTF2Score = m_nWinningScore;
    SetTickets(1, m_fWinningTickets);
    SetTickets(2, m_fWinningTickets);
    m_fLastObjectiveRepickTickets = 0.0000000;
    SetTimer(1.0000000, true, 'ManageCapturePointScore');
    GRI = TgRepInfo_Game(WorldInfo.GRI);
    // End:0x298
    if(GRI != none)
    {
        GRI.r_bUltimatesLocked = true;
        GRI.r_bKillCamEnabled = false;
        GRI.r_bAttackersKillCamEnabled = false;
        GRI.r_bDefendersKillCamEnabled = false;
        GRI.bNetDirty = true;
        Taskforce1 = GRI.GetTaskForce(1);
        // End:0x1E3
        if(Taskforce1 != none)
        {
            Taskforce1.r_nScore = m_nTF1Score;
            Taskforce1.bNetDirty = true;
        }
        Taskforce2 = GRI.GetTaskForce(2);
        // End:0x267
        if(Taskforce2 != none)
        {
            Taskforce2.r_nScore = m_nTF2Score;
            Taskforce2.bNetDirty = true;
        }
        // End:0x298
        if(m_fRoundLimitDuration > float(0))
        {
            s_fRoundLimitElapsed = 0.0000000;
            SendRoundLimitTimerNotify(0, 0.0000000);
        }
    }
    LoadCardVendor();
    // End:0x2B9
    if(m_bActivateSpawnGatesAtStart)
    {
        CloseSpawnGates();
    }
    //return;    
}

function int GetScore(int nTaskForce)
{
    switch(nTaskForce)
    {
        // End:0x21
        case 1:
            return m_nTF1Score;
        // End:0x30
        case 2:
            return m_nTF2Score;
        // End:0xFFFF
        default:
            return 0;
            break;
    }
    //return ReturnValue;    
}

function SetScore(int nTaskForce, int nScore)
{
    local TgRepInfo_Game GRI;
    local TgRepInfo_TaskForce Taskforce;

    // End:0x11
    if(!m_bScoringEnabled)
    {
        return;
    }
    GRI = TgRepInfo_Game(WorldInfo.GRI);
    // End:0x84
    if(GRI != none)
    {
        Taskforce = GRI.GetTaskForce(nTaskForce);
    }
    switch(nTaskForce)
    {
        // End:0xD9
        case 1:
            // End:0xD6
            if(SetTaskforceScore(Taskforce, nScore, m_nTF1Score))
            {
                NotifyClientsOfTF1ScoreChange(nScore);
            }
            // End:0x11F
            break;
        // End:0x11C
        case 2:
            // End:0x119
            if(SetTaskforceScore(Taskforce, nScore, m_nTF2Score))
            {
                NotifyClientsOfTF2ScoreChange(nScore);
            }
            // End:0x11F
            break;
        // End:0xFFFF
        default:
            break;
    }
    //return;    
}

function bool SetTaskforceScore(TgRepInfo_TaskForce Taskforce, int nScore, out int nStoredScore)
{
    local bool bUpdated;

    // End:0xF5
    if(nStoredScore != nScore)
    {
        nStoredScore = nScore;
        // End:0xBC
        if((Taskforce != none) && Taskforce.r_nScore != nScore)
        {
            Taskforce.r_nScore = nStoredScore;
            Taskforce.bNetDirty = true;
            bUpdated = true;
        }
        // End:0xF5
        if(nStoredScore <= 0)
        {
            TaskforceWin(Taskforce.r_nTeamId, 0);
        }
    }
    return bUpdated;
    //return ReturnValue;    
}

function GainPoints(int nTaskForce, int numPoints, TgGame_PaladinsExtended.EVictoryType VictoryType)
{
    local TgRepInfo_Game GRI;
    local TgRepInfo_TaskForce Taskforce;

    // End:0x11
    if(!m_bScoringEnabled)
    {
        return;
    }
    switch(nTaskForce)
    {
        // End:0x12D
        case 1:
            m_nTF1Score -= numPoints;
            GRI = TgRepInfo_Game(WorldInfo.GRI);
            // End:0xFF
            if(GRI != none)
            {
                Taskforce = GRI.GetTaskForce(1);
                // End:0xFF
                if(Taskforce != none)
                {
                    Taskforce.r_nScore = m_nTF1Score;
                    Taskforce.bNetDirty = true;
                }
            }
            // End:0x12A
            if(m_nTF1Score <= 0)
            {
                TaskforceWin(nTaskForce, VictoryType);
            }
            // End:0x23B
            break;
        // End:0x238
        case 2:
            m_nTF2Score -= numPoints;
            GRI = TgRepInfo_Game(WorldInfo.GRI);
            // End:0x20A
            if(GRI != none)
            {
                Taskforce = GRI.GetTaskForce(2);
                // End:0x20A
                if(Taskforce != none)
                {
                    Taskforce.r_nScore = m_nTF2Score;
                    Taskforce.bNetDirty = true;
                }
            }
            // End:0x235
            if(m_nTF2Score <= 0)
            {
                TaskforceWin(nTaskForce, VictoryType);
            }
            // End:0x23B
            break;
        // End:0xFFFF
        default:
            break;
    }
    //return;    
}

function TaskforceWin(int nTaskForce, TgGame_PaladinsExtended.EVictoryType VictoryType)
{
    local TgRepInfo_Game GRI;

    m_GameWinState = ((nTaskForce == 1) ? 2 : 1);
    GRI = TgRepInfo_Game(GameReplicationInfo);
    // End:0xB3
    if(GRI != none)
    {
        GRI.r_Winner = GRI.GetTaskForce(nTaskForce);
        GRI.bNetDirty = true;
    }
    BeginEndMission();
    //return;    
}

function NotifyClientsOfTF1ScoreChange(int nScore)
{
    local TgPlayerController TgPC;

    // End:0x5D
    foreach WorldInfo.AllControllers(Class'TgGame.TgPlayerController', TgPC)
    {
        TgPC.ClientUpdateTF1Score(nScore);        
    }    
    //return;    
}

function NotifyClientsOfTF2ScoreChange(int nScore)
{
    local TgPlayerController TgPC;

    // End:0x5D
    foreach WorldInfo.AllControllers(Class'TgGame.TgPlayerController', TgPC)
    {
        TgPC.ClientUpdateTF2Score(nScore);        
    }    
    //return;    
}

event SendRoundLimitTimerNotify(TgRepInfo_Game.MissionTimerState eState, float fElapsedSecs)
{
    local TgRepInfo_Game GRI;

    GRI = TgRepInfo_Game(GameReplicationInfo);
    // End:0xA3
    if(GRI != none)
    {
        GRI.r_fRoundLimitElapsed = fElapsedSecs;
        GRI.r_nRoundLimitTimerState = eState;
        GRI.r_fRoundLimitDuration = m_fRoundLimitDuration;
    }
    //return;    
}

event RoundTimeLimitReached()
{
    local TgRepInfo_Game GRI;
    local TgRepInfo_TaskForce TF1, TF2;
    local int WinningTF;

    GRI = TgRepInfo_Game(GameReplicationInfo);
    // End:0xC2
    if(GRI != none)
    {
        TF1 = GRI.GetTaskForce(1);
        TF2 = GRI.GetTaskForce(2);
        GRI.r_nRemainingObjectiveTime = 0;
        GRI.r_nTotalObjectiveTime = 0;
    }
    ClearTimer('UpdateObjectiveTimer');
    WinningTF = -1;
    // End:0x141
    if(m_fWinningTickets > float(0))
    {
        // End:0x11B
        if(m_fTF1Tickets < m_fTF2Tickets)
        {
            WinningTF = 1;            
        }
        else
        {
            // End:0x13E
            if(m_fTF2Tickets < m_fTF1Tickets)
            {
                WinningTF = 2;
            }
        }        
    }
    else
    {
        // End:0x1FD
        if((TF1 != none) && TF2 != none)
        {
            // End:0x1B0
            if(TF1.r_fSecondaryScore > TF2.r_fSecondaryScore)
            {
                WinningTF = 1;                
            }
            else
            {
                // End:0x1FD
                if(TF2.r_fSecondaryScore > TF1.r_fSecondaryScore)
                {
                    WinningTF = 2;
                }
            }
        }
    }
    // End:0x224
    if(WinningTF == -1)
    {
        WinningTF = ResolveTie();
    }
    GainPoints(WinningTF, m_nPointsForReachingRoundTimeLimit, 8);
    // End:0x2C3
    if(GRI != none)
    {
        GRI.r_nLastRoundWinner = byte(WinningTF);
        GRI.UpdateAttackingTaskforce(GRI.GetTaskForce(WinningTF));
    }
    OnRoundEnded();
    TransitionToNextRound();
    //return;    
}

function int ResolveTie()
{
    local int tf1Time, tf2Time;

    tf1Time = GetTaskForceObjectiveTime(1);
    tf2Time = GetTaskForceObjectiveTime(2);
    // End:0x47
    if(tf1Time > tf2Time)
    {
        return 1;        
    }
    else
    {
        // End:0x64
        if(tf1Time < tf2Time)
        {
            return 2;            
        }
        else
        {
            return Rand(2) + 1;
        }
    }
    //return ReturnValue;    
}

function BeginPlayConverge()
{
    local TgRepInfo_Game GRI;

    GRI = TgRepInfo_Game(WorldInfo.GRI);
    // End:0xA1
    if(GRI != none)
    {
        GRI.SetGameMode(1);
        GRI.SetGameRespawnRule(2);
        TriggerGlobalEventClass(Class'TgGame.TgSeqEvent_SurvivalGameBegin', self);
        CacheConvergeDevice();
    }
    //return;    
}

function EndPlayConverge()
{
    local TgRepInfo_Game GRI;

    GRI = TgRepInfo_Game(WorldInfo.GRI);
    // End:0x89
    if(GRI != none)
    {
        GRI.SetGameMode(m_DefaultGameMode);
        GRI.SetGameRespawnRule(0);
    }
    //return;    
}

event CheckCorePower(optional TgChaosCapturePoint capturePoint)
{
    local int nTaskForce;
    local TgRepInfo_Game GRI;
    local TgRepInfo_TaskForce TF1, TF2;

    GRI = TgRepInfo_Game(GameReplicationInfo);
    // End:0x44
    if((GRI == none) || int(m_GameWinState) != int(0))
    {
        return;
    }
    TF1 = GRI.GetTaskForce(1);
    TF2 = GRI.GetTaskForce(2);
    // End:0x224
    if((TF1.r_fSecondaryScore >= m_fSecondaryGoalScore) || TF2.r_fSecondaryScore >= m_fSecondaryGoalScore)
    {
        nTaskForce = ((TF1.r_fSecondaryScore >= m_fSecondaryGoalScore) ? 1 : 2);
        RewardPointCapture(nTaskForce);
        GRI.UpdateAttackingTaskforce(((TF1.r_fSecondaryScore >= m_fSecondaryGoalScore) ? TF1 : TF2));
        m_CapturedPoint = capturePoint;
        // End:0x206
        if(GRI.r_AttackingTaskForce != none)
        {
            GRI.PlaySoundBase(AkEvent'WW_UI_Default.UI_InGame_Alert_Point_Captured_1P_Play', false, false, false);
        }
        NotifyPlayersOfPointCapture();
        PointCaptured(nTaskForce);
    }
    //return;    
}

function RewardPointCapture(int nTaskForce)
{
    //return;    
}

function NotifyPlayersOfPointCapture()
{
    local TgPlayerController TgPC;
    local TgRepInfo_Game GRI;

    GRI = TgRepInfo_Game(GameReplicationInfo);
    // End:0xDF
    if(GRI != none)
    {
        // End:0xDE
        foreach WorldInfo.AllControllers(Class'TgGame.TgPlayerController', TgPC)
        {
            TgPC.ClientPlayPointCapturedEffects(m_CapturedPoint, TgPC.GetTaskForceNumber() == int(GRI.r_AttackingTaskForce.r_nTaskForce));            
        }        
    }
    //return;    
}

function float GetPointCaptureScoreMultiplier(int nTaskForce)
{
    local float CaptureRateModifier;

    // End:0x33
    if(int(GetTeamStatus(byte(nTaskForce), CaptureRateModifier)) == int(1))
    {
        return CaptureRateModifier;
    }
    return 1.0000000;
    //return ReturnValue;    
}

event TgGame_PaladinsExtended.ETeamStatus GetTeamStatus(byte TaskForceNum, optional out float CaptureRateModifier)
{
    local bool bIsTF1OuterWallUp, bIsTF1InnerWallUp, bIsTF2OuterWallUp, bIsTF2InnerWallUp;

    CaptureRateModifier = 1.0000000;
    bIsTF1OuterWallUp = (m_TF1OuterWall != none) && m_TF1OuterWall.IsAliveAndWell();
    bIsTF1InnerWallUp = (m_TF1InnerWall != none) && m_TF1InnerWall.IsAliveAndWell();
    bIsTF2OuterWallUp = (m_TF2OuterWall != none) && m_TF2OuterWall.IsAliveAndWell();
    bIsTF2InnerWallUp = (m_TF2InnerWall != none) && m_TF2InnerWall.IsAliveAndWell();
    // End:0x1C5
    if(int(TaskForceNum) == int(1))
    {
        // End:0x133
        if(bIsTF1OuterWallUp)
        {
            // End:0x12D
            if(bIsTF2OuterWallUp)
            {
                return 2;
            }
            return 0;            
        }
        else
        {
            // End:0x17B
            if(bIsTF1InnerWallUp)
            {
                // End:0x162
                if(bIsTF2OuterWallUp)
                {
                    CaptureRateModifier = 1.5000000;
                    return 1;                    
                }
                else
                {
                    // End:0x175
                    if(bIsTF2InnerWallUp)
                    {
                        return 2;                        
                    }
                    else
                    {
                        return 0;
                    }
                }                
            }
            else
            {
                // End:0x19D
                if(bIsTF2OuterWallUp)
                {
                    CaptureRateModifier = 2.0000000;
                    return 1;                    
                }
                else
                {
                    // End:0x1BF
                    if(bIsTF2InnerWallUp)
                    {
                        CaptureRateModifier = 1.5000000;
                        return 1;                        
                    }
                    else
                    {
                        return 2;
                    }
                }
            }
        }        
    }
    else
    {
        // End:0x1EB
        if(bIsTF2OuterWallUp)
        {
            // End:0x1E5
            if(bIsTF1OuterWallUp)
            {
                return 2;                
            }
            else
            {
                return 0;
            }            
        }
        else
        {
            // End:0x233
            if(bIsTF2InnerWallUp)
            {
                // End:0x21A
                if(bIsTF1OuterWallUp)
                {
                    CaptureRateModifier = 1.5000000;
                    return 1;                    
                }
                else
                {
                    // End:0x22D
                    if(bIsTF1InnerWallUp)
                    {
                        return 2;                        
                    }
                    else
                    {
                        return 0;
                    }
                }                
            }
            else
            {
                // End:0x255
                if(bIsTF1OuterWallUp)
                {
                    CaptureRateModifier = 2.0000000;
                    return 1;                    
                }
                else
                {
                    // End:0x277
                    if(bIsTF1InnerWallUp)
                    {
                        CaptureRateModifier = 1.5000000;
                        return 1;                        
                    }
                    else
                    {
                        return 2;
                    }
                }
            }
        }
    }
    return 2;
    //return ReturnValue;    
}

function bool IsSurivivalMode()
{
    return int(TgRepInfo_Game(GameReplicationInfo).r_GameMode) == int(1);
    //return ReturnValue;    
}

function Pawn SpawnDefaultPawnFor(Controller NewPlayer, NavigationPoint StartSpot)
{
    local Pawn P;

    P = super(TgGame).SpawnDefaultPawnFor(NewPlayer, StartSpot);
    // End:0x77
    if((TgPawn(P) != none) && m_bStasisTimerOn)
    {
        TgPawn(P).r_bIsInStasis = true;
    }
    return P;
    //return ReturnValue;    
}

event AllPlayersReady()
{
    super(TgGame_Mission).AllPlayersReady();
    // End:0x45
    if(m_bStasisTimerOn && !IsTimerActive('EndStasisTimer'))
    {
        SetTimer(3.0000000, false, 'EndStasisTimer');
    }
    //return;    
}

function ContestPoint()
{
    m_bPointContested = true;
    SetTimer(FMin(GetOvertimeDuration(), m_fPointContestDuration), false, 'PointContestEnd');
    //return;    
}

function PointContestEnd()
{
    m_bPointContested = false;
    //return;    
}

function SetCapturePointOvertimeEnabled(bool bEnabled)
{
    // End:0x72
    if(m_bCapturePointContestDurationEnabled != bEnabled)
    {
        m_bCapturePointContestDurationEnabled = bEnabled;
        // End:0x72
        if(!m_bCapturePointContestDurationEnabled)
        {
            // End:0x72
            if(IsTimerActive('PointOvertimeEnd'))
            {
                ClearTimer('PointOvertimeEnd');
                PointOvertimeEnd();
            }
        }
    }
    //return;    
}

function float GetOvertimeDuration()
{
    return FMax(1.0000000, m_fPointOvertimeDuration - ((m_fPointOvertimeDuration * (m_fPointOvertimeDrainPercPerSec / 100.0000000)) * m_fOvertimeActiveTime));
    //return ReturnValue;    
}

function BeginPointOvertime()
{
    local TgRepInfo_Game GRI;
    local TgChaosCapturePoint currentCapturePoint;
    local float fOvertimeDuration;

    m_bPointContested = false;
    ClearTimer('PointContested');
    currentCapturePoint = GetCurrentCapturePoint();
    // End:0x8B
    if(currentCapturePoint != none)
    {
        currentCapturePoint.m_fTF1TouchedPointTimer = 0.0000000;
        currentCapturePoint.m_fTF2TouchedPointTimer = 0.0000000;
    }
    m_bPointCaptureOvertime = true;
    fOvertimeDuration = GetOvertimeDuration();
    SetTimer(fOvertimeDuration, false, 'PointOvertimeEnd');
    GRI = TgRepInfo_Game(GameReplicationInfo);
    // End:0x178
    if(GRI != none)
    {
        GRI.r_bCapturePointOvertime = true;
        GRI.r_fCapturePointOvertimeStartDuration = GetOvertimeDuration();
        GRI.r_nCapturePointOvertimeStateChange++;
        GRI.bNetDirty = true;
    }
    //return;    
}

function RestartPointOvertime()
{
    local TgRepInfo_Game GRI;

    m_bPointCaptureOvertime = true;
    SetTimer(GetOvertimeDuration(), false, 'PointOvertimeEnd');
    GRI = TgRepInfo_Game(GameReplicationInfo);
    // End:0xDA
    if(GRI != none)
    {
        GRI.r_bCapturePointOvertime = true;
        GRI.r_fCapturePointOvertimeStartDuration = GetOvertimeDuration();
        GRI.r_nCapturePointOvertimeStateChange++;
        GRI.bNetDirty = true;
    }
    //return;    
}

function PointOvertimeEnd()
{
    local TgRepInfo_Game GRI;

    m_bPointCaptureOvertime = false;
    GRI = TgRepInfo_Game(GameReplicationInfo);
    // End:0x99
    if(GRI != none)
    {
        GRI.r_bCapturePointOvertime = false;
        GRI.r_nCapturePointOvertimeStateChange++;
        GRI.bNetDirty = true;
    }
    //return;    
}

function TgChaosCapturePoint GetCurrentCapturePoint()
{
    // End:0x6B
    if(!IsInState(m_AttackDefendState))
    {
        // End:0x61
        if((m_LastActiveCapturePoint == none) || m_LastActiveCapturePoint == m_CapturedPoint)
        {
            // End:0x5E
            if(m_CapturePointQueue.Length > 0)
            {
                return m_CapturePointQueue[s_nCurrentCapturePointQueueIndex];
            }            
        }
        else
        {
            return m_LastActiveCapturePoint;
        }
    }
    return m_CapturedPoint;
    //return ReturnValue;    
}

function bool ShouldHandlePointCaptureBacksliding()
{
    return m_fBackslideRate > 0.0000000;
    //return ReturnValue;    
}

function BackslideDelayTF1()
{
    m_bTF1Backsliding = true;
    //return;    
}

function BackslideDelayTF2()
{
    m_bTF2Backsliding = true;
    //return;    
}

function ManageCapturePointScore()
{
    local TgRepInfo_TaskForce Taskforce;
    local array<TgChaosCapturePoint> CapturePoints;
    local TgChaosCapturePoint capturePoint;
    local int I;

    // End:0x56
    if(m_bActivateAllCapturePoints)
    {
        // End:0x52
        foreach WorldInfo.DynamicActors(Class'TgGame.TgChaosCapturePoint', capturePoint)
        {
            CapturePoints.AddItem(capturePoint);            
        }                
    }
    else
    {
        CapturePoints.AddItem(GetCurrentCapturePoint());
    }
    I = 0;
    J0x78:

    // End:0x40B [Loop If]
    if(I < CapturePoints.Length)
    {
        capturePoint = CapturePoints[I];
        // End:0x3FD
        if(capturePoint != none)
        {
            capturePoint.UpdateOccupationStatus();
            // End:0x3FD
            if(ShouldHandlePointCaptureBacksliding())
            {
                // End:0x146
                if(capturePoint.m_nNumTF1OnPoint > 0)
                {
                    m_bTF1Backsliding = false;
                    // End:0x143
                    if(IsTimerActive('BackslideDelayTF1'))
                    {
                        ClearTimer('BackslideDelayTF1');
                    }                    
                }
                else
                {
                    // End:0x242
                    if(m_bTF1Backsliding)
                    {
                        Taskforce = TgRepInfo_Game(GameReplicationInfo).GetTaskForce(1);
                        // End:0x23F
                        if(Taskforce != none)
                        {
                            // End:0x23F
                            if((Taskforce.r_fSecondaryScore > m_fBackslidePercent) && Taskforce.r_fSecondaryScore < 100.0000000)
                            {
                                Taskforce.r_fSecondaryScore = FMax(Taskforce.r_fSecondaryScore - m_fBackslideRate, m_fBackslidePercent);
                            }
                        }                        
                    }
                    else
                    {
                        // End:0x272
                        if(!IsTimerActive('BackslideDelayTF1'))
                        {
                            SetTimer(m_fBackslideDelay, false, 'BackslideDelayTF1');
                        }
                    }
                }
                // End:0x2D0
                if(capturePoint.m_nNumTF2OnPoint > 0)
                {
                    m_bTF2Backsliding = false;
                    // End:0x2CD
                    if(IsTimerActive('BackslideDelayTF2'))
                    {
                        ClearTimer('BackslideDelayTF2');
                    }                    
                }
                else
                {
                    // End:0x3CD
                    if(m_bTF2Backsliding)
                    {
                        Taskforce = TgRepInfo_Game(GameReplicationInfo).GetTaskForce(2);
                        // End:0x3CA
                        if(Taskforce != none)
                        {
                            // End:0x3CA
                            if((Taskforce.r_fSecondaryScore > m_fBackslidePercent) && Taskforce.r_fSecondaryScore < 100.0000000)
                            {
                                Taskforce.r_fSecondaryScore = FMax(Taskforce.r_fSecondaryScore - m_fBackslideRate, m_fBackslidePercent);
                            }
                        }                        
                    }
                    else
                    {
                        // End:0x3FD
                        if(!IsTimerActive('BackslideDelayTF2'))
                        {
                            SetTimer(m_fBackslideDelay, false, 'BackslideDelayTF2');
                        }
                    }
                }
            }
        }
        I++;
        // [Loop Continue]
        goto J0x78;
    }
    //return;    
}

function CheckAwardObjectiveScore(byte TaskForceNum, TgChaosCapturePoint capturePoint, int NumOnPoint, int NumContested)
{
    local TgRepInfo_TaskForce Taskforce;
    local TgPawn_Character TgP;
    local float ScoreAmount;
    local TgRepInfo_Game GRI;
    local int I;

    GRI = TgRepInfo_Game(WorldInfo.GRI);
    // End:0xD0
    if(((((int(m_GameWinState) != int(0)) || GRI == none) || int(TaskForceNum) == int(0)) || (int(GRI.r_GameMode) == int(1)) && !m_bCanCaptureDuringSurvival) || !GRI.r_bSpawnGatesOpen)
    {
        return;
    }
    // End:0xE9
    if(NumContested > 0)
    {
        ContestPoint();
    }
    // End:0x102
    if(IsTimerActive('PointOvertimeEnd'))
    {
        return;
    }
    // End:0x4AE
    if((capturePoint.m_nTaskForce == 0) || capturePoint.m_nTaskForce == int(TaskForceNum))
    {
        Taskforce = TgRepInfo_Game(GameReplicationInfo).GetTaskForce(int(TaskForceNum));
        // End:0x485
        if(Taskforce != none)
        {
            // End:0x3B2
            if(NumContested == 0)
            {
                TgRepInfo_Game(GameReplicationInfo).r_CapturingTaskForce = Taskforce;
                ScoreAmount = 0.0000000;
                switch(NumOnPoint)
                {
                    // End:0x234
                    case 0:
                        TgRepInfo_Game(GameReplicationInfo).r_CapturingTaskForce = none;
                        return;
                    // End:0x24E
                    case 1:
                        ScoreAmount = m_fCapturePointsPerSecond1;
                        // End:0x2BD
                        break;
                    // End:0x269
                    case 2:
                        ScoreAmount = m_fCapturePointsPerSecond2;
                        // End:0x2BD
                        break;
                    // End:0x284
                    case 3:
                        ScoreAmount = m_fCapturePointsPerSecond3;
                        // End:0x2BD
                        break;
                    // End:0x29F
                    case 4:
                        ScoreAmount = m_fCapturePointsPerSecond4;
                        // End:0x2BD
                        break;
                    // End:0x2BA
                    case 5:
                        ScoreAmount = m_fCapturePointsPerSecond5;
                        // End:0x2BD
                        break;
                    // End:0xFFFF
                    default:
                        break;
                }
                ScoreAmount *= (GetPointCaptureScoreMultiplier(int(TaskForceNum)));
                Taskforce.r_fSecondaryScore = FMin(m_fSecondaryGoalScore, Taskforce.r_fSecondaryScore + ScoreAmount);
                // End:0x3AF
                if((Taskforce.r_fSecondaryScore >= m_fSecondaryGoalScore) && ShouldGoIntoOvertimeOnPointCapture(int(TaskForceNum)))
                {
                    Taskforce.r_fSecondaryScore = m_fSecondaryGoalScore - 1.0000000;
                    BeginPointOvertime();
                }                
            }
            else
            {
                TgRepInfo_Game(GameReplicationInfo).r_CapturingTaskForce = none;
            }
            I = 0;
            J0x3E6:

            // End:0x46F [Loop If]
            if(I < capturePoint.m_TouchingChampions.Length)
            {
                TgP = capturePoint.m_TouchingChampions[I];
                ScoreObjectiveHold(TgP, NumContested);
                I++;
                // [Loop Continue]
                goto J0x3E6;
            }
            CheckCorePower(capturePoint);            
        }
        else
        {
            TgRepInfo_Game(GameReplicationInfo).r_CapturingTaskForce = none;
        }
    }
    //return;    
}

function bool CapturePointContestDurationEnabled()
{
    return m_bCapturePointContestDurationEnabled;
    //return ReturnValue;    
}

function bool ShouldGoIntoOvertimeOnPointCapture(int TaskForceNum)
{
    local TgChaosCapturePoint currentCapturePoint;

    // End:0xB5
    if(CapturePointContestDurationEnabled())
    {
        currentCapturePoint = GetCurrentCapturePoint();
        // End:0xAA
        if(currentCapturePoint != none)
        {
            // End:0x6E
            if((TaskForceNum == 1) && currentCapturePoint.m_fTF2TouchedPointTimer > 0.0000000)
            {
                return true;                
            }
            else
            {
                // End:0xAA
                if((TaskForceNum == 2) && currentCapturePoint.m_fTF1TouchedPointTimer > 0.0000000)
                {
                    return true;
                }
            }
        }
        return m_bPointContested;
    }
    return false;
    //return ReturnValue;    
}

event GoalReached()
{
    //return;    
}

function bool CanGoToObjectiveActiveState()
{
    local TgRepInfo_Game GRI;

    GRI = TgRepInfo_Game(GameReplicationInfo);
    return GRI.r_LanePusher == none;
    //return ReturnValue;    
}

function bool CanGoToObjectiveInactiveState()
{
    local TgRepInfo_Game GRI;

    GRI = TgRepInfo_Game(GameReplicationInfo);
    return GRI.r_LanePusher == none;
    //return ReturnValue;    
}

function UpdateObjectiveStates()
{
    local TgRepInfo_Game GRI;
    local TgObjective Objective;

    GRI = TgRepInfo_Game(GameReplicationInfo);
    // End:0x43
    if((int(m_eTimerState) != int(3)) || GRI == none)
    {
        return;
    }
    EnableUltWhenObjectiveStateUpdated();
    EnableCreditSpoolingWhenObjectiveStateUpdated();
    // End:0x183
    foreach WorldInfo.DynamicActors(Class'TgGame.TgObjective', Objective)
    {
        // End:0xD3
        if((int(Objective.r_eStatus) == int(2)) && CanGoToObjectiveActiveState())
        {
            SetCapturePointActive(Objective);
            // End:0x182
            continue;
        }
        // End:0x12B
        if(int(Objective.r_eStatus) != int(0))
        {
            Objective.SetStatus(0);
            UpdateAllPawnsMetaGameState();
            // End:0x182
            continue;
        }
        // End:0x182
        if(int(Objective.r_eStatus) == int(2))
        {
            // End:0x182
            if(CanGoToObjectiveInactiveState())
            {
                Objective.SetStatus(0);
            }
        }        
    }    
    //return;    
}

function EnableUltWhenObjectiveStateUpdated()
{
    local TgRepInfo_Game GRI;

    GRI = TgRepInfo_Game(GameReplicationInfo);
    // End:0x6D
    if(GRI != none)
    {
        GRI.r_bUltimatesLocked = false;
        GRI.bNetDirty = true;
    }
    //return;    
}

function EnableCreditSpoolingWhenObjectiveStateUpdated()
{
    m_bCanSpoolCredits = true;
    //return;    
}

function bool ShouldNextRoundBeASurvivalRound()
{
    return false;
    //return ReturnValue;    
}

function SetCapturePointActive(TgObjective Objective)
{
    local TgChaosCapturePoint CaptureObjective;

    CaptureObjective = TgChaosCapturePoint(Objective);
    // End:0x68
    if((ShouldNextRoundBeASurvivalRound()) || (CaptureObjective != none) && CaptureObjective.m_bForceSurvival)
    {
        BeginPlayConverge();
    }
    Objective.SetStatus(1);
    m_LastActiveCapturePoint = TgChaosCapturePoint(Objective);
    UpdateAllPawnsMetaGameState(2);
    //return;    
}

function int GetNextSpawnTableId()
{
    return 215;
    //return ReturnValue;    
}

function PickNextObjective()
{
    local array<TgChaosCapturePoint> CapPoints;
    local TgChaosCapturePoint capturePoint;

    // End:0x85
    if(m_bActivateAllCapturePoints)
    {
        // End:0x81
        foreach WorldInfo.DynamicActors(Class'TgGame.TgChaosCapturePoint', capturePoint)
        {
            // End:0x80
            if(capturePoint.m_nTaskForce == 0)
            {
                capturePoint.SetStatus(2);
            }            
        }                
    }
    else
    {
        // End:0xEE
        foreach WorldInfo.DynamicActors(Class'TgGame.TgChaosCapturePoint', capturePoint)
        {
            // End:0xED
            if(capturePoint.m_nTaskForce == 0)
            {
                CapPoints.AddItem(capturePoint);
            }            
        }        
        // End:0x125
        if(CapPoints.Length == 1)
        {
            CapPoints[0].SetStatus(2);            
        }
        else
        {
            // End:0x17C
            if((m_nForcedObjectiveIndex >= 0) && m_nForcedObjectiveIndex < CapPoints.Length)
            {
                CapPoints[m_nForcedObjectiveIndex].SetStatus(2);                
            }
            else
            {
                // End:0x226
                if(m_CapturePointQueue.Length == 0)
                {
                    // End:0x1C9
                    foreach CapPoints(capturePoint)
                    {
                        m_CapturePointQueue.InsertItem(Rand(m_CapturePointQueue.Length + 1), capturePoint);                        
                    }                    
                    // End:0x21B
                    if(m_CapturePointQueue[0] == m_LastActiveCapturePoint)
                    {
                        m_CapturePointQueue.InsertItem(Rand(m_CapturePointQueue.Length - 1) + 2, m_CapturePointQueue[0]);
                        m_CapturePointQueue.Remove(0, 1);
                    }
                    s_nCurrentCapturePointQueueIndex = 0;
                }
                m_CapturePointQueue[s_nCurrentCapturePointQueueIndex].SetStatus(2);
                s_nCurrentActivePointIndex = m_CapturePointQueue.Find(m_CapturePointQueue[s_nCurrentCapturePointQueueIndex]);
                // End:0x2B8
                if(!m_bKeepThisPointForNextRound)
                {
                    s_nCurrentCapturePointQueueIndex++;
                    // End:0x2B8
                    if(s_nCurrentCapturePointQueueIndex >= m_CapturePointQueue.Length)
                    {
                        s_nCurrentCapturePointQueueIndex = 0;
                    }
                }
            }
        }
    }
    UpdateObjectiveStates();
    // End:0x2DF
    if(m_fObjectiveRepickTickets < 1.0000000)
    {
        EndBroadcastTimer();
    }
    //return;    
}

function PreFillCapturePointQueue()
{
    local array<TgChaosCapturePoint> CapPoints;
    local TgChaosCapturePoint capturePoint;

    // End:0x69
    foreach WorldInfo.DynamicActors(Class'TgGame.TgChaosCapturePoint', capturePoint)
    {
        // End:0x68
        if(capturePoint.m_nTaskForce == 0)
        {
            CapPoints.AddItem(capturePoint);
        }        
    }    
    // End:0xAA
    if((CapPoints.Length == 1) || (m_nForcedObjectiveIndex >= 0) && m_nForcedObjectiveIndex < CapPoints.Length)
    {
        return;        
    }
    else
    {
        // End:0x154
        if(m_CapturePointQueue.Length == 0)
        {
            // End:0xF7
            foreach CapPoints(capturePoint)
            {
                m_CapturePointQueue.InsertItem(Rand(m_CapturePointQueue.Length + 1), capturePoint);                
            }            
            // End:0x149
            if(m_CapturePointQueue[0] == m_LastActiveCapturePoint)
            {
                m_CapturePointQueue.InsertItem(Rand(m_CapturePointQueue.Length - 1) + 2, m_CapturePointQueue[0]);
                m_CapturePointQueue.Remove(0, 1);
            }
            s_nCurrentCapturePointQueueIndex = 0;
        }
    }
    //return;    
}

function PointCaptured(int nTaskForce, optional bool bSuppressPointsForCapture)
{
    //return;    
}

function OpenSpawnGates()
{
    local TgRepInfo_Game GRI;
    local TgSpawnGate SpawnGate;
    local TgPlayerController TgPC;
    local TgPawn TgP;
    local TgRepInfo_TaskForce TF1, TF2;

    m_bCanSpoolCredits = true;
    TriggerGlobalEventClass(Class'TgGame.TgSeqEvent_SpawnGateDeactivate', self);
    // End:0x6F
    foreach WorldInfo.DynamicActors(Class'TgGame.TgSpawnGate', SpawnGate)
    {
        SpawnGate.Deactivate();        
    }    
    // End:0x11B
    foreach WorldInfo.AllControllers(Class'TgGame.TgPlayerController', TgPC)
    {
        TgPC.ClientDeactivateSpawnGates();
        TgP = TgPC.GetTgPawn();
        // End:0x11A
        if(TgP != none)
        {
            TgP.OnSpawnGatesOpened();
        }        
    }    
    GRI = TgRepInfo_Game(GameReplicationInfo);
    // End:0x2C4
    if(GRI != none)
    {
        GRI.r_bSpawnGatesOpenedAtLeastOnce = true;
        GRI.r_bUltimatesLocked = false;
        GRI.r_bSpawnGatesOpen = true;
        GRI.r_bKillCamEnabled = true;
        GRI.bNetDirty = true;
        TF1 = GRI.GetTaskForce(1);
        // End:0x257
        if((TF1 != none) && TF1.r_nScore <= 1)
        {
            SendStartRoundOnePointFromWinningAlert(1);
        }
        TF2 = GRI.GetTaskForce(2);
        // End:0x2C4
        if((TF2 != none) && TF2.r_nScore <= 1)
        {
            SendStartRoundOnePointFromWinningAlert(2);
        }
    }
    // End:0x2E6
    if(m_fRoundLimitDuration > float(0))
    {
        SendRoundLimitTimerNotify(1, 0.0000000);
    }
    //return;    
}

function CloseSpawnGates()
{
    local TgRepInfo_Game GRI;
    local TgSpawnGate SpawnGate;
    local TgPlayerController TgPC;

    // End:0x4E
    foreach WorldInfo.DynamicActors(Class'TgGame.TgSpawnGate', SpawnGate)
    {
        SpawnGate.Activate();        
    }    
    // End:0xA3
    foreach WorldInfo.AllControllers(Class'TgGame.TgPlayerController', TgPC)
    {
        TgPC.ClientActivateSpawnGates();        
    }    
    GRI = TgRepInfo_Game(GameReplicationInfo);
    // End:0x1B6
    if(GRI != none)
    {
        GRI.r_bSpawnGatesOpen = false;
        GRI.r_bAttackersSpawnGatesOpen = false;
        GRI.r_bDefendersSpawnGatesOpen = false;
        GRI.r_bKillCamEnabled = false;
        GRI.r_bAttackersKillCamEnabled = false;
        GRI.r_bDefendersKillCamEnabled = false;
        GRI.bNetDirty = true;
    }
    TriggerGlobalEventClass(Class'TgGame.TgSeqEvent_SpawnGateActivate', self);
    //return;    
}

function PayloadCheckpointReached(TgSplineActor_Payload Checkpoint)
{
    //return;    
}

function EndPreRoundSetup()
{
    //return;    
}

function StartBroadcastTimer()
{
    ClearTimer('StartBroadcastTimer');
    BroadcastTimer();
    SetTimer(1.0000000, true, 'BroadcastTimer');
    //return;    
}

function EndBroadcastTimer()
{
    ClearTimer('BroadcastTimer');
    //return;    
}

function BroadcastTimer()
{
    local TgPlayerController TgPC;
    local float TimeRemaining;

    TimeRemaining = GetTimerRate('PickNextObjective') - GetTimerCount('PickNextObjective');
    // End:0xAE
    if(IsTimerActive('PickNextObjective'))
    {
        // End:0xAD
        foreach WorldInfo.AllControllers(Class'TgGame.TgPlayerController', TgPC)
        {
            TgPC.ClientUpdateRoundSetupTimer(TimeRemaining + float(1));            
        }        
    }
    CaptureSpawnAlert(TimeRemaining);
    //return;    
}

function float GetPickNextObjectiveTime()
{
    return m_fSetupObjectivePickTime;
    //return ReturnValue;    
}

function float GetSpawnGateOpenTime()
{
    // End:0x1E
    if(m_fSetupSpawnGateOpenTime <= 0.0000000)
    {
        return GetPickNextObjectiveTime();
    }
    return m_fSetupSpawnGateOpenTime;
    //return ReturnValue;    
}

function StartStasisTimer()
{
    local TgPawn TgP;

    // End:0x0F
    if(m_bStasisTimerOn)
    {
        return;
    }
    m_bStasisTimerOn = true;
    // End:0x73
    foreach WorldInfo.AllPawns(Class'TgGame.TgPawn', TgP)
    {
        TgP.r_bIsInStasis = true;        
    }    
    //return;    
}

function EndStasisTimer()
{
    local TgPawn TgP;

    // End:0x11
    if(!m_bStasisTimerOn)
    {
        return;
    }
    m_bStasisTimerOn = false;
    // End:0x75
    foreach WorldInfo.AllPawns(Class'TgGame.TgPawn', TgP)
    {
        TgP.r_bIsInStasis = false;        
    }    
    //return;    
}

event OnBotDied(TgAIController TgAIC)
{
    local TgPawn_SiegeWall SiegeWall;
    local TgPawn_LanePusher SiegeMachine;
    local TgRepInfo_Game GRI;
    local TgPawn_Character TgP;
    local TgPlayerController TgPC;
    local int nDestroyedTF;
    local float fPercent, ModifiedHealth;

    // End:0x37
    if((TgAIC == none) || TgAIC.Pawn == none)
    {
        return;
    }
    fPercent = 0.0500000;
    SiegeWall = TgPawn_SiegeWall(TgAIC.Pawn);
    // End:0x396
    if(SiegeWall != none)
    {
        nDestroyedTF = int(SiegeWall.GetTaskForceNumber());
        // End:0x1BB
        if(nDestroyedTF > 0)
        {
            // End:0x1BA
            foreach WorldInfo.AllControllers(Class'TgGame.TgPlayerController', TgPC)
            {
                // End:0x125
                if(TgPC.GetTaskForceNumber() == nDestroyedTF)
                {
                    continue;                    
                }
                TgP = TgPawn_Character(TgPC.Pawn);
                // End:0x169
                if(TgP == none)
                {
                    continue;                    
                }
                // End:0x195
                if(TgP.m_fWallDamagePercent > fPercent)
                {
                }
                TgP.m_fWallDamagePercent = 0.0000000;                
            }            
        }
        KillSiegeWallTowers(nDestroyedTF);
        // End:0x21E
        if(SiegeWall.IsA('TgPawn_SiegeWall_Outer'))
        {
            OpenOuterGates(SiegeWall.GetTaskForceNumber(), true);            
        }
        else
        {
            // End:0x26B
            if(SiegeWall.IsA('TgPawn_SiegeWall_Inner'))
            {
                OpenInnerGates(SiegeWall.GetTaskForceNumber(), true);
            }
        }
        // End:0x396
        if(KillLanePusherWhenGateIsDestroyed())
        {
            GRI = TgRepInfo_Game(GameReplicationInfo);
            // End:0x396
            if(((GRI != none) && GRI.r_LanePusher != none) && TgAIC.IsEnemy(GRI.r_LanePusher))
            {
                ModifiedHealth = FMax(GRI.r_LanePusher.GetHealth() / 2.0000000, 1.0000000);
                GRI.r_LanePusher.SetProperty(19, ModifiedHealth);
            }
        }
    }
    nDestroyedTF = 0;
    SiegeMachine = TgPawn_LanePusher(TgAIC.Pawn);
    // End:0x40C
    if(SiegeMachine != none)
    {
        nDestroyedTF = int(SiegeMachine.GetTaskForceNumber());
    }
    // End:0x516
    if(nDestroyedTF > 0)
    {
        // End:0x515
        foreach WorldInfo.AllControllers(Class'TgGame.TgPlayerController', TgPC)
        {
            // End:0x480
            if(TgPC.GetTaskForceNumber() == nDestroyedTF)
            {
                continue;                
            }
            TgP = TgPawn_Character(TgPC.Pawn);
            // End:0x4C4
            if(TgP == none)
            {
                continue;                
            }
            // End:0x4F0
            if(TgP.m_fSiegeDamagePercent > fPercent)
            {
            }
            TgP.m_fSiegeDamagePercent = 0.0000000;            
        }        
    }
    //return;    
}

function KillSiegeWallTowers(int nTaskForce)
{
    local TgPawn_Tower_FA Tower;
    local array<TgPawn_Tower_FA> InnerTowers;
    local bool bDestroyedOuterTower;
    local int I;

    // End:0x120
    foreach WorldInfo.AllPawns(Class'TgGame.TgPawn_Tower_FA', Tower)
    {
        // End:0x11F
        if((int(Tower.GetTaskForceNumber()) == nTaskForce) && Tower.IsAliveAndWell())
        {
            // End:0xE0
            if(int(Tower.m_TowerType) == int(2))
            {
                Tower.Suicide();
                bDestroyedOuterTower = true;
                // End:0x11F
                continue;
            }
            // End:0x11F
            if(int(Tower.m_TowerType) == int(1))
            {
                InnerTowers.AddItem(Tower);
            }
        }        
    }    
    // End:0x19A
    if(!bDestroyedOuterTower)
    {
        // End:0x19A
        if(InnerTowers.Length > 0)
        {
            I = 0;
            J0x14B:

            // End:0x19A [Loop If]
            if(I < InnerTowers.Length)
            {
                InnerTowers[I].Suicide();
                I++;
                // [Loop Continue]
                goto J0x14B;
            }
        }
    }
    //return;    
}

function ConsoleEvent(name EventName)
{
    local array<SequenceObject> AllConsoleEvents;
    local SeqEvent_Console ConsoleEvt;
    local Sequence GameSeq;
    local int Idx;

    GameSeq = WorldInfo.GetGameSequence();
    // End:0x13B
    if((GameSeq != none) && EventName != 'None')
    {
        GameSeq.FindSeqObjectsByClass(Class'Engine.SeqEvent_Console', true, AllConsoleEvents);
        Idx = 0;
        J0x8E:

        // End:0x13B [Loop If]
        if(Idx < AllConsoleEvents.Length)
        {
            ConsoleEvt = SeqEvent_Console(AllConsoleEvents[Idx]);
            // End:0x12D
            if((ConsoleEvt != none) && EventName == ConsoleEvt.ConsoleEventName)
            {
                ConsoleEvt.CheckActivate(self, self);
            }
            Idx++;
            // [Loop Continue]
            goto J0x8E;
        }
    }
    //return;    
}

function OpenInnerGates(byte TaskForceNum, bool bOpen)
{
    // End:0xB0
    if(int(TaskForceNum) == int(1))
    {
        ((bOpen) ? ConsoleEvent('TF1_DoorInner_Open') : ConsoleEvent('TF1_DoorInner_Close'));
        // End:0xAD
        if((m_TF1InnerWall != none) && m_TF1InnerWall.IsAliveAndWell())
        {
            m_TF1InnerWall.SetCollision(!bOpen, !bOpen);
        }        
    }
    else
    {
        // End:0x15D
        if(int(TaskForceNum) == int(2))
        {
            ((bOpen) ? ConsoleEvent('TF2_DoorInner_Open') : ConsoleEvent('TF2_DoorInner_Close'));
            // End:0x15D
            if((m_TF2InnerWall != none) && m_TF2InnerWall.IsAliveAndWell())
            {
                m_TF2InnerWall.SetCollision(!bOpen, !bOpen);
            }
        }
    }
    //return;    
}

function OpenOuterGates(byte TaskForceNum, bool bOpen)
{
    // End:0xB0
    if(int(TaskForceNum) == int(1))
    {
        ((bOpen) ? ConsoleEvent('TF1_DoorOuter_Open') : ConsoleEvent('TF1_DoorOuter_Close'));
        // End:0xAD
        if((m_TF1OuterWall != none) && m_TF1OuterWall.IsAliveAndWell())
        {
            m_TF1OuterWall.SetCollision(!bOpen, !bOpen);
        }        
    }
    else
    {
        // End:0x15D
        if(int(TaskForceNum) == int(2))
        {
            ((bOpen) ? ConsoleEvent('TF2_DoorOuter_Open') : ConsoleEvent('TF2_DoorOuter_Close'));
            // End:0x15D
            if((m_TF2OuterWall != none) && m_TF2OuterWall.IsAliveAndWell())
            {
                m_TF2OuterWall.SetCollision(!bOpen, !bOpen);
            }
        }
    }
    //return;    
}

function OpenAllAliveGates(bool bOpen)
{
    local TgRepInfo_Game GRI;
    local TgPawn_SiegeWall SiegeWall;

    GRI = TgRepInfo_Game(WorldInfo.GRI);
    // End:0x348
    foreach WorldInfo.AllPawns(Class'TgGame.TgPawn_SiegeWall', SiegeWall)
    {
        // End:0x347
        if(SiegeWall.IsAliveAndWell())
        {
            // End:0x158
            if(SiegeWall.IsA('TgPawn_SiegeWall_Inner'))
            {
                // End:0x102
                if(int(SiegeWall.GetTaskForceNumber()) == int(1))
                {
                    m_TF1InnerWall = SiegeWall;
                    OpenInnerGates(1, bOpen);                    
                }
                else
                {
                    // End:0x155
                    if(int(SiegeWall.GetTaskForceNumber()) == int(2))
                    {
                        m_TF2InnerWall = SiegeWall;
                        OpenInnerGates(2, bOpen);
                    }
                }
                // End:0x347
                continue;
            }
            // End:0x251
            if(SiegeWall.IsA('TgPawn_SiegeWall_Outer'))
            {
                // End:0x1FB
                if(int(SiegeWall.GetTaskForceNumber()) == int(1))
                {
                    m_TF1OuterWall = SiegeWall;
                    OpenOuterGates(1, bOpen);
                    GRI.r_pSiegeWallTF1[0] = SiegeWall;                    
                }
                else
                {
                    // End:0x24E
                    if(int(SiegeWall.GetTaskForceNumber()) == int(2))
                    {
                        m_TF2OuterWall = SiegeWall;
                        OpenOuterGates(2, bOpen);
                    }
                }
                // End:0x347
                continue;
            }
            // End:0x347
            if(SiegeWall.IsA('TgPawn_SiegeWall_Base'))
            {
                // End:0x2DF
                if(int(SiegeWall.GetTaskForceNumber()) == int(1))
                {
                    m_TF1BaseObjective = SiegeWall;
                    GRI.r_pSiegeWallTF1[2] = SiegeWall;
                    // End:0x347
                    continue;
                }
                // End:0x347
                if(int(SiegeWall.GetTaskForceNumber()) == int(2))
                {
                    m_TF2BaseObjective = SiegeWall;
                    GRI.r_pSiegeWallTF2[2] = SiegeWall;
                }
            }
        }        
    }    
    GRI.bNetDirty = true;
    //return;    
}

function GlobalRespawnTimeUpdate(float fRespawnTime, bool bEnsureRespawnTimeDoesntIncrease)
{
    local TgPlayerController TgPC;
    local TgAIController_BehaviorGod TgAI;
    local TgPawn TgP;

    // End:0x95
    foreach WorldInfo.AllControllers(Class'TgGame.TgPlayerController', TgPC)
    {
        TgP = TgPawn(TgPC.Pawn);
        GlobalRespawnTimeUpdateHelper(TgPC, TgP, fRespawnTime, bEnsureRespawnTimeDoesntIncrease);        
    }    
    // End:0x12B
    foreach WorldInfo.AllControllers(Class'TgGame.TgAIController_BehaviorGod', TgAI)
    {
        TgP = TgPawn(TgAI.Pawn);
        GlobalRespawnTimeUpdateHelper(TgAI, TgP, fRespawnTime, bEnsureRespawnTimeDoesntIncrease);        
    }    
    //return;    
}

function GlobalRespawnTimeUpdateHelper(Controller C, TgPawn TgP, float fRespawnTime, bool bEnsureRespawnTimeDoesntIncrease)
{
    local float fCurrentTimeToSpawn;

    // End:0x147
    if((TgP != none) && TgP.IsGod())
    {
        // End:0x147
        if(!TgP.IsAliveAndWell())
        {
            fCurrentTimeToSpawn = TgP.GetTimerRate('Revive') - TgP.GetTimerCount('Revive');
            // End:0x147
            if(!bEnsureRespawnTimeDoesntIncrease || fCurrentTimeToSpawn > fRespawnTime)
            {
                // End:0x11F
                if(fRespawnTime > 0.0000000)
                {
                    C.SetTimer(fRespawnTime, false, 'Revive');                    
                }
                else
                {
                    C.SetTimer(0.1000000, false, 'Revive');
                }
            }
        }
    }
    //return;    
}

event RespawnAllPlayers(bool bResetLivingPlayers, optional bool bResetDeadPlayers = true, optional bool bResetHealth = true, optional bool bResetDevices = false)
{
    local Controller TheController;
    local TgPaladinsController TgPC;
    local TgPawn TgP;
    local bool bAlive;
    local int I;

    // End:0x263
    foreach WorldInfo.AllControllers(Class'Engine.Controller', TheController)
    {
        TgPC = TgPaladinsController(TheController);
        // End:0x262
        if(NotEqual_InterfaceInterface(TgPC, TgPaladinsController(none)))
        {
            TgP = TgPC.GetTgPawn();
            // End:0x262
            if((TgP != none) && TgP.IsGod())
            {
                bAlive = TgP.IsAliveAndWell();
                // End:0x159
                if(bResetLivingPlayers && bAlive)
                {
                    TgPC.LiveRespawn(bResetHealth, bResetDevices);                    
                }
                else
                {
                    // End:0x239
                    if(bResetDeadPlayers && !bAlive)
                    {
                        // End:0x219
                        if(bResetDevices)
                        {
                            I = 1;
                            J0x18F:

                            // End:0x219 [Loop If]
                            if(I < 33)
                            {
                                // End:0x20B
                                if(TgP.m_EquippedDevices[I] != none)
                                {
                                    TgP.m_EquippedDevices[I].EndCooldown();
                                }
                                I++;
                                // [Loop Continue]
                                goto J0x18F;
                            }
                        }
                        TgPC.Revive();
                    }
                }
                TgP.KillAllOwnedPets();
                KillAllProjectiles();
            }
        }        
    }    
    //return;    
}

function ResetAllPlayersNotInSpawnRoom()
{
    ResetPlayersNotInSpawnRoom(true, true);
    //return;    
}

function ResetAttackersNotInSpawnRoom()
{
    ResetPlayersNotInSpawnRoom(true, false);
    //return;    
}

function ResetDefendersNotInSpawnRoom()
{
    ResetPlayersNotInSpawnRoom(false, true);
    //return;    
}

function ResetPlayersNotInSpawnRoom(bool bResetAttackers, bool bResetDefenders)
{
    local TgPawn TgP;
    local TgPlayerController TgPC;
    local TgAIController_BehaviorGod TgAI;
    local int AttackingTaskForceNum;

    // End:0x11
    if(!m_bResetPlayersNotInSpawnRoom)
    {
        return;
    }
    // End:0x20
    if(m_bResetPlayersNotInSpawnRoomDisabled)
    {
        return;
    }
    AttackingTaskForceNum = -1;
    // End:0xBF
    if((TgRepInfo_Game(GameReplicationInfo) != none) && TgRepInfo_Game(GameReplicationInfo).r_AttackingTaskForce != none)
    {
        AttackingTaskForceNum = int(TgRepInfo_Game(GameReplicationInfo).r_AttackingTaskForce.GetTeamNum());
    }
    // End:0x262
    foreach WorldInfo.AllControllers(Class'TgGame.TgPlayerController', TgPC)
    {
        // End:0x261
        if((bResetAttackers && TgPC.GetTaskForceNumber() == AttackingTaskForceNum) || bResetDefenders && TgPC.GetTaskForceNumber() != AttackingTaskForceNum)
        {
            TgP = TgPawn(TgPC.Pawn);
            // End:0x261
            if((TgP != none) && !TgP.IsInItemShop())
            {
                // End:0x219
                if(TgP.IsAliveAndWell())
                {
                    TgPC.LiveRespawn(false, false);                    
                }
                else
                {
                    TgPC.Revive();
                }
                TgP.KillAllOwnedPets();
                KillAllProjectiles();
            }
        }        
    }    
    // End:0x406
    foreach WorldInfo.AllControllers(Class'TgGame.TgAIController_BehaviorGod', TgAI)
    {
        // End:0x405
        if((bResetAttackers && TgAI.GetTaskForceNumber() == AttackingTaskForceNum) || bResetDefenders && TgAI.GetTaskForceNumber() != AttackingTaskForceNum)
        {
            TgP = TgPawn(TgAI.Pawn);
            // End:0x405
            if((TgP != none) && !TgP.IsInItemShop())
            {
                // End:0x3BD
                if(TgP.IsAliveAndWell())
                {
                    TgAI.LiveRespawn(false, false);                    
                }
                else
                {
                    TgPC.Revive();
                }
                TgP.KillAllOwnedPets();
                KillAllProjectiles();
            }
        }        
    }    
    //return;    
}

function KillAllProjectiles()
{
    local TgRepInfo_Game GRI;
    local TgProjectile Proj;

    GRI = TgRepInfo_Game(GameReplicationInfo);
    // End:0x78
    if(GRI != none)
    {
        // End:0x77
        foreach GRI.m_Projectiles(Proj)
        {
            Proj.ShutDown();            
        }        
    }
    //return;    
}

function RemoveAllBurnCards()
{
    local TgPlayerController TgPC;
    local TgAIController_BehaviorGod TgAI;
    local TgPawn TgP;

    // End:0x103
    foreach WorldInfo.AllControllers(Class'TgGame.TgPlayerController', TgPC)
    {
        TgP = TgPawn(TgPC.Pawn);
        // End:0x102
        if((TgP != none) && TgP.IsGod())
        {
            // End:0x102
            if(TgInventoryManager_Player(TgP.InvManager) != none)
            {
                TgInventoryManager_Player(TgP.InvManager).RemoveBurnCards();
            }
        }        
    }    
    // End:0x207
    foreach WorldInfo.AllControllers(Class'TgGame.TgAIController_BehaviorGod', TgAI)
    {
        TgP = TgPawn(TgAI.Pawn);
        // End:0x206
        if((TgP != none) && TgP.IsGod())
        {
            // End:0x206
            if(TgInventoryManager_Player(TgP.InvManager) != none)
            {
                TgInventoryManager_Player(TgP.InvManager).RemoveBurnCards();
            }
        }        
    }    
    //return;    
}

function PlayLanePusherHelpText()
{
    local TgPlayerController TgPC;
    local TgRepInfo_Game GRI;

    GRI = TgRepInfo_Game(GameReplicationInfo);
    // End:0x53
    if((GRI == none) || GRI.r_LanePusher == none)
    {
        return;
    }
    // End:0x107
    foreach WorldInfo.AllControllers(Class'TgGame.TgPlayerController', TgPC)
    {
        TgPC.ClientRequestHelpText(((TgPC.GetTaskForceNumber() == int(GRI.r_LanePusher.GetTaskForceNumber())) ? 113 : 114));        
    }    
    //return;    
}

event LanePusherReachedOuterWall(TgPawn_LanePusher LanePusher)
{
    //return;    
}

event LanePusherReachedInnerWall(TgPawn_LanePusher LanePusher)
{
    //return;    
}

event LanePusherReachedBaseObjective(TgPawn_LanePusher LanePusher)
{
    //return;    
}

function RevivePlayers(optional TgRepInfo_TaskForce ReviveTF)
{
    local TgPlayerController TgPC;
    local TgPawn TgP;

    // End:0x138
    foreach WorldInfo.AllControllers(Class'TgGame.TgPlayerController', TgPC)
    {
        TgP = TgPawn(TgPC.Pawn);
        // End:0x137
        if((((TgP != none) && TgP.IsGod()) && !TgP.IsAliveAndWell()) && (ReviveTF == none) || int(TgP.GetTaskForceNumber()) == int(ReviveTF.r_nTaskForce))
        {
            TgPC.Revive();
        }        
    }    
    //return;    
}

function TransitionToNextRound()
{
    // End:0x78
    if(int(m_GameWinState) == int(0))
    {
        StartNewObjectiveRound(false);
        StartBroadcastTimer();
        // End:0x4A
        if(m_bRevivePlayersWhenSiegeEngineDies)
        {
            RevivePlayers(GetDefendingTaskForce());
        }
        ResetScores();
        UpdateAttackingTaskforceForRoundTransition();
        ChangeTimerState(3);
        GotoState('GameRunning');
    }
    //return;    
}

function UpdateAttackingTaskforceForRoundTransition()
{
    TgRepInfo_Game(GameReplicationInfo).UpdateAttackingTaskforce(none);
    //return;    
}

function ResetScores()
{
    local TgRepInfo_Game GRI;
    local TgRepInfo_TaskForce DefendingTaskforce;

    GRI = TgRepInfo_Game(GameReplicationInfo);
    // End:0xEF
    if(GRI != none)
    {
        // End:0x88
        if(GRI.r_AttackingTaskForce != none)
        {
            GRI.r_AttackingTaskForce.r_fSecondaryScore = 0.0000000;
        }
        DefendingTaskforce = GetDefendingTaskForce();
        // End:0xCF
        if(DefendingTaskforce != none)
        {
            DefendingTaskforce.r_fSecondaryScore = 0.0000000;
        }
        GRI.r_CapturingTaskForce = none;
    }
    //return;    
}

function GotoGameRunningState()
{
    // End:0x24
    if(int(m_eTimerState) <= int(2))
    {
        GotoState('PreRoundSetup');
        return;
    }
    super(TgGame).GotoGameRunningState();
    //return;    
}

event ChangeTimerState(TgObject.GameTimerState eTimerState)
{
    local TgRepInfo_Player pPRI;
    local TgAIController_BehaviorGodDisconnected TgDPC;
    local TgPlayerController TgPC;
    local TgObject.GameTimerState OldState;

    OldState = m_eTimerState;
    // End:0x30
    if(int(m_eTimerState) == int(eTimerState))
    {
        return;
    }
    super(TgGame_Battle).ChangeTimerState(eTimerState);
    // End:0x1B0
    if((int(eTimerState) != int(OldState)) && int(OldState) != int(6))
    {
        switch(m_eTimerState)
        {
            // End:0xA3
            case 1:
                CheckMercenaries();
                SpawnBots();
                // End:0x1B0
                break;
            // End:0x197
            case 2:
                // End:0xFD
                foreach WorldInfo.AllControllers(Class'TgGame.TgPlayerController', TgPC)
                {
                    TgPC.ClientOnRoundSetupStarted(true);                    
                }                
                // End:0x193
                foreach WorldInfo.AllControllers(Class'TgGame.TgAIController_BehaviorGodDisconnected', TgDPC)
                {
                    pPRI = TgRepInfo_Player(TgDPC.PlayerReplicationInfo);
                    // End:0x192
                    if(pPRI != none)
                    {
                        pPRI.DrawNewCards();
                    }                    
                }                
                // End:0x1B0
                break;
            // End:0x1AD
            case 3:
                GotoState('GameRunning');
                // End:0x1B0
                break;
            // End:0xFFFF
            default:
                break;
        }
    }
    else
    {
        //return;        
    }
}

function SendClientRoundObjectivesCompleted()
{
    local TgPlayerController TgPC;

    // End:0x73
    foreach WorldInfo.AllControllers(Class'TgGame.TgPlayerController', TgPC)
    {
        TgPC.ClientOnRoundObjectivesCompleted();
        TgPC.ServerSkipKillCam();        
    }    
    //return;    
}

function SendClientRoundEnded()
{
    local TgPlayerController TgPC;

    // End:0x54
    foreach WorldInfo.AllControllers(Class'TgGame.TgPlayerController', TgPC)
    {
        TgPC.ClientOnRoundEnded();        
    }    
    //return;    
}

function AutoMountPlayersOnTaskForce(optional int nTaskForceNum = -1, optional bool bInvertTaskForce = false)
{
    local TgPawn TgP;
    local TgPlayerController TgPC;
    local TgAIController_BehaviorGod TgAI;
    local TgDevice_Mount MountDevice;

    // End:0x191
    foreach WorldInfo.AllControllers(Class'TgGame.TgPlayerController', TgPC)
    {
        // End:0x190
        if(((nTaskForceNum < 0) || !bInvertTaskForce && TgPC.GetTaskForceNumber() == nTaskForceNum) || bInvertTaskForce && TgPC.GetTaskForceNumber() != nTaskForceNum)
        {
            TgP = TgPawn(TgPC.Pawn);
            // End:0x190
            if(TgP != none)
            {
                MountDevice = TgDevice_Mount(TgP.GetDeviceByEqPoint(23));
                // End:0x190
                if(MountDevice != none)
                {
                    MountDevice.SetAllowMountServerTimer();
                    MountDevice.ClientStartMount();
                }
            }
        }        
    }    
    // End:0x315
    foreach WorldInfo.AllControllers(Class'TgGame.TgAIController_BehaviorGod', TgAI)
    {
        // End:0x314
        if(((nTaskForceNum < 0) || !bInvertTaskForce && TgAI.GetTaskForceNumber() == nTaskForceNum) || bInvertTaskForce && TgAI.GetTaskForceNumber() != nTaskForceNum)
        {
            TgP = TgPawn(TgAI.Pawn);
            // End:0x314
            if(TgP != none)
            {
                MountDevice = TgDevice_Mount(TgP.GetDeviceByEqPoint(23));
                // End:0x314
                if(MountDevice != none)
                {
                    MountDevice.SetAllowMountServerTimer();
                    MountDevice.ClientStartMount();
                }
            }
        }        
    }    
    //return;    
}

function AutoMountAllPlayers()
{
    ResetPlayersNotInSpawnRoom(true, true);
    AutoMountPlayersOnTaskForce();
    //return;    
}

function AutoMountAttackers()
{
    local TgRepInfo_Game GRI;

    ResetPlayersNotInSpawnRoom(true, false);
    GRI = TgRepInfo_Game(GameReplicationInfo);
    // End:0x9E
    if((GRI != none) && GRI.r_AttackingTaskForce != none)
    {
        AutoMountPlayersOnTaskForce(int(GRI.r_AttackingTaskForce.GetTeamNum()));
    }
    //return;    
}

function AutoMountDefenders()
{
    local TgRepInfo_Game GRI;

    ResetPlayersNotInSpawnRoom(false, true);
    GRI = TgRepInfo_Game(GameReplicationInfo);
    // End:0x9E
    if((GRI != none) && GRI.r_AttackingTaskForce != none)
    {
        AutoMountPlayersOnTaskForce(int(GRI.r_AttackingTaskForce.GetTeamNum()), true);
    }
    //return;    
}

function StartNewObjectiveRound(bool bFirstRound)
{
    local TgRepInfo_Game GRI;
    local TgPlayerController TgPC;

    GRI = TgRepInfo_Game(GameReplicationInfo);
    SetTimer(GetPickNextObjectiveTime(), false, 'PickNextObjective');
    SetSpawnGateTimers(bFirstRound);
    SetResetEscapedPlayersTimers(bFirstRound);
    // End:0x7D
    if(m_bAutoMountAtRoundBegin)
    {
        SetAutoMountTimers(bFirstRound);
    }
    GRI.m_fPurchaseTimer = 60.0000000;
    GRI.bNetDirty = true;
    // End:0x117
    foreach WorldInfo.AllControllers(Class'TgGame.TgPlayerController', TgPC)
    {
        TgPC.ClientOnRoundSetupStarted(false);        
    }    
    GRI.r_bIsFirstRound = bFirstRound;
    // End:0x173
    if(m_fRoundLimitDuration > float(0))
    {
        s_fRoundLimitElapsed = 0.0000000;
        SendRoundLimitTimerNotify(0, 0.0000000);
    }
    //return;    
}

function SetSpawnGateTimers(bool bFirstRound)
{
    local float SpawnGateOpenTime;

    SpawnGateOpenTime = GetSpawnGateOpenTime();
    SetTimer(SpawnGateOpenTime, false, 'OpenSpawnGates');
    //return;    
}

function SetAutoMountTimers(bool bFirstRound)
{
    local float SpawnGateOpenTime;

    SpawnGateOpenTime = GetSpawnGateOpenTime();
    // End:0x4F
    if((SpawnGateOpenTime - 2.0000000) > 0.0000000)
    {
        SetTimer(SpawnGateOpenTime - 2.0000000, false, 'AutoMountAllPlayers');        
    }
    else
    {
        AutoMountAllPlayers();
    }
    //return;    
}

function SetResetEscapedPlayersTimers(bool bFirstRound)
{
    local float SpawnGateOpenTime;

    SpawnGateOpenTime = GetSpawnGateOpenTime();
    // End:0x4F
    if((SpawnGateOpenTime - 3.0000000) > 0.0000000)
    {
        SetTimer(SpawnGateOpenTime - 3.0000000, false, 'ResetAllPlayersNotInSpawnRoom');        
    }
    else
    {
        ResetAllPlayersNotInSpawnRoom();
    }
    //return;    
}

function StartGameMode()
{
    StartNewObjectiveRound(true);
    StartBroadcastTimer();
    SetTimer(m_fGamePauseDelay, false, 'PauseDelay');
    //return;    
}

event bool IsInGrimReaperMode()
{
    local TgRepInfo_Game GRI;

    GRI = TgRepInfo_Game(GameReplicationInfo);
    return ((GRI != none) && int(GRI.r_GameRespawnRule) == int(2)) && !IsTimerActive('PickNextObjective');
    //return ReturnValue;    
}

final function TgRepInfo_TaskForce GetAttackingTaskForce()
{
    local TgRepInfo_Game GRI;

    GRI = TgRepInfo_Game(GameReplicationInfo);
    return ((GRI != none) ? GRI.super(TgGame_PaladinsExtended).GetAttackingTaskForce() : none);
    //return ReturnValue;    
}

final function TgRepInfo_TaskForce GetDefendingTaskForce()
{
    local TgRepInfo_Game GRI;

    GRI = TgRepInfo_Game(GameReplicationInfo);
    return ((GRI != none) ? GRI.super(TgGame_PaladinsExtended).GetDefendingTaskForce() : none);
    //return ReturnValue;    
}

function OnRoundEnded()
{
    CleanupTicketsForRound();
    // End:0x30
    if(m_fRoundLimitDuration > float(0))
    {
        SendRoundLimitTimerNotify(0, m_fRoundLimitDuration);
    }
    //return;    
}

function CleanupTicketsForRound()
{
    // End:0x47
    if(!m_bTicketsPersist)
    {
        SetTickets(1, m_fWinningTickets);
        SetTickets(2, m_fWinningTickets);
        m_fLastObjectiveRepickTickets = 0.0000000;
    }
    //return;    
}

function ResetGameMode()
{
    local TgRepInfo_Game GRI;
    local TgRepInfo_TaskForce TF1, TF2;
    local TgChaosCapturePoint capturePoint;
    local TgPawn_LanePusher LanePusher;

    GRI = TgRepInfo_Game(GameReplicationInfo);
    TF1 = GRI.GetTaskForce(1);
    TF2 = GRI.GetTaskForce(2);
    TF1.r_fSecondaryScore = 0.0000000;
    TF2.r_fSecondaryScore = 0.0000000;
    GRI.r_CapturingTaskForce = none;
    // End:0x18E
    foreach WorldInfo.DynamicActors(Class'TgGame.TgChaosCapturePoint', capturePoint)
    {
        capturePoint.SetStatus(0);
        capturePoint.r_nDefenderTaskForceIndex = 0;
        capturePoint.r_nControllingTaskForceIndex = 0;
        capturePoint.r_nContestingTaskForceIndex = 0;        
    }    
    // End:0x1E5
    foreach WorldInfo.AllPawns(Class'TgGame.TgPawn_LanePusher', LanePusher)
    {
        LanePusher.Suicide();        
    }    
    GRI.UpdateAttackingTaskforce(none);
    GRI.r_nTotalObjectiveTime = 0;
    GRI.r_nRemainingObjectiveTime = 0;
    ClearTimer('PickNextObjective');
    ClearTimer('BroadcastTimer');
    StartGameMode();
    GotoState('GameRunning');
    //return;    
}

function UpdateObjectiveTimer()
{
    local TgRepInfo_Game GRI;

    GRI = TgRepInfo_Game(GameReplicationInfo);
    // End:0x2D
    if(GRI == none)
    {
        return;
    }
    // End:0x88
    if(GRI.r_nTotalObjectiveTime <= 0)
    {
        GRI.r_nRemainingObjectiveTime = 0;
        ClearTimer('UpdateObjectiveTimer');        
    }
    else
    {
        GRI.r_nRemainingObjectiveTime = Max(GRI.r_nRemainingObjectiveTime - 1, 0);
    }
    //return;    
}

function UpdateTgPawnMetaGameState(TgPawn CurPawn, optional TgPawn.EMetaGameState NewState = 0)
{
    local TgRepInfo_Game GRI;
    local int TaskForceNumber;
    local TgObjective Objective;
    local int NumActiveObjectives;

    // End:0x45
    if(int(NewState) != int(0))
    {
        CurPawn.UpdateMetaGameState(NewState);        
    }
    else
    {
        NumActiveObjectives = 0;
        // End:0xDE
        foreach WorldInfo.DynamicActors(Class'TgGame.TgObjective', Objective)
        {
            // End:0xDD
            if((int(Objective.r_eStatus) == int(2)) || int(Objective.r_eStatus) == int(1))
            {
                NumActiveObjectives++;
            }            
        }        
        // End:0x111
        if(NumActiveObjectives > 0)
        {
            CurPawn.UpdateMetaGameState(2);
            return;
        }
        GRI = TgRepInfo_Game(GameReplicationInfo);
        // End:0x207
        if(GRI.r_LanePusher != none)
        {
            TaskForceNumber = int(CurPawn.GetTaskForceNumber());
            // End:0x1E3
            if(TaskForceNumber == int(GRI.r_AttackingTaskForce.r_nTaskForce))
            {
                CurPawn.UpdateMetaGameState(3);                
            }
            else
            {
                CurPawn.UpdateMetaGameState(4);
            }            
        }
        else
        {
            CurPawn.UpdateMetaGameState(1);
        }
    }
    //return;    
}

function UpdateAllPawnsMetaGameState(optional TgPawn.EMetaGameState NewState = 0)
{
    local TgAIController_Behavior TgAIC;
    local TgObjective Objective;
    local int NumActiveObjectives, NumFoundControllers;
    local TgRepInfo_Game GRI;

    // End:0x8D
    if(int(NewState) != int(0))
    {
        // End:0x89
        foreach WorldInfo.AllControllers(Class'TgGame.TgAIController_Behavior', TgAIC)
        {
            UpdateTgPawnMetaGameState(TgPawn(TgAIC.Pawn), NewState);            
        }                
    }
    else
    {
        NumActiveObjectives = 0;
        // End:0xFB
        foreach WorldInfo.DynamicActors(Class'TgGame.TgObjective', Objective)
        {
            // End:0xFA
            if(int(Objective.r_eStatus) == int(2))
            {
                NumActiveObjectives++;
            }            
        }        
        // End:0x177
        if(NumActiveObjectives > 0)
        {
            // End:0x173
            foreach WorldInfo.AllControllers(Class'TgGame.TgAIController_Behavior', TgAIC)
            {
                UpdateTgPawnMetaGameState(TgPawn(TgAIC.Pawn), 2);                
            }                        
        }
        else
        {
            GRI = TgRepInfo_Game(GameReplicationInfo);
            // End:0x223
            if(GRI.r_LanePusher == none)
            {
                // End:0x21F
                foreach WorldInfo.AllControllers(Class'TgGame.TgAIController_Behavior', TgAIC)
                {
                    UpdateTgPawnMetaGameState(TgPawn(TgAIC.Pawn), 1);                    
                }                                
            }
            else
            {
                // End:0x292
                foreach WorldInfo.AllControllers(Class'TgGame.TgAIController_Behavior', TgAIC)
                {
                    UpdateTgPawnMetaGameState(TgPawn(TgAIC.Pawn), NewState);                    
                }                
            }
        }
    }
    NumFoundControllers = 0;
    // End:0x2DE
    foreach WorldInfo.AllControllers(Class'TgGame.TgAIController_Behavior', TgAIC)
    {
        NumFoundControllers++;        
    }    
    // End:0x2EE
    if(NumFoundControllers == 0)
    {
    }
    //return;    
}

function bool KillLanePusherWhenGateIsDestroyed()
{
    return m_bKillLanePusherOnWallDestroyed;
    //return ReturnValue;    
}

function StartFogConverging()
{
    local TgRepInfo_Game GRI;

    GRI = TgRepInfo_Game(GameReplicationInfo);
    m_LastActiveCapturePoint.SetFogActive(true);
    m_bConvergeCompletely = false;
    SetTimer(GRI.r_fFogConvergeInterval, true, 'ConvergeFog');
    //return;    
}

function ResumeConvergeCompletely()
{
    local TgRepInfo_Game GRI;

    GRI = TgRepInfo_Game(GameReplicationInfo);
    SetTimer(GRI.r_fFogConvergeInterval, true, 'ConvergeFog');
    //return;    
}

function ConvergeFog()
{
    local TgRepInfo_Game GRI;
    local TgPawn TgP;
    local TgDeviceFire FireMode;
    local ImpactInfo Impact;
    local int I;
    local TgDeployable TgD;
    local float FogTolerance;
    local TgChaosCapturePoint_ParticleStorm CapPoint;

    CapPoint = TgChaosCapturePoint_ParticleStorm(m_LastActiveCapturePoint);
    GRI = TgRepInfo_Game(GameReplicationInfo);
    FireMode = ConvergeDevice.GetDeviceFire(0);
    // End:0x84
    if((GRI == none) || FireMode == none)
    {
        return;
    }
    // End:0x250
    if(!IsTimerActive('ResumeConvergeCompletely'))
    {
        // End:0x131
        if(CapPoint != none)
        {
            GRI.r_fConvergeDistance = float(Max(int(((m_bConvergeCompletely) ? 0.0000000 : m_fConvergeSafeDistance)), int(GRI.r_fConvergeDistance - CapPoint.m_fFogConvergeSpeed)));            
        }
        else
        {
            GRI.r_fConvergeDistance = float(Max(int(((m_bConvergeCompletely) ? 0.0000000 : m_fConvergeSafeDistance)), int(GRI.r_fConvergeDistance - m_fConvergeRate)));
        }
        // End:0x1E3
        if(!GRI.r_bFogConverging)
        {
            GRI.r_bFogConverging = true;
        }
        // End:0x250
        if((GRI.r_fConvergeDistance <= m_fConvergeSafeDistance) && !m_bConvergeCompletely)
        {
            // End:0x250
            if(m_bConvergeCompletelyAfterDelay)
            {
                m_bConvergeCompletely = true;
                SetTimer(m_fFogCompleteConvergeDelay, false, 'ResumeConvergeCompletely');
            }
        }
    }
    GRI.bNetDirty = true;
    FogTolerance = 0.0000000;
    // End:0x2C2
    if(!m_bConvergeCompletely)
    {
        FogTolerance = m_fConvergeRate * GRI.r_fFogConvergeInterval;
    }
    // End:0x541
    foreach WorldInfo.AllPawns(Class'TgGame.TgPawn', TgP)
    {
        // End:0x540
        if((((TgP != none) && FireMode.IsValidTarget(TgP)) && VSizeSq(m_LastActiveCapturePoint.Location - TgP.Location) > ((GRI.r_fConvergeDistance + FogTolerance) * (GRI.r_fConvergeDistance + FogTolerance))) && ConvergeDevice != none)
        {
            Impact.bDirectHit = true;
            Impact.DeviceModeReference = FireMode;
            Impact.HitActor = TgP;
            Impact.HitLocation = TgP.Location;
            Impact.HitNormal = vect(0.0000000, 0.0000000, 0.0000000);
            Impact.RayDir = vect(0.0000000, 0.0000000, 0.0000000);
            FireMode.ApplyHit(Impact, TgP);
            TgP.EnterCombat(TgP, TgP);
        }        
    }    
    I = 0;
    J0x54D:

    // End:0x7D0 [Loop If]
    if(I < GRI.m_Deployables.Length)
    {
        TgD = GRI.m_Deployables[I];
        // End:0x7C2
        if((((TgD != none) && FireMode.IsValidTarget(TgD)) && VSizeSq(m_LastActiveCapturePoint.Location - TgD.Location) > ((GRI.r_fConvergeDistance + FogTolerance) * (GRI.r_fConvergeDistance + FogTolerance))) && ConvergeDevice != none)
        {
            Impact.bDirectHit = true;
            Impact.DeviceModeReference = FireMode;
            Impact.HitActor = TgD;
            Impact.HitLocation = TgD.Location;
            Impact.HitNormal = vect(0.0000000, 0.0000000, 0.0000000);
            Impact.RayDir = vect(0.0000000, 0.0000000, 0.0000000);
            FireMode.ApplyHit(Impact, TgD);
        }
        I++;
        // [Loop Continue]
        goto J0x54D;
    }
    //return;    
}

simulated function float GetTotalSplineDist(SplineActor Spline)
{
    local float totalDist;
    local editinline SplineComponent SplineComp;

    // End:0x3C
    if((Spline == none) || Spline.Connections.Length < 1)
    {
        return 0.0000000;
    }
    totalDist = 0.0000000;
    SplineComp = Spline.Connections[0].SplineComponent;
    J0x88:

    // End:0x177 [Loop If]
    if(SplineComp != none)
    {
        totalDist += SplineComp.GetSplineLength();
        Spline = Spline.Connections[0].ConnectTo;
        // End:0x137
        if((Spline == none) || Spline.Connections.Length < 1)
        {
            // [Explicit Break]
            goto J0x177;
        }
        SplineComp = Spline.Connections[0].SplineComponent;
        // [Loop Continue]
        goto J0x88;
    }
    J0x177:

    return totalDist;
    //return ReturnValue;    
}

function ScorePayload()
{
    local TgPawn TgP;
    local TgRepInfo_Player PRI;
    local TgRepInfo_Game GRI;
    local TgPawn_SiegeEngine_Payload Pusher;
    local bool bContested;

    GRI = TgRepInfo_Game(GameReplicationInfo);
    Pusher = ((GRI != none) ? TgPawn_SiegeEngine_Payload(GRI.r_LanePusher) : none);
    // End:0x184
    if(Pusher != none)
    {
        bContested = Pusher.IsContested();
        // End:0x183
        foreach Pusher.m_VisiblePlayers(TgP)
        {
            PRI = TgP.GetPRI();
            // End:0x182
            if((PRI != none) && !PRI.IsBot())
            {
                // End:0x182
                if(!Pusher.IsEnemy(PRI) || bContested)
                {
                    ScorePayloadHold(TgP, ((bContested) ? 1 : 0));
                }
            }            
        }        
    }
    //return;    
}

function InitGameReplicationInfo()
{
    local TgRepInfo_Game GRI;

    super(TgGame).InitGameReplicationInfo();
    GRI = TgRepInfo_Game(GameReplicationInfo);
    // End:0x85
    if(GRI != none)
    {
        GRI.r_fSpeedScale = m_fSpeedScale;
        GRI.SetGameMode(m_DefaultGameMode);
    }
    //return;    
}

function SetLanePusherSpeedScale(float fNewSpeedScale)
{
    local TgRepInfo_Game GRI;

    m_fSpeedScale = fNewSpeedScale;
    GRI = TgRepInfo_Game(GameReplicationInfo);
    // End:0x66
    if(GRI != none)
    {
        GRI.r_fSpeedScale = m_fSpeedScale;
    }
    //return;    
}

function SetTickets(int nTaskForce, float fNumTickets)
{
    local TgRepInfo_Game GRI;
    local TgRepInfo_TaskForce Taskforce;

    switch(nTaskForce)
    {
        // End:0xCF
        case 1:
            m_fTF1Tickets = fNumTickets;
            GRI = TgRepInfo_Game(WorldInfo.GRI);
            // End:0xCC
            if(GRI != none)
            {
                Taskforce = GRI.GetTaskForce(1);
                // End:0xCC
                if(Taskforce != none)
                {
                    Taskforce.r_fTickets = m_fTF1Tickets;
                }
            }
            // End:0x190
            break;
        // End:0x18D
        case 2:
            m_fTF2Tickets = fNumTickets;
            GRI = TgRepInfo_Game(WorldInfo.GRI);
            // End:0x18A
            if(GRI != none)
            {
                Taskforce = GRI.GetTaskForce(2);
                // End:0x18A
                if(Taskforce != none)
                {
                    Taskforce.r_fTickets = m_fTF2Tickets;
                }
            }
            // End:0x190
            break;
        // End:0xFFFF
        default:
            break;
    }
    //return;    
}

function GainTickets(int nTaskForce, float fNumTickets, TgGame_PaladinsExtended.EVictoryType VictoryType)
{
    local bool bReachedTicketLimit;
    local TgChaosCapturePoint capturePoint;
    local int gainedTF1Tickets, gainedTF2Tickets;

    // End:0x15
    if(m_fWinningTickets <= 0.0000000)
    {
        return;
    }
    bReachedTicketLimit = false;
    switch(nTaskForce)
    {
        // End:0x93
        case 1:
            SetTickets(1, m_fTF1Tickets - fNumTickets);
            // End:0x90
            if(m_fTF1Tickets <= float(0))
            {
                ReachTicketLimit(nTaskForce, VictoryType);
                bReachedTicketLimit = true;
            }
            // End:0xF7
            break;
        // End:0xF4
        case 2:
            SetTickets(2, m_fTF2Tickets - fNumTickets);
            // End:0xF1
            if(m_fTF2Tickets <= float(0))
            {
                ReachTicketLimit(nTaskForce, VictoryType);
                bReachedTicketLimit = true;
            }
            // End:0xF7
            break;
        // End:0xFFFF
        default:
            break;
    }
    // End:0x2A6
    if(!bReachedTicketLimit)
    {
        gainedTF1Tickets = int(m_fWinningTickets - m_fTF1Tickets);
        gainedTF2Tickets = int(m_fWinningTickets - m_fTF2Tickets);
        // End:0x2A6
        if((m_fObjectiveRepickTickets > float(0)) && (float(gainedTF1Tickets + gainedTF2Tickets) - m_fLastObjectiveRepickTickets) >= m_fObjectiveRepickTickets)
        {
            m_fLastObjectiveRepickTickets = float(gainedTF1Tickets + gainedTF2Tickets) - (float(gainedTF1Tickets + gainedTF2Tickets) % m_fObjectiveRepickTickets);
            // End:0x27E
            foreach WorldInfo.DynamicActors(Class'TgGame.TgChaosCapturePoint', capturePoint)
            {
                capturePoint.SetStatus(0);
                capturePoint.r_nDefenderTaskForceIndex = 0;
                capturePoint.r_nControllingTaskForceIndex = 0;
                capturePoint.r_nContestingTaskForceIndex = 0;                
            }            
            SetTimer(GetPickNextObjectiveTime(), false, 'PickNextObjective');
            SendClientsRequestHelpText(1801);
        }
    }
    //return;    
}

function ReachTicketLimit(int nTaskForce, TgGame_PaladinsExtended.EVictoryType VictoryType)
{
    local TgRepInfo_Game GRI;

    // End:0x2D
    if(m_nPointsForReachingTicketMax > 0)
    {
        GainPoints(nTaskForce, m_nPointsForReachingTicketMax, 7);
    }
    GRI = TgRepInfo_Game(GameReplicationInfo);
    // End:0x82
    if(GRI != none)
    {
        GRI.r_nLastRoundWinner = byte(nTaskForce);
    }
    OnRoundEnded();
    //return;    
}

function OnPawnDied(TgPawn Victim)
{
    local TgRepInfo_Game GRI;
    local int killerTaskForce;

    super.OnPawnDied(Victim);
    // End:0xCA
    if(m_fTicketsForKill > float(0))
    {
        GRI = TgRepInfo_Game(GameReplicationInfo);
        // End:0xCA
        if((GRI != none) && Victim.IsGod())
        {
            killerTaskForce = ((int(Victim.GetTaskForceNumber()) == int(1)) ? 2 : 1);
            GainTickets(killerTaskForce, m_fTicketsForKill, 6);
        }
    }
    //return;    
}

function UpdateOccupationStatus(TgChaosCapturePoint capturePoint, int nNumTF1, int nNumTF2)
{
    local TgRepInfo_Game GRI;

    GRI = TgRepInfo_Game(GameReplicationInfo);
    // End:0x122
    if((GRI == none) || GRI.r_bSpawnGatesOpen)
    {
        // End:0x122
        if(m_fTicketsPerCaptureTick > 0.0000000)
        {
            // End:0xC3
            if((nNumTF1 > 0) && !nNumTF2 > 0)
            {
                GainTickets(1, m_fTicketsPerCaptureTick + ((float(nNumTF1 - 1) * m_fTicketsPerCaptureTick) * m_fTicketsBonusPerMultiCapture), 1);                
            }
            else
            {
                // End:0x122
                if((nNumTF2 > 0) && !nNumTF1 > 0)
                {
                    GainTickets(2, m_fTicketsPerCaptureTick + ((float(nNumTF2 - 1) * m_fTicketsPerCaptureTick) * m_fTicketsBonusPerMultiCapture), 1);
                }
            }
        }
    }
    //return;    
}

function bool AllowPausing(optional PlayerController PC)
{
    // End:0x45
    if(super(TgGame).AllowPausing(PC))
    {
        // End:0x43
        if(IsTimerActive('PauseDelay'))
        {
            NotifyPauseDelay(PC);
            return false;
        }
        return true;
    }
    return false;
    //return ReturnValue;    
}

function PauseDelay()
{
    //return;    
}

// Export UTgGame_PaladinsExtended::execNotifyPauseDelay(FFrame&, void* const)
native function NotifyPauseDelay(PlayerController PC);

state AttackDefend
{
    ignores UpdateObjectiveStates;

    event BeginState(name PreviousStateName)
    {
        local TgRepInfo_Game GRI;
        local TgObjective Objective;

        GRI = TgRepInfo_Game(GameReplicationInfo);
        // End:0x43
        if((GRI == none) || int(m_GameWinState) != int(0))
        {
            return;
        }
        OpenAllAliveGates(false);
        // End:0x8E
        if(int(GRI.r_GameMode) == int(0))
        {
            // End:0x8E
            if(m_bSpawnLanePusherWhenPointCaptured)
            {
                SpawnLanePusher();
            }
        }
        // End:0x108
        if(int(GRI.r_GameMode) == int(0))
        {
            // End:0x107
            foreach WorldInfo.DynamicActors(Class'TgGame.TgObjective', Objective)
            {
                Objective.SetStatus(0);                
            }            
        }
        // End:0x13F
        if(int(GRI.r_GameRespawnRule) == int(2))
        {
            RespawnAllPlayers(false);
        }
        UpdateAllPawnsMetaGameState();
        //return;        
    }

    function float GetPickNextObjectiveTime()
    {
        return m_fObjectivePickTime;
        //return ReturnValue;        
    }

    function float GetSpawnGateOpenTime()
    {
        // End:0x1E
        if(m_fSpawnGateOpenTime <= 0.0000000)
        {
            return GetPickNextObjectiveTime();
        }
        return m_fSpawnGateOpenTime;
        //return ReturnValue;        
    }

    function bool DestroyNextTower()
    {
        local TgRepInfo_Game GRI;
        local TgPawn_Tower_FA Tower;
        local array<TgPawn_Tower_FA> InnerTowers;

        GRI = TgRepInfo_Game(GameReplicationInfo);
        // End:0x2D
        if(GRI == none)
        {
            return false;
        }
        // End:0x170
        foreach WorldInfo.AllPawns(Class'TgGame.TgPawn_Tower_FA', Tower)
        {
            // End:0x16F
            if((int(Tower.GetTaskForceNumber()) != int(GRI.r_AttackingTaskForce.r_nTaskForce)) && Tower.IsAliveAndWell())
            {
                // End:0x130
                if(int(Tower.m_TowerType) == int(2))
                {
                    Tower.Suicide();                    
                    return true;
                    // End:0x16F
                    continue;
                }
                // End:0x16F
                if(int(Tower.m_TowerType) == int(1))
                {
                    InnerTowers.AddItem(Tower);
                }
            }            
        }        
        // End:0x1A4
        if(InnerTowers.Length > 0)
        {
            InnerTowers[0].Suicide();
            return true;
        }
        return false;
        //return ReturnValue;        
    }

    function TgChaosCapturePoint GetCapturePointToSpawnSiegeEngineAt()
    {
        local TgChaosCapturePoint capturePoint;
        local array<TgChaosCapturePoint> CapturePoints;

        // End:0x1C
        if(m_CapturedPoint != none)
        {
            return m_CapturedPoint;            
        }
        else
        {
            // End:0x61
            foreach WorldInfo.DynamicActors(Class'TgGame.TgChaosCapturePoint', capturePoint)
            {
                CapturePoints.AddItem(capturePoint);                
            }            
            return CapturePoints[Rand(CapturePoints.Length)];
        }
        //return ReturnValue;        
    }

    function SpawnLanePusher()
    {
        local TgRepInfo_Game GRI;
        local TgChaosCapturePoint CapturePointToSpawn;
        local TgSplineActor StartSpline;
        local array<TgBotFactory_Minions> Factories;

        GRI = TgRepInfo_Game(GameReplicationInfo);
        // End:0x69
        if(((GRI == none) || GRI.r_AttackingTaskForce == none) || int(m_GameWinState) != int(0))
        {
            return;
        }
        CapturePointToSpawn = GetCapturePointToSpawnSiegeEngineAt();
        // End:0x347
        if(CapturePointToSpawn != none)
        {
            Factories = ((int(GRI.r_AttackingTaskForce.GetTeamNum()) == int(2)) ? CapturePointToSpawn.m_Taskforce2Factories : CapturePointToSpawn.m_Taskforce1Factories);
            // End:0x347
            if(Factories[0] != none)
            {
                // End:0x15C
                if(m_bOverrideSpawnTableID)
                {
                    Factories[0].nSpawnTableId = GetNextSpawnTableId();
                }
                Factories[0].ResetQueue();
                GRI.r_LanePusher = TgPawn_LanePusher(Factories[0].UseSpawnTable());
                // End:0x2C8
                if(GRI.r_LanePusher != none)
                {
                    StartSpline = ((int(GRI.r_AttackingTaskForce.GetTeamNum()) == int(2)) ? CapturePointToSpawn.m_Taskforce2PathStart : CapturePointToSpawn.m_Taskforce1PathStart);
                    // End:0x2BE
                    if(StartSpline != none)
                    {
                        GRI.r_LanePusher.SetSpline(StartSpline, true);
                    }
                    PlayLanePusherHelpText();
                }
                SendLanePusherSpawnAlert(int(GRI.r_AttackingTaskForce.r_nTaskForce));
                SendLanePusherUpdateAlert(true, int(GRI.r_AttackingTaskForce.r_nTaskForce));
            }
        }
        //return;        
    }

    function UpdateAttackTimeRemaining()
    {
        local TgRepInfo_Game GRI;

        GRI = TgRepInfo_Game(GameReplicationInfo);
        // End:0x43
        if((GRI == none) || int(m_GameWinState) != int(0))
        {
            return;
        }
        GRI.r_nChaosRemainingAttackDefendTime = Max(GRI.r_nChaosRemainingAttackDefendTime - 1, 0);
        //return;        
    }

    function NavigationPoint FindPlayerStart(Controller Player, optional byte InTeam, optional string IncomingName)
    {
        local PlayerStart Start;

        Start = FindPlayerStartForCapturePoint(m_CapturedPoint, Player);
        // End:0x42
        if(Start != none)
        {
            return Start;
        }
        return super(TgGame).FindPlayerStart(Player, InTeam, IncomingName);
        //return ReturnValue;        
    }

    event bool IsInGrimReaperMode()
    {
        return false;
        //return ReturnValue;        
    }

    function EndAttackDefend()
    {
        local TgRepInfo_Game GRI;

        GRI = TgRepInfo_Game(GameReplicationInfo);
        // End:0x2D
        if(GRI == none)
        {
            return;
        }
        GRI.r_nRemainingObjectiveTime = 0;
        GRI.r_nTotalObjectiveTime = 0;
        ClearTimer('UpdateObjectiveTimer');
        TransitionToNextRound();
        //return;        
    }

    simulated event SendLanePusherUpdateAlert(bool isAlive, int tf)
    {
        local TgRepInfo_Game GRI;

        GRI = TgRepInfo_Game(GameReplicationInfo);
        global.SendLanePusherUpdateAlert(isAlive, tf);
        // End:0x8E
        if((!isAlive && GRI != none) && int(GRI.r_GameMode) == int(0))
        {
            EndAttackDefend();
        }
        //return;        
    }
    stop;    
}

state PreRoundSetup
{
    function BeginState(name PreviousStateName)
    {
        super(Object).BeginState(PreviousStateName);
        StartBroadcastTimer();
        ResetScores();
        TgRepInfo_Game(GameReplicationInfo).UpdateAttackingTaskforce(none);
        PreFillCapturePointQueue();
        // End:0xAF
        if(m_CapturePointQueue.Length > 0)
        {
            // End:0xAF
            if((m_CapturePointQueue[0] != none) && !m_bActivateAllCapturePoints)
            {
                m_CapturePointQueue[0].SetStatus(2);
            }
        }
        RespawnAllPlayers(true, true, true, true);
        //return;        
    }

    function EndState(name NextStateName)
    {
        super(Object).EndState(NextStateName);
        // End:0x34
        if(NextStateName == 'GameRunning')
        {
            StartGameMode();
        }
        //return;        
    }
    stop;    
}

state GameRunning
{
    function BeginState(name PreviousStateName)
    {
        m_fOvertimeActiveTime = 0.0000000;
        OpenAllAliveGates(false);
        UpdateAllPawnsMetaGameState(1);
        super.BeginState(PreviousStateName);
        //return;        
    }

    function PointCaptured(int nTaskForce, optional bool bSuppressPointsForCapture)
    {
        local TgRepInfo_Game GRI;

        m_fOvertimeActiveTime = 0.0000000;
        GRI = TgRepInfo_Game(GameReplicationInfo);
        // End:0x5B
        if(GRI != none)
        {
            GRI.r_CapturingTaskForce = none;
        }
        // End:0xAE
        if(m_bEndRoundWhenPointCaptured)
        {
            // End:0xA1
            if(GRI != none)
            {
                GRI.r_nLastRoundWinner = byte(nTaskForce);
            }
            OnRoundEnded();            
        }
        else
        {
            m_nAttackingTaskforce = nTaskForce;
            GotoState(m_AttackDefendState);
        }
        // End:0xFE
        if(m_fTicketsPerPointCapture > float(0))
        {
            GainTickets(nTaskForce, m_fTicketsPerPointCapture, 1);
        }
        //return;        
    }
    stop;    
}

defaultproperties
{
    m_nWinningScore=1
    m_bScoringEnabled=true
    m_bKillLanePusherOnWallDestroyed=true
    m_bConvergeCompletelyAfterDelay=true
    m_bActivateSpawnGatesAtStart=true
    m_bRevivePlayersWhenSiegeEngineDies=true
    m_bStasisTimerOn=true
    m_bCapturePointContestDurationEnabled=true
    m_bSpawnLanePusherWhenPointCaptured=true
    m_bCaptureSpawnAlerts=true
    m_nPointsForReachingTicketMax=1
    m_nPointsForReachingRoundTimeLimit=1
    m_fSecondaryGoalScore=100.0000000
    m_fSecondaryScoreAmount=2.0000000
    m_fObjectivePickTime=20.0000000
    m_fSetupObjectivePickTime=40.0000000
    m_fObjectiveActivationTime=1.0000000
    m_nRegLanePusherHPScaling=4840
    m_nGuardianHPScaling=6200
    m_nOuterGateHPScaling=1620
    m_nInnerGateHPScaling=3240
    m_nBaseObjectiveHPScaling=4860
    m_nForcedObjectiveIndex=-1
    m_nCountdown=30
    m_fSpeedScale=1.0000000
    m_fRespawnTimeCap=30.0000000
    m_fNoSiegeEngineRespawnModification=-5.0000000
    m_AttackDefendState="AttackDefend"
    m_fConvergeStartDistance=13000.0000000
    m_fConvergeRate=208.0000000
    m_fStartConvergeTime=10.0000000
    m_fConvergeSafeDistance=400.0000000
    m_fAutoPushForwardDelay=2.0000000
    m_fAutoPushForwardSpeedScale=0.5000000
    m_nCreditsForHoldingObjective=2
    m_nCreditsBonusPerContested=2
    m_nCreditsForHoldingPayload=2
    m_fFogCompleteConvergeDelay=60.0000000
    m_fPointContestDuration=6.0000000
    m_fPointOvertimeDuration=6.0000000
    m_fPointOvertimeDrainPercPerSec=3.2000000
    m_fPointClaimDuration=6.0000000
    s_nCurrentActivePointIndex=-1
    m_fFlankerSoloKillRewardDistance=100.0000000
    m_fDamageRoleMultiplier=2.0000000
    m_fFlankRoleMultiplier=1.3000000
    m_fFrontLineRoleMultiplier=1.0000000
    m_fSupportRoleMultiplier=2.0000000
    m_fGamePauseDelay=10.0000000
    m_bAutoMountOnRespawn=true
    m_fGameTypeReminderTime=60.0000000
    m_bRespawnInhibitors=false
    m_nWinBonusXp=15000
    m_nWinPlayerXp=2750
    m_nLosePlayerXp=2750
    m_fBaseTokens=4.0000000
    m_fFirstBloodGoldReward=100.0000000
    m_fBasePlayerAssistXpRewardMultipler=1.0000000
    m_fBaseNPCAssistXpRewardMultipler=2.0000000
    m_GameType=TG_GAME_TYPE.TGT_CHAOS
    SupportedEvents=/* Array type was not detected. */
}