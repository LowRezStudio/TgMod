class GameStatsAggregator extends GameplayEventsHandler
    native(GameStats)
    config(GameStats);

const GAMEEVENT_AGGREGATED_DATA = 10000;
const GAMEEVENT_AGGREGATED_PLAYER_TIMEALIVE = 10001;
const GAMEEVENT_AGGREGATED_PLAYER_KILLS = 10002;
const GAMEEVENT_AGGREGATED_PLAYER_DEATHS = 10003;
const GAMEEVENT_AGGREGATED_PLAYER_MATCH_WON = 10004;
const GAMEEVENT_AGGREGATED_PLAYER_ROUND_WON = 10005;
const GAMEEVENT_AGGREGATED_DAMAGE_DEALT_NORMALKILL = 10006;
const GAMEEVENT_AGGREGATED_DAMAGE_RECEIVED_WASNORMALKILL = 10007;
const GAMEEVENT_AGGREGATED_TEAM_KILLS = 10100;
const GAMEEVENT_AGGREGATED_TEAM_DEATHS = 10101;
const GAMEEVENT_AGGREGATED_TEAM_GAME_SCORE = 10102;
const GAMEEVENT_AGGREGATED_TEAM_MATCH_WON = 10103;
const GAMEEVENT_AGGREGATED_TEAM_ROUND_WON = 10104;
const GAMEEVENT_AGGREGATED_DAMAGE_KILLS = 10200;
const GAMEEVENT_AGGREGATED_DAMAGE_DEATHS = 10201;
const GAMEEVENT_AGGREGATED_DAMAGE_DEALT_WEAPON_DAMAGE = 10202;
const GAMEEVENT_AGGREGATED_DAMAGE_DEALT_MELEE_DAMAGE = 10203;
const GAMEEVENT_AGGREGATED_DAMAGE_RECEIVED_WEAPON_DAMAGE = 10204;
const GAMEEVENT_AGGREGATED_DAMAGE_RECEIVED_MELEE_DAMAGE = 10205;
const GAMEEVENT_AGGREGATED_DAMAGE_DEALT_MELEEHITS = 10206;
const GAMEEVENT_AGGREGATED_DAMAGE_RECEIVED_WASMELEEHIT = 10207;
const GAMEEVENT_AGGREGATED_WEAPON_FIRED = 10300;
const GAMEEVENT_AGGREGATED_PAWN_SPAWN = 10400;
const GAMEEVENT_AGGREGATED_GAME_SPECIFIC = 11000;

struct native GameEvent
{
    var init array<init float> EventCountByTimePeriod;

    structdefaultproperties
    {
        EventCountByTimePeriod=none
    }
};

struct native GameEvents
{
    var private native const transient Map_Mirror Events;
};

struct native EventsBase
{
    var GameEvents TotalEvents;
    var array<GameEvents> EventsByClass;

    structdefaultproperties
    {
        TotalEvents=()
        EventsByClass=none
    }
};

struct native WeaponEvents extends EventsBase
{
};

struct native ProjectileEvents extends EventsBase
{
};

struct native DamageEvents extends EventsBase
{
};

struct native PawnEvents extends EventsBase
{
};

struct native TeamEvents
{
    var GameEvents TotalEvents;
    var WeaponEvents WeaponEvents;
    var DamageEvents DamageAsPlayerEvents;
    var DamageEvents DamageAsTargetEvents;
    var ProjectileEvents ProjectileEvents;
    var PawnEvents PawnEvents;

    structdefaultproperties
    {
        TotalEvents=()
        WeaponEvents=(TotalEvents=(),EventsByClass=none)
        DamageAsPlayerEvents=(TotalEvents=(),EventsByClass=none)
        DamageAsTargetEvents=(TotalEvents=(),EventsByClass=none)
        ProjectileEvents=(TotalEvents=(),EventsByClass=none)
        PawnEvents=(TotalEvents=(),EventsByClass=none)
    }
};

struct native PlayerEvents
{
    var GameEvents TotalEvents;
    var WeaponEvents WeaponEvents;
    var DamageEvents DamageAsPlayerEvents;
    var DamageEvents DamageAsTargetEvents;
    var ProjectileEvents ProjectileEvents;
    var PawnEvents PawnEvents;

    structdefaultproperties
    {
        TotalEvents=()
        WeaponEvents=(TotalEvents=(),EventsByClass=none)
        DamageAsPlayerEvents=(TotalEvents=(),EventsByClass=none)
        DamageAsTargetEvents=(TotalEvents=(),EventsByClass=none)
        ProjectileEvents=(TotalEvents=(),EventsByClass=none)
        PawnEvents=(TotalEvents=(),EventsByClass=none)
    }
};

struct native AggregateEventMapping
{
    var int EventID;
    var int AggregateID;
    var int TargetAggregateID;

    structdefaultproperties
    {
        EventID=0
        AggregateID=0
        TargetAggregateID=0
    }
};

var GameStateObject GameState;
var array<AggregateEventMapping> AggregatesList;
var private native const transient Map_Mirror AggregateEventsMapping;
var array<GameplayEventMetaData> AggregateEvents;
var const array<int> AggregatesFound;
var GameEvents AllGameEvents;
var const array<TeamEvents> AllTeamEvents;
var const array<PlayerEvents> AllPlayerEvents;
var const WeaponEvents AllWeaponEvents;
var const ProjectileEvents AllProjectileEvents;
var const PawnEvents AllPawnEvents;
var const DamageEvents AllDamageEvents;

