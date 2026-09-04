class TgHUD extends HUD
    transient
    native
    config(Game)
    hidecategories(Navigation)
    dependson(TgDevice, TgObject);

var TgPlayerController m_TgPlayerController;

native function DeviceChangeEvent(TgDevice Dev, TgDevice.EDeviceChangeEvent Event);  // Export UTgHUD::execDeviceChangeEvent(FFrame&, void* const)

native function bool UpdateGameClockUI();  // Export UTgHUD::execUpdateGameClockUI(FFrame&, void* const)

native function bool UpdateGameScoreUI();  // Export UTgHUD::execUpdateGameScoreUI(FFrame&, void* const)

native function bool UpdateGameCapturePointsUI();  // Export UTgHUD::execUpdateGameCapturePointsUI(FFrame&, void* const)

native function bool UpdatePlayerInfoUI(TgRepInfo_Player PRI);  // Export UTgHUD::execUpdatePlayerInfoUI(FFrame&, void* const)

native function bool UpdatePlayerVitalsUI(TgPlayerController PC);  // Export UTgHUD::execUpdatePlayerVitalsUI(FFrame&, void* const)

native function bool UpdatePlayerStatUI(TgPawn changedPawn);  // Export UTgHUD::execUpdatePlayerStatUI(FFrame&, void* const)

native function PlayTakeHit(Rotator HitDir, int nDamage, Class<DamageType> DamageType);  // Export UTgHUD::execPlayTakeHit(FFrame&, void* const)

native function UpdateReleaseTimeRemaining(float fTimeRemaining);  // Export UTgHUD::execUpdateReleaseTimeRemaining(FFrame&, void* const)

native function UpdateScoreboard();  // Export UTgHUD::execUpdateScoreboard(FFrame&, void* const)

native function bool UpdateItemStoreItems(TgRepInfo_Player PRI);  // Export UTgHUD::execUpdateItemStoreItems(FFrame&, void* const)

native function EndMission(bool bPlayerAttacker, TgObject.GAME_WIN_STATE finalWinState);  // Export UTgHUD::execEndMission(FFrame&, void* const)

native function OnPingInfoUpdate(TgRepInfo_Player updatedPri);  // Export UTgHUD::execOnPingInfoUpdate(FFrame&, void* const)

native function PingWorldLocation(Vector PingLocation, TgObject.PING_TYPE Type);  // Export UTgHUD::execPingWorldLocation(FFrame&, void* const)

native function ShowGameTip(int nTipId, optional bool bNoSound=false, optional bool bPopup=false);  // Export UTgHUD::execShowGameTip(FFrame&, void* const)

native function HideGameTip(optional bool bNoSound=false);  // Export UTgHUD::execHideGameTip(FFrame&, void* const)

native function TutorialMessage(int msgId, bool bTips);  // Export UTgHUD::execTutorialMessage(FFrame&, void* const)

native function ShowCursor(bool bShow);  // Export UTgHUD::execShowCursor(FFrame&, void* const)

native function ShowHit(Actor Target, float fDamageAmount, bool bIsShieldHit, const out ExtraDamageInfo ExtraInfo);  // Export UTgHUD::execShowHit(FFrame&, void* const)

native function MapOutroFinished();  // Export UTgHUD::execMapOutroFinished(FFrame&, void* const)

event CommitClassSelectionChange() { }

function ShowTargetingMap(bool bShow) { }

function PlayDeviceFailResponse(TgObject.EDeviceFailType failType, bool IsAbility) { }

function OnRoundSetupStarted() { }

function UpdateRoundEndedTimer(float RoundEndTimeRemaining, float RoundEndTotalTime) { }

function UpdateRoundSetupTimer(float SetupTimeRemaining, float TimeStamp) { }

function bool FinishIntro() { }
