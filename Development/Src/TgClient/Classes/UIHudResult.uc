class UIHudResult extends TgGfxScene within GFxMoviePlayer
    native(GFxScene)
    config(Engine);

enum EPlayOfTheGameState {
    EPOTGS_None,  // 0
    EPOTGS_Setup,  // 1
    EPOTGS_Intro,  // 2
    EPOTGS_PlaybackRequested,  // 3
    EPOTGS_PlaybackStarted,  // 4
    EPOTGS_Outro,  // 5
};

var bool m_bRoundEnd;
var bool m_bLoadingModel;
var bool m_bMapOutroFinished;
var float m_fResultDisplayTime;
var float m_fPlayOfTheGameTimer;
var float m_fHomeTimer;
var float m_fRoundTime;
var float m_fRoundTimer;
var float m_fAnimTimer;
var float m_fAsyncMeshLoadTimeout;
var float m_fIntroDuration;
var float m_fPlayOfTheGameTimeoutDuration;
var GFxObject m_mcBlocker;
var GFxObject m_mcResult;
var GFxObject m_mcResultEOR;
var GFxObject m_mcResultTitle;
var GFxObject m_mcResultTitleAnim;
var GFxObject m_mcResultDefeat;
var GFxObject m_mcResultVictory;
var GFxObject m_mcResultVictorySpectator;
var GFxObject m_mcResultPlayOfTheGameContainer;
var GFxObject m_mcResultPlayOfTheGame;
var GFxObject m_mcResultPlayOfTheGameBackground;
var GFxObject m_mcResultPlayOfTheGamePlayerNameGroup;
var GFxObject m_mcResultPlayOfTheGamePlayerName;
var GFxObject m_mcResultPlayOfTheGamePlayerNameShadow;
var GFxObject m_mcResultPlayOfTheGamePlayerTitle;
var GFxObject m_mcResultPlayOfTheGamePlayerPortrait;
var GFxObject m_mcResultPlayOfTheGamePlayerPortraitFrame;
var GFxObject m_mcResultPlayOfTheGamePlayerPortraitIcon;
var GFxObject m_mcResultPlayOfTheGamePlayerPortraitIconTexture;
var GFxObject m_mcResultPlayOfTheGameChampionNameGroup;
var GFxObject m_mcResultPlayOfTheGameChampionName;
var GFxObject m_mcResultPlayOfTheGameChampionNameTF;
var GFxObject m_mcResultPlayOfTheGameText;
var GFxObject m_mcResultPlayOfTheGameTextAs;
var int m_nBasePotGXPos;
var UIHudResult.EPlayOfTheGameState m_ePlayOfTheGameState;
var float m_fPlayOfTheGameStateTime;

event HandleAnimState(int nAnimState, optional int nAnimGroup=0) { }

defaultproperties
{
    m_fAsyncMeshLoadTimeout=5.0000000
    m_fIntroDuration=5.0000000
    m_fPlayOfTheGameTimeoutDuration=1.5000000
    m_bAlwaysTick=true
    m_bAllowSpectatorClickThru=false
    m_bShowCursor=false
    m_bCaptureKeys=false
    m_Name="UIHudResult"
}
