class TgClientHUD extends TgHUD
    transient
    native
    config(Game)
    hidecategories(Navigation);

const LOADING_SCREEN_TIP_COUNT = 5;

enum ECaptureState
{
    ECS_None,                       // 0
    ECS_Chat,                       // 1
    ECS_VGSMenu,                    // 2
    ECS_Keybind,                    // 3
    ECS_MAX                         // 4
};

struct native SceneInfo
{
    var int nDepth;
    var init string sName;
    var init string sPath;

    structdefaultproperties
    {
        nDepth=0
        sName=""
        sPath=""
    }
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

// Export UTgClientHUD::execInitialize(FFrame&, void* const)
native function Initialize();

// Export UTgClientHUD::execPushScene(FFrame&, void* const)
native exec function bool PushScene(string sName, optional bool bSkipPrivilegeCheck = false);

// Export UTgClientHUD::execPopScene(FFrame&, void* const)
native exec function bool PopScene(optional int nIndex = -1);

// Export UTgClientHUD::execClearScenes(FFrame&, void* const)
native function ClearScenes(optional byte eTargetState = 0);

// Export UTgClientHUD::execRemoveSceneFromStack(FFrame&, void* const)
native function bool RemoveSceneFromStack(TgGfxScene pScene, optional bool bPopAll = false);

// Export UTgClientHUD::execIsInGame(FFrame&, void* const)
native function bool IsInGame();

// Export UTgClientHUD::execIsLoggedIn(FFrame&, void* const)
native function bool IsLoggedIn();

// Export UTgClientHUD::execShowCursor(FFrame&, void* const)
native function ShowCursor(bool bShow);

// Export UTgClientHUD::execShowHit(FFrame&, void* const)
native function ShowHit(Actor Target, float fDamageAmount, bool bIsShieldHit, const out ExtraDamageInfo ExtraInfo);

// Export UTgClientHUD::execTryToBack(FFrame&, void* const)
native function bool TryToBack();

// Export UTgClientHUD::execToggleHUD(FFrame&, void* const)
native exec function ToggleHUD();

// Export UTgClientHUD::execResetViewCenterPoint(FFrame&, void* const)
native exec function ResetViewCenterPoint();

// Export UTgClientHUD::execTestDidIt(FFrame&, void* const)
native exec function TestDidIt(int nActivityId, int nCount);

// Export UTgClientHUD::execDumpScenesToLog(FFrame&, void* const)
native exec function DumpScenesToLog();

// Export UTgClientHUD::execToggleDevMenu(FFrame&, void* const)
native exec function ToggleDevMenu();

// Export UTgClientHUD::execTogglePushToTalk(FFrame&, void* const)
native exec function TogglePushToTalk(bool bEnable);

simulated function PostBeginPlay()
{
    super(HUD).PostBeginPlay();
    Initialize();
    //return;    
}

event Tick(float DeltaTime)
{
    DeltaTime = WorldInfo.m_fRealDeltaSeconds;
    super(Actor).Tick(DeltaTime);
    // End:0x72
    if(m_pMovie != none)
    {
        m_pMovie.Tick(DeltaTime);
    }
    m_PictureInPicture.super(PComPictureInPicture).Tick();
    //return;    
}

event PostRender()
{
    super(HUD).PostRender();
    m_PictureInPicture.DebugRender(Canvas);
    //return;    
}

exec function TestPictureInPictureBasic()
{
    m_PictureInPicture.Scene = none;
    m_PictureInPicture.TestPictureInPicture();
    //return;    
}

exec function TestPictureInPicturePortraits(string botName)
{
    local PComPictureInPictureScene Scene;

    Scene = new Class'PlatformCommon.PComPictureInPictureScene';
    Scene.InitScene();
    m_PictureInPicture.Scene = Scene;
    m_PictureInPicture.ViewDescs.Length = 0;
    CreateTestPortraits(Scene, botName, vect(20.0000000, 2.5000000, 80.0000000), vect(0.0000000, 2.5000000, 77.0000000), 30.0000000);
    m_PictureInPicture.bEnableDebugRendering = true;
    //return;    
}

// Export UTgClientHUD::execCreateTestPortraits(FFrame&, void* const)
native final function CreateTestPortraits(PComPictureInPictureScene Scene, const out string botName, Vector ViewOffset, Vector LookAtOffset, float FOV);

exec function DebugPictureInPicture()
{
    m_PictureInPicture.bEnableDebugRendering = true;
    //return;    
}

exec function TestShowCursor(bool bShow)
{
    ShowCursor(bShow);
    //return;    
}

defaultproperties
{
    m_fPromptTime=1.0000000
    // Reference: PComPictureInPicture'TgClient.Default__TgClientHUD.PictureInPicture'
    begin object name="PictureInPicture" class=PlatformCommon.PComPictureInPicture
    end object
    m_PictureInPicture=PictureInPicture
    bAlwaysTick=true
}