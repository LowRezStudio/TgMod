class TgRepInfo_Game extends GameReplicationInfo
    native(Game)
    config(Game)
    hidecategories(Navigation,Movement,Collision)
    dependson(TgAIController_Behavior, TgAIDirector, TgObject);

const TG_MAX_MAP_OBJECTIVES = 75;

const TG_MAX_CAPTURE_POINTS = 5;

enum MissionTimerState {
    MTS_STOPPED,  // 0
    MTS_RUNNING,  // 1
    MTS_PAUSED,  // 2
};

enum MAP_LANE {
    MAP_LANE_NONE,  // 0
    MAP_LANE_LEFT,  // 1
    MAP_LANE_MIDDLE,  // 2
    MAP_LANE_RIGHT,  // 3
};

enum EFlagState {
    FLAG_Home,  // 0
    FLAG_HeldFriendly,  // 1
    FLAG_HeldEnemy,  // 2
    FLAG_Down,  // 3
};

struct GraphData {
    var int XP;
    var int Gold;
    var int Time;
    structdefaultproperties {}
};

struct BotDifficultyDebugData {
    var bool CurrentlyActive;
    var bool DisparityDetected;
    var bool ChangesLockedOut;
    var int TimeBeforeTrigger;
    var TgAIController_Behavior.EBotDifficultyLevel TaskForce1BotDifficulty;
    var TgAIController_Behavior.EBotDifficultyLevel TaskForce2BotDifficulty;
    var float TaskForce1Skill;
    var float TaskForce2Skill;
    var SkillLevelPercentageData SkillPercentages[2];
    structdefaultproperties {}
};

