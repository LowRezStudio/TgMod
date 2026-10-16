class UIDataLeague extends UIData
    native(UIData);

var dword dwLeagueId;
var dword dwSeason;
var dword dwRound;
var dword dwPlayerCount;
var DateTimeWrapper dtSeasonEnd;
var DateTimeWrapper dtRoundEnd;
var init array<init UIDataLeagueTier> m_TierArray;
var native map{VOID,VOID} m_Tiers;
var init array<init UIDataLeaguePlayer> m_PlayerArray;
var native map{VOID,VOID} m_Players;
