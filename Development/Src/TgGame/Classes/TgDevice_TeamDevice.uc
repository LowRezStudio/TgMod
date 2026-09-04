class TgDevice_TeamDevice extends TgDevice
    native(Devices)
    hidecategories(Navigation)
    config(Engine)
    dependson(TgTimerManager);

native function TgTimerManager GetCooldownTimerManager();  // Export UTgDevice_TeamDevice::execGetCooldownTimerManager(FFrame&, void* const)

native function TgRepInfo_TaskForce GetTaskForce();  // Export UTgDevice_TeamDevice::execGetTaskForce(FFrame&, void* const)

native function CheckAndUpdateCooldown();  // Export UTgDevice_TeamDevice::execCheckAndUpdateCooldown(FFrame&, void* const)

function FlashCooldown(byte nMode) { }

event ToggleCooldownEffects(bool bOnCooldown) { }

function AuthStartCooldown(optional int nMode=-1, optional float fCooldownTimeOverride=-1.0000000) { }

event ResetCooldown(int nMode, optional float fCooldownTimeOverride=-1.0000000) { }

simulated event EndCooldown() { }

function TeamCooldownTimerExpired(int nTimerId, TgTimerManager.TGT_EVENT eEvent) { }

function TeamCooldownStart(int nMode, float fCooldownTime) { }

function TeamCooldownReset(int nMode, float fCooldownTime) { }

function TeamCooldownEnd() { }

function TeamGotoState(name NewState) { }

function TeamFlashCooldown(byte nMode) { }
