class TgRewardCenterManager extends Object
    native;

enum QuestType
{
    EQT_Daily,                      // 0
    EQT_Collection,                 // 1
    EQT_Special,                    // 2
    EQT_Training,                   // 3
    EQT_ItemQuest,                  // 4
    EQT_MAX                         // 5
};

enum QuestRewardDisplayType
{
    EQRDT_None,                     // 0
    EQRDT_Crystals,                 // 1
    EQRDT_Essence,                  // 2
    EQRDT_Gold,                     // 3
    EQRDT_Chest,                    // 4
    EQRDT_Card,                     // 5
    EQRDT_Item,                     // 6
    EQRDT_Texture,                  // 7
    EQRDT_MAX                       // 8
};

struct native GoalRewardItem
{
    var int nItemId;
    var int nQuantity;
    var bool bRental;

    structdefaultproperties
    {
        nItemId=0
        nQuantity=0
        bRental=false
    }
};

struct native ActivityGoal
{
    var int nTargetValue;
    var int nProgressValue;
    var init string sDescription;
    var init string sName;
    var bool bClaimed;
    var int nGoalId;
    var init array<init GoalRewardItem> pLootItems;

    structdefaultproperties
    {
        nTargetValue=0
        nProgressValue=0
        sDescription=""
        sName=""
        bClaimed=false
        nGoalId=0
        pLootItems=none
    }
};

struct native PlayerPartyBonus
{
    var int nPlayerCount;
    var float fWorshipperBonus;
    var float fXpBonus;
    var float fFavorBonus;

    structdefaultproperties
    {
        nPlayerCount=0
        fWorshipperBonus=0.0000000
        fXpBonus=0.0000000
        fFavorBonus=0.0000000
    }
};

struct native SeasonTicketGameData
{
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

    structdefaultproperties
    {
        nGameMatchId=0
        sTeamName1=""
        sTeamName2=""
        sTeamAbbr1=""
        sTeamAbbr2=""
        sTeamImage1=""
        sTeamImage2=""
        sDesc=""
        nTeamId1=0
        nTeamId2=0
        sExternalLink=""
        nSelectedTeam=0
        nWinningTeam=0
        nStartTime=0
        nEventId=0
        nEventType=0
        nGroupId=0
        nRoundType=0
        nRoundTypeSortOrder=0
        sRoundName=""
        nDisplayGrouping=0
        sDisplayGroupingName=""
        nMatchCount=0
        nTeam1Wins=0
        nTeam2Wins=0
        nTeamMatchWinCount1=0
        nTeamMatchWinCount2=0
        nTeamMatchLossCount1=0
        nTeamMatchLossCount2=0
        NSTG_StartingWeek=0
        NSTG_StartYear=0
        NSTG_StartMonth=0
        NSTG_StartDate=0
        NSTG_StartHour=0
        NSTG_StartMin=0
        NSTG_StartDayOfWeek=0
        bFeatured=false
        bMatchOver=false
    }
};

struct native SeasonTicketTeamData
{
    var int nTeamId;
    var int nEventTeamId;
    var init string sName;
    var int nSeedNumber;

    structdefaultproperties
    {
        nTeamId=0
        nEventTeamId=0
        sName=""
        nSeedNumber=0
    }
};

struct native SeasonTicketEventData
{
    var int nEventId;
    var int nStartTime;
    var int nNewCount;
    var init string sName;
    var int nEventType;
    var int nMaxPicks;
    var init array<init int> m_PickedTeams;
    var init array<init SeasonTicketTeamData> m_TeamData;

    structdefaultproperties
    {
        nEventId=0
        nStartTime=0
        nNewCount=0
        sName=""
        nEventType=0
        nMaxPicks=0
        m_PickedTeams=none
        m_TeamData=none
    }
};

struct native QuestData
{
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

    structdefaultproperties
    {
        nQuestId=0
        nActivityId=0
        nGoalId=0
        nLootTableId=0
        nReceivedTime=0
        nNameId=0
        nDescId=0
        nCompletionGoal=0
        nCurrentProgress=0
        nIconIndex=0
        nQuestType=0
        nEndTime=0
        nProgressEarned=0
        nDisplayOrder=0
        bCanAbandon=false
        bSkipped=false
        bSeen=false
        bNew=false
        pLootItems=none
    }
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

// Export UTgRewardCenterManager::execInitialize(FFrame&, void* const)
native function Initialize(UIGameMoviePlayer pMoviePlayer);

defaultproperties
{
    m_bRewardClaimedToday=true
    m_nConsecutiveRewardDays=-1
    m_nLengthOfDay=86400
}