var array<GraphData> m_GraphData;
var GraphData r_LastDataPoint;
var float m_GraphUpdateWaitTime;
var repnotify TgObject.TG_GAME_TYPE r_GameType;
var TgObject.INITIALIZEABLE_BOOL r_eTalentsEnabled;
var TgRepInfo_Game.MissionTimerState r_nMissionTimerState;
var repnotify TgObject.GameTimerState r_eGameTimerState;
var TgRepInfo_Game.MissionTimerState r_nRoundLimitTimerState;
var TgRepInfo_Game.MissionTimerState r_nSecondaryTimerState;
var byte r_nLastRoundAttacker;
var byte r_nLastRoundWinner;
var TgRepInfo_Game.EFlagState r_FlagState[2];
var repnotify TgObject.EGameEnvironmentRule r_GameEnvironmentRule;
var TgObject.EGameRespawnRule r_GameRespawnRule;
var TgObject.EGameMode r_GameMode;
var bool r_bIsMission;
var bool r_bBlockCreditGain;
var bool r_bBlockEnergyGain;
var bool r_bOvertime;
var bool r_bCapturePointOvertime;
var bool r_bRoundEnding;
var bool r_bFadeOutAtRoundEnd;
var repnotify bool r_bIntroPlayed;
var repnotify bool r_bUsePointsMode;
var bool r_bUltimatesLocked;
var bool r_bEnableDistanceFOW;
var repnotify bool r_bSpawnGatesOpen;
var repnotify bool r_bAttackersSpawnGatesOpen;
var repnotify bool r_bDefendersSpawnGatesOpen;
var bool r_bForwardProgress;
var bool r_bServerFlagSprint;
var bool r_bServerFlagMinimapTeamVisibility;
var bool r_bForce3P;
var bool r_bForce1P;
var bool r_bForceOutOfCombatSprint;
var bool r_bAutoMelee;
var bool r_bShowProjectileProximityDistance;
var bool r_bDisableProjectileProximityDistance;
var repnotify bool r_bShowHeadMesh;
var bool m_fFogSettingsSaved;
var config bool r_bUseInstantFireMeshTrace;
var config bool r_bAllowWeaponLagPrediction;
var bool r_bSiegeEngineRequiresAlliesToMove;
var bool r_bSiegeEngineMovementPaused;
var bool r_bSiegeEngineMovementPausedAfterDamagingGate;
var bool r_bFogConverging;
var bool r_bFogEnded;
var bool r_bCheckpoint1Reached;
var bool r_bCheckpoint2Reached;
var private bool r_bEnableHeadshots;
var bool r_bAllowPlayerMounting;
var bool r_bKillCamEnabled;
var bool r_bAttackersKillCamEnabled;
var bool r_bDefendersKillCamEnabled;
var bool r_bBlockKillCam;
var bool r_bIsFirstRound;
var bool r_bGhostMountingEnabled;
var bool r_bSpawnGatesOpenedAtLeastOnce;
var float r_fMissionRemainingTime;
var repnotify int r_nMissionTimerStateChange;
var float r_fMissionTime;
var float c_fMissionTime;
var float c_fMissionTimeSeconds;
var float c_fAIBotDelaySeconds;
var float r_fRoundLimitElapsed;
var float r_fRoundLimitDuration;
var float r_fSecondaryRemainingTime;
var repnotify int r_nSecondaryTimerStateChange;
var float r_fSecondaryTime;
var float c_fSecondaryMissionTime;
var float c_fSecondaryMissionTimeSeconds;
var float r_fCapturePointOvertimeStartDuration;
var repnotify int r_nCapturePointOvertimeStateChange;
var float r_fPayloadOvertimeStartDuration;
var repnotify int r_nPayloadOvertimeStateChange;
var float r_fTF1PayloadPushDistance;
var int r_nPurchaseTime;
var float m_fPurchaseTimer;
var repnotify TgRepInfo_TaskForce r_AttackingTaskForce;
var repnotify TgRepInfo_TaskForce r_CapturingTaskForce;
var int r_nChaosRemainingAttackDefendTime;
var int r_nCapturePoints[5];
var TgRepInfo_TaskForce r_Winner;
var float r_fPhysicsThreshold;
var string r_sQueueName;
var int r_nPlayOfTheGamePawnId;
var int r_nPlayOfTheGameMapLane;
var float r_fPlayOfTheGameTimeStamp;
var TgPlayOfTheGameCamera c_PlayOfTheGameCamera;
var init transient array<init TgDeployable> m_Deployables;
var init transient array<init TgProjectile> m_Projectiles;
var init transient array<init TgDestructible> m_Destructibles;
var init transient array<init TgRepInfo_Deployable> m_DRIArray;
var init transient array<init TgRepInfo_CapturePoint> m_CPRIArray;
var init transient array<init TgChaosCapturePoint> m_CapturePoints;
var init transient array<init TgDeployable> m_MovableProjBlockers;
var repnotify transient int r_nCurrentCheckpoint[2];
var transient int c_nNextClientOnlyProjectileInstanceId;
var TgPawn_LanePusher r_LanePusher;
var TgPawn_LanePusherBase r_LanePusher1;
var TgPawn_LanePusherBase r_LanePusher2;
var TgPawn r_SquadTarget1;
var TgPawn r_SquadTarget2;
var float r_fLastSquadTargetUpdate1;
var float r_fLastSquadTargetUpdate2;
var float r_fSpeedScale;
var float r_fPayloadProgressPercent;
var float r_fCheckpoint1Percent;
var float r_fCheckpoint2Percent;
var float r_fServerFlagDamageMultiplier;
var float r_fServerFlagGroundSpeedModifier;
var float r_fServerFlagAutoHealingMultiplier;
var TgPawn_SiegeWall r_pSiegeWallTF1[3];
var TgPawn_SiegeWall r_pSiegeWallTF2[3];
var float m_fSavedFogDensity;
var float m_fSavedFogStartDistance;
var Color m_SavedFogColor;
var int r_nRemainingObjectiveTime;
var int r_nTotalObjectiveTime;
var float r_fPlayerViewDistance;
var float r_fVisibilityVolumeViewDistance;
var float r_fPushTimer;
var float r_fWeaponMaxLagCompensation;
var float m_fVaultImmuneToSiegeEngineHealth;
var float r_fConvergeDistance;
var float r_fConvergeStartDistance;
var float r_fFogConvergeInterval;
var repnotify int r_nTaskForcePushSuccessful;
var repnotify int r_nTaskForceDefenseSuccessful;
var int r_nMapLane;
var float r_fGlobalFrictionFalling;
var float r_fGlobalFrictionFlying;
var BotDifficultyDebugData r_DifficultyDebugData;

