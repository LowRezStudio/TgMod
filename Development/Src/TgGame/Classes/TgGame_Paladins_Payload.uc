class TgGame_Paladins_Payload extends TgGame_Paladins_Siege
    native(Game)
    config(Game)
    hidecategories(Navigation,Movement,Collision);

const TG_DISTANCE_CAP = 100000.0f;

var float s_fCurrentTF1FarthestPushDistance;
var float s_fCurrentTF2FarthestPushDistance;
var float s_fCurrentPushTimer;
var float s_fCurrentTF1FarthestPushDistanceTimestamp;
var float s_fCurrentTF2FarthestPushDistanceTimestamp;
var float s_fTimeTF1HadToPush;
var int m_nPayloadOnlyCurrentAttackingTeam;
var int s_nCurrentTurn;
var Vector s_vPayloadGhostLocation;
var () Vector s_vPayloadGhostOffset;
var Rotator s_PayloadGhostRotation;
var int m_nPayloadGhostID;
var TgDeployable m_PayloadGhost;

native function SpawnPayloadGhost();  // Export UTgGame_Paladins_Payload::execSpawnPayloadGhost(FFrame&, void* const)

native function SendStartRoundOnePointFromWinningAlert(int nTaskForceNum);  // Export UTgGame_Paladins_Payload::execSendStartRoundOnePointFromWinningAlert(FFrame&, void* const)

function StartGameMode() { }

function SetSpawnGateTimers(bool bFirstRound) { }

function OpenAttackersSpawnGates() { }

function OpenDefendersSpawnGates() { }

function float GetAttackersSpawnGateOpenTime() { }

function float GetDefendersSpawnGateOpenTime() { }

function SetAutoMountTimers(bool bFirstRound) { }

function SetResetEscapedPlayersTimers(bool bFirstRound) { }

event LanePusherReachedOuterWall(TgPawn_LanePusher LanePusher) { }

function BroadcastTimer() { }

function UpdateAttackingTaskforceForRoundTransition() { }

event UpdatePayloadProgress() { }

function float GetDistanceToEndOfSpline() { }

function TF2PushesPastTF1() { }

function TF2ReachesTF1Faster() { }

function TF2TakesLongerThanTF1() { }

function ManageComparativeScoring() { }

function OnRoundEnded() { }

function OvertimeExpired() { }

function PayloadExpired() { }

function float GetPayloadTimer() { }

function PayloadCheckpointReached(TgSplineActor_Payload Checkpoint) { }

simulated function SetCheckpoint1Reached() { }

simulated function SetCheckpoint2Reached() { }

simulated function ClearCheckpointsReached() { }

function ToggleAttackingTaskforce() { }

function CaptureAndPayloadRoundEnded() { }

state GameRunning {}

state AttackDefend {}

defaultproperties
{
    m_nPayloadOnlyCurrentAttackingTeam=1
    s_nCurrentTurn=1
    s_vPayloadGhostOffset=(X=0.0000000,Y=0.0000000,Z=-60.0000000)
    m_nPayloadGhostID=828
    m_nPointsForCapturing=0
    m_nPointsForPayload=0
    m_nPointsForDefending=0
    m_bFadeOutAtRoundEnd=true
    m_fPayloadDuration=420.0000000
    m_nWinningScore=1
    m_bKeepThisPointForNextRound=true
    m_fObjectivePickTime=50.0000000
    m_fSetupObjectivePickTime=50.0000000
    m_fSpawnGateOpenTime=50.0000000
    m_fAttackersSpawnGateOpenTime=50.0000000
    m_fDefendersSpawnGateOpenTime=10.0000000
    m_fSpeedScale=0.4000000
    m_nStartingCredits=1000
    m_fCreditsToGivePerTick=2.0000000
    m_GameType=TGT_CHAOS_PAYLOAD
    SupportedEvents=/* Array type was not detected. */
}
