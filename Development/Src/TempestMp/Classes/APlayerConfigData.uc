class APlayerConfigData extends Object
    config(PlayerData);

struct PlayerInfo
{
    var string PlayerName;
    var string ChampionName;
    var string Team;
    var string Password;
    var string Horse;
    var string NetAddress;
    var bool bProcessed;
};

var config array<PlayerInfo> SavedPlayers;
var config int MaxStoredPlayers;

function InitializeConfig()
{
    if (MaxStoredPlayers <= 0)
    {
        MaxStoredPlayers = 100; // TODO: Rename this so it actually makes sense lmao
        SaveConfig();
    }
}


function PlayerInfo FindPlayerByAddress(string Address)
{
    local PlayerInfo EmptyInfo;
    local int i;
    
    for (i = 0; i < SavedPlayers.Length; i++)
    {
        if (SavedPlayers[i].NetAddress == Address)
        {
            return SavedPlayers[i];
        }
    }
    
    return EmptyInfo;
}

function SavePlayerInfo(PlayerInfo Info)
{
    local int i;
    local bool bFound;
    
    for (i = 0; i < SavedPlayers.Length; i++)
    {
        if (SavedPlayers[i].NetAddress == Info.NetAddress)
        {
            SavedPlayers[i] = Info;
            bFound = true;
            break;
        }
    }
    
    if (!bFound)
    {
        SavedPlayers.AddItem(Info);
    }
    
    SaveConfig();
}


function ClearAllPlayers()
{
    SavedPlayers.Length = 0;
    SaveConfig();
}