replication {
    if(int(Role) == int(ENetRole.ROLE_Authority)) r_AttackingTaskForce, r_CapturingTaskForce, r_DifficultyDebugData, r_FlagState, r_GameEnvironmentRule, r_GameMode, r_GameRespawnRule, r_LanePusher, r_LanePusher1, r_LanePusher2, r_Winner, r_bAllowPlayerMounting, r_bAllowWeaponLagPrediction, r_bAttackersKillCamEnabled, r_bAttackersSpawnGatesOpen, r_bAutoMelee, r_bBlockCreditGain, r_bBlockKillCam, r_bCheckpoint1Reached, r_bCheckpoint2Reached, r_bDefendersKillCamEnabled, r_bDefendersSpawnGatesOpen, r_bDisableProjectileProximityDistance, r_bEnableDistanceFOW, r_bEnableHeadshots, r_bFadeOutAtRoundEnd, r_bFogConverging, r_bFogEnded, r_bForce1P, r_bForce3P, r_bForceOutOfCombatSprint, r_bForwardProgress, r_bIntroPlayed, r_bIsFirstRound, r_bKillCamEnabled, r_bRoundEnding, r_bServerFlagMinimapTeamVisibility, r_bServerFlagSprint, r_bShowHeadMesh, r_bShowProjectileProximityDistance, r_bSiegeEngineMovementPaused, r_bSiegeEngineMovementPausedAfterDamagingGate, r_bSiegeEngineRequiresAlliesToMove, r_bSpawnGatesOpen, r_bSpawnGatesOpenedAtLeastOnce, r_bUltimatesLocked, r_bUseInstantFireMeshTrace, r_bUsePointsMode, r_eGameTimerState, r_eTalentsEnabled, r_fCheckpoint1Percent, r_fCheckpoint2Percent, r_fConvergeDistance, r_fConvergeStartDistance, r_fFogConvergeInterval, r_fMissionRemainingTime, r_fMissionTime, r_fPayloadProgressPercent, r_fPlayerViewDistance, r_fRoundLimitDuration, r_fRoundLimitElapsed, r_fSecondaryRemainingTime, r_fSecondaryTime, r_fSpeedScale, r_fTF1PayloadPushDistance, r_fWeaponMaxLagCompensation, r_nChaosRemainingAttackDefendTime, r_nCurrentCheckpoint, r_nLastRoundAttacker, r_nLastRoundWinner, r_nMapLane, r_nMissionTimerState, r_nMissionTimerStateChange, r_nPurchaseTime, r_nRemainingObjectiveTime, r_nRoundLimitTimerState, r_nSecondaryTimerState, r_nSecondaryTimerStateChange, r_nTaskForceDefenseSuccessful, r_nTaskForcePushSuccessful, r_nTotalObjectiveTime, r_pSiegeWallTF1, r_pSiegeWallTF2;
    if(int(Role) == int(ENetRole.ROLE_Authority)) r_GameType, r_bIsMission, r_fPhysicsThreshold, r_sQueueName;
    if((int(Role) == int(ENetRole.ROLE_Authority)) && bNetDirty) r_bGhostMountingEnabled, r_fGlobalFrictionFalling, r_fGlobalFrictionFlying;
}

native function int GetDeployableCount();  // Export UTgRepInfo_Game::execGetDeployableCount(FFrame&, void* const)

native function TgDeployable GetDeployable(int nIndex);  // Export UTgRepInfo_Game::execGetDeployable(FFrame&, void* const)

native function TgProjectile GetProjectile(int nIndex);  // Export UTgRepInfo_Game::execGetProjectile(FFrame&, void* const)

native function TgRepInfo_TaskForce GetTaskForceFor(const Actor Actor);  // Export UTgRepInfo_Game::execGetTaskForceFor(FFrame&, void* const)

native function TgRepInfo_TaskForce GetTaskForce(int nTaskForceNum, optional bool bCreate=false);  // Export UTgRepInfo_Game::execGetTaskForce(FFrame&, void* const)

native function TgRepInfo_TaskForce CreateTaskForce(int nTaskForceNum);  // Export UTgRepInfo_Game::execCreateTaskForce(FFrame&, void* const)

native function bool TaskForceEnumerate(out TgRepInfo_TaskForce rpTaskForce, out int rnTaskForceNum, optional bool bPlayerOnly=true);  // Export UTgRepInfo_Game::execTaskForceEnumerate(FFrame&, void* const)

native function int GetNumNearbyPlayers(int nTaskForceNum, Vector vLocation, float fDist);  // Export UTgRepInfo_Game::execGetNumNearbyPlayers(FFrame&, void* const)

