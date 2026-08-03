class UIProfileMini extends TgGfxScene within GFxMoviePlayer
    native(GFxScene);

const MINIPROF_ACCOUNTBOOSTTOOLTIP_ENTRIES = 4;

var bool m_bSearching;
var bool m_bShowMinimize;
var float m_fRotation;
var GFxObject m_mcExit;
var GFxObject m_mcSpinner;
var GFxObject m_mcMinimize;
var GFxObject m_mcSearching;
var GFxObject m_mcSearchingTitle;
var GFxObject m_mcSearchingSubtitle;
var GFxObject m_mcParty;
var GFxObject m_mcPartyCount;
var GFxObject m_mcPartyIcon;
var GFxObject m_mcPartyFrame;
var GFxObject m_mcPlayer;
var GFxObject m_mcPlayerGold;
var GFxObject m_mcPlayerName;
var GFxObject m_mcPlayerLevel;
var GFxObject m_mcPlayerCrystals;
var GFxObject m_mcPlayerDust;
var GFxObject m_mcPlayerEquipableTitle;
var GFxObject m_mcBoostAccount;
var GFxObject m_mcBoostAccountIcon;
var GFxObject m_mcBoostAccountFrame;
var GFxObject m_mcBoostAccountTooltip;
var GFxObject m_mcBoostAccountTooltipTitle;
var GFxObject m_mcBoostAccountTooltipTimer;
var GFxObject m_mcBoostAccountTooltipEntry[4];
var GFxObject m_mcBoostParty;
var GFxObject m_mcBoostPartyIcon;
var GFxObject m_mcBoostPartyFrame;
var GFxObject m_mcBoostPartyTooltip;
var GFxObject m_mcBoostPartyTooltipTitle;
var GFxObject m_mcBoostPartyTooltipEntry0;
var GFxObject m_mcBoostPartyTooltipEntry1;
var GFxObject m_mcBoostPartyTooltipEntry2;
var GFxObject m_mcTencentNetcafeStatus;

defaultproperties
{
    m_eSnappingType=UISNAPPINGTYPE.UISNAPPING_TOP
    m_eAligningType=UIALIGNINGTYPE.UIALIGNING_RIGHT
    m_bAlwaysTick=true
    m_Name="UIProfileMini"
}