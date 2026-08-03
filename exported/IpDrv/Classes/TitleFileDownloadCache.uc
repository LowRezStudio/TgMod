class TitleFileDownloadCache extends MCPBase
    native
    config(Engine)
    implements(OnlineTitleFileCacheInterface);

enum ETitleFileFileOp
{
    TitleFile_None,                 // 0
    TitleFile_Save,                 // 1
    TitleFile_Load,                 // 2
    TitleFile_MAX                   // 3
};

struct native TitleFileCacheEntry extends TitleFile
{
    var string LogicalName;
    var string Hash;
    var TitleFileDownloadCache.ETitleFileFileOp FileOp;
    var private native const Pointer Ar;
};

var array<TitleFileCacheEntry> TitleFiles;
var private array< delegate<OnLoadTitleFileComplete> > LoadCompleteDelegates;
var private array< delegate<OnSaveTitleFileComplete> > SaveCompleteDelegates;
//var delegate<OnLoadTitleFileComplete> __OnLoadTitleFileComplete__Delegate;
//var delegate<OnSaveTitleFileComplete> __OnSaveTitleFileComplete__Delegate;

// Export UTitleFileDownloadCache::execLoadTitleFile(FFrame&, void* const)
native function bool LoadTitleFile(string Filename);

delegate OnLoadTitleFileComplete(bool bWasSuccessful, string Filename)
{
    //return;    
}

function AddLoadTitleFileCompleteDelegate(delegate<OnLoadTitleFileComplete> LoadCompleteDelegate)
{
    // End:0x3E
    if(LoadCompleteDelegates.Find(LoadCompleteDelegate) == -1)
    {
        LoadCompleteDelegates[LoadCompleteDelegates.Length] = LoadCompleteDelegate;
    }
    //return;    
}

function ClearLoadTitleFileCompleteDelegate(delegate<OnLoadTitleFileComplete> LoadCompleteDelegate)
{
    local int RemoveIndex;

    RemoveIndex = LoadCompleteDelegates.Find(LoadCompleteDelegate);
    // End:0x48
    if(RemoveIndex != -1)
    {
        LoadCompleteDelegates.Remove(RemoveIndex, 1);
    }
    //return;    
}

// Export UTitleFileDownloadCache::execSaveTitleFile(FFrame&, void* const)
native function bool SaveTitleFile(string Filename, string LogicalName, array<byte> FileContents);

delegate OnSaveTitleFileComplete(bool bWasSuccessful, string Filename)
{
    //return;    
}

function AddSaveTitleFileCompleteDelegate(delegate<OnSaveTitleFileComplete> SaveCompleteDelegate)
{
    // End:0x3E
    if(SaveCompleteDelegates.Find(SaveCompleteDelegate) == -1)
    {
        SaveCompleteDelegates[SaveCompleteDelegates.Length] = SaveCompleteDelegate;
    }
    //return;    
}

function ClearSaveTitleFileCompleteDelegate(delegate<OnSaveTitleFileComplete> SaveCompleteDelegate)
{
    local int RemoveIndex;

    RemoveIndex = SaveCompleteDelegates.Find(SaveCompleteDelegate);
    // End:0x48
    if(RemoveIndex != -1)
    {
        SaveCompleteDelegates.Remove(RemoveIndex, 1);
    }
    //return;    
}

// Export UTitleFileDownloadCache::execGetTitleFileContents(FFrame&, void* const)
native function bool GetTitleFileContents(string Filename, out array<byte> FileContents);

// Export UTitleFileDownloadCache::execGetTitleFileState(FFrame&, void* const)
native function OnlineSubsystem.EOnlineEnumerationReadState GetTitleFileState(string Filename);

// Export UTitleFileDownloadCache::execGetTitleFileHash(FFrame&, void* const)
native function string GetTitleFileHash(string Filename);

// Export UTitleFileDownloadCache::execGetTitleFileLogicalName(FFrame&, void* const)
native function string GetTitleFileLogicalName(string Filename);

// Export UTitleFileDownloadCache::execClearCachedFiles(FFrame&, void* const)
native function bool ClearCachedFiles();

// Export UTitleFileDownloadCache::execClearCachedFile(FFrame&, void* const)
native function bool ClearCachedFile(string Filename);

// Export UTitleFileDownloadCache::execDeleteTitleFiles(FFrame&, void* const)
native function bool DeleteTitleFiles(float MaxAgeSeconds);

// Export UTitleFileDownloadCache::execDeleteTitleFile(FFrame&, void* const)
native function bool DeleteTitleFile(string Filename);
