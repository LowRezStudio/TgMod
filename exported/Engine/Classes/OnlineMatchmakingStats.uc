class OnlineMatchmakingStats extends Object
    native;

struct native MMStats_Timer
{
    var bool bInProgress;
    var Double MSecs;

    structdefaultproperties
    {
        bInProgress=false
        MSecs=()
    }
};

// Export UOnlineMatchmakingStats::execStartTimer(FFrame&, void* const)
native function StartTimer(out MMStats_Timer Timer);

// Export UOnlineMatchmakingStats::execStopTimer(FFrame&, void* const)
native function StopTimer(out MMStats_Timer Timer);
