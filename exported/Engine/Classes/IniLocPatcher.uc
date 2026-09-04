class IniLocPatcher extends Object
    native
    config(Engine);

struct native IniLocFileEntry
{
    var string Filename;
    var string DLName;
    var string HashCode;
    var bool bIsUnicode;
    var OnlineSubsystem.EOnlineEnumerationReadState ReadState;

    structdefaultproperties
    {
        Filename=""
        DLName=""
        HashCode=""
        bIsUnicode=false
        ReadState=EOnlineEnumerationReadState.OERS_NotStarted
    }
};

var config array<config IniLocFileEntry> Files;
var config bool bRequestEmsFileList;
var config int MaxCachedFileAge;
var transient OnlineTitleFileInterface TitleFileInterface;
var transient OnlineTitleFileCacheInterface TitleFileCacheInterface;
var array< delegate<OnReadTitleFileComplete> > ReadTitleFileCompleteDelegates;
//var delegate<OnReadTitleFileComplete> __OnReadTitleFileComplete__Delegate;
//var delegate<OnAllTitleFilesCompleted> __OnAllTitleFilesCompleted__Delegate;

delegate OnReadTitleFileComplete(bool bWasSuccessful, string Filename)
{
    //return;    
}

delegate OnAllTitleFilesCompleted()
{
    //return;    
}

function Init()
{
    local OnlineSubsystem OnlineSub;
    local int Index;

    OnlineSub = Class'Engine.GameEngine'.static.GetOnlineSubsystem();
    // End:0x1B8
    if(OnlineSub != none)
    {
        TitleFileInterface = OnlineSub.TitleFileInterface;
        // End:0xB4
        if(NotEqual_InterfaceInterface(TitleFileInterface, OnlineTitleFileInterface(none)))
        {
            TitleFileInterface.AddReadTitleFileCompleteDelegate(OnDownloadFileComplete);            
        }
        else
        {
            Index = 0;
            J0xBF:

            // End:0x10E [Loop If]
            if(Index < Files.Length)
            {
                Files[Index].ReadState = 3;
                Index++;
                // [Loop Continue]
                goto J0xBF;
            }
        }
        TitleFileCacheInterface = OnlineSub.TitleFileCacheInterface;
        // End:0x1B8
        if(NotEqual_InterfaceInterface(TitleFileCacheInterface, OnlineTitleFileCacheInterface(none)))
        {
            TitleFileCacheInterface.AddLoadTitleFileCompleteDelegate(OnFileCacheLoadComplete);
            TitleFileCacheInterface.AddSaveTitleFileCompleteDelegate(OnFileCacheSaveComplete);
        }
    }
    //return;    
}

function DownloadFiles()
{
    local int FileIdx;

    // End:0xBD
    if(bRequestEmsFileList)
    {
        // End:0x69
        if((MaxCachedFileAge > 0) && NotEqual_InterfaceInterface(TitleFileCacheInterface, OnlineTitleFileCacheInterface(none)))
        {
            TitleFileCacheInterface.DeleteTitleFiles(float(MaxCachedFileAge));
        }
        TitleFileInterface.AddRequestTitleFileListCompleteDelegate(OnRequestTitleFileListComplete);
        TitleFileInterface.RequestTitleFileList();        
    }
    else
    {
        FileIdx = 0;
        J0xC8:

        // End:0x13B [Loop If]
        if(FileIdx < Files.Length)
        {
            Files[FileIdx].DLName = Files[FileIdx].Filename;
            FileIdx++;
            // [Loop Continue]
            goto J0xC8;
        }
        StartLoadingFiles();
    }
    //return;    
}

function OnRequestTitleFileListComplete(bool bWasSuccessful, array<string> FilePaths)
{
    //return;    
}

