class TgDemoRecSpectator extends TgSpectatorController
    config(Game)
    hidecategories(Navigation)
    dependson(TgObject);

struct SpectatorCommand {
    var int nFrame;
    var bool bUseIndex;
    var float fSpeed;
    structdefaultproperties {}
};

struct DilationData {
    var float fValue;
    var string sName;
    structdefaultproperties {}
};

var array<SpectatorCommand> PendingCommands;
var int m_TimeIndex;
var array<DilationData> m_TimeDilations;
var Pointer m_pTgCallbackDevice;
var transient int m_1xTimeIndex;
var transient bool m_bIsPaused;
var transient bool m_bInStasis;
var transient bool m_bSpectatorMaster;
var transient bool m_bSyncWithMasterEnabled;
var transient bool m_bIsSyncingWithMaster;
var config transient bool m_bAutoSlomo;
var config transient bool m_bReceiveCamSync;
var transient int m_nLastReceivedMasterFrame;
var transient float m_fLastReceivedMasterTimeDilation;
var transient float m_fLastReceievedRealTimeStamp;
var const config int m_nSyncFrameThreshold;
var const config int m_nSyncFrameCheckThreshold;
var const config int m_nSyncAheadFrameThreshold;
var transient int m_nLastTimerValue;
var TgSpectatorDirector m_SpectatorDirector;
var transient TgCollisionProxy_SpectatorActionListener m_ActionListener;
var config transient float m_fActionListenerRadius;
var config transient float m_fActionListenerHeight;
var transient int m_nCurrentActionListenerRating;
var config transient int m_nActionListenerRatingThreshold;
var float m_fRemainingAutoSlomoTime;
var config transient float m_fAutoSlomoExpirationTime;
var config transient int m_nAutoSlomoSpeedIndex;
var config transient int m_nAutoSlomoNearbyPlayersNum;
var config transient float m_fAutoSlomoFrequency;
var transient float m_fRemainingAutoSlomoTimeoutTime;

function OnSynced();  // Export UTgDemoRecSpectator::execOnSynced(FFrame&, void* const)

function RequestSync();  // Export UTgDemoRecSpectator::execRequestSync(FFrame&, void* const)

function UpdateTimeDilation();  // Export UTgDemoRecSpectator::execUpdateTimeDilation(FFrame&, void* const)

function bool UpdateSyncingUI();  // Export UTgDemoRecSpectator::execUpdateSyncingUI(FFrame&, void* const)

function UpdateCameraModeUI();  // Export UTgDemoRecSpectator::execUpdateCameraModeUI(FFrame&, void* const)

function RegisterEngineCallbacks();  // Export UTgDemoRecSpectator::execRegisterEngineCallbacks(FFrame&, void* const)

function UnregisterEngineCallbacks();  // Export UTgDemoRecSpectator::execUnregisterEngineCallbacks(FFrame&, void* const)

function Class<HUD> GetHudClass(Class<HUD> pNewHudType);  // Export UTgDemoRecSpectator::execGetHudClass(FFrame&, void* const)

exec function CreateManualRewindPoint();  // Export UTgDemoRecSpectator::execCreateManualRewindPoint(FFrame&, void* const)

exec function ToggleThirdPersonView();  // Export UTgDemoRecSpectator::execToggleThirdPersonView(FFrame&, void* const)

function StartAutoCombatLog();  // Export UTgDemoRecSpectator::execStartAutoCombatLog(FFrame&, void* const)

simulated event ReceivedPlayer() { }

simulated event PostBeginPlay() { }

exec function Slomo(float NewTimeDilation);  // Export UTgDemoRecSpectator::execSlomo(FFrame&, void* const)

exec function Pause();  // Export UTgDemoRecSpectator::execPause(FFrame&, void* const)

exec function DilateTime(float Amount, optional bool bForceReset);  // Export UTgDemoRecSpectator::execDilateTime(FFrame&, void* const)

exec function Rewind(int JumpAmount, optional int FrameNum=-1);  // Export UTgDemoRecSpectator::execRewind(FFrame&, void* const)

exec function GoToFrame(float fPercent);  // Export UTgDemoRecSpectator::execGoToFrame(FFrame&, void* const)

function bool CanFastForward();  // Export UTgDemoRecSpectator::execCanFastForward(FFrame&, void* const)

function bool SetSpectatorMasterSlave();  // Export UTgDemoRecSpectator::execSetSpectatorMasterSlave(FFrame&, void* const)

function PauseEx();  // Export UTgDemoRecSpectator::execPauseEx(FFrame&, void* const)

function RewindGraphs();  // Export UTgDemoRecSpectator::execRewindGraphs(FFrame&, void* const)

exec function SetSyncTargetFrame(int FrameNum, float TimeDilation);  // Export UTgDemoRecSpectator::execSetSyncTargetFrame(FFrame&, void* const)

function int GetSyncTargetFrame();  // Export UTgDemoRecSpectator::execGetSyncTargetFrame(FFrame&, void* const)

function bool IsSyncedWithMaster(int Threshold);  // Export UTgDemoRecSpectator::execIsSyncedWithMaster(FFrame&, void* const)

exec function EnableSync(bool bEnabled) { }

exec function ToggleSync() { }

function CheckSpectatorMasterSlave() { }

simulated event PostDemoRewind() { }

exec function DirectorModeToggle() { }

event FindNearbyAssistedViewTarget() { }

event FindNextClosestAssistedViewTarget() { }

exec function SetNewSpectatorMode(TgSpectatorController.ESpectatorMode NewMode) { }

simulated function bool PingMap(Vector WorldLocation, const out array<ReplicationInfo> worldActorRepInfo, TgObject.PING_TYPE Type) { }

exec function SpecViewPlayer(string PlayerName) { }

exec function ToggleAutoSlomo() { }

exec function EnableAutoSlomo(bool bEnabled) { }

function OnActionListenerStartFire(TgPawn FiringPawn, int nEquipSlot);  // Export UTgDemoRecSpectator::execOnActionListenerStartFire(FFrame&, void* const)

function TriggerAutoSlomo(float SlomoTime);  // Export UTgDemoRecSpectator::execTriggerAutoSlomo(FFrame&, void* const)

exec function EnableCamSync(bool bEnabled) { }

function SpectatorSetViewTarget(Actor VT, optional ViewTargetTransitionParams TransitionParams) { }

event SpectatorReceivedViewTarget(Actor VT) { }

function SendCamSyncTarget();  // Export UTgDemoRecSpectator::execSendCamSyncTarget(FFrame&, void* const)

function ReceiveCamSyncTarget(int PawnId, int SourcePlayerId);  // Export UTgDemoRecSpectator::execReceiveCamSyncTarget(FFrame&, void* const)

defaultproperties
{}
