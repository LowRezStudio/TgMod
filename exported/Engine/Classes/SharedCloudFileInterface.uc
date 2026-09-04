interface SharedCloudFileInterface extends Interface
    abstract;

function bool GetSharedFileContents(string SharedHandle, out array<byte> FileContents)
{
    //return ReturnValue;    
}

function bool ClearSharedFiles()
{
    //return ReturnValue;    
}

function bool ClearSharedFile(string SharedHandle)
{
    //return ReturnValue;    
}

delegate OnReadSharedFileComplete(bool bWasSuccessful, string SharedHandle)
{
    //return;    
}

function bool ReadSharedFile(string SharedHandle)
{
    //return ReturnValue;    
}

function AddReadSharedFileCompleteDelegate(delegate<OnReadSharedFileComplete> ReadSharedFileCompleteDelegate)
{
    //return;    
}

function ClearReadSharedFileCompleteDelegate(delegate<OnReadSharedFileComplete> ReadSharedFileCompleteDelegate)
{
    //return;    
}

delegate OnWriteSharedFileComplete(bool bWasSuccessful, string UserId, string Filename, string SharedHandle)
{
    //return;    
}

function bool WriteSharedFile(string UserId, string Filename, const out array<byte> Contents)
{
    //return ReturnValue;    
}

function AddWriteSharedFileCompleteDelegate(delegate<OnWriteSharedFileComplete> WriteSharedFileCompleteDelegate)
{
    //return;    
}

function ClearWriteSharedFileCompleteDelegate(delegate<OnWriteSharedFileComplete> WriteSharedFileCompleteDelegate)
{
    //return;    
}
