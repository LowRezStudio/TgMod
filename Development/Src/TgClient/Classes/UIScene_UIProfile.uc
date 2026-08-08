class UIScene_UIProfile extends UIScene
    native(UIComponent)
    config(Engine);

const UISCENE_UIPROFILE_MATCHSTATSPOPUP_TABS = 2;

var UIComponent_Interactable m_pBack;
var UIComponent_HeaderTabs m_pTabs;
var UIComponent_Popup m_MatchStatsPopup;
var GFxObject m_mcMatchStatsTabSelected[2];
var GFxObject m_mcOverview;
var TgGFxGroup m_grOverview;
var UIComponent_LevelProgress m_OverviewLevelProgress;
var GFxObject m_mcOverviewRankedIcon;
var GFxObject m_mcOverviewRankedSeason;
var GFxObject m_mcOverviewRankedRound;
var GFxObject m_mcOverviewRankedRoundRemaining;
var UIComponent_RankedProgress m_pOverviewRankedProgress;
var UIComponent_Interactable m_pOverviewRankedLeaderboardButton;
var UIComponent_List m_pOwnershipProgressList;
var UIComponent_Interactable m_pOverviewBoostButton;
var UIComponent_List m_ChampionList;
