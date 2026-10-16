class OnlineTitleFileDownloadWeb extends OnlineTitleFileDownloadBase
    native
    config(Engine);

var private array<TitleFileWeb> TitleFiles;

// Export UOnlineTitleFileDownloadWeb::execUncompressTitleFileContents(FFrame&, void* const)
native function bool UncompressTitleFileContents(OnlineTitleFileDownloadBase.EMcpFileCompressionType FileCompressionType, const out array<byte> CompressedFileContents, out array<byte> UncompressedFileContents);

function bool ReadTitleFile(string FileToRead, optional OnlineSubsystem.EOnlineFileType FileType = 1)
{
    local int FileIndex, Idx;
    local string URL;

    FileIndex = -1;
    Idx = 0;
    J0x20:

    // End:0x9A [Loop If]
    if(Idx < TitleFiles.Length)
    {
        // End:0x8C
        if(InStr(TitleFiles[Idx].Filename, FileToRead, true, false) != -1)
        {
            FileIndex = Idx;
            // [Explicit Break]
            goto J0x9A;
        }
        Idx++;
        // [Loop Continue]
        goto J0x20;
    }
    J0x9A:

    // End:0x132
    if(FileIndex == -1)
    {
        FileIndex = TitleFiles.Length;
        TitleFiles.Length = TitleFiles.Length + 1;
        TitleFiles[FileIndex].Filename = FileToRead;
        TitleFiles[FileIndex].AsyncState = 0;
    }
    // End:0x17A
    if(int(TitleFiles[FileIndex].AsyncState) == int(2))
    {
        TriggerDelegates(true, FileToRead);        
    }
    else
    {
        // End:0x1C4
        if(int(TitleFiles[FileIndex].AsyncState) == int(3))
        {
            TriggerDelegates(false, FileToRead);
            return false;            
        }
        else
        {
            // End:0x3C7
            if(int(TitleFiles[FileIndex].AsyncState) != int(1))
            {
                TitleFiles[FileIndex].AsyncState = 1;
                URL = (GetUrlForFile(FileToRead)) $ FileToRead;
                TitleFiles[FileIndex].HTTPRequest = Class'Engine.HttpFactory'.static.CreateRequest();
                // End:0x3C7
                if(TitleFiles[FileIndex].HTTPRequest != none)
                {
                    TitleFiles[FileIndex].HTTPRequest.__OnProcessRequestComplete__Delegate = OnFileDownloadComplete;
                    TitleFiles[FileIndex].HTTPRequest.SetVerb("GET");
                    TitleFiles[FileIndex].HTTPRequest.SetURL(URL);
                    TitleFiles[FileIndex].HTTPRequest.ProcessRequest();
                }
            }
        }
    }
    return true;
    //return ReturnValue;    
}

private final function OnFileDownloadComplete(HttpRequestInterface Request, HttpResponseInterface Response, bool bDidSucceed)
{
    local bool bSuccess;
    local int FileIndex, Idx;
    local string Filename;
    local array<byte> BinaryData;
    local string FileCompressionTypeString;

    // End:0x2ED
    if(bDidSucceed)
    {
        FileIndex = -1;
        Idx = 0;
        J0x27:

        // End:0x97 [Loop If]
        if(Idx < TitleFiles.Length)
        {
            // End:0x89
            if(TitleFiles[Idx].HTTPRequest == Request)
            {
                FileIndex = Idx;
                // [Explicit Break]
                goto J0x97;
            }
            Idx++;
            // [Loop Continue]
            goto J0x27;
        }
        J0x97:

        // End:0x2EA
        if(FileIndex != -1)
        {
            Filename = TitleFiles[FileIndex].Filename;
            TitleFiles[FileIndex].HTTPRequest = none;
            TitleFiles[FileIndex].AsyncState = 3;
            // End:0x295
            if(Response.GetResponseCode() == 200)
            {
                bSuccess = true;
                Response.GetContent(BinaryData);
                TitleFiles[FileIndex].Data = BinaryData;
                FileCompressionTypeString = Response.GetHeader("Content-Encoding");
                switch(FileCompressionTypeString)
                {
                    // End:0x23D
                    case "MFCT_ZLIB":
                        TitleFiles[FileIndex].FileCompressionType = 1;
                        // End:0x269
                        break;
                    // End:0xFFFF
                    default:
                        TitleFiles[FileIndex].FileCompressionType = 0;
                        break;
                }
                TitleFiles[FileIndex].AsyncState = 2;                
            }
            else
            {
                TitleFiles[FileIndex].AsyncState = 3;
                TitleFiles[FileIndex].Data.Length = 0;
            }            
        }        
    }
    TriggerDelegates(bSuccess, Filename);
    //return;    
}

