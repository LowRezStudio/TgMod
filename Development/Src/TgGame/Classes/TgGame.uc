class TgGame extends FrameworkGame
    abstract
    native(Game)
    config(Game)
    hidecategories(Navigation,Movement,Collision)
    dependson(TgObject);

const UNKNOWN_PROJECTILE_INSTANCE_ID = 0;

const FIRST_VALID_PROJECTILE_INSTANCE_ID = 1;

const BASE_RESPAWN_TIME_SEC = 5;

const DEFAULT_MOUNT = 11512;

struct PlayOfTheGameInfo {
    var TgRepInfo_Player PRI;
    var float Rating;
    structdefaultproperties {}
};

struct PlayOfTheGameEventConfig {
    var TgObject.EPlayOfTheGameEventType EventType;
    var float BaseRating;
    var float MultMod;
    var float MaxTimeDiff;
    var bool ScaleByTimeDiff;
    var int MaxMultInstances;
    var float Threshold;
    var float ThresholdTimeOut;
    structdefaultproperties {}
};

struct TgAIBotPlayersToSpawn {
    var init string fsName;
    var int nBotId;
    var int nTaskForceId;
    var int nSpawnTableDetailId;
    structdefaultproperties {}
};

var Class m_ContentPackageReference;
var TgObject.GAME_WIN_STATE m_GameWinState;
var TgObject.TG_GAME_TYPE m_GameType;
var float m_fSpawnProtectionTime;
var float m_fMaxRepawnTime;
var float m_fUnpauseCountdownRemaining;
var int s_nBotPlayerCount;
var bool s_bGameInitialized;
var bool s_bGameEndMissionProcessed;
var bool s_bMissionSealed;
var const bool m_bForceUsePRISpawnPoint;
var bool m_bRewardCalculated;
var bool m_bStatsCanTie;
var bool m_bStatsIsSymmetric;
var protected bool m_bIsTutorialGametype;
var protected bool m_bIsPracticeGametype;
var globalconfig bool m_bEnableHeadShots;
var bool m_bPlayOfTheGameLocked;
var protected int s_nNextActorInstanceId;
var protected int s_nNextProjectileInstanceId;
var init array<init TgAIVolume> s_AIVolumes;
var init array<init int> s_Taskforce1AIVolumesIndices;
var init array<init int> s_Taskforce2AIVolumesIndices;
var init array<init TgFortressVolume> s_FortressVolumes;
var init array<init TgDeviceVolume> s_DeviceVolumes;
var array<TgActorFactory> s_ActorFactories;
var float s_fXPModifier;
var const config float m_fGlobalCooldownTime;
var init array<init int> m_ClientLogins;
var config float m_fOcclusionCalcPeriod;
var config float m_fOcclusionMaxDeviation;
var PlayOfTheGameInfo m_PlayOfTheGame;
var float m_fPlayOfTheGameLength;
var float m_fPlayOfTheGameIntroBufferLength;
var float m_fPlayOfTheGameOuttroBufferLength;
var array<PlayOfTheGameEventConfig> m_PlayOfTheGameEventConfigs;
var array<TgSpawnTeleporterExit> m_PlayerSpawnExits;

native function LoadGameConfig();  // Export UTgGame::execLoadGameConfig(FFrame&, void* const)

native function InitGameRepInfo();  // Export UTgGame::execInitGameRepInfo(FFrame&, void* const)

native function TgPawn SpawnPlayerCharacter(Controller C, Vector vLocation);  // Export UTgGame::execSpawnPlayerCharacter(FFrame&, void* const)

native function int GetWinningTaskforce();  // Export UTgGame::execGetWinningTaskforce(FFrame&, void* const)

native function bool BeginEndMission(optional bool bClearNextMapGame=false, optional Actor EndMissionFocus, optional float fDelayOverride=0.0000000);  // Export UTgGame::execBeginEndMission(FFrame&, void* const)

native function bool FinishEndMission();  // Export UTgGame::execFinishEndMission(FFrame&, void* const)

