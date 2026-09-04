class UIHudResult extends TgGfxScene within GFxMoviePlayer
    native(GFxScene);

enum EPlayOfTheGameState
{
    EPOTGS_None,                    // 0
    EPOTGS_Setup,                   // 1
    EPOTGS_Intro,                   // 2
    EPOTGS_PlaybackRequested,       // 3
    EPOTGS_PlaybackStarted,         // 4
    EPOTGS_Outro,                   // 5
    EPOTGS_MAX                      // 6
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

event HandleAnimState(int nAnimState, optional int nAnimGroup = 0)
{
    switch(nAnimState)
    {
        // End:0x6FD
        case 2:
            CancelAnim(m_mcResultPlayOfTheGame);
            m_mcResultPlayOfTheGame.SetVisible(true);
            m_mcResultPlayOfTheGame.SetAlpha(100.0000000);
            m_mcResultPlayOfTheGame.SetXScale(100.0000000);
            m_mcResultPlayOfTheGame.SetYScale(100.0000000);
            m_mcResultPlayOfTheGame.SetX(float(m_nBasePotGXPos));
            CancelAnim(m_mcResultPlayOfTheGamePlayerPortrait);
            m_mcResultPlayOfTheGamePlayerPortrait.SetXScale(175.0000000);
            m_mcResultPlayOfTheGamePlayerPortrait.SetYScale(175.0000000);
            m_mcResultPlayOfTheGamePlayerPortrait.SetY(250.0000000);
            m_mcResultPlayOfTheGamePlayerPortrait.SetAlpha(0.0000000);
            Animate(m_mcResultPlayOfTheGamePlayerPortrait, 0.3330000, 5, 98.0000000, 0.3750000, 1, false);
            Animate(m_mcResultPlayOfTheGamePlayerPortrait, 0.3330000, 6, 98.0000000, 0.3750000, 1, false);
            Animate(m_mcResultPlayOfTheGamePlayerPortrait, 0.0410000, 5, 100.0000000, 0.7500000, 1, false);
            Animate(m_mcResultPlayOfTheGamePlayerPortrait, 0.0410000, 6, 100.0000000, 0.7500000, 1, false);
            Animate(m_mcResultPlayOfTheGamePlayerPortrait, 0.2080000, 1, 150.0000000, 0.3750000, 1, false);
            Animate(m_mcResultPlayOfTheGamePlayerPortrait, 0.1250000, 1, 180.0000000, 0.5830000, 1, false);
            Animate(m_mcResultPlayOfTheGamePlayerPortrait, 0.0410000, 1, 175.0000000, 0.7500000, 1, false);
            Animate(m_mcResultPlayOfTheGamePlayerPortrait, 0.2080000, 2, 100.0000000, 0.3750000, 1, false);
            CancelAnim(m_mcResultPlayOfTheGamePlayerNameGroup);
            m_mcResultPlayOfTheGamePlayerNameGroup.SetX(-650.0000000);
            m_mcResultPlayOfTheGamePlayerNameGroup.SetAlpha(0.0000000);
            Animate(m_mcResultPlayOfTheGamePlayerNameGroup, 0.2500000, 0, 1295.0000000, 0.0000000, 1, false);
            Animate(m_mcResultPlayOfTheGamePlayerNameGroup, 0.1250000, 0, 1200.0000000, 0.2500000, 1, false);
            Animate(m_mcResultPlayOfTheGamePlayerNameGroup, 0.0410000, 0, 1205.0000000, 0.3750000, 1, false);
            Animate(m_mcResultPlayOfTheGamePlayerNameGroup, 0.4160000, 2, 100.0000000, 0.0000000, 1, false);
            CancelAnim(m_mcResultPlayOfTheGamePlayerTitle);
            m_mcResultPlayOfTheGamePlayerTitle.SetX(-450.0000000);
            m_mcResultPlayOfTheGamePlayerTitle.SetAlpha(0.0000000);
            Animate(m_mcResultPlayOfTheGamePlayerTitle, 0.4580000, 0, 560.0000000, 0.0000000, 1, false);
            Animate(m_mcResultPlayOfTheGamePlayerTitle, 0.1250000, 0, 480.0000000, 0.4580000, 1, false);
            Animate(m_mcResultPlayOfTheGamePlayerTitle, 0.4580000, 2, 77.0000000, 0.0000000, 1, false);
            Animate(m_mcResultPlayOfTheGamePlayerTitle, 0.1250000, 2, 100.0000000, 0.4580000, 1, false);
            CancelAnim(m_mcResultPlayOfTheGameText);
            m_mcResultPlayOfTheGameText.SetAlpha(0.0000000);
            Animate(m_mcResultPlayOfTheGameText, 0.4160000, 2, 82.0000000, 0.2080000, 1, false);
            Animate(m_mcResultPlayOfTheGameText, 0.3330000, 2, 63.0000000, 0.6250000, 1, false);
            CancelAnim(m_mcResultPlayOfTheGameChampionNameGroup);
            m_mcResultPlayOfTheGameChampionNameGroup.SetX(1331.0000000);
            m_mcResultPlayOfTheGameChampionNameGroup.SetAlpha(0.0000000);
            Animate(m_mcResultPlayOfTheGameChampionNameGroup, 0.1250000, 0, 1050.0000000, 0.6660000, 1, false);
            Animate(m_mcResultPlayOfTheGameChampionNameGroup, 0.0830000, 0, 1065.0000000, 0.7910000, 1, false);
            Animate(m_mcResultPlayOfTheGameChampionNameGroup, 0.1250000, 2, 75.0000000, 0.6660000, 1, false);
            Animate(m_mcResultPlayOfTheGameChampionNameGroup, 0.0830000, 2, 100.0000000, 0.7910000, 1, false);
            CancelAnim(m_mcResultPlayOfTheGameBackground);
            m_mcResultPlayOfTheGameBackground.SetYScale(150.0000000);
            m_mcResultPlayOfTheGameBackground.SetAlpha(0.0000000);
            Animate(m_mcResultPlayOfTheGameBackground, 0.1660000, 6, 98.0000000, 0.5000000, 1, false);
            Animate(m_mcResultPlayOfTheGameBackground, 0.1250000, 6, 100.0000000, 0.6660000, 1, false);
            Animate(m_mcResultPlayOfTheGameBackground, 0.1660000, 2, 100.0000000, 0.5000000, 1, false);
            return;
        // End:0x7F5
        case 4:
            CancelAnim(m_mcResultPlayOfTheGame);
            Animate(m_mcResultPlayOfTheGame, 0.2500000, 0, m_mcResultPlayOfTheGame.GetX() - (m_mcResultPlayOfTheGame.GetWidth() * 2.0000000), 0.0000000, 1, false);
            Animate(m_mcResultPlayOfTheGame, 0.2500000, 5, 150.0000000, 0.0000000, 1, false);
            Animate(m_mcResultPlayOfTheGame, 0.2500000, 6, 75.0000000, 0.0000000, 1, false);
            Animate(m_mcResultPlayOfTheGame, 0.2500000, 2, 0.0000000, 0.0000000, 1, false);
            return;
        // End:0xFFFF
        default:
            //return;
            break;
    }    
}

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