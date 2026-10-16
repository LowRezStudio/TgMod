class UIMoviePlayer extends GFxMoviePlayer
    native
    config(UI);

var int m_nLastTimerIndex;
var bool m_bInitialized;
var bool m_bInTransition;
var bool m_bResizeForSafeZones;
var GFxObject m_mcRoot;
var GFxObject m_mcGlobal;
var TgDataHandler m_DataHandler;
var TgTimerManager m_TimerManager;
var Class<TgDataHandler> m_DataHandlerClass;
var native Pointer m_pTgCallbackDevice;
var native Pointer m_pKeybindLookup;
var OnlineSubsystem OnlineSub;
var OnlineGameInterface GameInterface;
var OnlineVoiceInterface VoiceInterface;
var OnlinePlayerInterface PlayerInterface;
var OnlineContentInterface ContentInterface;
var OnlinePlayerInterfaceEx PlayerInterfaceEx;
var OnlineMarketplaceInterface MarketplaceInterface;
//var delegate<DelegateOnMarshalEvent> __DelegateOnMarshalEvent__Delegate;

delegate DelegateOnMarshalEvent(Pointer pMarEvent)
{
    //return;    
}

// Export UUIMoviePlayer::execGetHUD(FFrame&, void* const)
native function TgClientHUD GetHUD();

// Export UUIMoviePlayer::execGetPlayerOwner(FFrame&, void* const)
native function TgPlayerController GetPlayerOwner();

// Export UUIMoviePlayer::execOnClose(FFrame&, void* const)
native event OnClose();

// Export UUIMoviePlayer::execPostInit(FFrame&, void* const)
native function PostInit();

// Export UUIMoviePlayer::execInitializeDataHandler(FFrame&, void* const)
native function InitializeDataHandler();

// Export UUIMoviePlayer::execNativeTick(FFrame&, void* const)
native function NativeTick(float DeltaTime);

// Export UUIMoviePlayer::execRegisterMarshalCallback(FFrame&, void* const)
native function bool RegisterMarshalCallback();

// Export UUIMoviePlayer::execUnregisterMarshalCallback(FFrame&, void* const)
native function UnregisterMarshalCallback();

// Export UUIMoviePlayer::execOnMarshalEvent(FFrame&, void* const)
native function OnMarshalEvent(Pointer pMarEvent);

// Export UUIMoviePlayer::execUpdateViewportForSafeAreas(FFrame&, void* const)
native function UpdateViewportForSafeAreas();

// Export UUIMoviePlayer::execGetTranslatedKeyBind(FFrame&, void* const)
native function string GetTranslatedKeyBind(string Command, optional int nAlternate = 0, optional bool bLocalizeKB = true, optional bool bLocalizeMouse = true, optional bool bLocalizeGamepad = true);

// Export UUIMoviePlayer::execRegisterEngineCallbacks(FFrame&, void* const)
native function RegisterEngineCallbacks();

// Export UUIMoviePlayer::execUnregisterEngineCallbacks(FFrame&, void* const)
native function UnregisterEngineCallbacks();

// Export UUIMoviePlayer::execQuitGame(FFrame&, void* const)
native function QuitGame();

// Export UUIMoviePlayer::execusc_Data_Handler_Created(FFrame&, void* const)
native function usc_Data_Handler_Created();

// Export UUIMoviePlayer::execusc_Console_Command(FFrame&, void* const)
native function usc_Console_Command(string Cmd);

// Export UUIMoviePlayer::execusc_toggle_cursor(FFrame&, void* const)
native function usc_toggle_cursor(bool bShow);

// Export UUIMoviePlayer::execusc_toggle_key_capture(FFrame&, void* const)
native function usc_toggle_key_capture(bool bCapture);

// Export UUIMoviePlayer::execShowTransitionScene(FFrame&, void* const)
native exec function ShowTransitionScene(bool bShow);

// Export UUIMoviePlayer::execusc_TranslateMsgId(FFrame&, void* const)
native exec function string usc_TranslateMsgId(int nId);

// Export UUIMoviePlayer::execusc_TranslateMsg(FFrame&, void* const)
native exec function string usc_TranslateMsg(string Identifier, string SectionName);

// Export UUIMoviePlayer::execusc_IME_SetEnabled(FFrame&, void* const)
native exec function bool usc_IME_SetEnabled(bool bEnabled);

// Export UUIMoviePlayer::execusc_IME_Exists(FFrame&, void* const)
native exec function bool usc_IME_Exists();

event Tick(float DeltaTime)
{
    NativeTick(DeltaTime);
    //return;    
}

event Init(optional LocalPlayer LocPlay)
{
    super.Init(LocPlay);
    RegisterMarshalCallback();
    InitOSSRef();
    // End:0x3F
    if(bMovieIsOpen)
    {
        PostInit();
    }
    //return;    
}

function InitOSSRef()
{
    OnlineSub = Class'Engine.GameEngine'.static.GetOnlineSubsystem();
    // End:0x128
    if(OnlineSub != none)
    {
        GameInterface = OnlineSub.GameInterface;
        VoiceInterface = OnlineSub.VoiceInterface;
        PlayerInterface = OnlineSub.PlayerInterface;
        ContentInterface = OnlineSub.ContentInterface;
        PlayerInterfaceEx = OnlineSub.PlayerInterfaceEx;
        MarketplaceInterface = OnlineSub.MarketplaceInterface;
    }
    //return;    
}

exec function string usc_ClipboardPaste()
{
    local TgPlayerController pPC;

    pPC = GetPlayerOwner();
    // End:0x43
    if(pPC != none)
    {
        return pPC.PasteFromClipboard();
    }
    return "";
    //return ReturnValue;    
}

exec function usc_ClipboardCopy(string Str)
{
    local TgPlayerController pPC;

    pPC = GetPlayerOwner();
    // End:0x4B
    if(pPC != none)
    {
        pPC.CopyToClipboard(Str);
    }
    //return;    
}

event SetMarketplaceVisibility(bool Visible)
{
    // End:0x4A
    if(NotEqual_InterfaceInterface(MarketplaceInterface, OnlineMarketplaceInterface(none)))
    {
        MarketplaceInterface.SetMarketplaceVisibility(Visible);
    }
    //return;    
}

defaultproperties
{
    m_nLastTimerIndex=1
    m_bResizeForSafeZones=true
    m_DataHandlerClass=Class'TgClient.TgDataHandler'
    bAutoPlay=true
}