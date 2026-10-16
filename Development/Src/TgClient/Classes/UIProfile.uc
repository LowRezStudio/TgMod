class UIProfile extends TgGfxScene within GFxMoviePlayer
    native(GFxScene)
    config(Engine);

const UIPROFILE_AWARD_ENTRIES = 8;

const UIPROFILE_AWARD_ROWS = 4;

const UIPROFILE_AWARD_COLS = 2;

const UIPROFILE_AWARD_GOALS = 10;

const UIPROFILE_COLLECTIONS = 4;

const UIPROFILE_HEADER_COUNT = 6;

const UIPROFILE_PLAYER_COUNT = 5;

const UIPROFILE_HISTORY_DATA = 7;

const UIPROFILE_HISTORY_ROWS = 8;

const UIPROFILE_CHAMPION_DATA = 5;

const UIPROFILE_CHAMPION_ROWS = 8;

const UIPROFILE_DETAILS_COUNT = 12;

const UIPROFILE_ACCOUNTBOOSTTOOLTIP_COUNT = 4;

const UIPROFILE_ANNOUNCERPACK_SLOT_COUNT = 10;

const UIPROFILE_ANNOUNCERPACK_SLOTS_PER_ROW = 2;

const UIPROFILE_ANNOUNCERPACK_CONSOLE_PROMPT_COUNT = 2;

enum PROFILESTATE {
    EPS_OVERVIEW,  // 0
    EPS_CHAMPIONS,  // 1
    EPS_TITLES,  // 2
    EPS_ANNOUNCERPACKS,  // 3
    EPS_AWARDS,  // 4
    EPS_HISTORY,  // 5
};

enum EHistoryResult {
    EHR_WIN,  // 0
    EHR_LOSS,  // 1
    EHR_LEFT,  // 2
};

struct UIGoalData {
    var int nDate;
    var int nGoal;
    var int nValue;
    var int nProgress;
    var int nDisplayId;
    var int nGoalProgress;
    var bool bCompleted;
    var init string sDate;
    var init string sDesc;
    var init string sTier;
    var init string sTitle;
    var init string sSource;
    structdefaultproperties {}
};

struct UIAwardData {
    var int nType;
    var int nActivity;
    var int nGoalCount;
    var int nGoalGroup;
    var UIGoalData Goals[10];
    structdefaultproperties {}
};

struct UIHistoryData {
    var int nId;
    var int nClass;
    var init string sDate;
    var init string sMode;
    var init string sScore;
    var UIProfile.EHistoryResult eResult;
    var init string sDuration;
    var DateTimeWrapper dtEvent;
    structdefaultproperties {}
};

