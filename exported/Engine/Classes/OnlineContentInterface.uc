interface OnlineContentInterface extends Interface
    abstract;

delegate OnContentChange()
{
    //return;    
}

function AddContentChangeDelegate(delegate<OnContentChange> ContentDelegate, optional byte LocalUserNum = 255)
{
    //return;    
}

function ClearContentChangeDelegate(delegate<OnContentChange> ContentDelegate, optional byte LocalUserNum = 255)
{
    //return;    
}

delegate OnReadDownloadableContentComplete(bool bWasSuccessful)
{
    //return;    
}

function AddReadDownloadableContentComplete(byte LocalUserNum, delegate<OnReadDownloadableContentComplete> ReadDLCCompleteDelegate)
{
    //return;    
}

function ClearReadDownloadableContentComplete(byte LocalUserNum, delegate<OnReadDownloadableContentComplete> ReadDLCCompleteDelegate)
{
    //return;    
}

function bool ReadDownloadableContentList(byte LocalUserNum)
{
    //return ReturnValue;    
}

function ClearDownloadableContentList(byte LocalUserNum)
{
    //return;    
}

function OnlineSubsystem.EOnlineEnumerationReadState GetDownloadableContentList(byte LocalUserNum, out array<OnlineContent> ContentList)
{
    //return ReturnValue;    
}

function bool ReadCrossTitleDownloadableContentList(byte LocalUserNum, optional int TitleId = 0)
{
    //return ReturnValue;    
}

function ClearCrossTitleDownloadableContentList(byte LocalUserNum)
{
    //return;    
}

function OnlineSubsystem.EOnlineEnumerationReadState GetCrossTitleDownloadableContentList(byte LocalUserNum, out array<OnlineCrossTitleContent> ContentList)
{
    //return ReturnValue;    
}

delegate OnReadCrossTitleDownloadableContentComplete(bool bWasSuccessful)
{
    //return;    
}

function AddReadCrossTitleDownloadableContentCompleteDelegate(byte LocalUserNum, delegate<OnReadCrossTitleDownloadableContentComplete> ReadCrossTitleDLCCompleteDelegate)
{
    //return;    
}

function ClearReadCrossTitleDownloadableContentCompleteDelegate(byte LocalUserNum, delegate<OnReadCrossTitleDownloadableContentComplete> ReadCrossTitleDLCCompleteDelegate)
{
    //return;    
}

function bool ReadCrossTitleSaveGameData(byte LocalUserNum, int DeviceID, int TitleId, string FriendlyName, string Filename, string SaveFileName)
{
    //return ReturnValue;    
}

function bool GetCrossTitleSaveGameData(byte LocalUserNum, int DeviceID, int TitleId, string FriendlyName, string Filename, string SaveFileName, out byte bIsValid, out array<byte> SaveGameData)
{
    //return ReturnValue;    
}

delegate OnReadCrossTitleSaveGameDataComplete(bool bWasSuccessful, byte LocalUserNum, int DeviceID, int TitleId, string FriendlyName, string Filename, string SaveFileName)
{
    //return;    
}

function AddReadCrossTitleSaveGameDataComplete(byte LocalUserNum, delegate<OnReadCrossTitleSaveGameDataComplete> ReadSaveGameDataCompleteDelegate)
{
    //return;    
}

function ClearReadCrossTitleSaveGameDataComplete(byte LocalUserNum, delegate<OnReadCrossTitleSaveGameDataComplete> ReadSaveGameDataCompleteDelegate)
{
    //return;    
}

function bool ClearCrossTitleSaveGames(byte LocalUserNum)
{
    //return ReturnValue;    
}

function bool QueryAvailableDownloads(byte LocalUserNum, optional int CategoryMask = -1)
{
    //return ReturnValue;    
}

delegate OnQueryAvailableDownloadsComplete(bool bWasSuccessful)
{
    //return;    
}

function AddQueryAvailableDownloadsComplete(byte LocalUserNum, delegate<OnQueryAvailableDownloadsComplete> QueryDownloadsDelegate)
{
    //return;    
}

function ClearQueryAvailableDownloadsComplete(byte LocalUserNum, delegate<OnQueryAvailableDownloadsComplete> QueryDownloadsDelegate)
{
    //return;    
}

function GetAvailableDownloadCounts(byte LocalUserNum, out int NewDownloads, out int TotalDownloads)
{
    //return;    
}

function bool ReadSaveGameData(byte LocalUserNum, string SaveFileName)
{
    //return ReturnValue;    
}

function bool GetSaveGameData(byte LocalUserNum, string SaveFileName, out byte bIsValid, out array<byte> SaveGameData)
{
    //return ReturnValue;    
}

delegate OnReadSaveGameDataComplete(bool bWasSuccessful, byte LocalUserNum, string SaveFileName)
{
    //return;    
}

function AddReadSaveGameDataCompleteDelegate(byte LocalUserNum, delegate<OnReadSaveGameDataComplete> ReadSaveGameDataCompleteDelegate)
{
    //return;    
}

function ClearReadSaveGameDataCompleteDelegate(byte LocalUserNum, delegate<OnReadSaveGameDataComplete> ReadSaveGameDataCompleteDelegate)
{
    //return;    
}

function bool WriteSaveGameData(byte LocalUserNum, string SaveFileName, const out array<byte> SaveGameData, optional string Title, optional string SubTitle, optional string Description)
{
    //return ReturnValue;    
}

delegate OnWriteSaveGameDataComplete(bool bWasSuccessful, byte LocalUserNum, string SaveFileName)
{
    //return;    
}

function AddWriteSaveGameDataCompleteDelegate(byte LocalUserNum, delegate<OnWriteSaveGameDataComplete> WriteSaveGameDataCompleteDelegate)
{
    //return;    
}

function ClearWriteSaveGameDataCompleteDelegate(byte LocalUserNum, delegate<OnWriteSaveGameDataComplete> WriteSaveGameDataCompleteDelegate)
{
    //return;    
}

function bool DeleteSaveGameData(byte LocalUserNum, string SaveFileName)
{
    //return ReturnValue;    
}

delegate OnDeleteSaveGameDataComplete(bool bWasSuccessful, byte LocalUserNum, string SaveFileName)
{
    //return;    
}

function AddDeleteSaveGameDataCompleteDelegate(byte LocalUserNum, delegate<OnDeleteSaveGameDataComplete> DeleteSaveGameDataCompleteDelegate)
{
    //return;    
}

function ClearDeleteSaveGameDataCompleteDelegate(byte LocalUserNum, delegate<OnDeleteSaveGameDataComplete> DeleteSaveGameDataCompleteDelegate)
{
    //return;    
}

function bool ClearCachedSaveGames(byte LocalUserNum)
{
    //return ReturnValue;    
}
