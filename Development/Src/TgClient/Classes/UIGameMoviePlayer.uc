class UIGameMoviePlayer extends UIMoviePlayer
    native(GameUI)
    config(UI)
    implements(TgCallbackInterface);

enum EUpdateModelType {
    UMT_All,  // 0
    UMT_WeaponOnly,  // 1
};

var int m_nReplayId;
var int m_nResizeTicks;
var int m_nChosenQueue;
var int m_nActiveControllerId;
var int m_nClearTransitionTicks;
var bool m_bGamepad;
var bool m_bGameWon;
var bool m_bVisible;
var bool m_bTimedQueue;
var bool m_bHasNoPlayer;
var bool m_bInLoginQueue;
var bool m_bLobbyPlayback;
var bool m_bShowCardTutorialNextTick;
var bool m_bConfigManagerProcessed;
var bool m_bPlayAnnouncerSample;
var bool m_bHasAttemptedAutoReplayDemoRecording;
var float m_fQueueTimer;
var float m_fFadeKillTimer;
var float m_fLoginQueueTimer;
var float m_fTransitionTimer;
var float m_fLobbyPlaybackTime;
var float m_fLobbyNextFireTime;
var float m_fVideoCompletedTimer;
var init string m_sPass;
var init string m_sUserName;
var init string m_SpecTeamNameEnemy;
var init string m_SpecTeamNameFriendly;
var GFxObject m_mcMapFrame;
var GFxObject m_mcMapFrameLarge;
var GFxObject m_mcKeyboardFocus;
var TgGameDC_Chat m_Chat;
var UIDataManager m_UIDataManager;
var native Pointer m_ConfigManager;
var UILandingPanelManager m_LandingPanelManager;
var UINotificationCenterJsonManager m_NotificationCenterJsonManager;
var TgStreamManager m_StreamManager;
var TgRewardCenterManager m_RewardCenterManager;
var TgBrowserManager m_WebBrowser;
var UIHudSpectator m_mcSpectatorHUD;
var AlienFXManager m_AlienFX;
var array<TgGfxScene> m_Scenes;
var init string m_sPendingOnlineScene;
var init string m_sDelayErrorTitle;
var init string m_sDelayErrorDesc;
var TextureRenderTarget2D m_RenderTarget;
var Texture m_BrowserTexture[4];
var init string m_Team1Name;
var init string m_Team2Name;
var AkBaseSoundObject m_akJoinQueue;
var TgManifestGroup m_AnnouncerManifestGroup;
var int m_nAnnouncerItemId;
var AkEvent m_akEquippedAnnouncerSound;
var TgManifestGroup m_VoicePackManifestGroup;
var int m_nVoicePackItemId;
var UIData_PopupGeneric m_pQuitPromptData;
var TgCallbackContainer m_CallbackContainer;

native function OnDemoReady();  // Export UUIGameMoviePlayer::execOnDemoReady(FFrame&, void* const)

native exec function CancelPlayback();  // Export UUIGameMoviePlayer::execCancelPlayback(FFrame&, void* const)

native exec function EndLobbyPlayback();  // Export UUIGameMoviePlayer::execEndLobbyPlayback(FFrame&, void* const)

native exec function ToggleSkillScreen(optional int nBotId=0);  // Export UUIGameMoviePlayer::execToggleSkillScreen(FFrame&, void* const)

native exec function Replay(int nInstanceId, optional string sSpectatePassword);  // Export UUIGameMoviePlayer::execReplay(FFrame&, void* const)

native exec function WatchReplay(string sInstanceId, optional string sSpectatePassword);  // Export UUIGameMoviePlayer::execWatchReplay(FFrame&, void* const)

native exec function ViewStatsOnline(string sInstanceId);  // Export UUIGameMoviePlayer::execViewStatsOnline(FFrame&, void* const)

native exec function usc_toggle_player_mute(string sPlayerName);  // Export UUIGameMoviePlayer::execusc_toggle_player_mute(FFrame&, void* const)

native exec function usc_vgs_command(int nId, bool bSubMenu);  // Export UUIGameMoviePlayer::execusc_vgs_command(FFrame&, void* const)

native exec function usc_resend_private_messages();  // Export UUIGameMoviePlayer::execusc_resend_private_messages(FFrame&, void* const)

native exec function usc_chat_close_tab(int nChannel, string Sender);  // Export UUIGameMoviePlayer::execusc_chat_close_tab(FFrame&, void* const)

native exec function usc_enable_browser_input(bool bEnable);  // Export UUIGameMoviePlayer::execusc_enable_browser_input(FFrame&, void* const)

native exec function bool usc_resize_browser(int surfaceId, float X, float Y, float Width, float Height, float widthReal, float heightReal);  // Export UUIGameMoviePlayer::execusc_resize_browser(FFrame&, void* const)

native exec function bool SetRenderTargetEnabled(bool bEnabled, int surfaceId);  // Export UUIGameMoviePlayer::execSetRenderTargetEnabled(FFrame&, void* const)

