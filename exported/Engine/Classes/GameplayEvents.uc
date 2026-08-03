class GameplayEvents extends Object
    abstract
    native;

const HeaderFlags_NoEventStrings = 1;

enum EGameStatGroups
{
    GSG_EngineStats,                // 0
    GSG_Game,                       // 1
    GSG_Team,                       // 2
    GSG_Player,                     // 3
    GSG_Weapon,                     // 4
    GSG_Damage,                     // 5
    GSG_Projectile,                 // 6
    GSG_Pawn,                       // 7
    GSG_GameSpecific,               // 8
    GSG_Aggregate,                  // 9
    GSG_MAX                         // 10
};

struct native GameStatGroup
{
    var GameplayEvents.EGameStatGroups Group;
    var int Level;

    structdefaultproperties
    {
        Group=EGameStatGroups.GSG_EngineStats
        Level=0
    }
};

struct native GameplayEventsHeader
{
    var const int EngineVersion;
    var const int StatsWriterVersion;
    var const int StreamOffset;
    var const int AggregateOffset;
    var const int FooterOffset;
    var const int TotalStreamSize;
    var const int FileSize;
    var string FilterClass;
    var int Flags;

    structdefaultproperties
    {
        EngineVersion=0
        StatsWriterVersion=0
        StreamOffset=0
        AggregateOffset=0
        FooterOffset=0
        TotalStreamSize=0
        FileSize=0
        FilterClass=""
        Flags=0
    }
};

struct native GameSessionInformation
{
    var int AppTitleID;
    var int PlatformType;
    var string Language;
    var const string GameplaySessionTimestamp;
    var const float GameplaySessionStartTime;
    var const float GameplaySessionEndTime;
    var const bool bGameplaySessionInProgress;
    var const string GameplaySessionID;
    var const string GameClassName;
    var const string MapName;
    var const string MapURL;
    var const int SessionInstance;
    var const int GameTypeId;
    var const UniqueNetId OwningNetId;
    var int PlaylistId;

    structdefaultproperties
    {
        AppTitleID=0
        PlatformType=0
        Language=""
        GameplaySessionTimestamp=""
        GameplaySessionStartTime=0.0000000
        GameplaySessionEndTime=0.0000000
        bGameplaySessionInProgress=false
        GameplaySessionID=""
        GameClassName=""
        MapName=""
        MapURL=""
        SessionInstance=0
        GameTypeId=0
        OwningNetId=(Uid=())
        PlaylistId=0
    }
};

struct native TeamInformation
{
    var int TeamIndex;
    var string TeamName;
    var Color TeamColor;
    var int MaxSize;

    structdefaultproperties
    {
        TeamIndex=0
        TeamName=""
        TeamColor=(R=0,G=0,B=0,A=0)
        MaxSize=0
    }
};

struct native PlayerInformation
{
    var name ControllerName;
    var string PlayerName;
    var UniqueNetId UniqueId;
    var bool bIsBot;
    var int BotId;
    var string BotName;
    var int Taskforce;

    structdefaultproperties
    {
        ControllerName="None"
        PlayerName=""
        UniqueId=(Uid=())
        bIsBot=false
        BotId=0
        BotName=""
        Taskforce=0
    }
};

struct native GameplayEventMetaData
{
    var const int EventID;
    var const name EventName;
    var const GameStatGroup StatGroup;
    var const int EventDataType;

    structdefaultproperties
    {
        EventID=0
        EventName="None"
        StatGroup=(Group=EGameStatGroups.GSG_EngineStats,Level=0)
        EventDataType=0
    }
};

struct native WeaponClassEventData
{
    var name WeaponClassName;

    structdefaultproperties
    {
        WeaponClassName="None"
    }
};

struct native DamageClassEventData
{
    var name DamageClassName;

    structdefaultproperties
    {
        DamageClassName="None"
    }
};

struct native ProjectileClassEventData
{
    var name ProjectileClassName;

    structdefaultproperties
    {
        ProjectileClassName="None"
    }
};

