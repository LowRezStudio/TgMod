class UIGameMoviePlayer extends UIMoviePlayer
    native(GameUI)
    config(UI)
    implements(TgCallbackInterface);

enum EUpdateModelType
{
    UMT_All,                        // 0
    UMT_WeaponOnly,                 // 1
    UMT_MAX                         // 2
};

var private native const noexport Pointer VfTable_ITgCallbackInterface;
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
var native map{VOID,VOID} m_OnlineProfiles;
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

// Export UUIGameMoviePlayer::execOnDemoReady(FFrame&, void* const)
native function OnDemoReady();

// Export UUIGameMoviePlayer::execCancelPlayback(FFrame&, void* const)
native exec function CancelPlayback();

// Export UUIGameMoviePlayer::execEndLobbyPlayback(FFrame&, void* const)
native exec function EndLobbyPlayback();

// Export UUIGameMoviePlayer::execToggleSkillScreen(FFrame&, void* const)
native exec function ToggleSkillScreen(optional int nBotId = 0);

// Export UUIGameMoviePlayer::execReplay(FFrame&, void* const)
native exec function Replay(int nInstanceId, optional string sSpectatePassword);

// Export UUIGameMoviePlayer::execWatchReplay(FFrame&, void* const)
native exec function WatchReplay(string sInstanceId, optional string sSpectatePassword);

// Export UUIGameMoviePlayer::execViewStatsOnline(FFrame&, void* const)
native exec function ViewStatsOnline(string sInstanceId);

// Export UUIGameMoviePlayer::execusc_toggle_player_mute(FFrame&, void* const)
native exec function usc_toggle_player_mute(string sPlayerName);

// Export UUIGameMoviePlayer::execusc_vgs_command(FFrame&, void* const)
native exec function usc_vgs_command(int nId, bool bSubMenu);

// Export UUIGameMoviePlayer::execusc_resend_private_messages(FFrame&, void* const)
native exec function usc_resend_private_messages();

// Export UUIGameMoviePlayer::execusc_chat_close_tab(FFrame&, void* const)
native exec function usc_chat_close_tab(int nChannel, string Sender);

// Export UUIGameMoviePlayer::execusc_enable_browser_input(FFrame&, void* const)
native exec function usc_enable_browser_input(bool bEnable);

// Export UUIGameMoviePlayer::execusc_resize_browser(FFrame&, void* const)
native exec function bool usc_resize_browser(int surfaceId, float X, float Y, float Width, float Height, float widthReal, float heightReal);

// Export UUIGameMoviePlayer::execSetRenderTargetEnabled(FFrame&, void* const)
native exec function bool SetRenderTargetEnabled(bool bEnabled, int surfaceId);

// Export UUIGameMoviePlayer::execPromptToQuit(FFrame&, void* const)
native function PromptToQuit();

// Export UUIGameMoviePlayer::execQuitGame(FFrame&, void* const)
native function QuitGame();

// Export UUIGameMoviePlayer::execAttemptAutoLogin(FFrame&, void* const)
native function AttemptAutoLogin();

// Export UUIGameMoviePlayer::execUpdateViewportForSafeAreas(FFrame&, void* const)
native function UpdateViewportForSafeAreas();

// Export UUIGameMoviePlayer::execAttemptAutoReplayDemoRecording(FFrame&, void* const)
native function AttemptAutoReplayDemoRecording();

// Export UUIGameMoviePlayer::execOpenChatTab(FFrame&, void* const)
native function OpenChatTab(int nChannel, optional string sName, optional bool bOpenWindow);

// Export UUIGameMoviePlayer::execCloseChatTab(FFrame&, void* const)
native function CloseChatTab(int nChannel, optional string sSender);

// Export UUIGameMoviePlayer::execAddInitialChatMessages(FFrame&, void* const)
native function AddInitialChatMessages();

// Export UUIGameMoviePlayer::execCheckControllerDisconnected(FFrame&, void* const)
native function CheckControllerDisconnected();

// Export UUIGameMoviePlayer::execUpdateGamepadIcons(FFrame&, void* const)
native function UpdateGamepadIcons();

// Export UUIGameMoviePlayer::execGetPortalType(FFrame&, void* const)
native exec function int GetPortalType();

// Export UUIGameMoviePlayer::execBeginLogin(FFrame&, void* const)
native exec function BeginLogin(optional string User, optional string pass, optional string PlayerName);

// Export UUIGameMoviePlayer::execSetLoginReady(FFrame&, void* const)
native exec function SetLoginReady();

