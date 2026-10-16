interface OnlineTitleFileCacheInterface extends Interface
    abstract;

function bool LoadTitleFile(string Filename)
{
    //return ReturnValue;    
}

delegate OnLoadTitleFileComplete(bool bWasSuccessful, string Filename)
{
    //return;    
}

function AddLoadTitleFileCompleteDelegate(delegate<OnLoadTitleFileComplete> LoadCompleteDelegate)
{
    //return;    
}

function ClearLoadTitleFileCompleteDelegate(delegate<OnLoadTitleFileComplete> LoadCompleteDelegate)
{
    //return;    
}

function bool SaveTitleFile(string Filename, string LogicalName, array<byte> FileContents)
{
    //return ReturnValue;    
}

delegate OnSaveTitleFileComplete(bool bWasSuccessful, string Filename)
{
    //return;    
}

function AddSaveTitleFileCompleteDelegate(delegate<OnSaveTitleFileComplete> SaveCompleteDelegate)
{
    //return;    
}

function ClearSaveTitleFileCompleteDelegate(delegate<OnSaveTitleFileComplete> SaveCompleteDelegate)
{
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

function string GetTitleFileHash(string Filename)
{
    //return ReturnValue;    
}

function string GetTitleFileLogicalName(string Filename)
{
    //return ReturnValue;    
}

function bool ClearCachedFiles()
{
    //return ReturnValue;    
}

function bool ClearCachedFile(string Filename)
{
    //return ReturnValue;    
}

function bool DeleteTitleFiles(float MaxAgeSeconds)
{
    //return ReturnValue;    
}

function bool DeleteTitleFile(string Filename)
{
    //return ReturnValue;    
}
