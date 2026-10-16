class OnlineNewsInterfaceMcp extends MCPBase
    native
    config(Engine)
    implements(OnlineNewsInterface);

struct native NewsCacheEntry
{
    var const string NewsUrl;
    var OnlineSubsystem.EOnlineEnumerationReadState ReadState;
    var const OnlineSubsystem.EOnlineNewsType NewsType;
    var string NewsItem;
    var const float TimeOut;
    var const bool bIsUnicode;
    var native const Pointer HttpDownloader;

    structdefaultproperties
    {
        NewsUrl=""
        ReadState=EOnlineEnumerationReadState.OERS_NotStarted
        NewsType=EOnlineNewsType.ONT_Unknown
        NewsItem=""
        TimeOut=0.0000000
        bIsUnicode=false
    }
};

var config array<config NewsCacheEntry> NewsItems;
var array< delegate<OnReadNewsCompleted> > ReadNewsDelegates;
var transient bool bNeedsTicking;
//var delegate<OnReadNewsCompleted> __OnReadNewsCompleted__Delegate;

// Export UOnlineNewsInterfaceMcp::execReadNews(FFrame&, void* const)
native function bool ReadNews(byte LocalUserNum, OnlineSubsystem.EOnlineNewsType NewsType);

delegate OnReadNewsCompleted(bool bWasSuccessful, OnlineSubsystem.EOnlineNewsType NewsType)
{
    //return;    
}

function AddReadNewsCompletedDelegate(delegate<OnReadNewsCompleted> ReadNewsDelegate)
{
    // End:0x3E
    if(ReadNewsDelegates.Find(ReadNewsDelegate) == -1)
    {
        ReadNewsDelegates[ReadNewsDelegates.Length] = ReadNewsDelegate;
    }
    //return;    
}

function ClearReadNewsCompletedDelegate(delegate<OnReadNewsCompleted> ReadGameNewsDelegate)
{
    local int RemoveIndex;

    RemoveIndex = ReadNewsDelegates.Find(ReadGameNewsDelegate);
    // End:0x48
    if(RemoveIndex != -1)
    {
        ReadNewsDelegates.Remove(RemoveIndex, 1);
    }
    //return;    
}

function string GetNews(byte LocalUserNum, OnlineSubsystem.EOnlineNewsType NewsType)
{
    local int NewsIndex;

    NewsIndex = 0;
    J0x0B:

    // End:0x90 [Loop If]
    if(NewsIndex < NewsItems.Length)
    {
        // End:0x82
        if(int(NewsItems[NewsIndex].NewsType) == int(NewsType))
        {
            return NewsItems[NewsIndex].NewsItem;
        }
        NewsIndex++;
        // [Loop Continue]
        goto J0x0B;
    }
    return "";
    //return ReturnValue;    
}
