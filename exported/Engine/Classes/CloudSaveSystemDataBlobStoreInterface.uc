interface CloudSaveSystemDataBlobStoreInterface extends Interface
    abstract;

delegate GetDataBlobCallbackDelegate(bool bWasSuccessful, string StorageID, string BlobName, const out array<byte> DataBlob, string Error)
{
    //return;    
}

function GetDataBlob(string StorageID, string BlobName, delegate<GetDataBlobCallbackDelegate> OnGetDataBlobComplete)
{
    //return;    
}

delegate SetDataBlobCallbackDelegate(bool bWasSucessfull, string StorageID, string BlobName, string Error)
{
    //return;    
}

function SetDataBlob(string StorageID, string BlobName, const out array<byte> DataBlob, delegate<SetDataBlobCallbackDelegate> InSetDataBlobCallback)
{
    //return;    
}

private final delegate DeleteDataBlobCallbackDelegate(bool bWasSucessfull, string StorageID, string BlobName, string Error)
{
    //return;    
}

function bool DeleteDataBlob(string StorageID, string BlobName, delegate<DeleteDataBlobCallbackDelegate> InDeleteDataBlobCallback)
{
    //return ReturnValue;    
}
