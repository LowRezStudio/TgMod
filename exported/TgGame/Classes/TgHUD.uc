class TgHUD extends HUD
    transient
    native
    config(Game)
    hidecategories(Navigation);

var TgPlayerController m_TgPlayerController;

// Export UTgHUD::execDeviceChangeEvent(FFrame&, void* const)
native function DeviceChangeEvent(TgDevice Dev, TgDevice.EDeviceChangeEvent Event);

// Export UTgHUD::execUpdateGameClockUI(FFrame&, void* const)
native function bool UpdateGameClockUI();

// Export UTgHUD::execUpdateGameScoreUI(FFrame&, void* const)
native function bool UpdateGameScoreUI();

// Export UTgHUD::execUpdateGameCapturePointsUI(FFrame&, void* const)
native function bool UpdateGameCapturePointsUI();

// Export UTgHUD::execUpdatePlayerInfoUI(FFrame&, void* const)
native function bool UpdatePlayerInfoUI(TgRepInfo_Player PRI);

// Export UTgHUD::execUpdatePlayerVitalsUI(FFrame&, void* const)
native function bool UpdatePlayerVitalsUI(TgPlayerController PC);

// Export UTgHUD::execUpdatePlayerStatUI(FFrame&, void* const)
native function bool UpdatePlayerStatUI(TgPawn changedPawn);

// Export UTgHUD::execPlayTakeHit(FFrame&, void* const)
native function PlayTakeHit(Rotator HitDir, int nDamage, Class<DamageType> DamageType);

// Export UTgHUD::execUpdateReleaseTimeRemaining(FFrame&, void* const)
native function UpdateReleaseTimeRemaining(float fTimeRemaining);

// Export UTgHUD::execUpdateScoreboard(FFrame&, void* const)
native function UpdateScoreboard();

// Export UTgHUD::execUpdateItemStoreItems(FFrame&, void* const)
native function bool UpdateItemStoreItems(TgRepInfo_Player PRI);

// Export UTgHUD::execEndMission(FFrame&, void* const)
native function EndMission(bool bPlayerAttacker, TgObject.GAME_WIN_STATE finalWinState);

// Export UTgHUD::execOnPingInfoUpdate(FFrame&, void* const)
native function OnPingInfoUpdate(TgRepInfo_Player updatedPri);

// Export UTgHUD::execPingWorldLocation(FFrame&, void* const)
native function PingWorldLocation(Vector PingLocation, TgObject.PING_TYPE Type);

// Export UTgHUD::execShowGameTip(FFrame&, void* const)
native function ShowGameTip(int nTipId, optional bool bNoSound = false, optional bool bPopup = false);

// Export UTgHUD::execHideGameTip(FFrame&, void* const)
native function HideGameTip(optional bool bNoSound = false);

// Export UTgHUD::execTutorialMessage(FFrame&, void* const)
native function TutorialMessage(int msgId, bool bTips);

// Export UTgHUD::execShowCursor(FFrame&, void* const)
native function ShowCursor(bool bShow);

// Export UTgHUD::execShowHit(FFrame&, void* const)
native function ShowHit(Actor Target, float fDamageAmount, bool bIsShieldHit, const out ExtraDamageInfo ExtraInfo);

// Export UTgHUD::execMapOutroFinished(FFrame&, void* const)
native function MapOutroFinished();

event CommitClassSelectionChange()
{
    //return;    
}

function ShowTargetingMap(bool bShow)
{
    //return;    
}

function PlayDeviceFailResponse(TgObject.EDeviceFailType failType, bool IsAbility)
{
    //return;    
}

function OnRoundSetupStarted()
{
    //return;    
}

function UpdateRoundEndedTimer(float RoundEndTimeRemaining, float RoundEndTotalTime)
{
    //return;    
}

function UpdateRoundSetupTimer(float SetupTimeRemaining, float TimeStamp)
{
    //return;    
}

function bool FinishIntro()
{
    //return ReturnValue;    
}
