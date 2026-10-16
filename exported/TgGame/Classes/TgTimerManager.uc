class TgTimerManager extends Object
    native;

const TGT_MAX_TIMERS = 32;

enum TGT_EVENT
{
    TGTE_DONE,                      // 0
    TGTE_START,                     // 1
    TGTE_UPDATE,                    // 2
    TGTE_PAUSED,                    // 3
    TGTE_MAX                        // 4
};

struct native TGT_REG_LINK
{
    var Pointer NextLink;
    var Object RegObject;
    var Function RegFunction;

    structdefaultproperties
    {
        NextLink=()
        RegObject=none
        RegFunction=none
    }
};

struct native TgTimerData
{
    var int nIndex;
    var byte byTimer;
    var float fStartTime;
    var float fRemaining;
    var bool bRepeat;
    var bool bPausedByGame;
    var float Rate;
    var TGT_REG_LINK CallbackRegistry;

    structdefaultproperties
    {
        nIndex=0
        byTimer=0
        fStartTime=0.0000000
        fRemaining=0.0000000
        bRepeat=false
        bPausedByGame=false
        Rate=1.0000000
        CallbackRegistry=(NextLink=(),RegObject=none,RegFunction=none)
    }
};

var private native const noexport Pointer VfTable_FTickableObject;
var init native map{VOID,VOID} m_TimerMap;
var protected bool m_bActive;
var protected bool m_bGameWasPaused;

// Export UTgTimerManager::execStart(FFrame&, void* const)
native function bool Start(int byTimerIndex, float fTime, optional bool bRepeat = false, optional bool bPausedByGame = true, optional float Rate = 1.0000000);

// Export UTgTimerManager::execUpdate(FFrame&, void* const)
native function bool Update(int byTimerIndex, float fTime, optional float fTimeInitial = -1.0000000, optional float Rate = 1.0000000);

// Export UTgTimerManager::execPause(FFrame&, void* const)
native function bool Pause(int byTimerIndex, float fTime);

// Export UTgTimerManager::execClose(FFrame&, void* const)
native function bool Close(int byTimerIndex, optional bool bFireEvent = true);

// Export UTgTimerManager::execIsSet(FFrame&, void* const)
native simulated function bool IsSet(int byTimerIndex);

// Export UTgTimerManager::execIsPaused(FFrame&, void* const)
native simulated function bool IsPaused(int byTimerIndex);

// Export UTgTimerManager::execGetTimeElapsed(FFrame&, void* const)
native simulated function float GetTimeElapsed(int byTimerIndex);

// Export UTgTimerManager::execGetTimeRemaining(FFrame&, void* const)
native simulated function float GetTimeRemaining(int byTimerIndex);

// Export UTgTimerManager::execGetPercentRemaining(FFrame&, void* const)
native simulated function float GetPercentRemaining(int byTimerIndex);

// Export UTgTimerManager::execGetTimeInitial(FFrame&, void* const)
native simulated function float GetTimeInitial(int byTimerIndex);

// Export UTgTimerManager::execSetRate(FFrame&, void* const)
native simulated function SetRate(int TimerIndex, float Rate);

// Export UTgTimerManager::execRegisterForEvents(FFrame&, void* const)
native simulated function bool RegisterForEvents(int byTimerIndex, Object HostObject, name nmFunc);

// Export UTgTimerManager::execUnRegisterForEvents(FFrame&, void* const)
native simulated function bool UnRegisterForEvents(int byTimerIndex, Object HostObject);

// Export UTgTimerManager::execIsActiveTimers(FFrame&, void* const)
native simulated function bool IsActiveTimers();

// Export UTgTimerManager::execCloseAllTimers(FFrame&, void* const)
native simulated function CloseAllTimers(optional bool bFireEvent = true);
