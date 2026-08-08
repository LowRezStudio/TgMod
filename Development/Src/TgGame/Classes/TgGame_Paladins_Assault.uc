class TgGame_Paladins_Assault extends TgGame_Paladins_Siege
    native(Game)
    config(Game)
    hidecategories(Navigation,Movement,Collision);

var config float m_fAttackDuration;
var const config float m_fAttackPhaseOvertimeDuration;
var config float m_fAttackCaptureRateMultiplier;
var TgChaosCapturePoint m_AttackPoint;
var bool m_bInAttackPhaseOvertime;
var float m_fTakeoverSecondPhaseInstructionDelay;

native function SendAssaultPointCapturedAlert(int Taskforce);  // Export UTgGame_Paladins_Assault::execSendAssaultPointCapturedAlert(FFrame&, void* const)

function ActivateTaskforceSpecificCapturePoint(int TaskForceId) { }

function float GetPointCaptureScoreMultiplier(int nTaskForce) { }

function NotifyPlayersOfPointCapture() { }

function InstructClientsOnTakeoverSecondPhase() { }

function bool ShouldHandlePointCaptureBacksliding() { }

function TgChaosCapturePoint GetCurrentCapturePoint() { }

function CaptureAndPayloadRoundEnded() { }

function bool AttackersOnPoint() { }

state GameRunning {}

state AttackDefend {}

defaultproperties
{
    m_fAttackDuration=180.0000000
    m_fAttackPhaseOvertimeDuration=6.0000000
    m_fAttackCaptureRateMultiplier=2.0000000
    m_fTakeoverSecondPhaseInstructionDelay=3.0000000
    m_fPayloadDuration=180.0000000
    m_nWinningScore=5
    m_bSpawnLanePusherWhenPointCaptured=false
    m_fSetupObjectivePickTime=30.0000000
    m_fSpawnGateOpenTime=30.0000000
    m_fSetupSpawnGateOpenTime=30.0000000
    m_fBackslidePercent=75.0000000
    m_fBackslideDelay=5.0000000
    m_fBackslideRate=2.5000000
}
