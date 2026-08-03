class GameEngine extends Engine
    transient
    native(GameEngine)
    config(Engine);

enum EFullyLoadPackageType
{
    FULLYLOAD_Map,                  // 0
    FULLYLOAD_Game_PreLoadClass,    // 1
    FULLYLOAD_Game_PostLoadClass,   // 2
    FULLYLOAD_Always,               // 3
    FULLYLOAD_Mutator,              // 4
    FULLYLOAD_MAX                   // 5
};

struct native transient URL
{
    var init string Protocol;
    var init string Host;
    var init int Port;
    var init string Map;
    var init array<string> Op;
    var init string Portal;
    var init string SecureAddress;
    var init int Valid;

    structdefaultproperties
    {
        Protocol=""
        Host=""
        Port=0
        Map=""
        Op=none
        Portal=""
        SecureAddress=""
        Valid=0
    }
};

struct native LevelStreamingStatus
{
    var name PackageName;
    var bool bShouldBeLoaded;
    var bool bShouldBeVisible;

    structdefaultproperties
    {
        PackageName="None"
        bShouldBeLoaded=false
        bShouldBeVisible=false
    }
};

struct native FullyLoadedPackagesInfo
{
    var GameEngine.EFullyLoadPackageType FullyLoadType;
    var string Tag;
    var array<name> PackagesToLoad;
    var array<Object> LoadedObjects;

    structdefaultproperties
    {
        FullyLoadType=EFullyLoadPackageType.FULLYLOAD_Map
        Tag=""
        PackagesToLoad=none
        LoadedObjects=none
    }
};

struct native NamedNetDriver
{
    var name NetDriverName;
    var native const Pointer NetDriver;

    structdefaultproperties
    {
        NetDriverName="None"
    }
};

struct native AnimTag
{
    var string Tag;
    var array<string> Contains;

    structdefaultproperties
    {
        Tag=""
        Contains=none
    }
};

var PendingLevel GPendingLevel;
var config string PendingLevelPlayerControllerClassName;
var URL LastURL;
var URL LastRemoteURL;
var config array<config string> ServerActors;
var string TravelURL;
var byte TravelType;
var const transient bool bWorldWasLoadedThisTick;
var const transient bool bWorldWasLoadedLastTick;
var const transient bool bCheckForMovieCapture;
var const transient bool bTriggerPostLoadMap;
var const transient bool bStartedLoadMapMovie;
var const bool bShouldCommitPendingMapChange;
var config bool bClearAnimSetLinkupCachesOnLoadMap;
var config bool bEnableSecondaryDisplay;
var config bool bEnableSecondaryViewport;
var const transient OnlineSubsystem OnlineSubsystem;
var const transient GamePadLightbarSubsystem GamePadLightbarSubsystem;
var const transient DownloadableContentEnumerator DLCEnumerator;
var config string DownloadableContentEnumeratorClassName;
var const transient DownloadableContentManager DLCManager;
var config string DownloadableContentManagerClassName;
var const array<name> LevelsToLoadForPendingMapChange;
var const array<Level> LoadedLevelsForPendingMapChange;
var const string PendingMapChangeFailureDescription;
var config float MaxDeltaTime;
var config string SecondaryViewportClientClassName;
var init array<init ScriptViewportClient> SecondaryViewportClients;
var init array<init Pointer> SecondaryViewportFrames;
var const array<LevelStreamingStatus> PendingLevelStreamingStatusUpdates;
var const array<ObjectReferencer> ObjectReferencers;
var array<FullyLoadedPackagesInfo> PackagesToFullyLoad;
var const transient array<NamedNetDriver> NamedNetDrivers;
var config array<config AnimTag> AnimTags;

// Export UGameEngine::execCreateNamedNetDriver(FFrame&, void* const)
native final function bool CreateNamedNetDriver(name NetDriverName);

// Export UGameEngine::execDestroyNamedNetDriver(FFrame&, void* const)
native final function DestroyNamedNetDriver(name NetDriverName);

// Export UGameEngine::execGetOnlineSubsystem(FFrame&, void* const)
native static final function OnlineSubsystem GetOnlineSubsystem();

// Export UGameEngine::execGetDLCEnumerator(FFrame&, void* const)
native static final function DownloadableContentEnumerator GetDLCEnumerator();

// Export UGameEngine::execGetDLCManager(FFrame&, void* const)
native static final function DownloadableContentManager GetDLCManager();

// Export UGameEngine::execHasSecondaryScreenActive(FFrame&, void* const)
native static final function bool HasSecondaryScreenActive();

// Export UGameEngine::execEncodeURLString(FFrame&, void* const)
native static final function EncodeURLString(out string Str);

// Export UGameEngine::execDecodeURLString(FFrame&, void* const)
native static final function DecodeURLString(out string Str);

defaultproperties
{
    LastURL=(Protocol="",Host="",Port=0,Map="",Op=none,Portal="",SecureAddress="",Valid=1)
    LastRemoteURL=(Protocol="",Host="",Port=0,Map="",Op=none,Portal="",SecureAddress="",Valid=1)
    bClearAnimSetLinkupCachesOnLoadMap=true
    LocalPlayerClassName="TgGame.TgLocalPlayer"
    bUsePostProcessEffects=true
    bOnScreenKismetWarnings=true
    MaxSmoothedFrameRate=150.0000000
    ScoutClassName="Engine.Scout"
    CameraTranslationThreshold=1600.0000000
}