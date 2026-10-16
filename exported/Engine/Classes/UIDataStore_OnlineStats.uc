class UIDataStore_OnlineStats extends UIDataStore_Remote
    abstract
    transient
    native(UIPrivate)
    config(Engine)
    hidecategories(Object,UIRoot);

enum EStatsFetchType
{
    SFT_Player,                     // 0
    SFT_CenteredOnPlayer,           // 1
    SFT_Friends,                    // 2
    SFT_TopRankings,                // 3
    SFT_MAX                         // 4
};

struct native PlayerNickMetaData
{
    var const name PlayerNickName;
    var const localized string PlayerNickColumnName;

    structdefaultproperties
    {
        PlayerNickName="None"
        PlayerNickColumnName=""
    }
};

struct native RankMetaData
{
    var const name RankName;
    var const localized string RankColumnName;

    structdefaultproperties
    {
        RankName="None"
        RankColumnName=""
    }
};

var array< Class<OnlineStatsRead> > StatsReadClasses;
var const name StatsReadName;
var const PlayerNickMetaData PlayerNickData;
var const RankMetaData RankNameMetaData;
var const name TotalRowsName;
var array<OnlineStatsRead> StatsReadObjects;
var OnlineStatsRead StatsRead;
var UIDataStore_OnlineStats.EStatsFetchType CurrentReadType;
var OnlineStatsInterface StatsInterface;
var OnlinePlayerInterface PlayerInterface;

event Init()
{
    local OnlineSubsystem OnlineSub;

    OnlineSub = Class'Engine.GameEngine'.static.GetOnlineSubsystem();
    // End:0xB9
    if(OnlineSub != none)
    {
        StatsInterface = OnlineSub.StatsInterface;
        PlayerInterface = OnlineSub.PlayerInterface;
        StatsInterface.AddReadOnlineStatsCompleteDelegate(OnReadComplete);
    }
    //return;    
}

function SetStatsReadInfo()
{
    StatsRead = StatsReadObjects[0];
    CurrentReadType = 0;
    //return;    
}

event bool RefreshStats(byte ControllerIndex)
{
    SetStatsReadInfo();
    StatsInterface.FreeStats(StatsRead);
    OnReadComplete(true);
    switch(CurrentReadType)
    {
        // End:0x92
        case 0:
            // End:0x90
            if(StatsInterface.ReadOnlineStatsForPlayer(ControllerIndex, StatsRead) == false)
            {
                return false;
            }
            return true;
        // End:0xD5
        case 1:
            // End:0xD3
            if(StatsInterface.ReadOnlineStatsByRankAroundPlayer(ControllerIndex, StatsRead, 10) == false)
            {
                return false;
            }
            return true;
        // End:0x118
        case 2:
            // End:0x116
            if(StatsInterface.ReadOnlineStatForFriends(ControllerIndex, StatsRead) == false)
            {
                return false;
            }
            return true;
        // End:0x15B
        case 3:
            // End:0x159
            if(StatsInterface.ReadOnlineStatsByRank(ControllerIndex, StatsRead) == false)
            {
                return false;
            }
            return true;
        // End:0xFFFF
        default:
            //return ReturnValue;
            break;
    }    
}

event bool ShowGamercard(byte ConrollerIndex, int ListIndex)
{
    local OnlineSubsystem OnlineSub;
    local OnlinePlayerInterfaceEx PlayerExt;
    local UniqueNetId PlayerID;

    // End:0x13F
    if((ListIndex >= 0) && ListIndex < StatsRead.Rows.Length)
    {
        OnlineSub = Class'Engine.GameEngine'.static.GetOnlineSubsystem();
        // End:0x13C
        if(OnlineSub != none)
        {
            PlayerExt = OnlineSub.PlayerInterfaceEx;
            // End:0x139
            if(NotEqual_InterfaceInterface(PlayerExt, OnlinePlayerInterfaceEx(none)))
            {
                PlayerID = StatsRead.Rows[ListIndex].PlayerID;
                return PlayerExt.ShowGamerCardUI(ConrollerIndex, PlayerID);                
            }            
        }        
    }
    //return ReturnValue;    
}

function OnReadComplete(bool bWasSuccessful)
{
    // End:0x20
    if(bWasSuccessful)
    {
        SortResultsByRank(StatsRead);
    }
    RefreshSubscribers();
    //return;    
}

// Export UUIDataStore_OnlineStats::execSortResultsByRank(FFrame&, void* const)
native static function SortResultsByRank(OnlineStatsRead StatsToSort);

defaultproperties
{
    StatsReadName="StatsReadResults"
    PlayerNickData=(PlayerNickName="Player Nick",PlayerNickColumnName="Player Nick")
    RankNameMetaData=(RankName="Rank",RankColumnName="Rank")
    TotalRowsName="TotalRows"
    Tag="OnlineStats"
}