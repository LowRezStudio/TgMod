class UIEndOfMatchLobby extends TgGfxScene within GFxMoviePlayer
    native(GFxScene);

const UIEOM_TABS = 4;
const UIEOM_STATS = 10;
const UIEOM_VALUES = 4;
const UIEOM_PLAYERS = 5;
const UIEOM_BUTTONS = 3;
const UIEOM_REPORTS = 4;
const UIEOM_ACCOLADES = 5;
const UIEOM_MVPCOUNT = 4;
const UIEOM_GOLDBOOSTS = 2;
const UIEOM_XPBOOSTS = 3;
const QUEST_PANEL_WIDTH = 357;
const QUEST_PANEL_GAP = 20;
const UIEOM_NUMREWARDPANELS = 2;
const UIEOM_REWARDPANEL_NUMFIELDS = 7;
const UIEOM_NUMSEGMENTS_BREAKDOWNBAR = 4;
const UIEOM_REWARDPANEL_WIDGETPADDING = 0;

enum UIEOM_REWARDFIELDQUALITY
{
    UIRFQ_NONE,                     // 0
    UIRFQ_BLUE,                     // 1
    UIRFQ_YELLOW,                   // 2
    UIRFQ_GREEN,                    // 3
    UIRFQ_GREY,                     // 4
    UIRFQ_MAX                       // 5
};

enum UIEOM_REWARDBOOSTICON
{
    UIRBI_NONE,                     // 0
    UIRBI_PARTYOFF,                 // 1
    UIRBI_PARTYON,                  // 2
    UIRBI_ACCOUNTOFF,               // 3
    UIRBI_ACCOUNTON,                // 4
    UIRBI_NETCAFE1,                 // 5
    UIRBI_NETCAFE2,                 // 6
    UIRBI_NETCAFE3,                 // 7
    UIRBI_FWOTD1,                   // 8
    UIRBI_FWOTD2,                   // 9
    UIRBI_FWOTD3,                   // 10
    UIRBI_MAX                       // 11
};

enum UIEOM_PANELINDICES
{
    UIEOM_GOLD,                     // 0
    UIEOM_XP,                       // 1
    UIEOM_MAX                       // 2
};

enum UIEOM_GOLDREWARDINDICES
{
    UIGLD_PERFORMANCE,              // 0
    UIGLD_VICTORY,                  // 1
    UIGLD_FWOTD,                    // 2
    UIGLD_ACCOLADES,                // 3
    UIGLD_TEAMBONUS,                // 4
    UIGLD_ACCOUNTBOOST,             // 5
    UIGLD_NETCAFEBOOST,             // 6
    UIGLD_MAX                       // 7
};

enum UIEOM_XPREWARDINDICES
{
    UIXP_PERFORMANCE,               // 0
    UIXP_VICTORY,                   // 1
    UIXP_TEAMBONUS,                 // 2
    UIXP_ACCOUNTBOOST,              // 3
    UIXP_NETCAFEBOOST,              // 4
    UIXP_MAX                        // 5
};

struct native RewardPanelBarSegment
{
    var GFxObject SegFrame;
    var GFxObject SegTF;
    var GFxObject SegBar;

    structdefaultproperties
    {
        SegFrame=none
        SegTF=none
        SegBar=none
    }
};

struct native RewardPanelField
{
    var GFxObject FieldFrame;
    var GFxObject FieldTitle;
    var GFxObject FieldValue;
    var GFxObject FieldIcon;
    var GFxObject FieldMultiplier;

    structdefaultproperties
    {
        FieldFrame=none
        FieldTitle=none
        FieldValue=none
        FieldIcon=none
        FieldMultiplier=none
    }
};

struct native RewardPanel
{
    var GFxObject PanelFrame;
    var GFxObject PanelTitle;
    var GFxObject PanelValueFieldFrame;
    var GFxObject PanelSummary;
    var GFxObject PanelBreakdownBar;
    var GFxObject PanelBreakdownBarTop;
    var GFxObject PanelBreakdownBarBG;
    var GFxObject PanelXPIcon;
    var GFxObject PanelGoldIcon;
    var GFxObject PanelSummaryTF;
    var array<RewardPanelField> PanelValueFields;
    var array<RewardPanelBarSegment> PanelBarSegments;

    structdefaultproperties
    {
        PanelFrame=none
        PanelTitle=none
        PanelValueFieldFrame=none
        PanelSummary=none
        PanelBreakdownBar=none
        PanelBreakdownBarTop=none
        PanelBreakdownBarBG=none
        PanelXPIcon=none
        PanelGoldIcon=none
        PanelSummaryTF=none
        PanelValueFields=none
        PanelBarSegments=none
    }
};