var int m_nPlayer;
var int m_nAwardScrollIndex;
var int m_nHistoryScrollIndex;
var int m_nChampionScrollIndex;
var int m_nAwardTotal;
var int m_nAwardCurrent;
var int m_nSelectedVoicePackCurrent;
var bool m_bScrollAwards;
var bool m_bScrollHistory;
var bool m_bScrollChampions;
var bool m_bLoadedActivities;
var bool m_bAnnouncerPackGamepadAware;
var UIProfile.PROFILESTATE m_eState;
var array<UIAwardData> m_AwardData;
var array<UIHistoryData> m_Matches;
var GFxObject m_mcOverview;
var GFxObject m_mcOverviewTitle;
var GFxObject m_mcOverviewPlayerEquippedTitle;
var GFxObject m_mcOverviewSubtitle;
var GFxObject m_mcOverviewRatingTitle;
var GFxObject m_mcOverviewRatingDetails;
var GFxObject m_mcOverviewRatingSubtitle;
var GFxObject m_mcOverviewBonus;
var GFxObject m_mcOverviewBonusBonusIcon;
var GFxObject m_mcOverviewBonusBonusIconIcon;
var GFxObject m_mcOverviewBonusBonusIconFrame;
var GFxObject m_mcOverviewBonusTitle;
var GFxObject m_mcOverviewBonusBoostActive;
var GFxObject m_mcOverviewBonusEntry[4];
var TgGFxGroup m_grOverview;
var UIComponent_TitlesView m_pTitlesView;
var GFxObject m_mcAwards;
var GFxObject m_mcAwardScroll;
var GFxObject m_mcAwardTotalProgress;
var GFxObject m_mcAwardTotalProgressTip;
var GFxObject m_mcAwardTotalProgressFill;
var GFxObject m_mcAwardTotalProgressTitle;
var GFxObject m_mcAwardTotalProgressSubtitle;
var GFxObject m_mcAwardRow[8];
var GFxObject m_mcAwardDate[8];
var GFxObject m_mcAwardIcon[8];
var GFxObject m_mcAwardTitle[8];
var GFxObject m_mcAwardFrame[8];
var GFxObject m_mcAwardPoints[8];
var GFxObject m_mcAwardSubtitle[8];
var GFxObject m_mcAwardHighlight[8];
var GFxObject m_mcAwardProgressFill[8];
var GFxObject m_mcAwardProgressText[8];
var TgGFxGroup m_grAward;
var GFxObject m_mcHistory;
var GFxObject m_mcHistoryScroll;
var GFxObject m_mcHistoryRow[8];
var GFxObject m_mcHistoryDate[8];
var GFxObject m_mcHistoryName[8];
var GFxObject m_mcHistoryType[8];
var GFxObject m_mcHistoryIcon[8];
var GFxObject m_mcHistoryMode[8];
var GFxObject m_mcHistoryFrame[8];
var GFxObject m_mcHistoryMatch[8];
var GFxObject m_mcHistoryScore[8];
var GFxObject m_mcHistoryResult[8];
var GFxObject m_mcHistoryDetails[8];
var GFxObject m_mcHistoryChampion[8];
var GFxObject m_mcHistoryDuration[8];
var TgGFxGroup m_grHistory;
var GFxObject m_mcChampions;
var GFxObject m_mcChampionScroll;
var GFxObject m_mcChampionRow[8];
var GFxObject m_mcChampionName[8];
var GFxObject m_mcChampionType[8];
var GFxObject m_mcChampionIcon[8];
var GFxObject m_mcChampionRank[8];
var GFxObject m_mcChampionFrame[8];
var GFxObject m_mcChampionScore[8];
var GFxObject m_mcChampionDetails[8];
var GFxObject m_mcChampionChampion[8];
var GFxObject m_mcChampionMastery[8];
var GFxObject m_mcChampionMasteryTip[8];
var GFxObject m_mcChampionMasteryFill[8];
var GFxObject m_mcChampionMasteryTitle[8];
var GFxObject m_mcChampionRankProgress[8];
var GFxObject m_mcChampionRankProgressTip[8];
var GFxObject m_mcChampionRankProgressFill[8];
var GFxObject m_mcChampionRankProgressTitle[8];
var GFxObject m_mcChampionRankProgressSubtitle[8];
var TgGFxGroup m_grChampion;
var GFxObject m_mcAnnouncerPacks;
var GFxObject m_mcAnnouncerPacksScroll;
var GFxObject m_mcAnnouncerPackHeader;
var GFxObject m_mcAnnouncerPackHeaderIconCon;
var GFxObject m_mcAnnouncerPackHeaderIcon;
var GFxObject m_mcAnnouncerPackHeaderLabel;
var GFxObject m_mcAnnouncerPackHeaderTitle;
var GFxObject m_mcAnnouncerPackHeaderRarityFrame;
var GFxObject m_mcAnnouncerPackSlot[10];
var GFxObject m_mcAnnouncerPackSlotTF[10];
var GFxObject m_mcAnnouncerPackSlotCostCrystalsCon[10];
var GFxObject m_mcAnnouncerPackSlotCostCrystalsTF[10];
var GFxObject m_mcAnnouncerPackSlotCostGoldCon[10];
var GFxObject m_mcAnnouncerPackSlotCostGoldTF[10];
var GFxObject m_mcAnnouncerPackSlotEquippedCon[10];
var GFxObject m_mcAnnouncerPackSlotLockIcon[10];
var GFxObject m_mcAnnouncerPackSlotAnnouncerIconCon[10];
var GFxObject m_mcAnnouncerPackSlotAnnouncerIcon[10];
var GFxObject m_mcAnnouncerPackSlotSelected[10];
var GFxObject m_mcAnnouncerPackSlotFrameButton[10];
var GFxObject m_mcAnnouncerPackSlotPlayButton[10];
var GFxObject m_mcAnnouncerPackSlotRarityFrame[10];
var TgGFxGroup m_grAnnouncerPacks;
var int m_nTitleToEquip;
var float m_fQueuedTitleEquipTimer;
var float m_fTitleEquipDelay;

defaultproperties
{
    m_fTitleEquipDelay=2.0000000
    m_UISceneClass=Class'UIScene_UIProfile'
    m_OptionList[0]=14
    m_OptionList[1]=4
    m_nBackground=1
    m_bResetHeaderFocusOnShow=false
    m_bAllowMultipleOnStack=false
    m_Name="UIProfile"
}
