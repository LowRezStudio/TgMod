interface OnlineEventsInterface extends Interface
    abstract;

function bool UploadPlayerData(UniqueNetId UniqueId, string PlayerNick, OnlineProfileSettings ProfileSettings, OnlinePlayerStorage PlayerStorage)
{
    //return ReturnValue;    
}

function bool UploadGameplayEventsData(UniqueNetId UniqueId, const out array<byte> Payload)
{
    //return ReturnValue;    
}

function bool UpdatePlaylistPopulation(int PlaylistId, int NumPlayers)
{
    //return ReturnValue;    
}