// Export UUIGameMoviePlayer::execGetHUDTeamName(FFrame&, void* const)
native exec function string GetHUDTeamName(bool bEnemy);

// Export UUIGameMoviePlayer::execSetSpecTeamName(FFrame&, void* const)
native exec function SetSpecTeamName(bool bEnemy, optional string TeamName);

// Export UUIGameMoviePlayer::execShowCardTutorial(FFrame&, void* const)
native exec function ShowCardTutorial(optional bool bForce = false, optional bool bReset = false);

// Export UUIGameMoviePlayer::execOnMarshalEvent(FFrame&, void* const)
native function OnMarshalEvent(Pointer pMarEvent);

// Export UUIGameMoviePlayer::execOnAnnouncerLoaded(FFrame&, void* const)
native function OnAnnouncerLoaded();

// Export UUIGameMoviePlayer::execOnVoicePackLoaded(FFrame&, void* const)
native function OnVoicePackLoaded();

// Export UUIGameMoviePlayer::execInitAnnouncer(FFrame&, void* const)
native function InitAnnouncer();

// Export UUIGameMoviePlayer::execPostInit(FFrame&, void* const)
native function PostInit();

// Export UUIGameMoviePlayer::execForceDirty(FFrame&, void* const)
native exec function ForceDirty();

// Export UUIGameMoviePlayer::execNativeTick(FFrame&, void* const)
native function NativeTick(float DeltaTime);

// Export UUIGameMoviePlayer::execUIFade(FFrame&, void* const)
native function UIFade(bool bFade, optional float fTime = 0.2500000, optional float fDelay = 0.0000000, optional float fFailSafeTime);

// Export UUIGameMoviePlayer::execUIFadeEndOfRound(FFrame&, void* const)
native function UIFadeEndOfRound(bool bFade, optional float fTime = 0.2500000, optional float fDelay = 0.0000000, optional float fFailSafeTime);

// Export UUIGameMoviePlayer::execGetGamepadValueForKeyBind(FFrame&, void* const)
native function int GetGamepadValueForKeyBind(string KeyBind);

// Export UUIGameMoviePlayer::execGetPlayerDisplayName(FFrame&, void* const)
native function string GetPlayerDisplayName(string PlayerName, string OnlineID);

// Export UUIGameMoviePlayer::execHasPlayerDisplayName(FFrame&, void* const)
native function bool HasPlayerDisplayName(string OnlineID);

// Export UUIGameMoviePlayer::execOnReadOnlinePlayerDataComplete(FFrame&, void* const)
native function OnReadOnlinePlayerDataComplete(bool bWasSuccessful, array<string> PlayerIDs, array<OnlineProfile> OnlineProfiles);

// Export UUIGameMoviePlayer::execNativeWidgetUnloaded(FFrame&, void* const)
native function bool NativeWidgetUnloaded(name WidgetName, name WidgetPath, GFxObject Widget);

// Export UUIGameMoviePlayer::execNativeWidgetInitialized(FFrame&, void* const)
native function bool NativeWidgetInitialized(name WidgetName, name WidgetPath, GFxObject Widget);

// Export UUIGameMoviePlayer::execShowSubtitle(FFrame&, void* const)
native function ShowSubtitle(string sValue, optional float fTime = 0.0000000);

// Export UUIGameMoviePlayer::execSwitchSubtitleText(FFrame&, void* const)
native function SwitchSubtitleText(string sValue);

// Export UUIGameMoviePlayer::execHideSubtitle(FFrame&, void* const)
native function HideSubtitle();

// Export UUIGameMoviePlayer::execGetGameData(FFrame&, void* const)
native function TgDataGroup_Game GetGameData();

// Export UUIGameMoviePlayer::execGetDataHandler(FFrame&, void* const)
native function TgGameDataHandler GetDataHandler();

// Export UUIGameMoviePlayer::execIsItemOwned(FFrame&, void* const)
native function bool IsItemOwned(int ItemId);

// Export UUIGameMoviePlayer::execOnSuccessfulUserAccountInfoRetrieved(FFrame&, void* const)
native function OnSuccessfulUserAccountInfoRetrieved(UserAccountInfo AccountInfo);

final event LoadScene(string sName, string sPath, int nDepth)
{
    ActionScriptVoid("LoadScene");
    //return;    
}

final event UnloadScene(string sName)
{
    ActionScriptVoid("UnloadScene");
    //return;    
}

// Export UUIGameMoviePlayer::execShowPartyRequiresPremiumAccountWarning(FFrame&, void* const)
native function ShowPartyRequiresPremiumAccountWarning();