native function PromptToQuit();  // Export UUIGameMoviePlayer::execPromptToQuit(FFrame&, void* const)

native function QuitGame();  // Export UUIGameMoviePlayer::execQuitGame(FFrame&, void* const)

native function AttemptAutoLogin();  // Export UUIGameMoviePlayer::execAttemptAutoLogin(FFrame&, void* const)

native function UpdateViewportForSafeAreas();  // Export UUIGameMoviePlayer::execUpdateViewportForSafeAreas(FFrame&, void* const)

native function AttemptAutoReplayDemoRecording();  // Export UUIGameMoviePlayer::execAttemptAutoReplayDemoRecording(FFrame&, void* const)

native function OpenChatTab(int nChannel, optional string sName, optional bool bOpenWindow);  // Export UUIGameMoviePlayer::execOpenChatTab(FFrame&, void* const)

native function CloseChatTab(int nChannel, optional string sSender);  // Export UUIGameMoviePlayer::execCloseChatTab(FFrame&, void* const)

native function AddInitialChatMessages();  // Export UUIGameMoviePlayer::execAddInitialChatMessages(FFrame&, void* const)

native function CheckControllerDisconnected();  // Export UUIGameMoviePlayer::execCheckControllerDisconnected(FFrame&, void* const)

native function UpdateGamepadIcons();  // Export UUIGameMoviePlayer::execUpdateGamepadIcons(FFrame&, void* const)

native exec function int GetPortalType();  // Export UUIGameMoviePlayer::execGetPortalType(FFrame&, void* const)

native exec function BeginLogin(optional string User, optional string pass, optional string PlayerName);  // Export UUIGameMoviePlayer::execBeginLogin(FFrame&, void* const)

native exec function SetLoginReady();  // Export UUIGameMoviePlayer::execSetLoginReady(FFrame&, void* const)

native exec function string GetHUDTeamName(bool bEnemy);  // Export UUIGameMoviePlayer::execGetHUDTeamName(FFrame&, void* const)

native exec function SetSpecTeamName(bool bEnemy, optional string TeamName);  // Export UUIGameMoviePlayer::execSetSpecTeamName(FFrame&, void* const)

native exec function ShowCardTutorial(optional bool bForce=false, optional bool bReset=false);  // Export UUIGameMoviePlayer::execShowCardTutorial(FFrame&, void* const)

native function OnMarshalEvent(Pointer pMarEvent);  // Export UUIGameMoviePlayer::execOnMarshalEvent(FFrame&, void* const)

native function OnAnnouncerLoaded();  // Export UUIGameMoviePlayer::execOnAnnouncerLoaded(FFrame&, void* const)

native function OnVoicePackLoaded();  // Export UUIGameMoviePlayer::execOnVoicePackLoaded(FFrame&, void* const)

native function InitAnnouncer();  // Export UUIGameMoviePlayer::execInitAnnouncer(FFrame&, void* const)

native function PostInit();  // Export UUIGameMoviePlayer::execPostInit(FFrame&, void* const)

native exec function ForceDirty();  // Export UUIGameMoviePlayer::execForceDirty(FFrame&, void* const)

native function NativeTick(float DeltaTime);  // Export UUIGameMoviePlayer::execNativeTick(FFrame&, void* const)

native function UIFade(bool bFade, optional float fTime=0.2500000, optional float fDelay=0.0000000, optional float fFailSafeTime);  // Export UUIGameMoviePlayer::execUIFade(FFrame&, void* const)

native function UIFadeEndOfRound(bool bFade, optional float fTime=0.2500000, optional float fDelay=0.0000000, optional float fFailSafeTime);  // Export UUIGameMoviePlayer::execUIFadeEndOfRound(FFrame&, void* const)

native function int GetGamepadValueForKeyBind(string KeyBind);  // Export UUIGameMoviePlayer::execGetGamepadValueForKeyBind(FFrame&, void* const)

native function string GetPlayerDisplayName(string PlayerName, string OnlineID);  // Export UUIGameMoviePlayer::execGetPlayerDisplayName(FFrame&, void* const)

native function bool HasPlayerDisplayName(string OnlineID);  // Export UUIGameMoviePlayer::execHasPlayerDisplayName(FFrame&, void* const)

native function OnReadOnlinePlayerDataComplete(bool bWasSuccessful, array<string> PlayerIDs, array<OnlineProfile> OnlineProfiles);  // Export UUIGameMoviePlayer::execOnReadOnlinePlayerDataComplete(FFrame&, void* const)

native function bool NativeWidgetUnloaded(name WidgetName, name WidgetPath, GFxObject Widget);  // Export UUIGameMoviePlayer::execNativeWidgetUnloaded(FFrame&, void* const)

native function bool NativeWidgetInitialized(name WidgetName, name WidgetPath, GFxObject Widget);  // Export UUIGameMoviePlayer::execNativeWidgetInitialized(FFrame&, void* const)

