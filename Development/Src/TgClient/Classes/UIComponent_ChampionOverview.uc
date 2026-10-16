class UIComponent_ChampionOverview extends UIComponent
    native(UIComponent)
    config(Engine);

const UICHAMPION_COLLECTS = 4;

const UICHAMPION_SKILLS = 5;

var GFxObject m_mcRating;
var GFxObject m_mcRatingProgress;
var GFxObject m_mcRatingProgressTip;
var GFxObject m_mcRatingProgressFill;
var GFxObject m_mcRatingRankSubtitle;
var GFxObject m_mcRatingAwardTitle;
var GFxObject m_mcRatingAwardSubtitle;
var GFxObject m_mcRatingNext;
var GFxObject m_mcRatingPrev;
var GFxObject m_mcRatingNextRank;
var GFxObject m_mcUnlock;
var GFxObject m_mcOverviewStats;
var GFxObject m_mcOverviewStatsProgress;
var GFxObject m_mcOverviewStatsExpSubtitle;
var GFxObject m_mcOverviewStatsWinsSubtitle;
var GFxObject m_mcOverviewStatsNextSubtitle;
var GFxObject m_mcOverviewStatsLevelSubtitle;
var GFxObject m_mcOverviewDetailsTitle;
var GFxObject m_mcOverviewDetailsSubtitle;
var GFxObject m_mcOverviewDetailsClassIcon;
var GFxObject m_mcOverviewChampionIcon;
var GFxObject m_mcOverviewChampionFrame;
var GFxObject m_mcOverviewSkill[5];
var GFxObject m_mcOverviewSkillIcon[5];
var GFxObject m_mcCollectionOverview;
var GFxObject m_mcOverviewCollection[4];
var GFxObject m_mcOverviewCollectionProgress[4];
var GFxObject m_mcOverviewCollectionOwnedTitle[4];
var GFxObject m_mcOverviewCollectionOwnedSubtitle[4];
var TgGFxGroup m_grUnlock;
var GFxObject m_mcRewardCurrency;
var GFxObject m_mcRewardFinePrint;
var GFxObject m_mcRewardName;
var GFxObject m_mcRentalText;
var GFxObject m_mcRentalTextLabel;
var GFxObject m_mcRentalTextDuration;
var GFxObject m_mcUnlockPanel;
var GFxObject m_mcUnlockPanelPurchase;
var GFxObject m_mcUnlockPanelPurchasePrice0;
var GFxObject m_mcUnlockPanelPurchasePrice0Currency;
var GFxObject m_mcUnlockPanelPurchasePrice1;
var GFxObject m_mcUnlockPanelPurchasePrice1Currency;
var GFxObject m_mcUnlockPanelRent;
var GFxObject m_mcUnlockPanelRentPrice0;
var GFxObject m_mcUnlockPanelRentPrice0Currency;
var GFxObject m_mcUnlockPanelFreeRotation;
var GFxObject m_mcUnlockPanelInputPrompt;
var GFxObject m_mcUnlockPanelUnlockButton;
var UIInteractable_Button_GamepadPrompt m_pLeaderboardButton;
var UIInteractable_Button_GamepadPrompt m_pDetailsButton;
var UIInteractable_Button_ChampUnlock m_pPurchaseButton;

defaultproperties
{
    m_sLoadName="Overview"
}
