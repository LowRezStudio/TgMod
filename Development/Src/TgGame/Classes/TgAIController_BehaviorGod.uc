class TgAIController_BehaviorGod extends TgAIController_Behavior
    native(AI)
    config(Game)
    hidecategories(Navigation)
    implements(TgPaladinsController)
    dependson(TgObject);

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

var float WaitForSpawnSecs;
var transient int PlayerID;
var transient bool bCanPurchaseItems;
var transient bool bCanPurchaseSkills;
var bool bRespawnAtOriginalLocation;
var transient float CurrentGoldRemainder;
var transient int CurrentGold;
var transient float CurrentXPRemainder;
var transient int CurrentXP;
var transient Vector GeometricMean;

native function PurchaseItems();  // Export UTgAIController_BehaviorGod::execPurchaseItems(FFrame&, void* const)

native function bool CanAllocateSkillPoint(int DeviceID, TgDevice aDevice);  // Export UTgAIController_BehaviorGod::execCanAllocateSkillPoint(FFrame&, void* const)

native function bool HaveBasicSkillsBeenActivated();  // Export UTgAIController_BehaviorGod::execHaveBasicSkillsBeenActivated(FFrame&, void* const)

native function int GetSkillPointsAvailable();  // Export UTgAIController_BehaviorGod::execGetSkillPointsAvailable(FFrame&, void* const)

native function PurchaseSkills();  // Export UTgAIController_BehaviorGod::execPurchaseSkills(FFrame&, void* const)

native function PurchaseBurnCards();  // Export UTgAIController_BehaviorGod::execPurchaseBurnCards(FFrame&, void* const)

native function float StartReviveTimer();  // Export UTgAIController_BehaviorGod::execStartReviveTimer(FFrame&, void* const)

native function bool OnRespawnRuleChanged();  // Export UTgAIController_BehaviorGod::execOnRespawnRuleChanged(FFrame&, void* const)

native function SetBotPlayerId();  // Export UTgAIController_BehaviorGod::execSetBotPlayerId(FFrame&, void* const)

native function SetStartingProperties();  // Export UTgAIController_BehaviorGod::execSetStartingProperties(FFrame&, void* const)

native function SetRewardValues(int XP, int nCredits, Actor Source, optional TgObject.ERewardValueType RewardType=0, optional bool bFlankKill=false);  // Export UTgAIController_BehaviorGod::execSetRewardValues(FFrame&, void* const)

native function int GetTaskForceNumber();  // Export UTgAIController_BehaviorGod::execGetTaskForceNumber(FFrame&, void* const)

function InitPlayerReplicationInfo() { }

event Revive() { }

function LiveRespawn(bool bResetHealth, bool bResetDevices) { }

event Possess(Pawn inPawn, bool bVehicleTransition) { }

function PawnDied(Pawn P) { }

event CopyPropertiesTo(Controller C) { }

function Rotator GetAdjustedAimFor(Weapon W, vector StartFireLoc) { }

simulated event PostBeginPlay() { }

function int GetCredits() { }

function SetCredits(int nCreditsAmount) { }

function ResetUlt() { }

function TgPawn GetTgPawn() { }

state Dead {}

defaultproperties
{
    BlackboardType=1
    LocalRepulsorSolverClass=Class'TgAILocalPositionSolver_God'
    NavigationSearchModifier_Max=10.0000000
    UtilityHandleClass=Class'TgAIUtilityHandle'
    bIsPaused=true
}
