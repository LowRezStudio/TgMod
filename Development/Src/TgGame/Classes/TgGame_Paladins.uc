class TgGame_Paladins extends TgGame_Battle
    native(Game)
    config(Game)
    hidecategories(Navigation,Movement,Collision)
    dependson(TgAIController_Behavior, TgObject, TgPawn);

const GAMEEVENT_PALADINS_PLAYER_KILL = 1001;

const GAMEEVENT_PALADINS_PLAYER_DEATH = 1002;

const GAMEEVENT_PALADINS_PLAYER_KILL_SUICIDE = 2001;

const GAMEEVENT_PALADINS_PLAYER_KILL_NORMAL = 2002;

const GAMEEVENT_PALADINS_PLAYER_KILL_ASSIST = 2003;

const GAMEEVENT_MATCH_STARTED = 0;

const GAMEEVENT_MATCH_ENDED = 1;

const GAMEEVENT_ROUND_STARTED = 2;

const GAMEEVENT_ROUND_ENDED = 3;

const GAMEEVENT_GAME_CLASS = 6;

const GAMEEVENT_GAME_OPTION_URL = 7;

const GAMEEVENT_GAME_MAPNAME = 8;

const GAMEEVENT_MEMORYUSAGE_POLL = 35;

const GAMEEVENT_FRAMERATE_POLL = 36;

const GAMEEVENT_NETWORKUSAGEIN_POLL = 37;

const GAMEEVENT_NETWORKUSAGEOUT_POLL = 38;

const GAMEEVENT_PING_POLL = 39;

const GAMEEVENT_RENDERTHREAD_POLL = 40;

const GAMEEVENT_GAMETHREAD_POLL = 41;

const GAMEEVENT_GPUFRAMETIME_POLL = 42;

const GAMEEVENT_FRAMETIME_POLL = 43;

const GAMEEVENT_TEAM_CREATED = 50;

const GAMEEVENT_TEAM_GAME_SCORE = 51;

const GAMEEVENT_TEAM_MATCH_WON = 4;

const GAMEEVENT_TEAM_ROUND_WON = 5;

const GAMEEVENT_TEAM_ROUND_STALEMATE = 52;

const GAMEEVENT_PLAYER_LOGIN = 100;

const GAMEEVENT_PLAYER_LOGOUT = 101;

const GAMEEVENT_PLAYER_SPAWN = 102;

const GAMEEVENT_PLAYER_MATCH_WON = 103;

const GAMEEVENT_PLAYER_KILL = 104;

const GAMEEVENT_PLAYER_LOCATION_POLL = 105;

const GAMEEVENT_PLAYER_TEAMCHANGE = 106;

const GAMEEVENT_PLAYER_KILL_STREAK = 107;

const GAMEEVENT_PLAYER_DEATH = 108;

const GAMEEVENT_PLAYER_ROUND_WON = 109;

const GAMEEVENT_PLAYER_ROUND_STALEMATE = 110;

const GAMEEVENT_WEAPON_DAMAGE = 150;

const GAMEEVENT_WEAPON_DAMAGE_MELEE = 151;

const GAMEEVENT_WEAPON_FIRED = 152;

const GAMEEVENT_PLAYER_KILL_NORMAL = 200;

const GAMEEVENT_GENERIC_PARAM_LIST_START = 300;

const GAMEEVENT_GENERIC_PARAM_LIST_END = 400;

const GAMEEVENT_GAME_SPECIFIC = 1000;

const GAMEEVENT_MAX_EVENTID = 0x0000FFFF;

struct TeamDifficultyData {
    var TgAIController_Behavior.EBotDifficultyLevel CurrentBotDifficultyLevel;
    var float TeamSkillLevel;
    structdefaultproperties {}
};

var config int m_nGoalScore;
var config bool m_bCanPurchaseItemsAnywhere;
var config bool m_bAutoMountOnRespawn;
var config bool m_bDropHealthNuggetOnDeath;
var bool m_bRespawnBots;
var config bool m_bDisableKillcam;
var config bool m_bCanApplyCardEquipStats;
var config bool m_bTalentsEnabled;
var config bool m_bDeckSwappingAlwaysEnabled;
var bool m_bDiminishingReturnsOnCCEnabled;
var const float m_fPlayerWaitTime;
var int m_nHealthNuggetDeployableId;
var int m_nHealthNuggetTeamOnlyDeployableId;
var int m_fHealthNuggetPersistTime;
var config float m_fPlayerViewDistance;
var config float m_fVisibilityVolumeViewDistance;
var float m_fCardCooldownIncrease;
var config float m_fCardCooldownMultiplier;
var config float m_fGameTypeReminderTime;
var config float m_fRespawnBeaconLifeSpan;
var config float m_fBaseRespawnTime;
var const float m_fMapLaneChangeDelay;
var config int m_nStartingCredits;
var config int m_nMaxCredits;
var config string m_GameplayEventsWriterClassName;
var GameplayEventsWriter GameplayEventsWriter;
var TeamDifficultyData DifficultyData[2];
var TgAIDirector AIDirector;

