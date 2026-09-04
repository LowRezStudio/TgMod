class TgStreamManager extends Object
    native
    config(Engine);

enum STREAMTYPE {
    VST_NONE,  // 0
    VST_HIREZ,  // 1
    VST_TWITCH,  // 2
    VST_TRAINING,  // 3
    VST_COMMUNITY,  // 4
    VST_NEWS,  // 5
};

struct GameStream {
    var bool bLive;
    var bool bFeatured;
    var bool bSpecial;
    var TgStreamManager.STREAMTYPE Type;
    var init string Title;
    var init string StreamURL;
    var init string ChannelName;
    var init string Description;
    var init string Viewers;
    structdefaultproperties {}
};

var string WatchEnd;
var string m_CurrentChannel;
var int m_nNewsIndex;
var array<GameStream> Streams;
var bool m_hasReceivedStreams;
var bool m_hasAnySpecial;
var bool m_hasAnyFeatured;
var UIGameMoviePlayer m_Movie;

native function LoadStreams();  // Export UTgStreamManager::execLoadStreams(FFrame&, void* const)

native function bool OpenStream(int surfaceId, string URL, bool external, float X, float Y, float Width, float Height, float widthReal, float heightReal, optional bool joinChat=true);  // Export UTgStreamManager::execOpenStream(FFrame&, void* const)

native function bool OpenPlayerStream(int nPlayerId, bool external, float X, float Y, float Width, float Height, float widthReal, float heightReal);  // Export UTgStreamManager::execOpenPlayerStream(FFrame&, void* const)

native function bool HasSpecialStreams();  // Export UTgStreamManager::execHasSpecialStreams(FFrame&, void* const)

event bool ViewStreamIndex(int surfaceId, int Index, optional bool external=false, optional float X=0.0000000, optional float Y=0.0000000, optional float Width=0.0000000, optional float Height=0.0000000, optional float widthReal=0.0000000, optional float heightReal=0.0000000, optional bool joinChat=true) { }

event CompleteUpdate() { }

event ResolveChannelName(string sChannel) { }

delegate int ViewerSort(GameStream A, GameStream B);

delegate int FeaturedSort(GameStream A, GameStream B);

delegate int LiveSort(GameStream A, GameStream B);

function int GetTypeCount(TgStreamManager.STREAMTYPE Type) { }

function int GetTypeCountWatching(TgStreamManager.STREAMTYPE Type) { }

function bool IsStream(int Index) { }

function string GetTitleAtIndex(int Index) { }

function string GetViewersAtIndex(int Index) { }

function string GetDescriptionAtIndex(int Index) { }

function bool IsLiveAtIndex(int Index) { }

function bool HaveFeature() { }

function string GetFeatureName(optional int Count=0) { }

function string GetFeatureDescription(optional int Count=0) { }

defaultproperties
{
    WatchEnd="/popout"
    m_nNewsIndex=-1
}
