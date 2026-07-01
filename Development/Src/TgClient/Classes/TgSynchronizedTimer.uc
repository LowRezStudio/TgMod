class TgSynchronizedTimer extends GFxObject within GFxMoviePlayer
    native;

var bool m_bPausedByGame;
var bool m_bSuppressCallback;
var bool m_bRunning;
var bool m_bPaused;
var TgTimerManager m_TimerManager;

// Export UTgSynchronizedTimer::execStartTimer(FFrame&, void* const)
native function StartTimer(float fSeconds);

// Export UTgSynchronizedTimer::execUpdateTimer(FFrame&, void* const)
native function UpdateTimer(float fElapsed, float fTotal, optional bool bPaused = false, optional bool bFromCallback = false);

// Export UTgSynchronizedTimer::execExpireTimer(FFrame&, void* const)
native function ExpireTimer(optional bool bFromCallback = false);

// Export UTgSynchronizedTimer::execIsRunning(FFrame&, void* const)
native function bool IsRunning();

// Export UTgSynchronizedTimer::execIsPaused(FFrame&, void* const)
native function bool IsPaused();