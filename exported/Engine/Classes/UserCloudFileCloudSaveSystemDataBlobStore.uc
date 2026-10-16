class UserCloudFileCloudSaveSystemDataBlobStore extends Object
    implements(CloudSaveSystemDataBlobStoreInterface);

var private transient UserCloudFileInterface UserCloudFile;
var private transient delegate<GetDataBlobCallbackDelegate> GetDataBlobCallback;
var private transient delegate<SetDataBlobCallbackDelegate> SetDataBlobCallback;
var private transient delegate<DeleteDataBlobCallbackDelegate> DeleteDataBlobCallback;
//var delegate<GetDataBlobCallbackDelegate> __GetDataBlobCallbackDelegate__Delegate;
//var delegate<SetDataBlobCallbackDelegate> __SetDataBlobCallbackDelegate__Delegate;
//var delegate<DeleteDataBlobCallbackDelegate> __DeleteDataBlobCallbackDelegate__Delegate;

delegate GetDataBlobCallbackDelegate(bool bWasSuccessful, string StorageID, string BlobName, out array<byte> DataBlob, string Error)
{
    //return;    
}

delegate SetDataBlobCallbackDelegate(bool bWasSucessfull, string StorageID, string BlobName, string Error)
{
    //return;    
}

private final delegate DeleteDataBlobCallbackDelegate(bool bWasSucessfull, string StorageID, string BlobName, string Error)
{
    //return;    
}

final function Init(UserCloudFileInterface InUserCloudFile)
{
    UserCloudFile = InUserCloudFile;
    //return;    
}

function GetDataBlob(string StorageID, string BlobName, delegate<GetDataBlobCallbackDelegate> InGetDataBlobCallback)
{
    local bool ErrorOccured;
    local string Error;
    local array<byte> EmptyBuffer;

    ErrorOccured = true;
    // End:0x6F
    if(EqualEqual_InterfaceInterface(UserCloudFile, UserCloudFileInterface(none)))
    {
        Error = "GetDataBlob::UserCloudFileInterface instance is null";        
    }
    else
    {
        // End:0xBE
        if(GetDataBlobCallback != none)
        {
            Error = "GetDataBlob::GetDataBlob operation already active";            
        }
        else
        {
            // End:0x10D
            if(InGetDataBlobCallback == none)
            {
                Error = "GetDataBlob::InGetDataBlobCallback cannot be none";                
            }
            else
            {
                UserCloudFile.AddReadUserFileCompleteDelegate(OnReadUserFileComplete);
                GetDataBlobCallback = InGetDataBlobCallback;
                // End:0x195
                if(UserCloudFile.ReadUserFile(StorageID, BlobName))
                {
                    ErrorOccured = false;                    
                }
                else
                {
                    Error = "GetDataBlob::Unknown error starting read of user file from cloud";
                    GetDataBlobCallback = None;
                    UserCloudFile.ClearReadUserFileCompleteDelegate(OnReadUserFileComplete);
                }
            }
        }
    }
    // End:0x283
    if(ErrorOccured && InGetDataBlobCallback != none)
    {
        GetDataBlobCallbackDelegate(false, StorageID, BlobName, EmptyBuffer, Error);
    }
    //return;    
}

private final function OnReadUserFileComplete(bool bWasSuccessful, string UserId, string Filename)
{
    local delegate<GetDataBlobCallbackDelegate> Callback;
    local array<byte> FileContents;
    local bool LocalResult;

    UserCloudFile.ClearReadUserFileCompleteDelegate(OnReadUserFileComplete);
    LocalResult = bWasSuccessful;
    // End:0x9F
    if(bWasSuccessful)
    {
        // End:0x9F
        if(!UserCloudFile.GetFileContents(UserId, Filename, FileContents))
        {
            LocalResult = false;
        }
    }
    // End:0x116
    if(GetDataBlobCallback != none)
    {
        Callback = GetDataBlobCallback;
        GetDataBlobCallback = None;
        GetDataBlobCallbackDelegate(LocalResult, UserId, Filename, FileContents, "");
    }
    //return;    
}

