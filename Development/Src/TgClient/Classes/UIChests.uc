class UIChests extends TgGfxScene within GFxMoviePlayer
    native(GFxScene)
    config(Engine);

const UICHESTS_MAX_BUNDLES = 4;

const UICHESTS_BOOSTCHEST = 3;

const UICHESTS_SKIP_LOCKOUT = 0.25f;

enum UIChestState {
    UICHESTS_NONE,  // 0
    UICHESTS_WAITINGFORSERVER,  // 1
    UICHESTS_WAITINGFORTIMEOUT,  // 2
    UICHESTS_OPENING,  // 3
    UICHESTS_OPENED,  // 4
    UICHESTS_GOLDCARDDELAY,  // 5
    UICHESTS_GOLDCARDSHOWN,  // 6
    UICHESTS_DONE,  // 7
};

struct UIChestData {
    var int nItemId;
    var int nVendorId;
    var int nSortOrder;
    var int nRolls;
    var int nBoostBonusRolls;
    var int nCachedOwnedChests;
    var int nBundleVendorId;
    var int nBundleCount;
    var int nBundleItemIds[4];
    var int nBundleItemCounts[4];
    structdefaultproperties {}
};

struct UIChestItem {
    var GFxObject mcItem;
    var GFxObject mcItemChampion;
    var GFxObject mcItemChampionIcon;
    var GFxObject mcItemIcon;
    var GFxObject mcItemCardIcon;
    var GFxObject mcItemGlow;
    var GFxObject mcItemAudio;
    var GFxObject mcItemTitle;
    var GFxObject mcItemRarity;
    var GFxObject mcItemRarityText;
    var GFxObject mcItemCurrency;
    var GFxObject mcItemSubtitle;
    var GFxObject mcItemDuplicateLabel;
    var GFxObject mcEquipButton;
    var GFxObject mcEquippedText;
    var GFxObject mcEquipPrompt;
    var GFxObject mcEquipPromptButton;
    var GFxObject mcInputFrame;
    var UIInteractable_Item Card;
    structdefaultproperties {}
};

var int m_nChestId;
var UIChests.UIChestState m_eState;
var float m_fStateTimer;
var bool m_bAutoLoot;
var bool m_bQueuedSkip;
var bool m_bShowingTreasureRoll;
var int m_nMissedItemId;
var int m_nMissedSecondaryItemId;
var array<int> m_nRolledItems;
var array<int> m_nRolledItemOverrides;
var float m_fOpeningTime;
var float m_fSprayPopupDelayTime;
var float m_fSprayPopupOpeningTime;
var float m_fSkipExitGuardTime;
var float m_fSkipExitGuardTimer;
var float m_fWaitingForServerDisplayTime;
var float m_fTimeoutTime;
var float m_fSkipLockoutTimer;
var dword m_scEpic;
var dword m_scRare;
var dword m_scLegendary;
var GFxObject m_mcChests;
var GFxObject m_mcBack;
var GFxObject m_mcCursor;
var GFxObject m_mcTitle;
var GFxObject m_mcHeader;
var GFxObject m_mcAcquired;
var GFxObject m_mcBoostIcon;
var GFxObject m_mcBoostBonusText;
var GFxObject m_mcBoosterButton;
var GFxObject m_mcBoosterButton_Title;
var GFxObject m_mcBoosterButtonConsole;
var Vector2D m_vBoostedObjectCenter;
var Vector2D m_vEquipButtonOffset;
var Vector2D m_vEquipPromptOffset;
var Vector2D m_vEquippedTextOffset;
var GFxObject m_mcSkipPrompt;
var GFxObject m_mcSkipPromptBG;
var array<UIChestItem> m_Items;
var array<UIChestItem> m_DuplicateItems;
var array<int> m_nGoldCardIds;
var array<int> m_nGoldSprayIds;
var TgGFxGroup m_grPopup;
var TgGFxGroup m_grItems;
var int m_nNavGroupX;
var GFxObject m_mcSprayPopup;
var GFxObject m_mcSprayPopupCardItem;
var GFxObject m_mcSprayPopupCardItemGlow;
var UIChestItem m_SprayPopupSprayItem;
var GFxObject m_mcSprayPopupButton;
var float m_fMissedCardAlpha;
var float m_fBaseCardPreDropTime;
var float m_fOverrideCardPreDropTime;
var GFxObject m_mcWaiting;
var GFxObject m_mcWaitingSpinner;
var float m_fWaitingSpinnerRotation;

simulated event float QueueLootAnimations(array<GFxObject> baseItems, array<float> desiredScales, array<float> desiredAlphas, array<GFxObject> overrideItems, array<GFxObject> duplicateLabelClips) { }

defaultproperties
{
    m_fOpeningTime=3.5000000
    m_fSprayPopupDelayTime=0.7500000
    m_fSprayPopupOpeningTime=1.0000000
    m_fSkipExitGuardTime=0.5000000
    m_fWaitingForServerDisplayTime=5.0000000
    m_fTimeoutTime=20.0000000
    m_vEquipButtonOffset=(X=22.5000000,Y=165.2500000)
    m_vEquipPromptOffset=(X=87.0000000,Y=166.4000000)
    m_vEquippedTextOffset=(X=25.1500000,Y=166.5500000)
    m_fMissedCardAlpha=75.0000000
    m_fBaseCardPreDropTime=0.2500000
    m_fOverrideCardPreDropTime=0.2500000
    m_OptionList[0]=14
    m_OptionList[1]=4
    m_OptionList[2]=0
    m_bAlwaysTick=true
    m_Name="UIChests"
}
