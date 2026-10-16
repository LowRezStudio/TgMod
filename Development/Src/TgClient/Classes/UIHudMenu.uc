class UIHudMenu extends TgGfxScene within GFxMoviePlayer
    native(GFxScene)
    config(Engine);

const UIHUDMENU_COUNT = 8;

enum HUDMENU_OPTIONS {
    UIHM_RETURNTOGAME,  // 0
    UIHM_EDITLOADOUT,  // 1
    UIHM_SETTINGS,  // 2
    UIHM_SCOREBOARD,  // 3
    UIHM_CHANGECHAMPION,  // 4
    UIHM_RETURNTOLOBBY,  // 5
    UIHM_QUITGAME,  // 6
};

var bool m_bTutorialPopup;
var GFxObject m_mcFrame;
var GFxObject m_mcTitle;
var GFxObject m_mcBlocker;
var GFxObject m_mcSubtitle;
var GFxObject m_mcButton[8];
var TgGFxGroup m_grButton;
var GFxObject m_mcTutorialPopup;
var GFxObject m_mcTutorialPopupTitle;
var GFxObject m_mcTutorialPopupAccept;
var GFxObject m_mcTutorialPopupCancel;
var GFxObject m_mcTutorialPopupBlocker;
var GFxObject m_mcTutorialPopupSubtitle;
var TgGFxGroup m_grTutorialPopup;
var array<int> m_eOptions;

defaultproperties
{
    m_OptionList[0]=249
    m_bBlur=true
    m_bAllowSpectatorClickThru=false
    m_Name="UIHudMenu"
}