native function GetOpposingTeamsPawns(const TgPawn instigatingPawn, out array<TgPawn_Character> enemyPawns);  // Export UTgRepInfo_Game::execGetOpposingTeamsPawns(FFrame&, void* const)

native function TgRepInfo_TaskForce GetAttackingTaskForce();  // Export UTgRepInfo_Game::execGetAttackingTaskForce(FFrame&, void* const)

native function TgRepInfo_TaskForce GetDefendingTaskForce();  // Export UTgRepInfo_Game::execGetDefendingTaskForce(FFrame&, void* const)

native simulated function bool CheckIsEnemy(const Actor A, const Actor B);  // Export UTgRepInfo_Game::execCheckIsEnemy(FFrame&, void* const)

native function UpdateGameClockUI();  // Export UTgRepInfo_Game::execUpdateGameClockUI(FFrame&, void* const)

native function UpdateGameScoreUI();  // Export UTgRepInfo_Game::execUpdateGameScoreUI(FFrame&, void* const)

native function UpdateGameTransitionUI();  // Export UTgRepInfo_Game::execUpdateGameTransitionUI(FFrame&, void* const)

native function GameStateChanged();  // Export UTgRepInfo_Game::execGameStateChanged(FFrame&, void* const)

native function GameTypeSet();  // Export UTgRepInfo_Game::execGameTypeSet(FFrame&, void* const)

native function SpawnGatesOpenChanged();  // Export UTgRepInfo_Game::execSpawnGatesOpenChanged(FFrame&, void* const)

native function AttackersSpawnGatesOpenChanged();  // Export UTgRepInfo_Game::execAttackersSpawnGatesOpenChanged(FFrame&, void* const)

native function DefendersSpawnGatesOpenChanged();  // Export UTgRepInfo_Game::execDefendersSpawnGatesOpenChanged(FFrame&, void* const)

native function TgProj_Simulated GetClientSpawnedProjectile(int ClientFireRequestId);  // Export UTgRepInfo_Game::execGetClientSpawnedProjectile(FFrame&, void* const)

native function TgProj_Simulated GetSimulatedProjectile(int nProjectileId);  // Export UTgRepInfo_Game::execGetSimulatedProjectile(FFrame&, void* const)

native function TgProj_Simulated SpawnSimulatedProjectile(int nProjectileInstanceId, int nFireModeId, Actor pOwner, Vector vLocation, Vector vRotation, optional int nProjectileIdOverride=0, optional bool bPredictStartLocationBasedOnPing=false);  // Export UTgRepInfo_Game::execSpawnSimulatedProjectile(FFrame&, void* const)

native function TgRepInfo_Game.MAP_LANE GetLane(int nLane, TgRepInfo_TaskForce tfri);  // Export UTgRepInfo_Game::execGetLane(FFrame&, void* const)

native function bool SiegeEngineRequiresAlliesToMove();  // Export UTgRepInfo_Game::execSiegeEngineRequiresAlliesToMove(FFrame&, void* const)

native function RecalcRespawnTimers();  // Export UTgRepInfo_Game::execRecalcRespawnTimers(FFrame&, void* const)

native function bool AllowHeadShots();  // Export UTgRepInfo_Game::execAllowHeadShots(FFrame&, void* const)

native function TgChaosCapturePoint GetActiveCapturePoint();  // Export UTgRepInfo_Game::execGetActiveCapturePoint(FFrame&, void* const)

simulated event ReplicatedEvent(name VarName) { }

simulated function ShowHeadMesh() { }

simulated function HideHeadMesh() { }

simulated function SetGameEnvironmentRule(TgObject.EGameEnvironmentRule Rule) { }

simulated function SetGameRespawnRule(TgObject.EGameRespawnRule Rule) { }

simulated function SetGameMode(TgObject.EGameMode Mode) { }

simulated function OnFogAdded(ExponentialHeightFog Fog) { }

simulated function GameEnvironmentRuleUpdated() { }

simulated function UpdateFog(optional ExponentialHeightFog Fog) { }

simulated function UpdateAttackingTaskforce(TgRepInfo_TaskForce NewAttackingTaskForce) { }

simulated event PostBeginPlay() { }

simulated function InitMissionTime() { }

simulated function InitSecondaryMissionTime() { }

simulated function UpdateMissionTimer(optional bool bForcePrimary, optional bool bForceSecondary) { }

function MissionTimeUpdateAllClients() { }

