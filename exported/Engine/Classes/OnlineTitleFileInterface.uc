interface OnlineTitleFileInterface extends Interface
    abstract;

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
    //return;    
}

function ClearReadTitleFileCompleteDelegate(delegate<OnReadTitleFileComplete> ReadTitleFileCompleteDelegate)
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
    //return;    
}

function ClearRequestTitleFileListCompleteDelegate(delegate<OnRequestTitleFileListComplete> RequestTitleFileListDelegate)
{
    //return;    
}