function StartLoadingFiles()
{
    local int Index;

    // End:0x1BF
    if(bRequestEmsFileList)
    {
        // End:0x1BC
        if(NotEqual_InterfaceInterface(TitleFileCacheInterface, OnlineTitleFileCacheInterface(none)))
        {
            Index = 0;
            J0x38:

            // End:0x1BC [Loop If]
            if(Index < Files.Length)
            {
                // End:0x1AE
                if(int(Files[Index].ReadState) == int(0))
                {
                    Files[Index].ReadState = 1;
                    // End:0x1AE
                    if(!TitleFileCacheInterface.LoadTitleFile(Files[Index].DLName))
                    {
                        // End:0x185
                        if((int(Files[Index].ReadState) != int(2)) && int(Files[Index].ReadState) != int(3))
                        {
                            Files[Index].ReadState = 1;                            
                        }
                        else
                        {
                            Files[Index].ReadState = 3;
                        }
                    }
                }
                Index++;
                // [Loop Continue]
                goto J0x38;
            }
        }        
    }
    else
    {
        // End:0x337
        if(NotEqual_InterfaceInterface(TitleFileInterface, OnlineTitleFileInterface(none)))
        {
            Index = 0;
            J0x1EA:

            // End:0x337 [Loop If]
            if(Index < Files.Length)
            {
                // End:0x329
                if(int(Files[Index].ReadState) == int(0))
                {
                    Files[Index].Filename = UpdateLocFileName(Files[Index].Filename);
                    // End:0x300
                    if(TitleFileInterface.ReadTitleFile(Files[Index].DLName))
                    {
                        Files[Index].ReadState = 1;                        
                    }
                    else
                    {
                        Files[Index].ReadState = 3;
                    }
                }
                Index++;
                // [Loop Continue]
                goto J0x1EA;
            }
        }
    }
    //return;    
}

function OnDownloadFileComplete(bool bWasSuccessful, string Filename)
{
    local bool bSuccessLoad;
    local int Index;
    local array<byte> FileData;

    Index = 0;
    J0x0B:

    // End:0x276 [Loop If]
    if(Index < Files.Length)
    {
        // End:0x268
        if(Files[Index].DLName == Filename)
        {
            // End:0x23C
            if(bWasSuccessful)
            {
                // End:0x210
                if(TitleFileInterface.GetTitleFileContents(Filename, FileData) && FileData.Length > 0)
                {
                    bSuccessLoad = true;
                    Files[Index].ReadState = 2;
                    // End:0x184
                    if(bRequestEmsFileList && NotEqual_InterfaceInterface(TitleFileCacheInterface, OnlineTitleFileCacheInterface(none)))
                    {
                        TitleFileCacheInterface.SaveTitleFile(Files[Index].DLName, Files[Index].Filename, FileData);
                    }
                    TitleFileInterface.ClearDownloadedFile(Filename);
                    ProcessIniLocFile(Files[Index].Filename, Files[Index].bIsUnicode, FileData);                    
                }
                else
                {
                    Files[Index].ReadState = 3;
                }                
            }
            else
            {
                Files[Index].ReadState = 3;
            }
            // [Explicit Break]
            goto J0x276;
        }
        Index++;
        // [Loop Continue]
        goto J0x0B;
    }
    J0x276:

    TriggerDownloadCompleteDelegates(bSuccessLoad, Filename);
    //return;    
}

function OnFileCacheLoadComplete(bool bWasSuccessful, string Filename)
{
    local int Index;
    local array<byte> FileData;
    local bool bRequiresDownload;

    bRequiresDownload = true;
    Index = 0;
    J0x17:

    // End:0x218 [Loop If]
    if(Index < Files.Length)
    {
        // End:0x20A
        if(Files[Index].DLName == Filename)
        {
            // End:0x207
            if(bWasSuccessful)
            {
                // End:0x207
                if(TitleFileCacheInterface.GetTitleFileHash(Filename) == Files[Index].HashCode)
                {
                    // End:0x204
                    if(TitleFileCacheInterface.GetTitleFileContents(Filename, FileData) && FileData.Length > 0)
                    {
                        Files[Index].ReadState = 2;
                        bRequiresDownload = false;
                        // End:0x204
                        if(InStr(Files[Index].Filename, ".bin", false, true) == -1)
                        {
                            ProcessIniLocFile(Files[Index].Filename, Files[Index].bIsUnicode, FileData);
                            TitleFileCacheInterface.ClearCachedFile(Filename);
                        }
                    }                    
                }
            }
            // [Explicit Break]
            goto J0x218;
        }
        Index++;
        // [Loop Continue]
        goto J0x17;
    }
    J0x218:

    // End:0x2F5
    if(bRequiresDownload)
    {
        TitleFileCacheInterface.DeleteTitleFile(Filename);
        // End:0x2C9
        if(NotEqual_InterfaceInterface(TitleFileInterface, OnlineTitleFileInterface(none)) && TitleFileInterface.ReadTitleFile(Filename))
        {
            Files[Index].ReadState = 1;            
        }
        else
        {
            Files[Index].ReadState = 3;
        }        
    }
    else
    {
        TriggerDownloadCompleteDelegates(true, Filename);
    }
    //return;    
}

