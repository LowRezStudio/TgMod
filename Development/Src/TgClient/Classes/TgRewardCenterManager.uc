class TgRewardCenterManager extends Object
    native
    config(Engine);

enum QuestType {
    EQT_Daily,  // 0
    EQT_Collection,  // 1
    EQT_Special,  // 2
    EQT_Training,  // 3
    EQT_ItemQuest,  // 4
};

enum QuestRewardDisplayType {
    EQRDT_None,  // 0
    EQRDT_Crystals,  // 1
    EQRDT_Essence,  // 2
    EQRDT_Gold,  // 3
    EQRDT_Chest,  // 4
    EQRDT_Card,  // 5
    EQRDT_Item,  // 6
    EQRDT_Texture,  // 7
};

struct GoalRewardItem {
    var int nItemId;
    var int nQuantity;
    var bool bRental;
    structdefaultproperties {}
};

struct ActivityGoal {
    var int nTargetValue;
    var int nProgressValue;
    var init string sDescription;
    var init string sName;
    var bool bClaimed;
    var int nGoalId;
    var init array<init GoalRewardItem> pLootItems;
    structdefaultproperties {}
};

struct PlayerPartyBonus {
    var int nPlayerCount;
    var float fWorshipperBonus;
    var float fXpBonus;
    var float fFavorBonus;
    structdefaultproperties {}
};

struct SeasonTicketGameData {
    var int nGameMatchId;
    var init string sTeamName1;
    var init string sTeamName2;
    var init string sTeamAbbr1;
    var init string sTeamAbbr2;
    var init string sTeamImage1;
    var init string sTeamImage2;
    var init string sDesc;
    var int nTeamId1;
    var int nTeamId2;
    var init string sExternalLink;
    var int nSelectedTeam;
    var int nWinningTeam;
    var int nStartTime;
    var int nEventId;
    var int nEventType;
    var int nGroupId;
    var int nRoundType;
    var int nRoundTypeSortOrder;
    var init string sRoundName;
    var int nDisplayGrouping;
    var init string sDisplayGroupingName;
    var int nMatchCount;
    var int nTeam1Wins;
    var int nTeam2Wins;
    var int nTeamMatchWinCount1;
    var int nTeamMatchWinCount2;
    var int nTeamMatchLossCount1;
    var int nTeamMatchLossCount2;
    var int NSTG_StartingWeek;
    var int NSTG_StartYear;
    var int NSTG_StartMonth;
    var int NSTG_StartDate;
    var int NSTG_StartHour;
    var int NSTG_StartMin;
    var int NSTG_StartDayOfWeek;
    var bool bFeatured;
    var bool bMatchOver;
    structdefaultproperties {}
};

struct SeasonTicketTeamData {
    var int nTeamId;
    var int nEventTeamId;
    var init string sName;
    var int nSeedNumber;
    structdefaultproperties {}
};

struct SeasonTicketEventData {
    var int nEventId;
    var int nStartTime;
    var int nNewCount;
    var init string sName;
    var int nEventType;
    var int nMaxPicks;
    var init array<init int> m_PickedTeams;
    var init array<init SeasonTicketTeamData> m_TeamData;
    structdefaultproperties {}
};

struct QuestData {
    var int nQuestId;
    var int nActivityId;
    var int nGoalId;
    var int nLootTableId;
    var int nReceivedTime;
    var int nNameId;
    var int nDescId;
    var int nCompletionGoal;
    var int nCurrentProgress;
    var int nIconIndex;
    var int nQuestType;
    var int nEndTime;
    var int nProgressEarned;
    var int nDisplayOrder;
    var bool bCanAbandon;
    var bool bSkipped;
    var bool bSeen;
    var bool bNew;
    var init array<init GoalRewardItem> pLootItems;
    structdefaultproperties {}
};

var UIGameMoviePlayer m_pMovie;
var bool m_bPlayerLoggedIn;
var bool m_bRewardClaimedToday;
var bool m_bDayHasRolledOver;
var bool m_bEsportsGameLive;
var bool m_bHasQuestProgress;
var bool m_bHasQuestActivities;
var bool m_bHasQuestRewards;
var bool m_bQuestsSeenToday;
var int m_nConsecutiveRewardDays;
var int m_nLengthOfDay;
var float m_fTimeTillNextDay;
var array<ActivityGoal> m_pLevelUpGoals;
var int m_nPlayerLevel;
var array<GoalRewardItem> m_pReturningBonus;
var int m_nPartyBonusStartTime;
var int m_nPartyBonusEndTime;
var array<PlayerPartyBonus> m_pPartyBonuses;
var array<SeasonTicketGameData> m_GameDatas;
var array<SeasonTicketEventData> m_EventData;
var float m_fNextESportsEventUpdate;
var int m_nESportsGamesStartingSoon;
var float m_fTimeTillNextWeek;
var array<QuestData> m_QuestList;
var array<QuestData> m_TrainingQuestList;
var array<QuestData> m_ProgressedQuestList;

native function Initialize(UIGameMoviePlayer pMoviePlayer);  // Export UTgRewardCenterManager::execInitialize(FFrame&, void* const)

defaultproperties
{
    m_bRewardClaimedToday=true
    m_nConsecutiveRewardDays=-1
    m_nLengthOfDay=86400
}
