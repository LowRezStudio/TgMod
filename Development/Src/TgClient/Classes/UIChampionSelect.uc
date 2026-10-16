class UIChampionSelect extends TgGfxScene within GFxMoviePlayer
    native(GFxScene)
    config(Engine);

const UICHAMPIONSELECT_COUNT = 33;

struct UIChamionFoundersPackPanel {
    var GFxObject Obj;
    var GFxObject Title;
    var GFxObject SubTitle;
    var GFxObject BuyNow;
    var GFxObject Price;
    var GFxObject SaleBanner;
    structdefaultproperties {}
};

struct UICHAMP_CLIP {
    var GFxObject pObj;
    structdefaultproperties {}
};

var GFxObject m_mcBack;
var GFxObject m_mcTitle;
var GFxObject m_mcHeader;
var GFxObject m_mcChampions;
var GFxObject m_mcChampionBack;
var GFxObject m_mcChampionTitle;
var GFxObject m_mcChampionScrollBar;
var GFxObject m_mcChampionSubtitle;
var GFxObject m_mcChampionClassIcon;
var TgGFxGroup m_grChampions;
var TgGFxGroup m_grpFounderPack;
var array<UICHAMP_CLIP> m_ChampionClips;
var int m_nChampionScroll;
var float m_fChampWidth;
var float m_fChampHeight;
var string m_sCurrencyCode;
var string m_sFoundersPackTitle;
var string m_sFoundersPackSubtitle;
var UIChamionFoundersPackPanel m_FoundersPack;
var bool m_bShowFounderAdd;

defaultproperties
{
    m_OptionList[0]=14
    m_OptionList[1]=4
    m_nBackground=1
    m_bBlur=true
    m_bAllowMultipleOnStack=false
    m_Name="UIChampionSelect"
}
