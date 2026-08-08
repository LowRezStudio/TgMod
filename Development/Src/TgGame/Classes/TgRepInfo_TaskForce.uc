class TgRepInfo_TaskForce extends TeamInfo
    native(Game)
    nativereplication
    hidecategories(Navigation,Movement,Collision)
    config(Engine)
    dependson(TgObject);

const TG_MAX_PREMADE_DEPLOYS = 20;

const TG_MAX_PRIMARY_OBJECTIVES = 5;

const TG_MAX_TASK_TEAM_NUMBER = 10;

struct TGTEAM_ENTRY {
    var string fsName;
    var string fsMapName;
    var int nHealth;
    var int nMaxHealth;
    var bool bLeader;
    var TgRepInfo_Player pPrep;
    structdefaultproperties {}
};

struct sPredefinedLevelDeployInfo {
    var int m_Id;
    var Vector m_Location;
    structdefaultproperties {}
};

struct TEAMTIMEMANAGER_ENTRY {
    var TgTimerManager m_TimerManager;
    var int m_nDeviceId;
    structdefaultproperties {}
};

struct GLOBALEFFECT_ENTRY {
    var TgEffectGroup eg;
    var TgPawn pawnInstigator;
    structdefaultproperties {}
};

var string c_fsName;
var int r_nTeamId;
var repnotify int r_nLeaderPlayerId;
var repnotify byte r_nTaskForce;
var TgObject.TgMapTeam r_MapTeam;
var int s_nTaskForceChatId;
var int s_nStrikeForceId;
var int s_nTaskTeamNum;
var Color m_Color;
var repnotify bool r_bIsSurrendering;
var bool r_bSpectator;
var bool m_bDestroyOnEmpty;
var bool r_bIsAttacking;
var int s_nPlayerStartCount;
var private array<TGTEAM_ENTRY> m_TeamPlayers;
var private array<TGTEAM_ENTRY> m_TeamBots;
var array<TgRepInfo_Factory> m_Factories;
var private array<TgBotFactory_Minions> m_MinionFactories;
var private array<TEAMTIMEMANAGER_ENTRY> s_TeamTimerManagers;
var TgMinimapManager s_MinimapManager;
var repnotify int r_nScore;
var float r_fTickets;
var repnotify float r_fSecondaryScore;
var repnotify int r_nScorePercent;
var int r_nGoldBuffCount;
var int s_nGodVisionMask;
var private array<GLOBALEFFECT_ENTRY> m_GlobalEffectGroups;
var int m_nTowersKilled;
var int m_nPhoenixCount;
var int r_nGodKillCount;
var int m_nLastGodIndex;
var int m_nLastGodList;
var TgRespawnBeaconExit r_RespawnBeaconExit;
var int c_nScoreOverride;

replication {
    if(int(Role) == int(ENetRole.ROLE_Authority)) r_RespawnBeaconExit, r_bIsSurrendering, r_nGoldBuffCount, r_nLeaderPlayerId;
    if((int(Role) == int(ENetRole.ROLE_Authority)) && bNetInitial) r_MapTeam, r_bSpectator, r_nTaskForce, r_nTeamId;
}

native function TgRepInfo_Player CycleFrom(TgRepInfo_Player pFrom, bool bForward);  // Export UTgRepInfo_TaskForce::execCycleFrom(FFrame&, void* const)

native simulated function bool RepEvent(name VarName);  // Export UTgRepInfo_TaskForce::execRepEvent(FFrame&, void* const)

native function int GetPlayerCount();  // Export UTgRepInfo_TaskForce::execGetPlayerCount(FFrame&, void* const)

native function int GetActivePlayerCount();  // Export UTgRepInfo_TaskForce::execGetActivePlayerCount(FFrame&, void* const)

native function int GetBotCount();  // Export UTgRepInfo_TaskForce::execGetBotCount(FFrame&, void* const)

native function int GetMinionFactoryCount();  // Export UTgRepInfo_TaskForce::execGetMinionFactoryCount(FFrame&, void* const)

native function TgRepInfo_Player GetPlayer(int nIndex);  // Export UTgRepInfo_TaskForce::execGetPlayer(FFrame&, void* const)

native function TgRepInfo_Player GetPlayerById(int nPawnId);  // Export UTgRepInfo_TaskForce::execGetPlayerById(FFrame&, void* const)

native function TgRepInfo_Player GetPlayerByPower(int nIndex);  // Export UTgRepInfo_TaskForce::execGetPlayerByPower(FFrame&, void* const)

