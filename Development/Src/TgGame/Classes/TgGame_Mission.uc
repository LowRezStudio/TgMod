class TgGame_Mission extends TgGame
    native(Game)
    config(Game)
    hidecategories(Navigation,Movement,Collision)
    dependson(TgObject, TgRepInfo_Game);

const SURRENDER_TIME_SECS = 60.0;

const SURRENDER_TIME_BETWEEN = 180.0;

const MISSION_TIME_SETUP_SECS = 90.0;

const PLAYER_END_GAME_DELAY = 10.0f;

const FINISH_END_MISSION_DELAY = 300.0;

const PRE_GUARDIAN_PHASE_START = 7110.0f;

const GUARDIAN_PHASE_START = 7200.0f;

const PRE_MATCH_FROZEN_TIME_SECS = 3.0f;

struct SurrenderVote {
    var int nPlayerId;
    var bool bSurrender;
    structdefaultproperties {}
};

struct SurrenderData {
    var float fLastSurrenderTime;
    var array<SurrenderVote> SurrenderVotes;
    var int nSurrenderTotal;
    var int nSurrenderNeeded;
    var int nSurrenderVoteCount;
    var int nNoSurrenderVoteCount;
    structdefaultproperties {}
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

native function bool BeginEndMission(optional bool bClearNextMapGame=false, optional Actor EndMissionFocus, optional float fDelayOverride=0.0000000);  // Export UTgGame_Mission::execBeginEndMission(FFrame&, void* const)

native function LoadGameConfig();  // Export UTgGame_Mission::execLoadGameConfig(FFrame&, void* const)

native function SpoolCredits();  // Export UTgGame_Mission::execSpoolCredits(FFrame&, void* const)

native function TgPawn SpawnPlayerCharacter(Controller C, Vector vLocation);  // Export UTgGame_Mission::execSpawnPlayerCharacter(FFrame&, void* const)

native function SendMissionTimerEvent(int nEventId);  // Export UTgGame_Mission::execSendMissionTimerEvent(FFrame&, void* const)

native function UpdateMissionTimerEventWinVar();  // Export UTgGame_Mission::execUpdateMissionTimerEventWinVar(FFrame&, void* const)

native function float MissionTimeRemaining();  // Export UTgGame_Mission::execMissionTimeRemaining(FFrame&, void* const)

native function float MissionTimeElapsed();  // Export UTgGame_Mission::execMissionTimeElapsed(FFrame&, void* const)

native function MarkAsReady(Player P);  // Export UTgGame_Mission::execMarkAsReady(FFrame&, void* const)

native function AllPlayersRevive();  // Export UTgGame_Mission::execAllPlayersRevive(FFrame&, void* const)

native function AllPlayersFullVitals();  // Export UTgGame_Mission::execAllPlayersFullVitals(FFrame&, void* const)

native function AllPlayersRecall();  // Export UTgGame_Mission::execAllPlayersRecall(FFrame&, void* const)

native function PlayerSurrender(int nPlayerId, optional bool bSurrender=true);  // Export UTgGame_Mission::execPlayerSurrender(FFrame&, void* const)

native function SurrenderCompleteTimer1();  // Export UTgGame_Mission::execSurrenderCompleteTimer1(FFrame&, void* const)

native function SurrenderCompleteTimer2();  // Export UTgGame_Mission::execSurrenderCompleteTimer2(FFrame&, void* const)

native function SurrenderComplete(int nTaskForce);  // Export UTgGame_Mission::execSurrenderComplete(FFrame&, void* const)

native function EndGameBySurrender(int SurrenderingTaskForce);  // Export UTgGame_Mission::execEndGameBySurrender(FFrame&, void* const)

native function CapturedPoint(TgPawn_Character PC);  // Export UTgGame_Mission::execCapturedPoint(FFrame&, void* const)

native function CapturePointReclaimed(TgPawn_Character PC);  // Export UTgGame_Mission::execCapturePointReclaimed(FFrame&, void* const)

native function float GetMinIntroWait();  // Export UTgGame_Mission::execGetMinIntroWait(FFrame&, void* const)

native function ScoreKill(Controller Killer, Controller Other);  // Export UTgGame_Mission::execScoreKill(FFrame&, void* const)

native function ScoreKillCommon(out ScoreKillData Data);  // Export UTgGame_Mission::execScoreKillCommon(FFrame&, void* const)

native function ScoreKillGameType(out ScoreKillData Data);  // Export UTgGame_Mission::execScoreKillGameType(FFrame&, void* const)

native function ScoreKillAchievements(out ScoreKillData Data);  // Export UTgGame_Mission::execScoreKillAchievements(FFrame&, void* const)

native function bool GetScoreKillData(Controller Killer, Controller Other, out ScoreKillData Data);  // Export UTgGame_Mission::execGetScoreKillData(FFrame&, void* const)

native function NativeUpdateTimerState();  // Export UTgGame_Mission::execNativeUpdateTimerState(FFrame&, void* const)

native function bool IsFlankKill(out ScoreKillData Data);  // Export UTgGame_Mission::execIsFlankKill(FFrame&, void* const)

event PostBeginPlay() { }

function CreateMinimapManagers(Class<TgMinimapManager> managerClass) { }

event PostLogin(PlayerController NewPlayer) { }

function StartMatch() { }

function AddObjectiveScore(PlayerReplicationInfo Scorer, Int Score) { }

function OnPointCaptureOwnershipChanged(TgCapturePoint Point, int NewTaskForceOwner, int PreviousTaskForceOwner) { }

function UpdateLockedPointStatus() { }

function bool CheckScore(PlayerReplicationInfo Scorer) { }

event QuickEndGame(int nWinnerTF) { }

event TgTimer(out string sTimerCommand) { }

function bool StartGameTimer() { }

function KeepClientsInSync() { }

event SetMissionTime(float fTime) { }

event SetSecondaryMissionTime(float fTime) { }

event MissionTimerStart() { }

event MissionTimerStop() { }

event MissionTimerPause() { }

event MissionTimer() { }

event AllPlayersReady() { }

event ChangeTimerState(TgObject.GameTimerState eTimerState) { }

event bool MissionTimerActive() { }

event float ElapsedTime() { }

event MissionTimerModify(bool bPause, int nNewTime) { }

event MissionTimeIncrement(float fInc) { }

event SendMissionTimerNotify(TgRepInfo_Game.MissionTimerState eState, float fRemainingSecs) { }

event SendSecondaryMissionTimerNotify(TgRepInfo_Game.MissionTimerState eState, float fRemainingSecs) { }

function float GetSetupTime() { }

function float GetPlayerWaitTime() { }

event TgObject.GameTimerState GetMissionTimerStatus() { }

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
    m_MinimapManagerClass=Class'TgMinimapManager'
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
