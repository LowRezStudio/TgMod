interface OnlineSuppliedUIInterface extends Interface
    abstract;

delegate OnShowOnlineStatsUIComplete()
{
    //return;    
}

function bool ShowOnlineStatsUI(const out array<UniqueNetId> Players, OnlineStatsRead StatsRead)
{
    //return ReturnValue;    
}

function AddShowOnlineStatsUICompleteDelegate(delegate<OnShowOnlineStatsUIComplete> ShowOnlineStatsUICompleteDelegate)
{
    //return;    
}

function ClearShowOnlineStatsUICompleteDelegate(delegate<OnShowOnlineStatsUIComplete> ShowOnlineStatsUICompleteDelegate)
{
    //return;    
}

function bool ShowMatchmakingUI(byte SearchingPlayerNum, OnlineGameSearch SearchSettings, OnlineGameSettings GameSettings)
{
    //return ReturnValue;    
}