native function TgPawn SpawnBotById(int nBotId, int nSkinId, int nHeadId, int nWeaponSkinId, Vector vLocation, Rotator rRotation, TgBotFactory pFactory, optional bool bIgnoreCollision=false, optional TgPawn pOwnerPawn, optional TgDeviceFire deviceFire, optional float fDeployAnimLength=0.0000000, optional name ControllerClassName, optional name BehaviorTreeName);  // Export UTgGame::execSpawnBotById(FFrame&, void* const)

native function TgPawn SpawnBotPawn(TgAIController pTgAI, Vector vLocation, Rotator rRotation, optional bool bIgnoreCollision=false, optional TgPawn pOwnerPawn, optional float fDeploySecs);  // Export UTgGame::execSpawnBotPawn(FFrame&, void* const)

native function TgPawn SpawnTemplatePlayer(TgPlayerController pTgPC, int nProfileId, optional int nSkinId=0, optional int nWeaponSkinId=0, optional int nHeadSkinId=0);  // Export UTgGame::execSpawnTemplatePlayer(FFrame&, void* const)

native function EnsureBotPrecache(int nBotId, int nSkinId, int nHeadId, int nDeviceSkinId);  // Export UTgGame::execEnsureBotPrecache(FFrame&, void* const)

native function EnsureDevicePrecache(int nDeviceId, int nDeviceSkinId);  // Export UTgGame::execEnsureDevicePrecache(FFrame&, void* const)

native function EnsureHeadPrecache(int nHeadId);  // Export UTgGame::execEnsureHeadPrecache(FFrame&, void* const)

native function bool SwapToNewAIController(Controller C, TgPawn_Character TgPawn);  // Export UTgGame::execSwapToNewAIController(FFrame&, void* const)

native function bool SpawnDefaultBotPlayers(out array<TgAIBotPlayersToSpawn> BotPlayersToSpawn, optional bool bStartPaused=true);  // Export UTgGame::execSpawnDefaultBotPlayers(FFrame&, void* const)

native function PlayerDied(TgPlayerController PC);  // Export UTgGame::execPlayerDied(FFrame&, void* const)

native function BotDied(TgAIController aic);  // Export UTgGame::execBotDied(FFrame&, void* const)

native function float GetActualRespawnTime(int TaskForceNum);  // Export UTgGame::execGetActualRespawnTime(FFrame&, void* const)

native function float GetRespawnTime(int TaskForceNum);  // Export UTgGame::execGetRespawnTime(FFrame&, void* const)

native function string GetGameVersion();  // Export UTgGame::execGetGameVersion(FFrame&, void* const)

native function NotifyPostCommitMapChange();  // Export UTgGame::execNotifyPostCommitMapChange(FFrame&, void* const)

native function ResetStats();  // Export UTgGame::execResetStats(FFrame&, void* const)

native function bool AllowPausing(optional PlayerController PC);  // Export UTgGame::execAllowPausing(FFrame&, void* const)

native function BeginUnpauseCountdown(float fSeconds);  // Export UTgGame::execBeginUnpauseCountdown(FFrame&, void* const)

native function EndUnpauseCountdown();  // Export UTgGame::execEndUnpauseCountdown(FFrame&, void* const)

native function SendPauseNotification(optional PlayerController PC);  // Export UTgGame::execSendPauseNotification(FFrame&, void* const)

native function bool CanSpoolCredits();  // Export UTgGame::execCanSpoolCredits(FFrame&, void* const)

native function bool ConsiderForBestPlayOfTheGame(TgRepInfo_Player PRI);  // Export UTgGame::execConsiderForBestPlayOfTheGame(FFrame&, void* const)

native function float GetWeightedPlayOfTheGameEventRating(TgRepInfo_Player PRI, int nIndex);  // Export UTgGame::execGetWeightedPlayOfTheGameEventRating(FFrame&, void* const)

native function CachePlayOfTheGame();  // Export UTgGame::execCachePlayOfTheGame(FFrame&, void* const)

native function ResetPlayOfTheGame();  // Export UTgGame::execResetPlayOfTheGame(FFrame&, void* const)

native function LockPlayOfTheGame(bool bLocked);  // Export UTgGame::execLockPlayOfTheGame(FFrame&, void* const)