native function ShowSubtitle(string sValue, optional float fTime=0.0000000);  // Export UUIGameMoviePlayer::execShowSubtitle(FFrame&, void* const)

native function SwitchSubtitleText(string sValue);  // Export UUIGameMoviePlayer::execSwitchSubtitleText(FFrame&, void* const)

native function HideSubtitle();  // Export UUIGameMoviePlayer::execHideSubtitle(FFrame&, void* const)

native function TgDataGroup_Game GetGameData();  // Export UUIGameMoviePlayer::execGetGameData(FFrame&, void* const)

native function TgGameDataHandler GetDataHandler();  // Export UUIGameMoviePlayer::execGetDataHandler(FFrame&, void* const)

native function bool IsItemOwned(int ItemId);  // Export UUIGameMoviePlayer::execIsItemOwned(FFrame&, void* const)

native function OnSuccessfulUserAccountInfoRetrieved(UserAccountInfo AccountInfo);  // Export UUIGameMoviePlayer::execOnSuccessfulUserAccountInfoRetrieved(FFrame&, void* const)

event LoadScene(string sName, string sPath, int nDepth) { }

event UnloadScene(string sName) { }

native function ShowPartyRequiresPremiumAccountWarning();  // Export UUIGameMoviePlayer::execShowPartyRequiresPremiumAccountWarning(FFrame&, void* const)

native function ShowNoFriendsForProfileViewWarning();  // Export UUIGameMoviePlayer::execShowNoFriendsForProfileViewWarning(FFrame&, void* const)

native function OnAccountPickerCancelled();  // Export UUIGameMoviePlayer::execOnAccountPickerCancelled(FFrame&, void* const)

native function bool ShowErrorMessage(string sTitle, string sError);  // Export UUIGameMoviePlayer::execShowErrorMessage(FFrame&, void* const)

native function PlayerLoginError(int nError, string sMessage);  // Export UUIGameMoviePlayer::execPlayerLoginError(FFrame&, void* const)

event Init(optional LocalPlayer LocPlay) { }

function InitOSSRef() { }

event OnClose() { }

function OnAccountPickerCancelledWrapper() { }

event ShowKeyboardUI(GFxObject FocusedTextField, string TitleText, string DescriptionText, optional bool bIsPassword=false, optional bool bShouldValidate=true, optional string DefaultText, optional int MaxResultLength=256) { }

event bool CheckControllerConnected() { }

function OnKeyboardInputComplete(bool bWasSuccessful) { }

event bool WidgetInitialized(name WidgetName, name WidgetPath, GFxObject Widget) { }

event bool WidgetUnloaded(name WidgetName, name WidgetPath, GFxObject Widget) { }

exec function ToggleAlienFX() { }

event bool ShowConsoleLoginUI(int ControllerId, optional bool bForceLoginAfter) { }

event RegisterLocalTalker(byte LocalUserNum, optional byte ChannelIndex) { }

event UnregisterLocalTalker(byte LocalUserNum, optional byte ChannelIndex) { }

event MutePlayer(byte LocalUserNum, UniqueNetId ConsoleId) { }

event UnmutePlayer(byte LocalUserNum, UniqueNetId ConsoleId) { }

event bool IsPlayerMuted(UniqueNetId ConsoleId) { }

event ShowGamerCardByUserName(string UserName) { }

event ShowGamercard(UniqueNetId PlayerID) { }

function updatePlayerMute(bool bWasSuccessful) { }

event CacheLoggedInGamepad() { }

exec event usc_ShowContentMarketPlaceUI(int ParentProductType, int RequestedProductTypes) { }

exec event usc_ShowContentMarketPlaceUIForProduct(int ParentProductType, int RequestedProductTypes, string ProductID) { }

exec event usc_ShowGameDetailsUI() { }

exec event usc_ShowProductDetailsUI(string ProductID) { }

exec event ShowContentPurchaseUI(string SingedOffer) { }

exec event GetAccountInfo() { }

function OnUserAccountInfoRetrieved(bool bSuccessful, UserAccountInfo AccountInfo) { }

event ReadOnlinePlayerData(array<string> PlayerIDs) { }

function OnReadOnlinePlayerData(bool bWasSuccessful, array<string> PlayerIDs, array<OnlineProfile> OnlineProfiles) { }

function OnAccountPickerCompleteForLogin(bool bForceLogin) { }

event NativeOpenURL(string URL) { }

function OnPermissionForOnlineScene(byte LocalUserNum, OnlineSubsystem.EFeaturePrivilege Privilege, OnlineSubsystem.EFeaturePrivilegeLevel PrivilegeLevel, bool bDiffersFromHint) { }

event CheckPermissionForOnlineScene(string sScene, byte ControlledId, OnlineSubsystem.EFeaturePrivilegeLevel Hint, optional bool bAttemptToResolve=false) { }

defaultproperties
{}