struct native PawnClassEventData
{
    var name PawnClassName;

    structdefaultproperties
    {
        PawnClassName="None"
    }
};

var native const Pointer Archive;
var private const string StatsFileName;
var GameplayEventsHeader Header;
var GameSessionInformation CurrentSessionInfo;
var const array<PlayerInformation> PlayerList;
var const array<TeamInformation> TeamList;
var array<GameplayEventMetaData> SupportedEvents;
var array<WeaponClassEventData> WeaponClassArray;
var array<DamageClassEventData> DamageClassArray;
var array<ProjectileClassEventData> ProjectileClassArray;
var array<PawnClassEventData> PawnClassArray;
var array<string> ActorArray;
var array<string> SoundCueArray;

function bool OpenStatsFile(string Filename)
{
    //return ReturnValue;    
}

function CloseStatsFile()
{
    //return;    
}

event string GetFilename()
{
    return StatsFileName;
    //return ReturnValue;    
}

defaultproperties
{
    SupportedEvents[0]=(EventID=-1,EventName="Unknown",StatGroup=(Group=EGameStatGroups.GSG_EngineStats,Level=999),EventDataType=1)
    SupportedEvents[1]=(EventID=0,EventName="Match Started",StatGroup=(Group=EGameStatGroups.GSG_Game,Level=1),EventDataType=1)
    SupportedEvents[2]=(EventID=1,EventName="Match Ended",StatGroup=(Group=EGameStatGroups.GSG_Game,Level=1),EventDataType=1)
    SupportedEvents[3]=(EventID=2,EventName="Round Started",StatGroup=(Group=EGameStatGroups.GSG_Game,Level=1),EventDataType=1)
    SupportedEvents[4]=(EventID=3,EventName="Round Ended",StatGroup=(Group=EGameStatGroups.GSG_Game,Level=1),EventDataType=1)
    SupportedEvents[5]=(EventID=6,EventName="Game Class",StatGroup=(Group=EGameStatGroups.GSG_Game,Level=1),EventDataType=0)
    SupportedEvents[6]=(EventID=7,EventName="Game Options",StatGroup=(Group=EGameStatGroups.GSG_Game,Level=1),EventDataType=0)
    SupportedEvents[7]=(EventID=8,EventName="Map Name",StatGroup=(Group=EGameStatGroups.GSG_Game,Level=1),EventDataType=0)
    SupportedEvents[8]=(EventID=50,EventName="Team Created",StatGroup=(Group=EGameStatGroups.GSG_Team,Level=1),EventDataType=2)
    SupportedEvents[9]=(EventID=51,EventName="Team Score",StatGroup=(Group=EGameStatGroups.GSG_Team,Level=1),EventDataType=2)
    SupportedEvents[10]=(EventID=4,EventName="Match Won",StatGroup=(Group=EGameStatGroups.GSG_Team,Level=1),EventDataType=2)
    SupportedEvents[11]=(EventID=5,EventName="Round Won",StatGroup=(Group=EGameStatGroups.GSG_Team,Level=1),EventDataType=2)
    SupportedEvents[12]=(EventID=52,EventName="Round Stalemate",StatGroup=(Group=EGameStatGroups.GSG_Team,Level=1),EventDataType=2)
    SupportedEvents[13]=(EventID=100,EventName="Player Login",StatGroup=(Group=EGameStatGroups.GSG_Player,Level=1),EventDataType=7)
    SupportedEvents[14]=(EventID=101,EventName="Player Logout",StatGroup=(Group=EGameStatGroups.GSG_Player,Level=1),EventDataType=7)
    SupportedEvents[15]=(EventID=104,EventName="Player Killed",StatGroup=(Group=EGameStatGroups.GSG_Player,Level=1),EventDataType=9)
    SupportedEvents[16]=(EventID=108,EventName="Player Death",StatGroup=(Group=EGameStatGroups.GSG_Player,Level=1),EventDataType=9)
    SupportedEvents[17]=(EventID=106,EventName="Player Team Change",StatGroup=(Group=EGameStatGroups.GSG_Player,Level=1),EventDataType=3)
    SupportedEvents[18]=(EventID=102,EventName="Player Spawn",StatGroup=(Group=EGameStatGroups.GSG_Player,Level=1),EventDataType=6)
    SupportedEvents[19]=(EventID=105,EventName="Player Locations",StatGroup=(Group=EGameStatGroups.GSG_Player,Level=10),EventDataType=8)
    SupportedEvents[20]=(EventID=107,EventName="Kill Streak",StatGroup=(Group=EGameStatGroups.GSG_Player,Level=1),EventDataType=3)
    SupportedEvents[21]=(EventID=103,EventName="Player Match Won",StatGroup=(Group=EGameStatGroups.GSG_Player,Level=1),EventDataType=3)
    SupportedEvents[22]=(EventID=109,EventName="Player Round Won",StatGroup=(Group=EGameStatGroups.GSG_Player,Level=1),EventDataType=3)
    SupportedEvents[23]=(EventID=110,EventName="Player Round Stalemate",StatGroup=(Group=EGameStatGroups.GSG_Player,Level=1),EventDataType=3)
    SupportedEvents[24]=(EventID=150,EventName="Weapon Damage",StatGroup=(Group=EGameStatGroups.GSG_Weapon,Level=10),EventDataType=12)
    SupportedEvents[25]=(EventID=151,EventName="Melee Damage",StatGroup=(Group=EGameStatGroups.GSG_Weapon,Level=10),EventDataType=12)
    SupportedEvents[26]=(EventID=152,EventName="Weapon Fired",StatGroup=(Group=EGameStatGroups.GSG_Weapon,Level=10),EventDataType=11)
    SupportedEvents[27]=(EventID=200,EventName="Normal Kill",StatGroup=(Group=EGameStatGroups.GSG_Weapon,Level=1),EventDataType=9)
    SupportedEvents[28]=(EventID=35,EventName="Memory Usage",StatGroup=(Group=EGameStatGroups.GSG_EngineStats,Level=10),EventDataType=1)
    SupportedEvents[29]=(EventID=37,EventName="Network Usage IN",StatGroup=(Group=EGameStatGroups.GSG_EngineStats,Level=10),EventDataType=1)
    SupportedEvents[30]=(EventID=38,EventName="Network Usage OUT",StatGroup=(Group=EGameStatGroups.GSG_EngineStats,Level=10),EventDataType=1)
    SupportedEvents[31]=(EventID=39,EventName="Ping",StatGroup=(Group=EGameStatGroups.GSG_EngineStats,Level=10),EventDataType=1)
    SupportedEvents[32]=(EventID=36,EventName="Frame Rate",StatGroup=(Group=EGameStatGroups.GSG_EngineStats,Level=10),EventDataType=1)
    SupportedEvents[33]=(EventID=41,EventName="Game thread time",StatGroup=(Group=EGameStatGroups.GSG_EngineStats,Level=10),EventDataType=18)
    SupportedEvents[34]=(EventID=40,EventName="Render thread time",StatGroup=(Group=EGameStatGroups.GSG_EngineStats,Level=10),EventDataType=18)
    SupportedEvents[35]=(EventID=42,EventName="GPU render time",StatGroup=(Group=EGameStatGroups.GSG_EngineStats,Level=10),EventDataType=18)
    SupportedEvents[36]=(EventID=43,EventName="Total frame time",StatGroup=(Group=EGameStatGroups.GSG_EngineStats,Level=10),EventDataType=18)
    SupportedEvents[37]=(EventID=302,EventName="AI Path Failure",StatGroup=(Group=EGameStatGroups.GSG_Game,Level=10),EventDataType=14)
    SupportedEvents[38]=(EventID=305,EventName="AI Firelink",StatGroup=(Group=EGameStatGroups.GSG_Game,Level=10),EventDataType=14)
}