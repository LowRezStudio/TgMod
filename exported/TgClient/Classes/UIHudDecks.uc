class UIHudDecks extends TgGfxScene within GFxMoviePlayer
    native(GFxScene);

const UIHUDDECKS_COUNT = 6;
const UIHUDDECKS_CARDS = 5;
const UIHUDTALENTS_COUNT = 3;

var bool m_bPresentCharacterCustomizationWhenReady;
var bool m_bPopup;
var int m_nTalent;
var int m_nLoadout;
var GFxObject m_mcPopup;
var GFxObject m_mcPopupEquip;
var GFxObject m_mcPopupTitle;
var GFxObject m_mcPopupCard[5];
var GFxObject m_mcPopupShadow[5];
var TgGFxGroup m_grLoadout;
var GFxObject m_mcLoadoutContainer;
var GFxObject m_mcLoadout[6];
var GFxObject m_mcLoadoutTitle[6];
var GFxObject m_mcBack;
var GFxObject m_mcBreadcrumbs[3];
var GFxObject m_mcBreadcrumbLines[2];
var GFxObject m_mcTitle;
var GFxObject m_mcSubtitle;
var AkBaseSoundObject m_akEquip;

defaultproperties
{
    m_akEquip=AkEvent'WW_UI_Default.UI_Lobby_MatchSetUp_LockIn_Self_Play'
    m_UISceneClass=Class'TgClient.UIScene_UIHudDecks'
    m_OptionList[0]=249
    m_bBlur=true
    m_Name="UIHudDecks"
}