function OnFileCacheSaveComplete(bool bWasSuccessful, string Filename)
{
    local string LogicalName;

    LogicalName = TitleFileCacheInterface.GetTitleFileLogicalName(Filename);
    // End:0x7A
    if(InStr(LogicalName, ".bin", false, true) == -1)
    {
        TitleFileCacheInterface.ClearCachedFile(Filename);
    }
    //return;    
}

function TriggerDownloadCompleteDelegates(bool bSuccess, string Filename)
{
    local int Index;
    local delegate<OnReadTitleFileComplete> OnReadTitleFileComplete;

    Index = 0;
    J0x0B:

    // End:0x8D [Loop If]
    if(Index < ReadTitleFileCompleteDelegates.Length)
    {
        // End:0x7F
        if(ReadTitleFileCompleteDelegates[Index] != none)
        {
            OnReadTitleFileComplete = ReadTitleFileCompleteDelegates[Index];
            OnReadTitleFileComplete(bSuccess, Filename);
        }
        Index++;
        // [Loop Continue]
        goto J0x0B;
    }
    CheckForAllFilesComplete();
    //return;    
}

function CheckForAllFilesComplete()
{
    local int Index;
    local bool bAllFilesComplete;

    bAllFilesComplete = true;
    Index = 0;
    J0x17:

    // End:0xAD [Loop If]
    if(Index < Files.Length)
    {
        // End:0x9F
        if((int(Files[Index].ReadState) == int(0)) || int(Files[Index].ReadState) == int(1))
        {
            bAllFilesComplete = false;
        }
        Index++;
        // [Loop Continue]
        goto J0x17;
    }
    // End:0xCD
    if(bAllFilesComplete)
    {
        OnAllTitleFilesCompleted();
    }
    //return;    
}

// Export UIniLocPatcher::execProcessIniLocFile(FFrame&, void* const)
native function ProcessIniLocFile(string Filename, bool bIsUnicode, const out array<byte> FileData);

function AddFileToDownload(string Filename)
{
    local int FileIndex;

    FileIndex = Files.Find('Filename', Filename);
    // End:0x12D
    if(FileIndex == -1)
    {
        FileIndex = Files.Length;
        Files.Length = FileIndex + 1;
        Files[FileIndex].Filename = Filename;
        Files[FileIndex].DLName = Filename;
        Files[FileIndex].bIsUnicode = (InStr(Filename, ".ini",, true) == -1) && InStr(Filename, ".int",, true) == -1;        
    }
    else
    {
        Files[FileIndex].ReadState = 0;
    }
    DownloadFiles();
    //return;    
}

function AddReadFileDelegate(delegate<OnReadTitleFileComplete> ReadTitleFileCompleteDelegate)
{
    // End:0x47
    if(ReadTitleFileCompleteDelegate != none && ReadTitleFileCompleteDelegates.Find(ReadTitleFileCompleteDelegate) == -1)
    {
        ReadTitleFileCompleteDelegates.AddItem(ReadTitleFileCompleteDelegate);
    }
    //return;    
}

function ClearReadFileDelegate(delegate<OnReadTitleFileComplete> ReadTitleFileCompleteDelegate)
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

function ClearCachedFiles()
{
    local int Index;

    Index = 0;
    J0x0B:

    // End:0x5A [Loop If]
    if(Index < Files.Length)
    {
        Files[Index].ReadState = 0;
        Index++;
        // [Loop Continue]
        goto J0x0B;
    }
    // End:0x9A
    if(NotEqual_InterfaceInterface(TitleFileInterface, OnlineTitleFileInterface(none)))
    {
        TitleFileInterface.ClearDownloadedFiles();
    }
    // End:0xDA
    if(NotEqual_InterfaceInterface(TitleFileCacheInterface, OnlineTitleFileCacheInterface(none)))
    {
        TitleFileCacheInterface.ClearCachedFiles();
    }
    //return;    
}

// Export UIniLocPatcher::execUpdateLocFileName(FFrame&, void* const)
native function string UpdateLocFileName(string Filename);
