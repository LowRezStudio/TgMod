interface OnlineStatsInterface extends Interface
    abstract;

function bool ReadOnlineStatsForPlayer(byte LocalUserNum, OnlineStatsRead StatsRead)
{
    //return ReturnValue;    
}

function bool ReadOnlineStats(byte LocalUserNum, const out array<UniqueNetId> Players, OnlineStatsRead StatsRead)
{
    //return ReturnValue;    
}

function bool ReadOnlineStatForFriends(byte LocalUserNum, OnlineStatsRead StatsRead, optional bool FavoriteFriendsOnly = false, optional int NumToRead = 100)
{
    //return ReturnValue;    
}

function bool ReadOnlineStatsByRank(byte LocalUserNum, OnlineStatsRead StatsRead, optional int StartIndex = 1, optional int NumToRead = 100)
{
    //return ReturnValue;    
}

function bool ReadOnlineStatsByRankAroundPlayer(byte LocalUserNum, OnlineStatsRead StatsRead, optional int NumRows = 10)
{
    //return ReturnValue;    
}

delegate OnReadOnlineStatsComplete(bool bWasSuccessful)
{
    //return;    
}

function AddReadOnlineStatsCompleteDelegate(delegate<OnReadOnlineStatsComplete> ReadOnlineStatsCompleteDelegate)
{
    //return;    
}

function ClearReadOnlineStatsCompleteDelegate(delegate<OnReadOnlineStatsComplete> ReadOnlineStatsCompleteDelegate)
{
    //return;    
}

function FreeStats(OnlineStatsRead StatsRead)
{
    //return;    
}

function bool WriteOnlineStats(name SessionName, UniqueNetId Player, OnlineStatsWrite StatsWrite)
{
    //return ReturnValue;    
}

function bool FlushOnlineStats(name SessionName)
{
    //return ReturnValue;    
}

delegate OnFlushOnlineStatsComplete(name SessionName, bool bWasSuccessful)
{
    //return;    
}

function AddFlushOnlineStatsCompleteDelegate(delegate<OnFlushOnlineStatsComplete> FlushOnlineStatsCompleteDelegate)
{
    //return;    
}

function ClearFlushOnlineStatsCompleteDelegate(delegate<OnFlushOnlineStatsComplete> FlushOnlineStatsCompleteDelegate)
{
    //return;    
}

function bool WriteOnlinePlayerScores(name SessionName, int LeaderboardId, const out array<OnlinePlayerScore> PlayerScores)
{
    //return ReturnValue;    
}

function string GetHostStatGuid()
{
    //return ReturnValue;    
}

function bool RegisterHostStatGuid(const out string HostStatGuid)
{
    //return ReturnValue;    
}

delegate OnRegisterHostStatGuidComplete(bool bWasSuccessful)
{
    //return;    
}

function AddRegisterHostStatGuidCompleteDelegate(delegate<OnRegisterHostStatGuidComplete> RegisterHostStatGuidCompleteDelegate)
{
    //return;    
}

function ClearRegisterHostStatGuidCompleteDelegateDelegate(delegate<OnRegisterHostStatGuidComplete> RegisterHostStatGuidCompleteDelegate)
{
    //return;    
}

function string GetClientStatGuid()
{
    //return ReturnValue;    
}

function bool RegisterStatGuid(UniqueNetId PlayerID, const out string ClientStatGuid)
{
    //return ReturnValue;    
}

function CalcAggregateSkill(array<Double> Mus, array<Double> Sigmas, out Double OutAggregateMu, out Double OutAggregateSigma)
{
    //return;    
}

delegate OnStatisticChanged(UniqueNetId PlayerNetId, name StatName, string NewStatValue)
{
    //return;    
}

function SubscribeToStatisticEvent(byte LocalUserNum, UniqueNetId PlayerNetId, name StatName, delegate<OnStatisticChanged> EventDelegate)
{
    //return;    
}

function UnsubscribeToStatisticEvent(byte LocalUserNum, UniqueNetId PlayerNetId, name StatName)
{
    //return;    
}

function bool SendPlayerSessionStart(byte LocalUserNum, string MultiplayerCorrelationId, int GameplayModeId, int DifficultyLevelId)
{
    //return ReturnValue;    
}

function bool SendPlayerSessionEnd(byte LocalUserNum, string MultiplayerCorrelationId, int GameplayModeId, int DifficultyLevelId, int ExitStatusId)
{
    //return ReturnValue;    
}

function bool SendPlayerSessionPause(byte LocalUserNum, string MultiplayerCorrelationId)
{
    //return ReturnValue;    
}

function bool SendPlayerSessionResume(byte LocalUserNum, string MultiplayerCorrelationId, int GameplayModeId, int DifficultyLevelId)
{
    //return ReturnValue;    
}