native function float GetRespawnTime(int TaskForceNum);  // Export UTgGame_Paladins::execGetRespawnTime(FFrame&, void* const)

native function ScoreKillGameType(out ScoreKillData Data);  // Export UTgGame_Paladins::execScoreKillGameType(FFrame&, void* const)

native function bool GetScoreKillData(Controller Killer, Controller Other, out ScoreKillData Data);  // Export UTgGame_Paladins::execGetScoreKillData(FFrame&, void* const)

native function ScoreKillCommon(out ScoreKillData Data);  // Export UTgGame_Paladins::execScoreKillCommon(FFrame&, void* const)

native function OnBeaconReset(int nTaskForce, Controller Killer);  // Export UTgGame_Paladins::execOnBeaconReset(FFrame&, void* const)

native function bool BeginEndMission(optional bool bClearNextMapGame=false, optional Actor EndMissionFocus, optional float fDelayOverride=0.0000000);  // Export UTgGame_Paladins::execBeginEndMission(FFrame&, void* const)

native function TriggerMapLaneChange();  // Export UTgGame_Paladins::execTriggerMapLaneChange(FFrame&, void* const)

native function BeginGameStatsLogging();  // Export UTgGame_Paladins::execBeginGameStatsLogging(FFrame&, void* const)

native function EndGameStatsLogging();  // Export UTgGame_Paladins::execEndGameStatsLogging(FFrame&, void* const)

event FadeAllClients() { }

event PostBeginPlay() { }

function RestartPlayer(Controller aPlayer) { }

function InitializeCreditsFor(TgPaladinsController TgPC) { }

event SetCredits(TgPaladinsController TgPC, int nCreditsAmount) { }

event GiveCredits(TgPaladinsController TgPC, int nCreditsAmount) { }

event TakeCredits(TgPaladinsController TgPC, int nCreditsAmount) { }

function ResetCreditsForAllPlayers() { }

function ResetKillstreaksForAllPlayers() { }

function ResetUltForAllPlayers() { }

function int GetGameTypeHelpTipIndex(TgPlayerController TgPC) { }

function ShowGameTypeHelpTip() { }

function SendClientsRequestHelpText(int GameTipId) { }

function Killed(Controller Killer, Controller KilledPlayer, Pawn KilledPawn, class<DamageType> damageType) { }

function OnPawnDied(TgPawn Victim) { }

function OnKillConfirmed(TgRepInfo_Player PRI, TgRepInfo_TaskForce Taskforce, optional int bonusScore=0) { }

function UpdateTgPawnMetaGameState(TgPawn CurPawn, optional TgPawn.EMetaGameState NewState=0) { }

function UpdateAllPawnsMetaGameState(optional TgPawn.EMetaGameState NewState=0) { }

function float GetPlayerWaitTime() { }

event CheckGameState() { }

function EndTheGame() { }

defaultproperties
{
    m_nGoalScore=100
    m_bRespawnBots=true
    m_bTalentsEnabled=true
    m_bDiminishingReturnsOnCCEnabled=true
    m_fPlayerWaitTime=20.0000000
    m_nHealthNuggetDeployableId=643
    m_nHealthNuggetTeamOnlyDeployableId=754
    m_fHealthNuggetPersistTime=30
    m_fPlayerViewDistance=7200.0000000
    m_fVisibilityVolumeViewDistance=256.0000000
    m_fCardCooldownMultiplier=1.0000000
    m_fRespawnBeaconLifeSpan=120.0000000
    m_fBaseRespawnTime=12.0000000
    m_fMapLaneChangeDelay=8.0000000
    m_nStartingCredits=400
    m_nMaxCredits=7500
    m_GameplayEventsWriterClassName="TgGame.TgGameplayEventsWriter"
    DifficultyData[0]=(CurrentBotDifficultyLevel=AIDifficulty_Easy1,TeamSkillLevel=0.0000000)
    DifficultyData[1]=(CurrentBotDifficultyLevel=AIDifficulty_Easy1,TeamSkillLevel=0.0000000)
    m_fSetupTime=0.1000000
}