// Export UUIGameMoviePlayer::execShowNoFriendsForProfileViewWarning(FFrame&, void* const)
native function ShowNoFriendsForProfileViewWarning();

// Export UUIGameMoviePlayer::execOnAccountPickerCancelled(FFrame&, void* const)
native function OnAccountPickerCancelled();

// Export UUIGameMoviePlayer::execShowErrorMessage(FFrame&, void* const)
native function bool ShowErrorMessage(string sTitle, string sError);

// Export UUIGameMoviePlayer::execPlayerLoginError(FFrame&, void* const)
native function PlayerLoginError(int nError, string sMessage);

event Init(optional LocalPlayer LocPlay)
{
    super.Init(LocPlay);
    InitAnnouncer();
    // End:0x64
    if(m_AlienFX == none)
    {
        m_AlienFX = new Class'TgGame.AlienFXManager';
        m_AlienFX.Initialize();
    }
    //return;    
}

function InitOSSRef()
{
    super.InitOSSRef();
    PlayerInterface.AddAccountPickerCompleteDelegate(OnAccountPickerCompleteForLogin);
    PlayerInterface.AddLoginCancelledDelegate(OnAccountPickerCancelledWrapper);
    //return;    
}

event OnClose()
{
    PlayerInterface.RemoveAccountPickerCompleteDelegate(OnAccountPickerCompleteForLogin);
    PlayerInterface.ClearLoginCancelledDelegate(OnAccountPickerCancelledWrapper);
    //return;    
}

function OnAccountPickerCancelledWrapper()
{
    OnAccountPickerCancelled();
    //return;    
}

event ShowKeyboardUI(GFxObject FocusedTextField, string TitleText, string DescriptionText, optional bool bIsPassword = false, optional bool bShouldValidate = true, optional string DefaultText, optional int MaxResultLength = 256)
{
    m_mcKeyboardFocus = FocusedTextField;
    PlayerInterface.AddKeyboardInputDoneDelegate(OnKeyboardInputComplete);
    PlayerInterface.ShowKeyboardUI(0, TitleText, DescriptionText, bIsPassword, bShouldValidate, DefaultText, MaxResultLength);
    //return;    
}

event bool CheckControllerConnected()
{
    return OnlineSub.SystemInterface.IsControllerConnected(GetLP().ControllerId);
    //return ReturnValue;    
}

function OnKeyboardInputComplete(bool bWasSuccessful)
{
    local byte bCancelled;
    local string OutStr;

    OutStr = PlayerInterface.GetKeyboardInputResults(bCancelled);
    PlayerInterface.ClearKeyboardInputDoneDelegate(OnKeyboardInputComplete);
    // End:0xB8
    if((int(bCancelled) == int(0)) && m_mcKeyboardFocus != none)
    {
        m_mcKeyboardFocus.SetString("text", OutStr);
    }
    m_mcKeyboardFocus = none;
    //return;    
}

event bool WidgetInitialized(name WidgetName, name WidgetPath, GFxObject Widget)
{
    // End:0x38
    if(WidgetName == 'SpectatorHUD_mc')
    {
        m_mcSpectatorHUD = UIHudSpectator(Widget);
        return true;        
    }
    else
    {
        // End:0x67
        if(WidgetName == 'MapFrame_mc')
        {
            m_mcMapFrame = Widget;
            return true;            
        }
        else
        {
            // End:0x96
            if(WidgetName == 'MissionMapFrame_mc')
            {
                m_mcMapFrameLarge = Widget;
                return true;                
            }
            else
            {
                // End:0xC3
                if(WidgetName == 'GAPeach')
                {
                    AttemptAutoLogin();
                    AttemptAutoReplayDemoRecording();
                    return true;
                }
            }
        }
    }
    // End:0xED
    if(NativeWidgetInitialized(WidgetName, WidgetPath, Widget))
    {
        return true;
    }
    return super(GFxMoviePlayer).WidgetInitialized(WidgetName, WidgetPath, Widget);
    //return ReturnValue;    
}

event bool WidgetUnloaded(name WidgetName, name WidgetPath, GFxObject Widget)
{
    // End:0x27
    if(WidgetName == 'SpectatorHUD_mc')
    {
        m_mcSpectatorHUD = none;
        return true;        
    }
    else
    {
        // End:0x4B
        if(WidgetName == 'MapFrame_mc')
        {
            m_mcMapFrame = none;
            return true;
        }
    }
    // End:0x75
    if(NativeWidgetUnloaded(WidgetName, WidgetPath, Widget))
    {
        return true;
    }
    return super(GFxMoviePlayer).WidgetUnloaded(WidgetName, WidgetPath, Widget);
    //return ReturnValue;    
}

