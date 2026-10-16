class UIComponent_MatchPlayerEntry extends UIComponent
    native(UIList)
    config(Engine);

const UICOMPONENT_MATCHPLAYERENTRY_BUILD_STATCOUNT = 2;

const UICOMPONENT_MATCHPLAYERENTRY_DETAILS_STATCOUNT = 7;

const UICOMPONENT_MATCHPLAYERENTRY_BUILD_CARDCOUNT = 5;

const UICOMPONENT_MATCHPLAYERENTRY_BUILD_ITEMCOUNT = 4;

var GFxObject m_mcEndCap;
var GFxObject m_mcIcon;
var GFxObject m_mcName;
var GFxObject m_mcTitle;
var GFxObject m_mcBuild;
var GFxObject m_mcBuild_Stat[2];
var GFxObject m_mcBuild_Talent;
var GFxObject m_mcBuild_TalentIcon;
var UIComponent_ItemMini m_Cards[5];
var UIComponent_Interactable m_CardButtons[5];
var UIComponent_ItemMini m_Items[4];
var UIComponent_Interactable m_ItemButtons[4];
var GFxObject m_mcStatsDetails;
var GFxObject m_mcStatsDetails_Stat[7];
var UIComponent_Interactable m_TalentButton;
var UIComponent_Interactable m_FrameButton;
var UIComponent_Interactable m_ReportButton;
var UIComponent_Interactable m_ImportButton;
var UIComponent_Interactable m_AddButton;
var UIComponent_ItemTooltip m_pTooltip;
var UIData_PlayerMatchRecord m_pPlayerData;
var bool m_bCanReport;
