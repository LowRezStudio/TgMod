class TgGame_PaladinsExtended extends TgGame_Paladins
    native(Game)
    config(Game)
    hidecategories(Navigation,Movement,Collision);

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
};

var config float m_fWinningTickets;
var config bool m_bTicketsPersist;
var const config bool m_bKillLanePusherOnWallDestroyed;
var bool m_bKeepThisPointForNextRound;
var bool m_bConvergeCompletely;
var bool m_bCanCaptureDuringSurvival;
var const config bool m_bCanAutoPushForward;
var bool m_bConvergeCompletelyAfterDelay;
var bool m_bOverrideSpawnTableID;
var config bool m_bActivateSpawnGatesAtStart;
var config bool m_bRevivePlayersWhenSiegeEngineDies;
var bool m_bStasisTimerOn;
var config bool m_bActivateAllCapturePoints;
var bool m_bPointContested;
var bool m_bPointCaptureOvertimeTF1;
var bool m_bPointCaptureOvertimeTF2;
var bool m_bSimpleOvertime;
var bool m_bSimpleOvertimeEnabled;
var bool m_bCapturePointContestDurationEnabled;
var bool m_bTF1Backsliding;
var bool m_bTF2Backsliding;
var bool m_bEndRoundWhenPointCaptured;
var bool m_bSpawnLanePusherWhenPointCaptured;
var bool m_bCaptureSpawnAlerts;
var bool m_bResetPlayersNotInSpawnRoomDisabled;
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
var int s_nCurrentCapturePointQueueIndex;
var const config int m_nRegLanePusherHPScaling;
var const config int m_nRegLanePusherPowerScaling;
var const config int m_nGuardianHPScaling;
var const config int m_nGuardianPowerScaling;
var const config int m_nOuterGateHPScaling;
var const config int m_nInnerGateHPScaling;
var const config int m_nBaseObjectiveHPScaling;
var int m_nForcedObjectiveIndex;
var int m_nCountdown;
var protected float m_fSpeedScale;
var float m_fRespawnOffset;
var float m_fRespawnIncreaseOverTime;
var float m_fTimeDeltaRespawnIncrease;
var config float m_fDefenseRespawnIncrease;
var config float m_fAttackRespawnIncrease;
var config float m_fRespawnTimeCap;
var config float m_fNoSiegeEngineRespawnModification;
var const name m_AttackDefendState;
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
var float m_fOvertimeActiveTimeMemory[3];
var int m_nOvertimeActiveTimeEntry;
var float m_fOvertimeLeft;
var config float m_fBackslidePercent;
var config float m_fBackslideDelay;
var config float m_fBackslideRate;
var int s_nCurrentActivePointIndex;
var int m_nAttackingTaskforce;
var Vector m_SnappedWaypointIndicatorOffset;
var float m_fGamePauseDelay;
var TgChaosCapturePoint m_LastActiveCapturePoint;
var array<TgChaosCapturePoint> m_CapturePointQueue;

// Export UTgGame_PaladinsExtended::execGetRespawnTime(FFrame&, void* const)
native function float GetRespawnTime(int TaskForceNum);

// Export UTgGame_PaladinsExtended::execScoreObjectiveHold(FFrame&, void* const)
native function ScoreObjectiveHold(TgPawn ScorePawn, int NumContested);

// Export UTgGame_PaladinsExtended::execScorePayloadHold(FFrame&, void* const)
native function ScorePayloadHold(TgPawn ScorePawn, int NumContested);

// Export UTgGame_PaladinsExtended::execLoadCardVendor(FFrame&, void* const)
native function LoadCardVendor();

// Export UTgGame_PaladinsExtended::execCaptureSpawnAlert(FFrame&, void* const)
native function CaptureSpawnAlert(float TimeRemaining);

event RespawnAllPlayers(bool bResetLivingPlayers, optional bool bResetDeadPlayers = true, optional bool bResetHealth = true, optional bool bResetDevices = false){}

function GlobalRespawnTimeUpdate(float fRespawnTime, bool bEnsureRespawnTimeDoesntIncrease){}
function GlobalRespawnTimeUpdateHelper(Controller C, TgPawn TgP, float fRespawnTime, bool bEnsureRespawnTimeDoesntIncrease){}

function StartGameMode(){}