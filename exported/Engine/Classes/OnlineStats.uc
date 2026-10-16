class OnlineStats extends Object
    abstract
    native;

struct native OnlineStatsRow
{
    var const UniqueNetId PlayerID;
    var const SettingsData Rank;
    var const string NickName;
    var array<SettingsData> StatValues;

    structdefaultproperties
    {
        PlayerID=(Uid=())
        Rank=(Type=ESettingsDataType.SDT_Empty,Value1=0)
        NickName=""
        StatValues=none
    }
};

struct native ColumnMetaData
{
    var string ColumnName;
    var string StatName;

    structdefaultproperties
    {
        ColumnName=""
        StatName=""
    }
};

var const int TotalRowsInView;
var array<OnlineStatsRow> Rows;
var array<ColumnMetaData> ColumnData;

// Export UOnlineStats::execGetIntStatValueForPlayer(FFrame&, void* const)
native function bool GetIntStatValueForPlayer(UniqueNetId PlayerID, const string StatName, out int StatValue);

// Export UOnlineStats::execGetFloatStatValueForPlayer(FFrame&, void* const)
native function bool GetFloatStatValueForPlayer(UniqueNetId PlayerID, const string StatName, out float StatValue);

// Export UOnlineStats::execGetStatValueForPlayerAsString(FFrame&, void* const)
native function bool GetStatValueForPlayerAsString(UniqueNetId PlayerID, const string StatName, out string StatValue);

// Export UOnlineStats::execIsStatZero(FFrame&, void* const)
native function bool IsStatZero(UniqueNetId PlayerID, const string StatName);

// Export UOnlineStats::execGetRankForPlayer(FFrame&, void* const)
native function int GetRankForPlayer(UniqueNetId PlayerID);