exec function ToggleAlienFX()
{
    // End:0x27
    if(m_AlienFX == none)
    {
        m_AlienFX = new Class'TgGame.AlienFXManager';
    }
    // End:0x6B
    if(m_AlienFX.m_bLoaded)
    {
        m_AlienFX.Close();        
    }
    else
    {
        m_AlienFX.Initialize();
    }
    //return;    
}

event bool ShowConsoleLoginUI(int ControllerId, optional bool bForceLoginAfter)
{
    PlayerLoginError(0, "");
    return PlayerInterface.ShowLoginUI(byte(ControllerId), bForceLoginAfter);
    //return ReturnValue;    
}

event RegisterLocalTalker(byte LocalUserNum, optional byte ChannelIndex)
{
    VoiceInterface.RegisterLocalTalker(LocalUserNum, ChannelIndex);
    //return;    
}

event UnregisterLocalTalker(byte LocalUserNum, optional byte ChannelIndex)
{
    VoiceInterface.UnregisterLocalTalker(LocalUserNum, ChannelIndex);
    //return;    
}

event MutePlayer(byte LocalUserNum, UniqueNetId ConsoleId)
{
    VoiceInterface.MuteRemoteTalker(LocalUserNum, ConsoleId, false);
    //return;    
}

event UnmutePlayer(byte LocalUserNum, UniqueNetId ConsoleId)
{
    VoiceInterface.UnmuteRemoteTalker(LocalUserNum, ConsoleId, false);
    //return;    
}

event bool IsPlayerMuted(UniqueNetId ConsoleId)
{
    return VoiceInterface.IsTalkerMuted(ConsoleId);
    //return ReturnValue;    
}

event ShowGamerCardByUserName(string UserName)
{
    local string LocalPlayerUserName;

    PlayerInterfaceEx.AddShowGamerCardCompleteDelegate(updatePlayerMute);
    // End:0xDA
    if(Len(UserName) == 0)
    {
        LocalPlayerUserName = PlayerInterface.GetPlayerNickname(byte(GetLP().ControllerId));
        PlayerInterfaceEx.ShowGamerCardUIByUsername(byte(GetLP().ControllerId), LocalPlayerUserName);        
    }
    else
    {
        PlayerInterfaceEx.ShowGamerCardUIByUsername(byte(GetLP().ControllerId), UserName);
    }
    //return;    
}

event ShowGamercard(UniqueNetId PlayerID)
{
    PlayerInterfaceEx.AddShowGamerCardCompleteDelegate(updatePlayerMute);
    PlayerInterfaceEx.ShowGamerCardUI(byte(GetLP().ControllerId), PlayerID);
    //return;    
}

function updatePlayerMute(bool bWasSuccessful)
{
    //return;    
}

event CacheLoggedInGamepad()
{
    PlayerInterface.CacheLoggedInGamepad();
    //return;    
}

exec event usc_ShowContentMarketPlaceUI(int ParentProductType, int RequestedProductTypes)
{
    PlayerInterfaceEx.ShowContentMarketplaceUI(byte(GetLP().ControllerId), ParentProductType, RequestedProductTypes);
    //return;    
}

exec event usc_ShowContentMarketPlaceUIForProduct(int ParentProductType, int RequestedProductTypes, string ProductID)
{
    PlayerInterfaceEx.ShowContentMarketplaceUI(byte(GetLP().ControllerId), ParentProductType, RequestedProductTypes, ProductID);
    //return;    
}

exec event usc_ShowGameDetailsUI()
{
    PlayerInterfaceEx.ShowProductDetailsUI(byte(GetLP().ControllerId));
    //return;    
}

exec event usc_ShowProductDetailsUI(string ProductID)
{
    PlayerInterfaceEx.ShowProductDetailsUI(byte(GetLP().ControllerId), ProductID);
    //return;    
}

exec event ShowContentPurchaseUI(string SingedOffer)
{
    PlayerInterfaceEx.ShowContentPurchaseUI(byte(GetLP().ControllerId), SingedOffer);
    //return;    
}

exec event GetAccountInfo()
{
    PlayerInterface.AddGetUserAccountInfoDelegate(OnUserAccountInfoRetrieved);
    PlayerInterface.GetUserAccountInfo(byte(GetLP().ControllerId));
    //return;    
}