function SetDataBlob(string StorageID, string BlobName, const out array<byte> DataBlob, delegate<SetDataBlobCallbackDelegate> InSetDataBlobCallback)
{
    local bool ErrorOccured;
    local string Error;

    ErrorOccured = true;
    // End:0x6F
    if(EqualEqual_InterfaceInterface(UserCloudFile, UserCloudFileInterface(none)))
    {
        Error = "SetDataBlob::UserCloudFileInterface instance is null";        
    }
    else
    {
        // End:0xBE
        if(SetDataBlobCallback != none)
        {
            Error = "SetDataBlob::SetDataBlob operation already active";            
        }
        else
        {
            // End:0x10D
            if(InSetDataBlobCallback == none)
            {
                Error = "SetDataBlob::InSetDataBlobCallback cannot be none";                
            }
            else
            {
                UserCloudFile.AddWriteUserFileCompleteDelegate(OnWriteUserFileComplete);
                SetDataBlobCallback = InSetDataBlobCallback;
                // End:0x19E
                if(UserCloudFile.WriteUserFile(StorageID, BlobName, DataBlob))
                {
                    ErrorOccured = false;                    
                }
                else
                {
                    Error = "SetDataBlob::Unknown error starting write of user file to cloud";
                    SetDataBlobCallback = None;
                    UserCloudFile.ClearWriteUserFileCompleteDelegate(OnWriteUserFileComplete);
                }
            }
        }
    }
    // End:0x282
    if(ErrorOccured && InSetDataBlobCallback != none)
    {
        SetDataBlobCallbackDelegate(false, StorageID, BlobName, Error);
    }
    //return;    
}

private final function OnWriteUserFileComplete(bool bWasSuccessful, string UserId, string Filename)
{
    local delegate<SetDataBlobCallbackDelegate> Callback;

    UserCloudFile.ClearWriteUserFileCompleteDelegate(OnWriteUserFileComplete);
    // End:0x9F
    if(SetDataBlobCallback != none)
    {
        Callback = SetDataBlobCallback;
        SetDataBlobCallback = None;
        SetDataBlobCallbackDelegate(bWasSuccessful, UserId, Filename, "");
    }
    //return;    
}

function bool DeleteDataBlob(string StorageID, string BlobName, delegate<DeleteDataBlobCallbackDelegate> InDeleteDataBlobCallback)
{
    local bool RValue;

    RValue = false;
    // End:0x11B
    if(NotEqual_InterfaceInterface(UserCloudFile, UserCloudFileInterface(none)) && DeleteDataBlobCallback == none)
    {
        UserCloudFile.AddDeleteUserFileCompleteDelegate(OnDeleteUserFileComplete);
        DeleteDataBlobCallback = InDeleteDataBlobCallback;
        RValue = UserCloudFile.DeleteUserFile(StorageID, BlobName, true, true);
        // End:0x11B
        if(!RValue)
        {
            DeleteDataBlobCallback = None;
            UserCloudFile.ClearDeleteUserFileCompleteDelegate(OnDeleteUserFileComplete);
        }
    }
    return RValue;
    //return ReturnValue;    
}

private final function OnDeleteUserFileComplete(bool bWasSuccessful, string UserId, string Filename)
{
    local delegate<DeleteDataBlobCallbackDelegate> Callback;

    UserCloudFile.ClearDeleteUserFileCompleteDelegate(OnDeleteUserFileComplete);
    // End:0x9F
    if(DeleteDataBlobCallback != none)
    {
        Callback = DeleteDataBlobCallback;
        DeleteDataBlobCallback = None;
        DeleteDataBlobCallbackDelegate(bWasSuccessful, UserId, Filename, "");
    }
    //return;    
}
