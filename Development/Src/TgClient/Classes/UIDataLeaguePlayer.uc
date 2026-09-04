class UIDataLeaguePlayer extends UIData
    native(UIData)
    config(Engine);

var UIDataPlayer pPlayer;
var UIDataLeague pLeague;
var UIDataLeagueTier pTier;
var UIDataLeagueTier pHighestTier;
var int nPointsEarned;
var int nPointsTrend;
var dword dwRank;
var dword dwRankPrev;
var dword dwWins;
var dword dwLosses;
var dword dwDodges;
var dword dwMatchesPlayedInTier;
var dword dwRegion;
var dword dwRecommendedTierId;
var dword dwTitleId;
var DateTimeWrapper dtLastPlayed;
