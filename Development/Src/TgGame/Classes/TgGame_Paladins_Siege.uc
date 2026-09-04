class TgGame_Paladins_Siege extends TgGame_PaladinsExtended
    native(Game)
    config(Game)
    hidecategories(Navigation,Movement,Collision);

var config transient int m_nPointsForCapturing;
var config transient int m_nPointsForPayload;
var config transient int m_nPointsForDefending;
var config transient int m_nPointsForPayloadCheckpoint;
var config int m_nCreditsForWinningARound;
var config int m_nCreditsForCapturingPoint;
var config int m_nCreditsForSuccessfulDefend;
var config int m_nCreditsForSuccessfulPush;
var config bool m_bRespawnDeadPlayersAfterRound;
var config bool m_bRespawnLivePlayersAfterRound;
var config bool m_bRoundTreatment;
var config bool m_bCanWinOnDefense;
var bool m_bInCapturePointOvertime;
var bool m_bInPayloadOvertime;
var bool m_bDestroyPayloadCartAfterPayloadPhase;
var config bool m_bDoNotSwitchPoints;
var transient bool m_bHasHitCheckpoint;
var config bool m_bFadeOutAtRoundEnd;
var config float m_fLosingCaptureRateModifier;
var config float m_fDurationUntilCaptureOvertime;
var config float m_fCaptureOvertimeWarningDuration;
var const config float m_fPayloadDuration;
var const config float m_fPayloadOvertimeDuration;
var const config float m_fPayloadDurationCheckpoint;
var const config float m_fRoundEndRespawnDelay;
var int s_nCurrentRound;

native function TrackPushAttempt(TgRepInfo_TaskForce Taskforce);  // Export UTgGame_Paladins_Siege::execTrackPushAttempt(FFrame&, void* const)

native function TrackPushSuccess(TgRepInfo_TaskForce Taskforce);  // Export UTgGame_Paladins_Siege::execTrackPushSuccess(FFrame&, void* const)

native function TrackMapLane(int laneID);  // Export UTgGame_Paladins_Siege::execTrackMapLane(FFrame&, void* const)

native function TickOvertime(float DeltaSeconds);  // Export UTgGame_Paladins_Siege::execTickOvertime(FFrame&, void* const)

function PostBeginPlay() { }

function TaskforceWin(int nTaskForce, TgGame_PaladinsExtended.EVictoryType VictoryType) { }

function SetOvertime(float fOvertime, float fOvertimeWarning) { }

function float GetPointCaptureScoreMultiplier(int nTaskForce) { }

function RewardPointCapture(int nTaskForce) { }

function TgChaosCapturePoint GetCurrentCapturePoint() { }

function PickNextObjective() { }

function EnableUltWhenObjectiveStateUpdated() { }

function EnableCreditSpoolingWhenObjectiveStateUpdated() { }

function TgPawn_SiegeEngine_Payload GetSiegeEnginePush() { }

event LanePusherReachedInnerWall(TgPawn_LanePusher LanePusher) { }

event LanePusherReachedOuterWall(TgPawn_LanePusher LanePusher) { }

function SetPayloadTimer(float fDuration, bool overtime) { }

function OnRoundEnded() { }

function AwardTPOnRoundEnded() { }

function bool ShouldSelectNextCapturePointForLoading() { }

function CaptureAndPayloadRoundEnded() { }

function OpenSpawnGates() { }

function BroadcastTimer() { }

function PointCapturePhaseCleanup() { }

function PayloadPhaseCleanup() { }

function NavigationPoint FindPlayerStart(Controller Player, optional byte InTeam, optional string IncomingName) { }

function TriggerSuccessfulDefense(int nTaskForce) { }

function TriggerSuccessfulPush(int nTaskForce) { }

simulated function TriggerCapturePointVictory() { }

simulated function TriggerPayloadVictory(int nTaskForce) { }

function FogOvertimeWarning() { }

function FogOvertime() { }

function FogOvertimeEnd() { }

function int GetGameSpawnPhase(TgPawn TgP) { }

function int GetCurrentLane() { }

state AttackDefend {}

state RoundEnded {}

state GameRunning {}

defaultproperties
{
    m_nPointsForCapturing=1
    m_nPointsForPayload=1
    m_nPointsForDefending=1
    m_nPointsForPayloadCheckpoint=1
    m_nCreditsForCapturingPoint=300
    m_bRespawnDeadPlayersAfterRound=true
    m_bRespawnLivePlayersAfterRound=true
    m_bRoundTreatment=true
    m_bDestroyPayloadCartAfterPayloadPhase=true
    m_bDoNotSwitchPoints=true
    m_fLosingCaptureRateModifier=15.0000000
    m_fPayloadDuration=150.0000000
    m_fPayloadOvertimeDuration=6.0000000
    m_fPayloadDurationCheckpoint=120.0000000
    m_fRoundEndRespawnDelay=5.0000000
    s_nCurrentRound=1
    m_nWinningScore=4
    m_bCanCaptureDuringSurvival=true
    m_bRevivePlayersWhenSiegeEngineDies=false
    m_bAutoMountAtRoundBegin=true
    m_bResetPlayersNotInSpawnRoom=true
    m_fObjectivePickTime=30.0000000
    m_fSetupObjectivePickTime=25.0000000
    m_fSpawnGateOpenTime=40.0000000
    m_fSetupSpawnGateOpenTime=50.0000000
    m_fDefenseRespawnIncrease=2.0000000
    m_fAttackRespawnIncrease=-4.0000000
    m_fCapturePointsPerSecond1=3.0000000
    m_fCapturePointsPerSecond2=3.0000000
    m_fCapturePointsPerSecond3=3.0000000
    m_fCapturePointsPerSecond4=3.0000000
    m_fCapturePointsPerSecond5=3.0000000
    m_GameType=TGT_CHAOS_CAPTUREANDPAYLOAD
    SupportedEvents=/* Array type was not detected. */
}
