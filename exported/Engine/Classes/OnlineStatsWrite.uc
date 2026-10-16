class OnlineStatsWrite extends OnlineStats
    abstract
    native;

// Export UOnlineStatsWrite::execSetFloatStat(FFrame&, void* const)
native function SetFloatStat(const string StatName, float Value);

// Export UOnlineStatsWrite::execSetIntStat(FFrame&, void* const)
native function SetIntStat(const string StatName, int Value);

// Export UOnlineStatsWrite::execSetStringStat(FFrame&, void* const)
native function SetStringStat(const string StatName, const out string Value);
