class TgBotFactory extends TgActorFactory
    native(Factory)
    placeable
    hidecategories(Navigation,Advanced,Attachment,Collision,Display,Advanced,Attachment,Collision,Display,Movement)
    config(Engine);

const BOT_ENCOUNTER_DESPAWN_TIME = 60;

enum eBotSelection {
    BS_RANDOM,  // 0
    BS_SEQUENTIAL,  // 1
};

struct SpawnQueueEntry {
    var float fSpawnTime;
    var int nBotId;
    var int nSkinId;
    var int nWeaponSkinId;
    var int nSpawnTableDetailId;
    var name BehaviorTreeOverride;
    structdefaultproperties {}
};

var () TgBotFactory.eBotSelection LocationSelection;
var (BotFactory) const array<NavigationPoint> LocationList;
var int s_nCurLocationIndex;
var (BotFactory) NavigationPoint SafetyLocation;
var (BotFactory) bool ShouldTraceSpawnLocationToFloor;
var (BotFactory) bool bUseSmiteStaggerSpawning;
var (BotFactory) bool bSpawnAsSquad;
var bool bAutoSpawn;
var bool m_bFirstSpawn;
var () bool bBulkSpawn;
var () bool bRespawn;
var (Introduction) bool bStartBotsInIntroState;
var (Introduction) bool bHasDifferentInitialIntro;
var bool m_bFirstSpawnWave;
var () bool m_bIgnoreCollisionOnSpawn;
var () bool m_bUseCollisionHeightForSpawnPlacement;
var int nBotCount;
var int nCurrentCount;
var (BotFactory) int nActiveCount;
var int nTotalSpawns;
var (BotFactory) int nLane;
var (BotFactory) int nNavPointsToSkipForPathing;
var (BotFactory) float fStaggerSpawnDelay;
var transient TgAISquad s_CurrentSquad;
var Class<TgAISquad> m_SquadClass;
var () int m_nLocationId;
var () int nSpawnTableId;
var () int nDefaultSpawnTableId;
var () float fSpawnDelay;
var array<SpawnQueueEntry> m_SpawnQueue;
var TgBotEncounterVolume m_SpawnVolume;
var int m_nLastGroup;
var () float fSpawnHealthPercent;
var (Introduction) float fIntroductionDuration;
var (Introduction) float fInitialIntroductionDuration;
var (LanePusher) TgSplineActor m_StartingSpline;
var () export editinline StaticMeshComponent m_RespawnIndicator;
var transient MaterialInstanceConstant m_RespawnIndicatorMIC;
var Texture2D m_TextureNormal;
var float fLastKillTime;
var () float fRespawnDelay;

native function LoadObjectConfig();  // Export UTgBotFactory::execLoadObjectConfig(FFrame&, void* const)

native function ResetQueue();  // Export UTgBotFactory::execResetQueue(FFrame&, void* const)

native function BuildQueue();  // Export UTgBotFactory::execBuildQueue(FFrame&, void* const)

native function ClearQueue();  // Export UTgBotFactory::execClearQueue(FFrame&, void* const)

native function Actor SpawnBot();  // Export UTgBotFactory::execSpawnBot(FFrame&, void* const)

native function Actor SpawnNextBot();  // Export UTgBotFactory::execSpawnNextBot(FFrame&, void* const)

native function Actor SpawnBotId(int nBotId, int nSkinId);  // Export UTgBotFactory::execSpawnBotId(FFrame&, void* const)

native function Actor SpawnBotAdjusted(SpawnQueueEntry Entry);  // Export UTgBotFactory::execSpawnBotAdjusted(FFrame&, void* const)

native function CalcFactoryPlacement(Vector Extent, bool bCenterOnGround, out Vector OutLocation, out Rotator OutRotation);  // Export UTgBotFactory::execCalcFactoryPlacement(FFrame&, void* const)

native function Actor UseSpawnTable();  // Export UTgBotFactory::execUseSpawnTable(FFrame&, void* const)

native function BotDied(TgPawn Pawn, TgAIController aic);  // Export UTgBotFactory::execBotDied(FFrame&, void* const)

native function SquadDied(TgAISquad squad);  // Export UTgBotFactory::execSquadDied(FFrame&, void* const)

native function KillCurrentSquad();  // Export UTgBotFactory::execKillCurrentSquad(FFrame&, void* const)

native function int GetRemainingTotalSpawns();  // Export UTgBotFactory::execGetRemainingTotalSpawns(FFrame&, void* const)

native function float GetStaggerSpawnTime();  // Export UTgBotFactory::execGetStaggerSpawnTime(FFrame&, void* const)

simulated function PostBeginPlay() { }

simulated function OnToggle(SeqAct_Toggle Action) { }

function OnKillBots(TgSeqAct_KillBots inAction) { }

function OnDespawnBots(TgSeqAct_DespawnBots inAction) { }

event EndEncounter() { }

event ContinueEncounter() { }

event StartEncounter(TgBotEncounterVolume Volume) { }

function Despawn() { }

event KillBots(bool bDespawn) { }

simulated function OnTriggerBots(TgSeqAct_TriggerBots Action) { }

simulated function OnSetTaskforce(TgSeqAct_SetTaskforce Action) { }

function OnGetBot(TgSeqAct_GetBot inAction) { }

function OnBotDamaged(TgPawn Bot, Controller DamageInstigator, Class<DamageType> DamageType, int DamageAmount) { }

simulated function UpdateRespawnTimeIndicator(float fPct) { }

function OnKillCurrentSquad(TgSeqAct_KillCurrentSquad killSquadAction) { }

defaultproperties
{}
