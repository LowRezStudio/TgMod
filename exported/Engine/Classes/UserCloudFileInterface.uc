interface UserCloudFileInterface extends Interface
    abstract;

function bool GetFileContents(string UserId, string Filename, out array<byte> FileContents)
{
    //return ReturnValue;    
}

function bool ClearFiles(string UserId)
{
    //return ReturnValue;    
}

function bool ClearFile(string UserId, string Filename)
{
    //return ReturnValue;    
}

delegate OnEnumerateUserFilesComplete(bool bWasSuccessful, string UserId)
{
    //return;    
}

function EnumerateUserFiles(string UserId)
{
    //return;    
}

function AddEnumerateUserFileCompleteDelegate(delegate<OnEnumerateUserFilesComplete> EnumerateUserFileCompleteDelegate)
{
    //return;    
}

function ClearEnumerateUserFileCompleteDelegate(delegate<OnEnumerateUserFilesComplete> EnumerateUserFileCompleteDelegate)
{
    //return;    
}

function GetUserFileList(string UserId, out array<EmsFile> UserFiles)
{
    //return;    
}

delegate OnReadUserFileComplete(bool bWasSuccessful, string UserId, string Filename)
{
    //return;    
}

function bool ReadUserFile(string UserId, string Filename)
{
    //return ReturnValue;    
}

function AddReadUserFileCompleteDelegate(delegate<OnReadUserFileComplete> ReadUserFileCompleteDelegate)
{
    //return;    
}

function ClearReadUserFileCompleteDelegate(delegate<OnReadUserFileComplete> ReadUserFileCompleteDelegate)
{
    //return;    
}

delegate OnWriteUserFileComplete(bool bWasSuccessful, string UserId, string Filename)
{
    //return;    
}

function bool WriteUserFile(string UserId, string Filename, const out array<byte> FileContents)
{
    //return ReturnValue;    
}

function AddWriteUserFileCompleteDelegate(delegate<OnWriteUserFileComplete> WriteUserFileCompleteDelegate)
{
    //return;    
}

function ClearWriteUserFileCompleteDelegate(delegate<OnWriteUserFileComplete> WriteUserFileCompleteDelegate)
{
    //return;    
}

delegate OnDeleteUserFileComplete(bool bWasSuccessful, string UserId, string Filename)
{
    //return;    
}

function bool DeleteUserFile(string UserId, string Filename, bool bShouldCloudDelete, bool bShouldLocallyDelete)
{
    //return ReturnValue;    
}

function AddDeleteUserFileCompleteDelegate(delegate<OnDeleteUserFileComplete> DeleteUserFileCompleteDelegate)
{
    //return;    
}

function ClearDeleteUserFileCompleteDelegate(delegate<OnDeleteUserFileComplete> DeleteUserFileCompleteDelegate)
{
    //return;    
}

function ClearAllDelegates()
{
    //return;    
}
