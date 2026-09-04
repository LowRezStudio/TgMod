class UIDataLeague extends UIData
    native(UIData)
    config(Engine);

var dword dwLeagueId;
var dword dwSeason;
var dword dwRound;
var dword dwPlayerCount;
var DateTimeWrapper dtSeasonEnd;
var DateTimeWrapper dtRoundEnd;
var init array<init UIDataLeagueTier> m_TierArray;
var init array<init UIDataLeaguePlayer> m_PlayerArray;