native function InitPlayOfTheGameConfig();  // Export UTgGame::execInitPlayOfTheGameConfig(FFrame&, void* const)

event PreBeginPlay() { }

event PostBeginPlay() { }

function InitGameReplicationInfo() { }

event int GetNextActorInstanceId() { }

event int GetNextProjectileInstanceId() { }

function Reset() { }

event InitGame(string Options, out string ErrorMessage) { }

function StartBots() { }

function Pawn SpawnDefaultPawnFor(Controller NewPlayer, NavigationPoint StartSpot) { }

event AllPlayersEndGame(Actor EndGameFocus) { }

function RestartPlayer(Controller aPlayer) { }

function AddDefaultInventory(Pawn PlayerPawn) { }

function SetPlayerDefaults(Pawn PlayerPawn) { }

event NavigationPoint FindPlayerStartPoint(Controller Player, optional string SpawnTagName) { }

event NavigationPoint GetReviveLocation(Controller Player, out Vector OutLocation, out Rotator OutRotation) { }

function NavigationPoint FindPlayerStart(Controller Player, optional byte InTeam, optional string IncomingName) { }

function NavigationPoint FindPlayerGroupStart(Controller Player, int groupNumber, optional byte InTeam, optional string IncomingName) { }

event float RatePlayerStartPoint(PlayerStart P, Controller Player) { }

function float RatePlayerStart(PlayerStart P, byte Team, Controller Player) { }

function bool ChangeTeam(Controller Other, int Num, bool bNewTeam) { }

function bool ShouldSpawnAtStartSpot(Controller Player) { }

function GotoGameRunningState() { }

function StartMatch() { }

function AddInactivePRI(PlayerReplicationInfo PRI, PlayerController PC) { }

function bool FindInactivePRI(PlayerController PC) { }

event PostLogin(PlayerController NewPlayer) { }

event PostCommitMapChange() { }

simulated function bool CanSpectate(PlayerController Viewer, PlayerReplicationInfo ViewTarget) { }

function bool PreventDeath(Pawn KilledPawn, Controller Killer, class<DamageType> DamageType, vector HitLocation) { }

function bool SetPause(PlayerController PC, optional delegate<CanUnpause> CanUnpauseDelegate=CanUnpause) { }

event ClearPause() { }

event ClearPauseAfterCountdown() { }

event KickIdler(PlayerController PC) { }

function SetEnableHeadshots(bool bEnable) { }

function int GetGameSpawnPhase(TgPawn TgP) { }

function int GetCurrentLane() { }

function bool FindValidSpawnPoints(TgPawn TgP, out array<TgSpawnTeleporterExit> ValidExits) { }

function PlayerStart FindPlayerStartForCapturePoint(TgChaosCapturePoint CapPoint, Controller Player, optional bool bUseAttackingForwardSpawn=true) { }

function PlayerStart FindBestPlayerStart(out array<PlayerStart> PlayerStartPoints, Controller Player) { }

function int GetTaskForceForPlayer(Controller Player) { }

event AddPotGEventToAllPlayers(TgObject.EPlayOfTheGameEventType potgEvent) { }

auto state PrepGameStart {}

state GameRunning {}

defaultproperties
{
    m_fSpawnProtectionTime=3.0000000
    m_fMaxRepawnTime=60.0000000
    m_bEnableHeadShots=true
    s_nNextActorInstanceId=1
    s_nNextProjectileInstanceId=1
    s_fXPModifier=1.0000000
    m_fGlobalCooldownTime=1.0000000
    m_fOcclusionCalcPeriod=0.1000000
    m_fPlayOfTheGameLength=13.0000000
    m_fPlayOfTheGameIntroBufferLength=2.0000000
    m_fPlayOfTheGameOuttroBufferLength=2.0000000
    bRestartLevel=false
    bDelayedStart=false
    DefaultPawnClass=Class'TgPawn_Character'
    HUDType=Class'TgHUD'
    PlayerControllerClass=Class'TgPlayerController'
    PlayerReplicationInfoClass=Class'TgRepInfo_Player'
    GameReplicationInfoClass=Class'TgRepInfo_Game'
    OnlineGameSettingsClass=Class'TgOnlineGameSettings'
}
