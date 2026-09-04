interface OnlineCommunityContentInterface extends Interface
    abstract;

function bool Init()
{
    //return ReturnValue;    
}

function Exit()
{
    //return;    
}

function bool ReadContentList(byte PlayerNum, UniqueNetId NetId, optional string Path = "", optional int StartAt = 0, optional int NumToRead = 0)
{
    //return ReturnValue;    
}

delegate OnReadContentListComplete(bool bWasSuccessful, array<CommunityContentFile> ContentFiles)
{
    //return;    
}

function AddReadContentListCompleteDelegate(delegate<OnReadContentListComplete> ReadContentListCompleteDelegate)
{
    //return;    
}

function ClearReadContentListCompleteDelegate(delegate<OnReadContentListComplete> ReadContentListCompleteDelegate)
{
    //return;    
}

function bool GetContentList(byte PlayerNum, out array<CommunityContentFile> ContentFiles)
{
    //return ReturnValue;    
}

function bool ReadFriendsContentList(byte PlayerNum, const out array<OnlineFriend> Friends, optional int StartAt = 0, optional int NumToRead = -1)
{
    //return ReturnValue;    
}

delegate OnReadFriendsContentListComplete(bool bWasSuccessful)
{
    //return;    
}

function AddReadFriendsContentListCompleteDelegate(delegate<OnReadFriendsContentListComplete> ReadFriendsContentListCompleteDelegate)
{
    //return;    
}

function ClearReadFriendsContentListCompleteDelegate(delegate<OnReadFriendsContentListComplete> ReadFriendsContentListCompleteDelegate)
{
    //return;    
}

function bool GetFriendsContentList(byte PlayerNum, const out OnlineFriend Friend, out array<CommunityContentFile> ContentFiles)
{
    //return ReturnValue;    
}

function bool UploadContent(byte PlayerNum, const out array<byte> Payload, const out CommunityContentMetadata MetaData)
{
    //return ReturnValue;    
}

delegate OnUploadContentComplete(bool bWasSuccessful, CommunityContentFile UploadedFile)
{
    //return;    
}

function AddUploadContentCompleteDelegate(delegate<OnUploadContentComplete> UploadContentCompleteDelegate)
{
    //return;    
}

function ClearUploadContentCompleteDelegate(delegate<OnUploadContentComplete> UploadContentCompleteDelegate)
{
    //return;    
}

function bool DownloadContent(byte PlayerNum, const out CommunityContentFile FileToDownload)
{
    //return ReturnValue;    
}

delegate OnDownloadContentComplete(bool bWasSuccessful, CommunityContentFile FileDownloaded, array<byte> Payload)
{
    //return;    
}

function AddDownloadContentCompleteDelegate(delegate<OnDownloadContentComplete> DownloadContentCompleteDelegate)
{
    //return;    
}

function ClearDownloadContentCompleteDelegate(delegate<OnDownloadContentComplete> DownloadContentCompleteDelegate)
{
    //return;    
}

function bool DeleteContent(byte PlayerNum, const out CommunityContentMetadata MetaData)
{
    //return ReturnValue;    
}

delegate OnDeleteContentComplete(bool bWasSuccessful)
{
    //return;    
}

function AddDeleteContentCompleteDelegate(delegate<OnDeleteContentComplete> DeleteContentCompleteDelegate)
{
    //return;    
}

function ClearDeleteContentCompleteDelegate(delegate<OnDeleteContentComplete> DeleteContentCompleteDelegate)
{
    //return;    
}

function RateContent(byte PlayerNum, const out CommunityContentFile FileToRate, int NewRating)
{
    //return;    
}
