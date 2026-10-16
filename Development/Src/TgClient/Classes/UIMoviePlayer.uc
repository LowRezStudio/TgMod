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

delegate DelegateOnMarshalEvent(Pointer pMarEvent);

native function TgClientHUD GetHUD();  // Export UUIMoviePlayer::execGetHUD(FFrame&, void* const)

native function TgPlayerController GetPlayerOwner();  // Export UUIMoviePlayer::execGetPlayerOwner(FFrame&, void* const)

native event OnClose();  // Export UUIMoviePlayer::execOnClose(FFrame&, void* const)

native function PostInit();  // Export UUIMoviePlayer::execPostInit(FFrame&, void* const)

native function InitializeDataHandler();  // Export UUIMoviePlayer::execInitializeDataHandler(FFrame&, void* const)

native function NativeTick(float DeltaTime);  // Export UUIMoviePlayer::execNativeTick(FFrame&, void* const)

native function bool RegisterMarshalCallback();  // Export UUIMoviePlayer::execRegisterMarshalCallback(FFrame&, void* const)

native function UnregisterMarshalCallback();  // Export UUIMoviePlayer::execUnregisterMarshalCallback(FFrame&, void* const)

native function OnMarshalEvent(Pointer pMarEvent);  // Export UUIMoviePlayer::execOnMarshalEvent(FFrame&, void* const)

native function UpdateViewportForSafeAreas();  // Export UUIMoviePlayer::execUpdateViewportForSafeAreas(FFrame&, void* const)

native function string GetTranslatedKeyBind(string Command, optional int nAlternate=0, optional bool bLocalizeKB=true, optional bool bLocalizeMouse=true, optional bool bLocalizeGamepad=true);  // Export UUIMoviePlayer::execGetTranslatedKeyBind(FFrame&, void* const)

native function RegisterEngineCallbacks();  // Export UUIMoviePlayer::execRegisterEngineCallbacks(FFrame&, void* const)

native function UnregisterEngineCallbacks();  // Export UUIMoviePlayer::execUnregisterEngineCallbacks(FFrame&, void* const)

native function QuitGame();  // Export UUIMoviePlayer::execQuitGame(FFrame&, void* const)

native function usc_Data_Handler_Created();  // Export UUIMoviePlayer::execusc_Data_Handler_Created(FFrame&, void* const)

native function usc_Console_Command(string Cmd);  // Export UUIMoviePlayer::execusc_Console_Command(FFrame&, void* const)

native function usc_toggle_cursor(bool bShow);  // Export UUIMoviePlayer::execusc_toggle_cursor(FFrame&, void* const)

native function usc_toggle_key_capture(bool bCapture);  // Export UUIMoviePlayer::execusc_toggle_key_capture(FFrame&, void* const)

native exec function ShowTransitionScene(bool bShow);  // Export UUIMoviePlayer::execShowTransitionScene(FFrame&, void* const)

native exec function string usc_TranslateMsgId(int nId);  // Export UUIMoviePlayer::execusc_TranslateMsgId(FFrame&, void* const)

native exec function string usc_TranslateMsg(string Identifier, string SectionName);  // Export UUIMoviePlayer::execusc_TranslateMsg(FFrame&, void* const)

native exec function bool usc_IME_SetEnabled(bool bEnabled);  // Export UUIMoviePlayer::execusc_IME_SetEnabled(FFrame&, void* const)

native exec function bool usc_IME_Exists();  // Export UUIMoviePlayer::execusc_IME_Exists(FFrame&, void* const)

event Tick(float DeltaTime) { }

event Init(optional LocalPlayer LocPlay) { }

function InitOSSRef() { }

exec function string usc_ClipboardPaste() { }

exec function usc_ClipboardCopy(string Str) { }

event SetMarketplaceVisibility(bool Visible) { }

defaultproperties
{
    m_nLastTimerIndex=1
    m_bResizeForSafeZones=true
    m_DataHandlerClass=Class'TgDataHandler'
    bAutoPlay=true
}
