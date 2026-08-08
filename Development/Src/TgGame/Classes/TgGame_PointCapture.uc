class TgGame_PointCapture extends TgGame_Battle
    native(Game)
    config(Game)
    hidecategories(Navigation,Movement,Collision)
    dependson(TgObject);

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

native function float GetRespawnTime(int TaskForceNum);  // Export UTgGame_PointCapture::execGetRespawnTime(FFrame&, void* const)

native function MarkAsReady(Player P);  // Export UTgGame_PointCapture::execMarkAsReady(FFrame&, void* const)

native function EndGameBySurrender(int SurrenderingTaskForce);  // Export UTgGame_PointCapture::execEndGameBySurrender(FFrame&, void* const)

native function bool BeginEndMission(optional bool bClearNextMapGame=false, optional Actor EndMissionFocus, optional float fDelayOverride=0.0000000);  // Export UTgGame_PointCapture::execBeginEndMission(FFrame&, void* const)

native function ScoreKillGameType(out ScoreKillData Data);  // Export UTgGame_PointCapture::execScoreKillGameType(FFrame&, void* const)

native function CapturedPoint(TgPawn_Character PC);  // Export UTgGame_PointCapture::execCapturedPoint(FFrame&, void* const)

native function CapturePointReclaimed(TgPawn_Character PC);  // Export UTgGame_PointCapture::execCapturePointReclaimed(FFrame&, void* const)

native function AlertAboutToLose(int nTaskForce);  // Export UTgGame_PointCapture::execAlertAboutToLose(FFrame&, void* const)

native function UpdateGameWinState(TgPawn nexus);  // Export UTgGame_PointCapture::execUpdateGameWinState(FFrame&, void* const)

native function SendBonusMinionAlerts(TgRepInfo_TaskForce tf, int nLane);  // Export UTgGame_PointCapture::execSendBonusMinionAlerts(FFrame&, void* const)

native function StructureDied(TgPawn_Structure theStructure);  // Export UTgGame_PointCapture::execStructureDied(FFrame&, void* const)

native function ApplyTowerImmunity();  // Export UTgGame_PointCapture::execApplyTowerImmunity(FFrame&, void* const)

native function int GetNextVulnerableTowerId(int nBotId);  // Export UTgGame_PointCapture::execGetNextVulnerableTowerId(FFrame&, void* const)

native function bool ShouldSpawnSuperMinions(TgBotFactory_Minions minionFactory);  // Export UTgGame_PointCapture::execShouldSpawnSuperMinions(FFrame&, void* const)

event Actor GetEndFocusActor() { }

function float GetSetupTime() { }

function bool StartGameTimer() { }

function SpawnNeutralBots() { }

event ChangeTimerState(TgObject.GameTimerState eTimerState) { }

function CheckTickets() { }

function CheckWinCondition() { }

event CheckWinState() { }

function SpawnWaveTeam1Timer() { }

function SpawnWaveTeam2Timer() { }

function float GetTaskForceDominatingFactor(int TaskForceNum) { }

function UpdateLockedPointStatus() { }

function OnPointCaptureOwnershipChanged(TgCapturePoint Point, int NewTaskForceOwner, int PreviousTaskForceOwner) { }

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
    m_GameType=TGT_POINTCAPTURE
    GoalScore=400
}
