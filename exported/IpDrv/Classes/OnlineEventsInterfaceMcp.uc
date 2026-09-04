class OnlineEventsInterfaceMcp extends MCPBase
    native
    config(Engine)
    implements(OnlineEventsInterface);

enum EEventUploadType
{
    EUT_GenericStats,               // 0
    EUT_ProfileData,                // 1
    EUT_MatchmakingData,            // 2
    EUT_PlaylistPopulation,         // 3
    EUT_MAX                         // 4
};

struct native EventUploadConfig
{
    var const OnlineEventsInterfaceMcp.EEventUploadType UploadType;
    var const string UploadUrl;
    var const float TimeOut;
    var const bool bUseCompression;

    structdefaultproperties
    {
        UploadType=EEventUploadType.EUT_GenericStats
        UploadUrl=""
        TimeOut=0.0000000
        bUseCompression=false
    }
};

var const config array<config EventUploadConfig> EventUploadConfigs;
var native const array<Pointer> MCPEventPostObjects;
var config array<config OnlineEventsInterfaceMcp.EEventUploadType> DisabledUploadTypes;
var const config bool bBinaryStats;

// Export UOnlineEventsInterfaceMcp::execUploadPlayerData(FFrame&, void* const)
native function bool UploadPlayerData(UniqueNetId UniqueId, string PlayerNick, OnlineProfileSettings ProfileSettings, OnlinePlayerStorage PlayerStorage);

// Export UOnlineEventsInterfaceMcp::execUploadGameplayEventsData(FFrame&, void* const)
native function bool UploadGameplayEventsData(UniqueNetId UniqueId, const out array<byte> Payload);

// Export UOnlineEventsInterfaceMcp::execUpdatePlaylistPopulation(FFrame&, void* const)
native function bool UpdatePlaylistPopulation(int PlaylistId, int NumPlayers);

// Export UOnlineEventsInterfaceMcp::execUploadMatchmakingStats(FFrame&, void* const)
native function bool UploadMatchmakingStats(UniqueNetId UniqueId, OnlineMatchmakingStats MMStats);
