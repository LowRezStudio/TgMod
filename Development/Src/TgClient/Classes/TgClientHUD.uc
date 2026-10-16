class TgClientHUD extends TgHUD
    transient
    native
    config(Game)
    hidecategories(Navigation);

const LOADING_SCREEN_TIP_COUNT = 5;

enum ECaptureState {
    ECS_None,  // 0
    ECS_Chat,  // 1
    ECS_VGSMenu,  // 2
    ECS_Keybind,  // 3
};

struct SceneInfo {
    var int nDepth;
    var init string sName;
    var init string sPath;
    structdefaultproperties {}
};

var byte m_eState;
var byte m_ePromptType;
var byte m_eCaptureState;
var float m_fPromptTime;
var float m_fPromptTimer;
var UIGameMoviePlayer m_pMovie;
var array<TgGfxScene> m_SceneStack;
var array<TgGfxScene> m_PopupStack;
var array<SceneInfo> m_ScenePreloads;
var array<string> m_sNeededScenes;
var bool m_bShowCursor;
var bool m_bCaptureKeys;
var PComPictureInPicture m_PictureInPicture;
var init protected array<init UIMoviePlayer> m_MoviePlayers;
var init TgDevMenuMoviePlayer m_DevMenu;

native function Initialize();  // Export UTgClientHUD::execInitialize(FFrame&, void* const)

native exec function bool PushScene(string sName, optional bool bSkipPrivilegeCheck=false);  // Export UTgClientHUD::execPushScene(FFrame&, void* const)

native exec function bool PopScene(optional int nIndex=-1);  // Export UTgClientHUD::execPopScene(FFrame&, void* const)

native function ClearScenes(optional byte eTargetState=0);  // Export UTgClientHUD::execClearScenes(FFrame&, void* const)

native function bool RemoveSceneFromStack(TgGfxScene pScene, optional bool bPopAll=false);  // Export UTgClientHUD::execRemoveSceneFromStack(FFrame&, void* const)

native function bool IsInGame();  // Export UTgClientHUD::execIsInGame(FFrame&, void* const)

native function bool IsLoggedIn();  // Export UTgClientHUD::execIsLoggedIn(FFrame&, void* const)

native function ShowCursor(bool bShow);  // Export UTgClientHUD::execShowCursor(FFrame&, void* const)

native function ShowHit(Actor Target, float fDamageAmount, bool bIsShieldHit, const out ExtraDamageInfo ExtraInfo);  // Export UTgClientHUD::execShowHit(FFrame&, void* const)

native function bool TryToBack();  // Export UTgClientHUD::execTryToBack(FFrame&, void* const)

native exec function ToggleHUD();  // Export UTgClientHUD::execToggleHUD(FFrame&, void* const)

native exec function ResetViewCenterPoint();  // Export UTgClientHUD::execResetViewCenterPoint(FFrame&, void* const)

native exec function TestDidIt(int nActivityId, int nCount);  // Export UTgClientHUD::execTestDidIt(FFrame&, void* const)

native exec function DumpScenesToLog();  // Export UTgClientHUD::execDumpScenesToLog(FFrame&, void* const)

native exec function ToggleDevMenu();  // Export UTgClientHUD::execToggleDevMenu(FFrame&, void* const)

native exec function TogglePushToTalk(bool bEnable);  // Export UTgClientHUD::execTogglePushToTalk(FFrame&, void* const)

simulated function PostBeginPlay() { }

event Tick(float DeltaTime) { }

event PostRender() { }

exec function TestPictureInPictureBasic() { }

exec function TestPictureInPicturePortraits(string botName) { }

native function CreateTestPortraits(PComPictureInPictureScene Scene, const out string botName, Vector ViewOffset, Vector LookAtOffset, float FOV);  // Export UTgClientHUD::execCreateTestPortraits(FFrame&, void* const)

exec function DebugPictureInPicture() { }

exec function TestShowCursor(bool bShow) { }

defaultproperties
{}