simulated function AddDRI(TgRepInfo_Deployable DRI) { }

simulated function RemoveDRI(TgRepInfo_Deployable DRI) { }

simulated function AddCPRI(TgRepInfo_CapturePoint CPRI) { }

simulated function RemoveCPRI(TgRepInfo_CapturePoint CPRI) { }

simulated function AddCapturePoint(TgChaosCapturePoint pPoint) { }

simulated function RemoveCapturePoint(TgChaosCapturePoint pPoint) { }

simulated function AddDestructible(TgDestructible Dest) { }

simulated function RemoveDestructible(TgDestructible Dest) { }

simulated event int GetNextClientOnlyProjectileInstanceId() { }

function SetFlagHome(int TeamIndex) { }

simulated function bool FlagIsHome(int TeamIndex) { }

simulated function bool FlagsAreHome() { }

function SetFlagHeldFriendly(int TeamIndex) { }

simulated function bool FlagIsHeldFriendly(int TeamIndex) { }

function SetFlagHeldEnemy(int TeamIndex) { }

simulated function bool FlagIsHeldEnemy(int TeamIndex) { }

function SetFlagDown(int TeamIndex) { }

simulated function bool FlagIsDown(int TeamIndex) { }

event SetCheckpoint(int NewCheckpoint, int Taskforce) { }

function SetUsePointsMode(bool bValue, int nValue) { }

function DecrementPoints(int nTaskForce, int nValue) { }

simulated event float GetMissionTime() { }

function SendPayloadMissionEvent(int nEventId, TgRepInfo_TaskForce attackingTaskForce, TgRepInfo_TaskForce WinningTaskForce) { }

simulated function ProcessMissionTimerEvent(int nEventId, byte nAttackingTaskForce, byte nWinningTaskForce) { }

function SetEnableHeadshots(bool bEnable) { }

event AddPotGEventToAllPlayers(TgObject.EPlayOfTheGameEventType potgEvent) { }

native function bool AllowPlayerMounting();  // Export UTgRepInfo_Game::execAllowPlayerMounting(FFrame&, void* const)

defaultproperties
{
    r_bIsMission=true
    r_bEnableDistanceFOW=true
    r_bServerFlagSprint=true
    r_bServerFlagMinimapTeamVisibility=true
    r_bAutoMelee=true
    r_bShowHeadMesh=true
    r_bAllowWeaponLagPrediction=true
    r_bKillCamEnabled=true
    c_fAIBotDelaySeconds=30.0000000
    r_nPurchaseTime=120
    m_fPurchaseTimer=120.0000000
    r_nPlayOfTheGameMapLane=-1
    c_nNextClientOnlyProjectileInstanceId=-1
    r_fSpeedScale=1.0000000
    r_fServerFlagDamageMultiplier=1.0000000
    r_fServerFlagGroundSpeedModifier=1.0000000
    r_fServerFlagAutoHealingMultiplier=1.0000000
    r_fWeaponMaxLagCompensation=0.3000000
    m_fVaultImmuneToSiegeEngineHealth=1.0000000
    r_fFogConvergeInterval=1.0000000
    r_DifficultyDebugData=(CurrentlyActive=true,DisparityDetected=false,ChangesLockedOut=false,TimeBeforeTrigger=0,TaskForce1BotDifficulty=AIDifficulty_Medium1,TaskForce2BotDifficulty=AIDifficulty_Medium1,TaskForce1Skill=0.0000000,TaskForce2Skill=0.0000000,SkillPercentages=(NumDeathsPercentage=0.0000000,DamagePercentage=0.0000000,KillsPercentage=0.0000000,SoloKillsPercentage=0.0000000,AssistsPercentage=0.0000000,HealingPercentage=0.0000000,CreditsPercentage=0.0000000,ObjectiveTimePercentage=0.0000000,ShieldingPercentage=0.0000000,KillstreakMultiplier=0.0000000),SkillPercentages[1]=(NumDeathsPercentage=0.0000000,DamagePercentage=0.0000000,KillsPercentage=0.0000000,SoloKillsPercentage=0.0000000,AssistsPercentage=0.0000000,HealingPercentage=0.0000000,CreditsPercentage=0.0000000,ObjectiveTimePercentage=0.0000000,ShieldingPercentage=0.0000000,KillstreakMultiplier=0.0000000))
    bReplicateMovement=false
}