// Export UOnlineTitleFileDownloadWeb::execTriggerDelegates(FFrame&, void* const)
private native final function TriggerDelegates(bool bSuccess, string FileRead);

// Export UOnlineTitleFileDownloadWeb::execGetTitleFileContents(FFrame&, void* const)
native function bool GetTitleFileContents(string Filename, out array<byte> FileContents);

function OnlineSubsystem.EOnlineEnumerationReadState GetTitleFileState(string Filename)
{
    local int FileIndex;

    FileIndex = TitleFiles.Find('Filename', Filename);
    // End:0x63
    if(FileIndex != -1)
    {
        return TitleFiles[FileIndex].AsyncState;
    }
    return 3;
    //return ReturnValue;    
}

// Export UOnlineTitleFileDownloadWeb::execClearDownloadedFiles(FFrame&, void* const)
native function bool ClearDownloadedFiles();

// Export UOnlineTitleFileDownloadWeb::execClearDownloadedFile(FFrame&, void* const)
native function bool ClearDownloadedFile(string Filename);

function bool RequestTitleFileList()
{
    local HttpRequestInterface HTTPRequest;
    local string URL;
    local bool Success;

    Success = false;
    HTTPRequest = Class'Engine.HttpFactory'.static.CreateRequest();
    // End:0x119
    if(HTTPRequest != none)
    {
        URL = ((GetBaseURL()) $ RequestFileListURL) $ (GetAppAccessURL());
        HTTPRequest.__OnProcessRequestComplete__Delegate = OnFileListReceived;
        HTTPRequest.SetVerb("GET");
        HTTPRequest.SetURL(URL);
        HTTPRequest.ProcessRequest();
        Success = true;        
    }
    return Success;
    //return ReturnValue;    
}

function OnFileListReceived(HttpRequestInterface Request, HttpResponseInterface Response, bool bDidSucceed)
{
    local int Index;
    local delegate<OnRequestTitleFileListComplete> RequestTitleFileListDelegate;
    local array<string> ResponseArr;
    local bool bSuccess;

    // End:0x82
    if(bDidSucceed)
    {
        // End:0x7F
        if((Response != none) && Response.GetResponseCode() == 200)
        {
            ResponseArr.AddItem(Response.GetContentAsString());
            bSuccess = true;            
        }        
    }
    Index = 0;
    J0x8D:

    // End:0x105 [Loop If]
    if(Index < RequestTitleFileListCompleteDelegates.Length)
    {
        RequestTitleFileListDelegate = RequestTitleFileListCompleteDelegates[Index];
        // End:0xF7
        if(RequestTitleFileListDelegate != none)
        {
            OnRequestTitleFileListComplete(bSuccess, ResponseArr);
        }
        Index++;
        // [Loop Continue]
        goto J0x8D;
    }
    //return;    
}

function string GetUrlForFile(string Filename)
{
    local string URL;

    URL = (((GetBaseURL()) $ RequestFileURL) $ (GetAppAccessURL())) $ "&dlName=";
    return URL;
    //return ReturnValue;    
}

defaultproperties
{
    RequestFileListURL="/listfiles"
    RequestFileURL="/downloadfile"
    TimeOut=10.0000000
}