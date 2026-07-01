class TgGame extends FrameworkGame
    abstract
    native(Game)
    config(Game)
    hidecategories(Navigation,Movement,Collision);

var Class m_ContentPackageReference;
var float m_fSpawnProtectionTime;
var float m_fMaxRepawnTime;
var float m_fUnpauseCountdownRemaining;
var int s_nBotPlayerCount;
var bool s_bSpawnOfflinePawns;
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
var bool m_bSpawnDisconnectedPlayersStunned;
var bool m_bPlayersCanOnlyDieOnce;
var bool m_bUseKillEmotes;
var bool m_bNotifyKillCombos;
var bool m_bFirstBloodAwarded;
var protected int s_nNextActorInstanceId;
var protected int s_nNextProjectileInstanceId;
var init array<init int> s_Taskforce1AIVolumesIndices;
var init array<init int> s_Taskforce2AIVolumesIndices;
var init native map{VOID,VOID} s_AIAnnotations;
var array<TgActorFactory> s_ActorFactories;
var float s_fXPModifier;
var const config float m_fGlobalCooldownTime;
var init array<init int> m_ClientLogins;
var config float m_fOcclusionCalcPeriod;
var config float m_fOcclusionMaxDeviation;
var float m_fPlayOfTheGameLength;
var float m_fPlayOfTheGameIntroBufferLength;
var float m_fPlayOfTheGameOuttroBufferLength;
var array<Player> m_ReadyPlayers;

// Export UTgGame::execEnsureBotPrecache(FFrame&, void* const)
native function EnsureBotPrecache(int nBotId, int nSkinId, int nHeadId, int nDeviceSkinId);

// Export UTgGame::execEnsureDevicePrecache(FFrame&, void* const)
native function EnsureDevicePrecache(int nDeviceId, int nDeviceSkinId);

// Export UTgGame::execSpawnTemplatePlayer(FFrame&, void* const)
native function TgPawn SpawnTemplatePlayer(TgPlayerController pTgPC, int nProfileId, optional int nSkinId = 0, optional int nWeaponSkinId = 0, optional int nHeadSkinId = 0);

// Export UTgGame::execSpawnBotById(FFrame&, void* const)
native function TgPawn SpawnBotById(int nBotId, int nSkinId, int nHeadId, int nWeaponSkinId, Vector vLocation, Rotator rRotation, TgBotFactory pFactory, optional bool bIgnoreCollision = false, optional TgPawn pOwnerPawn, optional TgDeviceFire deviceFire, optional float fDeployAnimLength = 0.0000000, optional name ControllerClassName, optional name BehaviorTreeName);

// Export UTgGame::execSpawnPlayerCharacter(FFrame&, void* const)
native function TgPawn SpawnPlayerCharacter(Controller C, Vector vLocation);

function bool ChangeTeam(Controller Other, int Num, bool bNewTeam){}
function Pawn SpawnDefaultPawnFor(Controller NewPlayer, NavigationPoint StartSpot) {}

function NavigationPoint FindPlayerStart(Controller Player, optional byte InTeam, optional string IncomingName){}