class UIScene_UILeaderboard extends UIScene
    native(UIComponent)
    config(Engine);

var bool m_bPendingLoad;
var UIDataChampion m_CurrentLeaderboard;
var UIComponent_List m_ChampionLeaderboard;
var UIComponent_List m_PlayerLeaderboard;
var UIComponent_Dropdown m_LeagueDropdown;
var UIComponent_RankedProgress m_RankedProgress;
var GFxObject m_mcHeader;
var GFxObject m_mcRankIcon;