var int m_nLevel;
var int m_nMastery;
var int m_nAccoladeIndex;
var int m_nWIPMapQueueIndex;
var int m_nVipBoostLevel;
var int m_nHoursUntilCapReset;
var int m_nMinutesUntilCapReset;
var bool m_bAnimBack;
var bool m_bWasAccountBoosted;
var bool m_bWasPartyBoosted;
var bool m_bReachedGoldCap;
var bool m_bJustReachedGoldCap;
var bool m_bEndedGoldTick;
var bool m_bEndedXPTick;
var bool m_bShowingQuestPanel;
var float m_fMVPDuration;
var float m_fAnimation;
var float m_fXPDuration;
var float m_fGoldDuration;
var float m_fLevelDuration;
var float m_fMasteryDuration;
var float m_fShowFeedbackDelay;
var float m_fAccoladeTimer;
var float m_fShowFeedbackTimer;
var GFxObject m_mcHeader;
var GFxObject m_mcHeaderTitle;
var GFxObject m_mcHeaderSubtitle;
var GFxObject m_mcButtonPlay;
var GFxObject m_mcButtonHome;
var TgGFxGroup m_grButtons;
var GFxObject m_mcTabButtons[4];
var GFxObject m_mcMVPs;
var GFxObject m_mcRewards;
var GFxObject m_mcMVP[4];
var GFxObject m_mcMVPIcon[4];
var GFxObject m_mcMVPName[4];
var GFxObject m_mcMVPFrame[4];
var GFxObject m_mcMVPTitle[4];
var GFxObject m_mcMVPSubtitle[4];
var GFxObject m_mcMVPEquipableTitle[4];
var GFxObject m_mcAccolade[5];
var GFxObject m_mcAccoladeIcon[5];
var GFxObject m_mcAccoladeTitle[5];
var GFxObject m_mcAccoladeValue[5];
var string m_sRewardPanelNames[2];
var RewardPanel m_GoldRewardPanel;
var RewardPanel m_XPRewardPanel;
var GFxObject m_mcGoldMaxGold;
var UIEndOfMatchLobby.UIEOM_REWARDFIELDQUALITY m_eGoldPanelFieldQualities[7];
var UIEndOfMatchLobby.UIEOM_REWARDBOOSTICON m_eGoldPanelFieldIcons[7];
var UIEndOfMatchLobby.UIEOM_REWARDFIELDQUALITY m_eXPPanelFieldQualities[7];
var UIEndOfMatchLobby.UIEOM_REWARDBOOSTICON m_eXPPanelFieldIcons[7];
var string m_sGoldPanelFieldNames[7];
var string m_sXPPanelFieldNames[7];
var int m_nCurrentTab;
var float m_fTabSwitchTimestamp;
var float m_fOnFirstRewardTabTimestamp;
var int m_nGoldTotal;
var int m_nXPTotal;
var GFxObject m_mcLevel;
var GFxObject m_mcLevelUp;
var GFxObject m_mcLevelTitle;
var GFxObject m_mcLevelValue;
var GFxObject m_mcLevelFrame;
var GFxObject m_mcLevelFrameRewardLegend;
var GFxObject m_mcLevelFrameRewardLegendTitle;
var GFxObject m_mcLevelFrameRewardLegendEarned;
var GFxObject m_mcLevelFrameRewardLegendUnearned;
var GFxObject m_mcLevelReward;
var GFxObject m_mcLevelRewardTF;
var GFxObject m_mcLevelProgress;
var GFxObject m_mcLevelIncrease;
var GFxObject m_mcLevelIncreaseEarnedBoost;
var GFxObject m_mcLevelIncreaseUnearnedBoost;
var GFxObject m_mcLevelSubtitle;
var GFxObject m_mcLevelNeeded;
var GFxObject m_mcMastery;
var GFxObject m_mcMasteryUp;
var GFxObject m_mcMasteryTitle;
var GFxObject m_mcMasteryValue;
var GFxObject m_mcMasteryFrame;
var GFxObject m_mcMasteryFrameRewardLegend;
var GFxObject m_mcMasteryFrameRewardLegendTitle;
var GFxObject m_mcMasteryFrameRewardLegendEarned;
var GFxObject m_mcMasteryFrameRewardLegendUnearned;
var GFxObject m_mcMasteryRewardEquippableTitle;
var GFxObject m_mcMasteryRewardEquippableTitleTF;
var GFxObject m_mcMasteryReward;
var GFxObject m_mcMasteryRewardTF;
var GFxObject m_mcMasteryRewardIcon;
var GFxObject m_mcMasteryRewardItem;
var GFxObject m_mcMasteryProgress;
var GFxObject m_mcMasteryIncrease;
var GFxObject m_mcMasteryIncreaseEarnedBoost;
var GFxObject m_mcMasteryIncreaseUnearnedBoost;
var GFxObject m_mcMasterySubtitle;
var GFxObject m_mcMasteryNeeded;
var GFxObject m_mcReport;
var GFxObject m_mcReportClose;
var GFxObject m_mcReportInput;
var GFxObject m_mcReportTitle;
var GFxObject m_mcReportButton[4];
var GFxObject m_mcReportBlocker;
var GFxObject m_mcReportSubtitle;
var GFxObject m_mcQuestPanels;
var GFxObject m_mcClaimQuestButton;
var GFxObject m_mcPanels[10];
var GFxObject m_mcFlash01[10];
var GFxObject m_mcFlash02[10];
var GFxObject m_mcFlash03[10];
var GFxObject m_mcQuestPanelButton[10];
var GFxObject m_mcQuestPanelButtonTitle[10];
var GFxObject m_mcQuestPanelButtonType[10];
var GFxObject m_mcQuestPanelButtonProgressText[10];
var GFxObject m_mcQuestPanelButtonQuestDescription[10];
var GFxObject m_mcQuestPanelButtonRewardLabelTF[10];
var GFxObject m_mcQuestPanelButtonCurrency[10];
var GFxObject m_mcQuestPanelButtonMaxGold[10];
var GFxObject m_mcQuestPanelButtonRewardAmountTF[10];
var GFxObject m_mcQuestPanelButtonQuestIconRendered[10];
var GFxObject m_mcQuestPanelButtonChestIcon[10];
var GFxObject m_mcQuestPanelButtonRewardItem[10];
var GFxObject m_mcQuestPanelButtonRewardItemIcon[10];
var GFxObject m_mcQuestPanelButtonRewardItemImageStack[10];
var GFxObject m_mcQuestPanelButtonRewardItemTexture[10];
var TgGFxGroup m_grQuestPanels;
var int m_nQuestIndices[10];
var SoundCue m_scTick;
var SoundCue m_scTickEnd;
var AkBaseSoundObject m_akLevelUp;
var AkBaseSoundObject m_akAccolade;
var AkBaseSoundObject m_akMasteryUp;
var int m_nPlayerToReport;

