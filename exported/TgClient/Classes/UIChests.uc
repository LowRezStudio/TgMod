class UIChests extends TgGfxScene within GFxMoviePlayer
    native(GFxScene);

const UICHESTS_MAX_BUNDLES = 4;
const UICHESTS_BOOSTCHEST = 3;
const UICHESTS_SKIP_LOCKOUT = 0.25f;

enum UIChestState
{
    UICHESTS_NONE,                  // 0
    UICHESTS_WAITINGFORSERVER,      // 1
    UICHESTS_WAITINGFORTIMEOUT,     // 2
    UICHESTS_OPENING,               // 3
    UICHESTS_OPENED,                // 4
    UICHESTS_GOLDCARDDELAY,         // 5
    UICHESTS_GOLDCARDSHOWN,         // 6
    UICHESTS_DONE,                  // 7
    UICHESTS_MAX                    // 8
};

struct native UIChestData
{
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

    structdefaultproperties
    {
        nItemId=0
        nVendorId=0
        nSortOrder=0
        nRolls=0
        nBoostBonusRolls=0
        nCachedOwnedChests=0
        nBundleVendorId=0
        nBundleCount=0
        nBundleItemIds[0]=0
        nBundleItemIds[1]=0
        nBundleItemIds[2]=0
        nBundleItemIds[3]=0
        nBundleItemCounts[0]=0
        nBundleItemCounts[1]=0
        nBundleItemCounts[2]=0
        nBundleItemCounts[3]=0
    }
};

struct native UIChestItem
{
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

    structdefaultproperties
    {
        mcItem=none
        mcItemChampion=none
        mcItemChampionIcon=none
        mcItemIcon=none
        mcItemCardIcon=none
        mcItemGlow=none
        mcItemAudio=none
        mcItemTitle=none
        mcItemRarity=none
        mcItemRarityText=none
        mcItemCurrency=none
        mcItemSubtitle=none
        mcItemDuplicateLabel=none
        mcEquipButton=none
        mcEquippedText=none
        mcEquipPrompt=none
        mcEquipPromptButton=none
        mcInputFrame=none
        Card=none
    }
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

simulated event float QueueLootAnimations(array<GFxObject> baseItems, array<float> desiredScales, array<float> desiredAlphas, array<GFxObject> overrideItems, array<GFxObject> duplicateLabelClips)
{
    local int I;
    local float fFadeInDelay;

    fFadeInDelay = 0.1000000;
    I = 0;
    J0x1A:

    // End:0x11A [Loop If]
    if(I < baseItems.Length)
    {
        fFadeInDelay += m_fBaseCardPreDropTime;
        Animate(baseItems[I], 0.1500000, 2, desiredAlphas[I], fFadeInDelay);
        Animate(baseItems[I], 0.1500000, 5, desiredScales[I], fFadeInDelay);
        Animate(baseItems[I], 0.1500000, 6, desiredScales[I], fFadeInDelay);
        I++;
        // [Loop Continue]
        goto J0x1A;
    }
    fFadeInDelay += 0.2500000;
    I = 0;
    J0x135:

    // End:0x47F [Loop If]
    if(I < overrideItems.Length)
    {
        // End:0x2A0
        if(duplicateLabelClips[I] != none)
        {
            fFadeInDelay += m_fOverrideCardPreDropTime;
            duplicateLabelClips[I].SetAlpha(0.0000000);
            duplicateLabelClips[I].SetXScale(250.0000000);
            duplicateLabelClips[I].SetYScale(250.0000000);
            Animate(duplicateLabelClips[I], 0.1500000, 2, 100.0000000, fFadeInDelay);
            Animate(duplicateLabelClips[I], 0.1500000, 5, 100.0000000, fFadeInDelay);
            Animate(duplicateLabelClips[I], 0.1500000, 6, 100.0000000, fFadeInDelay);
        }
        // End:0x471
        if(overrideItems[I] != none)
        {
            fFadeInDelay += m_fOverrideCardPreDropTime;
            Animate(overrideItems[I], 0.3300000, 2, desiredAlphas[I], fFadeInDelay);
            Animate(overrideItems[I], 0.3300000, 5, desiredScales[I], fFadeInDelay);
            Animate(overrideItems[I], 0.3300000, 6, desiredScales[I], fFadeInDelay);
            Animate(baseItems[I], 0.2500000, 2, 0.0000000, fFadeInDelay + 0.2500000, 1, false);
            Animate(baseItems[I], 0.2500000, 5, desiredScales[I] * 0.5000000, fFadeInDelay + 0.2500000, 1, false);
            Animate(baseItems[I], 0.2500000, 6, desiredScales[I] * 0.5000000, fFadeInDelay + 0.2500000, 1, false);
        }
        I++;
        // [Loop Continue]
        goto J0x135;
    }
    FadeOut(m_mcSkipPrompt, 0.3300000, fFadeInDelay);
    FadeOut(m_mcSkipPromptBG, 0.3300000, fFadeInDelay);
    return fFadeInDelay;
    //return ReturnValue;    
}

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