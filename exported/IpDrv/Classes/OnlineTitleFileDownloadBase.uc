class OnlineTitleFileDownloadBase extends MCPBase
    native
    config(Engine)
    implements(OnlineTitleFileInterface);

enum EMcpFileCompressionType
{
    MFCT_NONE,                      // 0
    MFCT_ZLIB,                      // 1
    MFCT_MAX                        // 2
};

struct native TitleFileWeb extends TitleFile
{
    var string StringData;
    var HttpRequestInterface HTTPRequest;
    var OnlineTitleFileDownloadBase.EMcpFileCompressionType FileCompressionType;
};

struct native FileNameToURLMapping
{
    var name Filename;
    var name UrlMapping;

    structdefaultproperties
    {
        Filename="None"
        UrlMapping="None"
    }
};

var private array< delegate<OnReadTitleFileComplete> > ReadTitleFileCompleteDelegates;
var array< delegate<OnRequestTitleFileListComplete> > RequestTitleFileListCompleteDelegates;
var config string BaseUrl;
var config string RequestFileListURL;
var config string RequestFileURL;
var config float TimeOut;
var config array<config FileNameToURLMapping> FilesToUrls;
//var delegate<OnReadTitleFileComplete> __OnReadTitleFileComplete__Delegate;
//var delegate<OnRequestTitleFileListComplete> __OnRequestTitleFileListComplete__Delegate;

delegate OnReadTitleFileComplete(bool bWasSuccessful, string Filename)
{
    //return;    
}

function bool ReadTitleFile(string FileToRead, optional OnlineSubsystem.EOnlineFileType FileType = 1)
{
    //return ReturnValue;    
}

function AddReadTitleFileCompleteDelegate(delegate<OnReadTitleFileComplete> ReadTitleFileCompleteDelegate)
{
    // End:0x3E
    if(ReadTitleFileCompleteDelegates.Find(ReadTitleFileCompleteDelegate) == -1)
    {
        ReadTitleFileCompleteDelegates[ReadTitleFileCompleteDelegates.Length] = ReadTitleFileCompleteDelegate;
    }
    //return;    
}

function ClearReadTitleFileCompleteDelegate(delegate<OnReadTitleFileComplete> ReadTitleFileCompleteDelegate)
{
    local int RemoveIndex;

    RemoveIndex = ReadTitleFileCompleteDelegates.Find(ReadTitleFileCompleteDelegate);
    // End:0x48
    if(RemoveIndex != -1)
    {
        ReadTitleFileCompleteDelegates.Remove(RemoveIndex, 1);
    }
    //return;    
}

function bool GetTitleFileContents(string Filename, out array<byte> FileContents)
{
    //return ReturnValue;    
}

function OnlineSubsystem.EOnlineEnumerationReadState GetTitleFileState(string Filename)
{
    //return ReturnValue;    
}

function bool ClearDownloadedFiles()
{
    //return ReturnValue;    
}

function bool ClearDownloadedFile(string Filename)
{
    //return ReturnValue;    
}

function bool RequestTitleFileList()
{
    //return ReturnValue;    
}

delegate OnRequestTitleFileListComplete(bool bWasSuccessful, array<string> FilePaths)
{
    //return;    
}

function AddRequestTitleFileListCompleteDelegate(delegate<OnRequestTitleFileListComplete> RequestTitleFileListDelegate)
{
    // End:0x36
    if(RequestTitleFileListCompleteDelegates.Find(RequestTitleFileListDelegate) == -1)
    {
        RequestTitleFileListCompleteDelegates.AddItem(RequestTitleFileListDelegate);
    }
    //return;    
}

function ClearRequestTitleFileListCompleteDelegate(delegate<OnRequestTitleFileListComplete> RequestTitleFileListDelegate)
{
    local int RemoveIndex;

    RemoveIndex = RequestTitleFileListCompleteDelegates.Find(RequestTitleFileListDelegate);
    // End:0x48
    if(RemoveIndex != -1)
    {
        RequestTitleFileListCompleteDelegates.Remove(RemoveIndex, 1);
    }
    //return;    
}

// Export UOnlineTitleFileDownloadBase::execGetUrlForFile(FFrame&, void* const)
native function string GetUrlForFile(string Filename);
