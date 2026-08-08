class TgSynchronizedTimer extends GFxObject within GFxMoviePlayer
    native
    config(Engine);

var bool m_bPausedByGame;
var bool m_bSuppressCallback;
var bool m_bRunning;
var bool m_bPaused;
var UIMoviePlayer m_MP;
var TgTimerManager m_TimerManager;

native function StartTimer(float fSeconds);  // Export UTgSynchronizedTimer::execStartTimer(FFrame&, void* const)

native function UpdateTimer(float fElapsed, float fTotal, optional bool bPaused=false, optional bool bFromCallback=false);  // Export UTgSynchronizedTimer::execUpdateTimer(FFrame&, void* const)

native function ExpireTimer(optional bool bFromCallback=false);  // Export UTgSynchronizedTimer::execExpireTimer(FFrame&, void* const)

native function EventCallback(int nTimerId, TgTimerManager.TGT_EVENT eEvent);  // Export UTgSynchronizedTimer::execEventCallback(FFrame&, void* const)

native function bool IsRunning();  // Export UTgSynchronizedTimer::execIsRunning(FFrame&, void* const)

native function bool IsPaused();  // Export UTgSynchronizedTimer::execIsPaused(FFrame&, void* const)

defaultproperties
{
    m_nIndex=-1
}