// Export UGameStatsAggregator::execPreProcessStream(FFrame&, void* const)
native event PreProcessStream();

// Export UGameStatsAggregator::execPostProcessStream(FFrame&, void* const)
native event PostProcessStream();

// Export UGameStatsAggregator::execReset(FFrame&, void* const)
native function Reset();

// Export UGameStatsAggregator::execGetAggregateMappingIDs(FFrame&, void* const)
native function bool GetAggregateMappingIDs(int EventID, out int AggregateID, out int TargetAggregateID);

defaultproperties
{
    AggregatesList[0]=(EventID=103,AggregateID=10004,TargetAggregateID=0)
    AggregatesList[1]=(EventID=109,AggregateID=10005,TargetAggregateID=0)
    AggregatesList[2]=(EventID=51,AggregateID=10102,TargetAggregateID=0)
    AggregatesList[3]=(EventID=4,AggregateID=10103,TargetAggregateID=0)
    AggregatesList[4]=(EventID=5,AggregateID=10104,TargetAggregateID=0)
    AggregatesList[5]=(EventID=150,AggregateID=10202,TargetAggregateID=10204)
    AggregatesList[6]=(EventID=151,AggregateID=10203,TargetAggregateID=10205)
    AggregatesList[7]=(EventID=152,AggregateID=10300,TargetAggregateID=0)
    AggregatesList[8]=(EventID=102,AggregateID=10400,TargetAggregateID=0)
    AggregatesList[9]=(EventID=200,AggregateID=10006,TargetAggregateID=10007)
    AggregateEvents[0]=(EventID=10001,EventName="Player Time Alive",StatGroup=(Group=EGameStatGroups.GSG_Aggregate,Level=1),EventDataType=21)
    AggregateEvents[1]=(EventID=10002,EventName="Kills",StatGroup=(Group=EGameStatGroups.GSG_Aggregate,Level=1),EventDataType=21)
    AggregateEvents[2]=(EventID=10003,EventName="Deaths",StatGroup=(Group=EGameStatGroups.GSG_Aggregate,Level=1),EventDataType=21)
    AggregateEvents[3]=(EventID=10006,EventName="Normal Kill",StatGroup=(Group=EGameStatGroups.GSG_Aggregate,Level=1),EventDataType=21)
    AggregateEvents[4]=(EventID=10007,EventName="Was Normal Kill",StatGroup=(Group=EGameStatGroups.GSG_Aggregate,Level=1),EventDataType=21)
    AggregateEvents[5]=(EventID=10004,EventName="Match Won",StatGroup=(Group=EGameStatGroups.GSG_Aggregate,Level=1),EventDataType=21)
    AggregateEvents[6]=(EventID=10005,EventName="Round Won",StatGroup=(Group=EGameStatGroups.GSG_Aggregate,Level=1),EventDataType=21)
    AggregateEvents[7]=(EventID=10100,EventName="Kills",StatGroup=(Group=EGameStatGroups.GSG_Aggregate,Level=1),EventDataType=20)
    AggregateEvents[8]=(EventID=10101,EventName="Deaths",StatGroup=(Group=EGameStatGroups.GSG_Aggregate,Level=1),EventDataType=20)
    AggregateEvents[9]=(EventID=10102,EventName="Team Score",StatGroup=(Group=EGameStatGroups.GSG_Aggregate,Level=1),EventDataType=20)
    AggregateEvents[10]=(EventID=10103,EventName="Matches Won",StatGroup=(Group=EGameStatGroups.GSG_Aggregate,Level=1),EventDataType=20)
    AggregateEvents[11]=(EventID=10104,EventName="Rounds Won",StatGroup=(Group=EGameStatGroups.GSG_Aggregate,Level=1),EventDataType=20)
    AggregateEvents[12]=(EventID=10200,EventName="Kills",StatGroup=(Group=EGameStatGroups.GSG_Aggregate,Level=1),EventDataType=23)
    AggregateEvents[13]=(EventID=10201,EventName="Deaths",StatGroup=(Group=EGameStatGroups.GSG_Aggregate,Level=1),EventDataType=23)
    AggregateEvents[14]=(EventID=10202,EventName="Weapon Damage Dealt",StatGroup=(Group=EGameStatGroups.GSG_Aggregate,Level=1),EventDataType=23)
    AggregateEvents[15]=(EventID=10203,EventName="Melee Damage Dealt",StatGroup=(Group=EGameStatGroups.GSG_Aggregate,Level=1),EventDataType=23)
    AggregateEvents[16]=(EventID=10204,EventName="Weapon Damage Received",StatGroup=(Group=EGameStatGroups.GSG_Aggregate,Level=1),EventDataType=23)
    AggregateEvents[17]=(EventID=10205,EventName="Melee Damage Received",StatGroup=(Group=EGameStatGroups.GSG_Aggregate,Level=1),EventDataType=23)
    AggregateEvents[18]=(EventID=10206,EventName="Melee Hits",StatGroup=(Group=EGameStatGroups.GSG_Aggregate,Level=1),EventDataType=23)
    AggregateEvents[19]=(EventID=10207,EventName="Was Melee Hit",StatGroup=(Group=EGameStatGroups.GSG_Aggregate,Level=1),EventDataType=23)
    AggregateEvents[20]=(EventID=10300,EventName="Weapon Fired",StatGroup=(Group=EGameStatGroups.GSG_Aggregate,Level=1),EventDataType=22)
    AggregateEvents[21]=(EventID=10400,EventName="Spawns",StatGroup=(Group=EGameStatGroups.GSG_Aggregate,Level=1),EventDataType=25)
}