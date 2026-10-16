class TgGame_PaladinsExtended extends TgGame_Paladins
    native(Game)
    config(Game)
    hidecategories(Navigation,Movement,Collision)
    dependson(TgObject, TgPawn, TgRepInfo_Game);

enum ETeamStatus {
    TEAM_WINNING,  // 0
    TEAM_LOSING,  // 1
    TEAM_TIED,  // 2
};

enum EVictoryType {
    EVT_Default,  // 0
    EVT_Capture,  // 1
    EVT_Defend,  // 2
    EVT_Payload,  // 3
    EVT_Siege,  // 4
    EVT_Survival,  // 5
    EVT_Kill,  // 6
    EVT_Ticket,  // 7
    EVT_TimeLimit,  // 8
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
var () config float m_fConvergeStartDistance;
var () config float m_fConvergeRate;
var () config float m_fStartConvergeTime;
var () config float m_fConvergeSafeDistance;
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

native function float GetRespawnTime(int TaskForceNum);  // Export UTgGame_PaladinsExtended::execGetRespawnTime(FFrame&, void* const)

native function ScoreObjectiveHold(TgPawn ScorePawn, int NumContested);  // Export UTgGame_PaladinsExtended::execScoreObjectiveHold(FFrame&, void* const)

native function ScorePayloadHold(TgPawn ScorePawn, int NumContested);  // Export UTgGame_PaladinsExtended::execScorePayloadHold(FFrame&, void* const)

native function BotDied(TgAIController aic);  // Export UTgGame_PaladinsExtended::execBotDied(FFrame&, void* const)

native function LoadCardVendor();  // Export UTgGame_PaladinsExtended::execLoadCardVendor(FFrame&, void* const)

native function CaptureSpawnAlert(float TimeRemaining);  // Export UTgGame_PaladinsExtended::execCaptureSpawnAlert(FFrame&, void* const)

native function SiegeEnginePreDamageMitigation(TgPawn attacker, TgEffectGroup eg, out float fDamage, int nPropertyId);  // Export UTgGame_PaladinsExtended::execSiegeEnginePreDamageMitigation(FFrame&, void* const)

native function SiegeEngineAdjustDamage(const out AdjustDamageParams Params, out float fDamage);  // Export UTgGame_PaladinsExtended::execSiegeEngineAdjustDamage(FFrame&, void* const)

native function CacheConvergeDevice();  // Export UTgGame_PaladinsExtended::execCacheConvergeDevice(FFrame&, void* const)

native function bool CanSpoolCredits();  // Export UTgGame_PaladinsExtended::execCanSpoolCredits(FFrame&, void* const)

native function TickOvertime(float DeltaSeconds);  // Export UTgGame_PaladinsExtended::execTickOvertime(FFrame&, void* const)

native function float GetRewardScale(Actor Rewardee, TgObject.ERewardValueType RewardType, optional bool bFlankKill=false);  // Export UTgGame_PaladinsExtended::execGetRewardScale(FFrame&, void* const)

native function bool IsFlankKill(out ScoreKillData Data);  // Export UTgGame_PaladinsExtended::execIsFlankKill(FFrame&, void* const)

native function int GetTaskForceObjectiveTime(int TaskForceNum);  // Export UTgGame_PaladinsExtended::execGetTaskForceObjectiveTime(FFrame&, void* const)

native function SendStartRoundOnePointFromWinningAlert(int nTaskForceNum);  // Export UTgGame_PaladinsExtended::execSendStartRoundOnePointFromWinningAlert(FFrame&, void* const)

event PostBeginPlay() { }

function int GetScore(int nTaskForce) { }

function SetScore(int nTaskForce, int nScore) { }

function bool SetTaskforceScore(TgRepInfo_TaskForce Taskforce, int nScore, out int nStoredScore) { }

function GainPoints(int nTaskForce, int numPoints, TgGame_PaladinsExtended.EVictoryType VictoryType) { }

function TaskforceWin(int nTaskForce, TgGame_PaladinsExtended.EVictoryType VictoryType) { }

function NotifyClientsOfTF1ScoreChange(int nScore) { }

function NotifyClientsOfTF2ScoreChange(int nScore) { }

event SendRoundLimitTimerNotify(TgRepInfo_Game.MissionTimerState eState, float fElapsedSecs) { }

event RoundTimeLimitReached() { }

function int ResolveTie() { }

function BeginPlayConverge() { }

function EndPlayConverge() { }

event CheckCorePower(optional TgChaosCapturePoint capturePoint) { }

function RewardPointCapture(int nTaskForce) { }

function NotifyPlayersOfPointCapture() { }

function float GetPointCaptureScoreMultiplier(int nTaskForce) { }

event TgGame_PaladinsExtended.ETeamStatus GetTeamStatus(byte TaskForceNum, optional out float CaptureRateModifier) { }

function bool IsSurivivalMode() { }

function Pawn SpawnDefaultPawnFor(Controller NewPlayer, NavigationPoint StartSpot) { }

event AllPlayersReady() { }

function ContestPoint() { }

function PointContestEnd() { }

function SetCapturePointOvertimeEnabled(bool bEnabled) { }

function float GetOvertimeDuration() { }

function BeginPointOvertime() { }

function RestartPointOvertime() { }

function PointOvertimeEnd() { }

function TgChaosCapturePoint GetCurrentCapturePoint() { }

function bool ShouldHandlePointCaptureBacksliding() { }

function BackslideDelayTF1() { }

function BackslideDelayTF2() { }

function ManageCapturePointScore() { }

function CheckAwardObjectiveScore(byte TaskForceNum, TgChaosCapturePoint capturePoint, int NumOnPoint, int NumContested) { }

function bool CapturePointContestDurationEnabled() { }

function bool ShouldGoIntoOvertimeOnPointCapture(int TaskForceNum) { }

event GoalReached() { }

function bool CanGoToObjectiveActiveState() { }

function bool CanGoToObjectiveInactiveState() { }

function UpdateObjectiveStates() { }

function EnableUltWhenObjectiveStateUpdated() { }

function EnableCreditSpoolingWhenObjectiveStateUpdated() { }

function bool ShouldNextRoundBeASurvivalRound() { }

function SetCapturePointActive(TgObjective Objective) { }

function int GetNextSpawnTableId() { }

function PickNextObjective() { }

function PreFillCapturePointQueue() { }

function PointCaptured(int nTaskForce, optional bool bSuppressPointsForCapture) { }

function OpenSpawnGates() { }

function CloseSpawnGates() { }

function PayloadCheckpointReached(TgSplineActor_Payload Checkpoint) { }

function EndPreRoundSetup() { }

function StartBroadcastTimer() { }

function EndBroadcastTimer() { }

function BroadcastTimer() { }

function float GetPickNextObjectiveTime() { }

function float GetSpawnGateOpenTime() { }

function StartStasisTimer() { }

function EndStasisTimer() { }

event OnBotDied(TgAIController TgAIC) { }

function KillSiegeWallTowers(int nTaskForce) { }

function ConsoleEvent(name EventName) { }

function OpenInnerGates(byte TaskForceNum, bool bOpen) { }

function OpenOuterGates(byte TaskForceNum, bool bOpen) { }

function OpenAllAliveGates(bool bOpen) { }

function GlobalRespawnTimeUpdate(float fRespawnTime, bool bEnsureRespawnTimeDoesntIncrease) { }

function GlobalRespawnTimeUpdateHelper(Controller C, TgPawn TgP, float fRespawnTime, bool bEnsureRespawnTimeDoesntIncrease) { }

event RespawnAllPlayers(bool bResetLivingPlayers, optional bool bResetDeadPlayers=true, optional bool bResetHealth=true, optional bool bResetDevices=false) { }

function ResetAllPlayersNotInSpawnRoom() { }

function ResetAttackersNotInSpawnRoom() { }

function ResetDefendersNotInSpawnRoom() { }

function ResetPlayersNotInSpawnRoom(bool bResetAttackers, bool bResetDefenders) { }

function KillAllProjectiles() { }

function RemoveAllBurnCards() { }

function PlayLanePusherHelpText() { }

event LanePusherReachedOuterWall(TgPawn_LanePusher LanePusher) { }

event LanePusherReachedInnerWall(TgPawn_LanePusher LanePusher) { }

event LanePusherReachedBaseObjective(TgPawn_LanePusher LanePusher) { }

function RevivePlayers(optional TgRepInfo_TaskForce ReviveTF) { }

function TransitionToNextRound() { }

function UpdateAttackingTaskforceForRoundTransition() { }

function ResetScores() { }

function GotoGameRunningState() { }

event ChangeTimerState(TgObject.GameTimerState eTimerState) { }

function SendClientRoundObjectivesCompleted() { }

function SendClientRoundEnded() { }

function AutoMountPlayersOnTaskForce(optional int nTaskForceNum=-1, optional bool bInvertTaskForce=false) { }

function AutoMountAllPlayers() { }

function AutoMountAttackers() { }

function AutoMountDefenders() { }

function StartNewObjectiveRound(bool bFirstRound) { }

function SetSpawnGateTimers(bool bFirstRound) { }

function SetAutoMountTimers(bool bFirstRound) { }

function SetResetEscapedPlayersTimers(bool bFirstRound) { }

function StartGameMode() { }

event bool IsInGrimReaperMode() { }

function TgRepInfo_TaskForce GetAttackingTaskForce() { }

function TgRepInfo_TaskForce GetDefendingTaskForce() { }

function OnRoundEnded() { }

function CleanupTicketsForRound() { }

function ResetGameMode() { }

function UpdateObjectiveTimer() { }

function UpdateTgPawnMetaGameState(TgPawn CurPawn, optional TgPawn.EMetaGameState NewState=0) { }

function UpdateAllPawnsMetaGameState(optional TgPawn.EMetaGameState NewState=0) { }

function bool KillLanePusherWhenGateIsDestroyed() { }

function StartFogConverging() { }

function ResumeConvergeCompletely() { }

function ConvergeFog() { }

simulated function float GetTotalSplineDist(SplineActor Spline) { }

function ScorePayload() { }

function InitGameReplicationInfo() { }

function SetLanePusherSpeedScale(float fNewSpeedScale) { }

function SetTickets(int nTaskForce, float fNumTickets) { }

function GainTickets(int nTaskForce, float fNumTickets, TgGame_PaladinsExtended.EVictoryType VictoryType) { }

function ReachTicketLimit(int nTaskForce, TgGame_PaladinsExtended.EVictoryType VictoryType) { }

function OnPawnDied(TgPawn Victim) { }

function UpdateOccupationStatus(TgChaosCapturePoint capturePoint, int nNumTF1, int nNumTF2) { }

function bool AllowPausing(optional PlayerController PC) { }

function PauseDelay() { }

native function NotifyPauseDelay(PlayerController PC);  // Export UTgGame_PaladinsExtended::execNotifyPauseDelay(FFrame&, void* const)

state AttackDefend {}

state PreRoundSetup {}

state GameRunning {}

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
    m_GameType=TGT_CHAOS
    SupportedEvents=/* Array type was not detected. */
}
