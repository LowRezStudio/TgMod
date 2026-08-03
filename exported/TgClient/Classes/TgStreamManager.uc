class TgStreamManager extends Object
    native;

enum STREAMTYPE
{
    VST_NONE,                       // 0
    VST_HIREZ,                      // 1
    VST_TWITCH,                     // 2
    VST_TRAINING,                   // 3
    VST_COMMUNITY,                  // 4
    VST_NEWS,                       // 5
    VST_MAX                         // 6
};

struct native GameStream
{
    var bool bLive;
    var bool bFeatured;
    var bool bSpecial;
    var TgStreamManager.STREAMTYPE Type;
    var init string Title;
    var init string StreamURL;
    var init string ChannelName;
    var init string Description;
    var init string Viewers;

    structdefaultproperties
    {
        bLive=false
        bFeatured=false
        bSpecial=false
        Type=STREAMTYPE.VST_NONE
        Title=""
        StreamURL=""
        ChannelName=""
        Description=""
        Viewers=""
    }
};

var string WatchEnd;
var string m_CurrentChannel;
var int m_nNewsIndex;
var array<GameStream> Streams;
var bool m_hasReceivedStreams;
var bool m_hasAnySpecial;
var bool m_hasAnyFeatured;
var UIGameMoviePlayer m_Movie;
//var delegate<ViewerSort> __ViewerSort__Delegate;
//var delegate<FeaturedSort> __FeaturedSort__Delegate;
//var delegate<LiveSort> __LiveSort__Delegate;

// Export UTgStreamManager::execLoadStreams(FFrame&, void* const)
native function LoadStreams();

// Export UTgStreamManager::execOpenStream(FFrame&, void* const)
native function bool OpenStream(int surfaceId, string URL, bool external, float X, float Y, float Width, float Height, float widthReal, float heightReal, optional bool joinChat = true);

// Export UTgStreamManager::execOpenPlayerStream(FFrame&, void* const)
native function bool OpenPlayerStream(int nPlayerId, bool external, float X, float Y, float Width, float Height, float widthReal, float heightReal);

// Export UTgStreamManager::execHasSpecialStreams(FFrame&, void* const)
native function bool HasSpecialStreams();

event bool ViewStreamIndex(int surfaceId, int Index, optional bool external = false, optional float X = 0.0000000, optional float Y = 0.0000000, optional float Width = 0.0000000, optional float Height = 0.0000000, optional float widthReal = 0.0000000, optional float heightReal = 0.0000000, optional bool joinChat = true)
{
    local string watch_end;

    // End:0x138
    if(IsStream(Index))
    {
        // End:0x78
        if(!external)
        {
            watch_end = WatchEnd;
        }
        ResolveChannelName(Streams[Index].ChannelName);
        OpenStream(surfaceId, Streams[Index].StreamURL $ watch_end, external, X, Y, Width, Height, widthReal, heightReal, joinChat);
        return true;
    }
    return false;
    //return ReturnValue;    
}

event CompleteUpdate()
{
    //return;    
}

event ResolveChannelName(string sChannel)
{
    m_CurrentChannel = Split(sChannel, "live_user_", true);
    //return;    
}

delegate int ViewerSort(GameStream A, GameStream B)
{
    return ((int(A.Viewers) < int(B.Viewers)) ? -1 : 0);
    //return ReturnValue;    
}

delegate int FeaturedSort(GameStream A, GameStream B)
{
    return ((!A.bFeatured && B.bFeatured) ? -1 : 0);
    //return ReturnValue;    
}

delegate int LiveSort(GameStream A, GameStream B)
{
    return ((!A.bLive && B.bLive) ? -1 : 0);
    //return ReturnValue;    
}

function int GetTypeCount(TgStreamManager.STREAMTYPE Type)
{
    local int I, Count;

    Count = 0;
    I = 0;
    J0x16:

    // End:0x7F [Loop If]
    if(I < Streams.Length)
    {
        // End:0x71
        if(int(Streams[I].Type) == int(Type))
        {
            Count++;
        }
        I++;
        // [Loop Continue]
        goto J0x16;
    }
    return Count;
    //return ReturnValue;    
}

function int GetTypeCountWatching(TgStreamManager.STREAMTYPE Type)
{
    local int I, Count;

    Count = 0;
    I = 0;
    J0x16:

    // End:0xA7 [Loop If]
    if(I < Streams.Length)
    {
        // End:0x99
        if(int(Streams[I].Type) == int(Type))
        {
            Count += int(Streams[I].Viewers);
        }
        I++;
        // [Loop Continue]
        goto J0x16;
    }
    return Count;
    //return ReturnValue;    
}

function bool IsStream(int Index)
{
    // End:0x4E
    if(Index < Streams.Length)
    {
        return ((int(Streams[Index].Type) == int(2)) ? true : false);
    }
    return false;
    //return ReturnValue;    
}

function string GetTitleAtIndex(int Index)
{
    // End:0x3F
    if(Index < Streams.Length)
    {
        return Streams[Index].Title;
    }
    return "";
    //return ReturnValue;    
}

function string GetViewersAtIndex(int Index)
{
    // End:0x3F
    if(Index < Streams.Length)
    {
        return Streams[Index].Viewers;
    }
    return "0";
    //return ReturnValue;    
}

function string GetDescriptionAtIndex(int Index)
{
    local string Desc;

    // End:0x48
    if(Index < Streams.Length)
    {
        Desc = Streams[Index].Description;
    }
    // End:0x58
    if(Desc == "")
    {
    }
    return Desc;
    //return ReturnValue;    
}

function bool IsLiveAtIndex(int Index)
{
    // End:0x40
    if(Index < Streams.Length)
    {
        return Streams[Index].bLive;
    }
    return false;
    //return ReturnValue;    
}

function bool HaveFeature()
{
    local int I;

    I = 0;
    J0x0B:

    // End:0x5D [Loop If]
    if(I < Streams.Length)
    {
        // End:0x4F
        if(Streams[I].bFeatured)
        {
            return true;
        }
        I++;
        // [Loop Continue]
        goto J0x0B;
    }
    return false;
    //return ReturnValue;    
}

function string GetFeatureName(optional int Count = 0)
{
    local int I;

    I = 0;
    J0x10:

    // End:0xD4 [Loop If]
    if(I < Streams.Length)
    {
        // End:0xC6
        if(Streams[I].bFeatured && int(Streams[I].Type) != int(5))
        {
            // End:0xBB
            if(Count <= 0)
            {
                return Streams[I].Title;
            }
            Count--;
        }
        I++;
        // [Loop Continue]
        goto J0x10;
    }
    return "";
    //return ReturnValue;    
}

function string GetFeatureDescription(optional int Count = 0)
{
    local int I;

    I = 0;
    J0x10:

    // End:0xD4 [Loop If]
    if(I < Streams.Length)
    {
        // End:0xC6
        if(Streams[I].bFeatured && int(Streams[I].Type) != int(5))
        {
            // End:0xBB
            if(Count <= 0)
            {
                return Streams[I].Description;
            }
            Count--;
        }
        I++;
        // [Loop Continue]
        goto J0x10;
    }
    return "";
    //return ReturnValue;    
}

defaultproperties
{
    WatchEnd="/popout"
    m_nNewsIndex=-1
}