native function TgRepInfo_Player GetBot(int nIndex);  // Export UTgRepInfo_TaskForce::execGetBot(FFrame&, void* const)

native function TgBotFactory_Minions GetMinionFactory(int nIndex);  // Export UTgRepInfo_TaskForce::execGetMinionFactory(FFrame&, void* const)

native function bool IsLeader(TgRepInfo_Player pTgPri);  // Export UTgRepInfo_TaskForce::execIsLeader(FFrame&, void* const)

native function TeamRemoveFrom(Controller Other);  // Export UTgRepInfo_TaskForce::execTeamRemoveFrom(FFrame&, void* const)

native function UpdateSurrenderTimer();  // Export UTgRepInfo_TaskForce::execUpdateSurrenderTimer(FFrame&, void* const)

native function AddGlobalEffectGroup(TgEffectGroup eg, TgPawn InstigatorPawn);  // Export UTgRepInfo_TaskForce::execAddGlobalEffectGroup(FFrame&, void* const)

native function RemoveGlobalEffectGroup(int nEffectGroupID);  // Export UTgRepInfo_TaskForce::execRemoveGlobalEffectGroup(FFrame&, void* const)

native function ApplyGlobalEffectGroups(TgPawn_Character aPawn);  // Export UTgRepInfo_TaskForce::execApplyGlobalEffectGroups(FFrame&, void* const)

native function RemoveGlobalEffectGroups(TgPawn_Character aPawn);  // Export UTgRepInfo_TaskForce::execRemoveGlobalEffectGroups(FFrame&, void* const)

native function ReapplyGlobalEffectGroups();  // Export UTgRepInfo_TaskForce::execReapplyGlobalEffectGroups(FFrame&, void* const)

native function RemoveAllGlobalEffectGroups();  // Export UTgRepInfo_TaskForce::execRemoveAllGlobalEffectGroups(FFrame&, void* const)

native function int GetGodCount();  // Export UTgRepInfo_TaskForce::execGetGodCount(FFrame&, void* const)

native function TgRepInfo_Player GetGod(int nIndex);  // Export UTgRepInfo_TaskForce::execGetGod(FFrame&, void* const)

native function ResetGodIterator();  // Export UTgRepInfo_TaskForce::execResetGodIterator(FFrame&, void* const)

native function TgRepInfo_Player GetNextGod(optional bool bIncrement=true, optional bool bReset=false);  // Export UTgRepInfo_TaskForce::execGetNextGod(FFrame&, void* const)

native function int LaneOfSiegeWeapon();  // Export UTgRepInfo_TaskForce::execLaneOfSiegeWeapon(FFrame&, void* const)

native function TgPawn GetASiegeWeapon();  // Export UTgRepInfo_TaskForce::execGetASiegeWeapon(FFrame&, void* const)

native function bool HasBot(Class<TgPawn> PawnClass);  // Export UTgRepInfo_TaskForce::execHasBot(FFrame&, void* const)

native function int GetNumAlivePlayers();  // Export UTgRepInfo_TaskForce::execGetNumAlivePlayers(FFrame&, void* const)

native function GetPlayers(out array<TgRepInfo_Player> List);  // Export UTgRepInfo_TaskForce::execGetPlayers(FFrame&, void* const)

native function GetPlayersByDistance(Vector fromVector, float dwDist, out array<TgRepInfo_Player> List);  // Export UTgRepInfo_TaskForce::execGetPlayersByDistance(FFrame&, void* const)

event PostInit() { }

simulated event PostDemoRewind() { }

function CreateMinimap(TgObject.TgMapTeam Team, Class<TgMinimapManager> managerClass) { }

function RemoveFromTeam(Controller Other) { }

simulated function bool HasActivePlayers() { }

simulated event ReceivedScoringChanges() { }

simulated event ReceivedTaskForceNumber() { }

simulated event ReplicatedEvent(name VarName) { }

simulated function UpdateKismetOnScore() { }

simulated function TgPlayerController FindLocalPlayerController() { }

simulated function NotifyScoreChange() { }

function array<TGTEAM_ENTRY> getTeamPlayers() { }

simulated event PostTimeLapse(bool bPlayOfTheGame) { }

defaultproperties
{
    r_MapTeam=MAPTEAM_NEUTRAL
    m_nPhoenixCount=3
    c_nScoreOverride=-1
    m_bHasThreadedWork=true
}