function OnUserAccountInfoRetrieved(bool bSuccessful, UserAccountInfo AccountInfo)
{
    OnlineSub.PlayerInterface.ClearGetUserAccountInfoDelegate(OnUserAccountInfoRetrieved);
    // End:0x66
    if(bSuccessful)
    {
        OnSuccessfulUserAccountInfoRetrieved(AccountInfo);
    }
    //return;    
}

event ReadOnlinePlayerData(array<string> PlayerIDs)
{
    local OnlinePlayerInterfaceEx OPI;

    OPI = GetPlayerOwner().OnlineSub.PlayerInterfaceEx;
    // End:0xB8
    if(NotEqual_InterfaceInterface(OPI, OnlinePlayerInterfaceEx(none)))
    {
        OPI.AddReadOnlineProfilesCompleteDelegate(OnReadOnlinePlayerData);
        OPI.ReadOnlineProfilesForPlayers(PlayerIDs);
    }
    //return;    
}

function OnReadOnlinePlayerData(bool bWasSuccessful, array<string> PlayerIDs, array<OnlineProfile> OnlineProfiles)
{
    local OnlinePlayerInterfaceEx OPI;

    OPI = GetPlayerOwner().OnlineSub.PlayerInterfaceEx;
    // End:0x8F
    if(NotEqual_InterfaceInterface(OPI, OnlinePlayerInterfaceEx(none)))
    {
        OPI.ClearReadOnlineProfilesCompleteDelegate(OnReadOnlinePlayerData);
    }
    OnReadOnlinePlayerDataComplete(bWasSuccessful, PlayerIDs, OnlineProfiles);
    //return;    
}

function OnAccountPickerCompleteForLogin(bool bForceLogin)
{
    // End:0x46
    if(bForceLogin)
    {
        BeginLogin(string(GetLP().ControllerId), "Console", "");        
    }
    else
    {
        SetLoginReady();
    }
    //return;    
}

event NativeOpenURL(string URL)
{
    PlayerInterfaceEx.ShowVideo(URL);
    //return;    
}

function OnPermissionForOnlineScene(byte LocalUserNum, OnlineSubsystem.EFeaturePrivilege Privilege, OnlineSubsystem.EFeaturePrivilegeLevel PrivilegeLevel, bool bDiffersFromHint)
{
    PlayerInterface.ClearPrivilegeLevelCheckedDelegate(OnPermissionForOnlineScene);
    // End:0xEA
    if((int(Privilege) == int(0)) && int(PrivilegeLevel) == int(2))
    {
        GetHUD().PushScene(m_sPendingOnlineScene, true);
        m_sPendingOnlineScene = "";
        // End:0xE7
        if((m_sDelayErrorTitle != "") || m_sDelayErrorDesc != "")
        {
            ShowErrorMessage(m_sDelayErrorTitle, m_sDelayErrorDesc);
            m_sDelayErrorTitle = "";
            m_sDelayErrorDesc = "";
        }        
    }
    else
    {
        ShowPartyRequiresPremiumAccountWarning();
    }
    //return;    
}

event CheckPermissionForOnlineScene(string sScene, byte ControlledId, OnlineSubsystem.EFeaturePrivilegeLevel Hint, optional bool bAttemptToResolve = false)
{
    m_sPendingOnlineScene = sScene;
    PlayerInterface.AddPrivilegeLevelCheckedDelegate(OnPermissionForOnlineScene);
    PlayerInterface.CanPlayOnline(ControlledId, Hint, bAttemptToResolve);
    //return;    
}

defaultproperties
{
    m_nReplayId=-1
    m_nChosenQueue=-1
    m_bVisible=true
    m_akJoinQueue=AkEvent'WW_UI_Default.UI_Menu_EnterQueue_Play'
    // Reference: TgManifestGroup'TgClient.Default__UIGameMoviePlayer.TgManifestGroup0'
    begin object name="TgManifestGroup0" class=TgGame.TgManifestGroup
    end object
    m_AnnouncerManifestGroup=TgManifestGroup0
    // Reference: TgManifestGroup'TgClient.Default__UIGameMoviePlayer.TgManifestGroup1'
    begin object name="TgManifestGroup1" class=TgGame.TgManifestGroup
    end object
    m_VoicePackManifestGroup=TgManifestGroup1
    m_DataHandlerClass=Class'TgClient.TgGameDataHandler'
    MovieInfo=SwfMovie'MenuManager.MenuManager'
    bCloseOnLevelChange=false
    WidgetBindings=/* Array type was not detected. */
}