defaultproperties
{
    m_fMVPDuration=10.0000000
    m_fXPDuration=1.0000000
    m_fGoldDuration=1.0000000
    m_fLevelDuration=2.0000000
    m_fMasteryDuration=2.0000000
    m_fShowFeedbackDelay=1.0000000
    m_sRewardPanelNames[0]="Gold"
    m_sRewardPanelNames[1]="XP"
    m_eGoldPanelFieldIcons[2]=UIEOM_REWARDBOOSTICON.UIRBI_FWOTD1
    m_eGoldPanelFieldIcons[4]=UIEOM_REWARDBOOSTICON.UIRBI_PARTYOFF
    m_eGoldPanelFieldIcons[5]=UIEOM_REWARDBOOSTICON.UIRBI_ACCOUNTOFF
    m_eGoldPanelFieldIcons[6]=UIEOM_REWARDBOOSTICON.UIRBI_NETCAFE1
    m_eXPPanelFieldIcons[2]=UIEOM_REWARDBOOSTICON.UIRBI_PARTYOFF
    m_eXPPanelFieldIcons[3]=UIEOM_REWARDBOOSTICON.UIRBI_ACCOUNTOFF
    m_eXPPanelFieldIcons[4]=UIEOM_REWARDBOOSTICON.UIRBI_NETCAFE1
    m_sGoldPanelFieldNames[0]="m_lsRewardPerformance"
    m_sGoldPanelFieldNames[1]="m_lsRewardVictory"
    m_sGoldPanelFieldNames[2]="m_lsRewardFWOTD"
    m_sGoldPanelFieldNames[3]="m_lsRewardAccolades"
    m_sGoldPanelFieldNames[4]="m_lsRewardTeamBonus"
    m_sGoldPanelFieldNames[5]="m_lsRewardAccountBoost"
    m_sGoldPanelFieldNames[6]="m_lsRewardNetCafeBonus"
    m_sXPPanelFieldNames[0]="m_lsRewardPerformance"
    m_sXPPanelFieldNames[1]="m_lsRewardVictory"
    m_sXPPanelFieldNames[2]="m_lsRewardTeamBonus"
    m_sXPPanelFieldNames[3]="m_lsRewardAccountBoost"
    m_sXPPanelFieldNames[4]="m_lsRewardNetCafeBonus"
    m_scTick=SoundCue'AUD_UI_Notifications.A_CUE_UI_Notification_XPTick_Loop'
    m_scTickEnd=SoundCue'AUD_UI_Notifications.A_CUE_UI_Notification_XPTick_End'
    m_akLevelUp=AkEvent'WW_UI_Default.UI_Lobby_Alert_LevelUp_AccountMastery_Play'
    m_akAccolade=AkEvent'WW_UI_Default.UI_Menu_CardCraft_Finish_Play'
    m_akMasteryUp=AkEvent'WW_UI_Default.UI_Lobby_Alert_LevelUp_CharacterMastery_Play'
    m_nPlayerToReport=-1
    m_UISceneClass=Class'TgClient.UIScene_UIEndOfMatchLobby'
    m_OptionList[0]=9
    m_OptionList[1]=4
    m_OptionList[2]=0
    m_bBlur=true
    m_Name="UIEndOfMatchLobby"
}