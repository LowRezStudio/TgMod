class UIStore extends TgGfxScene within GFxMoviePlayer
    native(GFxScene);

const UISTORE_TABS = 5;
const UISTORE_ARROWS = 2;
const UISTORE_CHESTS = 15;
const UISTORE_FEATURES = 7;
const UISTORE_INPUTCOUNT = 3;
const UISTORE_EXCLUSIVES = 10;
const UISTORE_ITEMTABS = 11;
const FILTER_POPUP_OPTION_COUNT = 4;
const FILTER_POPUP_RARITY_COUNT = 5;
const UISTORE_CHEST_BUNDLE_DROPDOWN_COUNT = 5;
const UICHESTS_MAX_BUNDLES = 4;
const UISTORE_CAROUSEL_PANEL = 1;
const UISTORE_CURRENCIES = 2;
const UISTORE_ENCHANTEDKEYS = 2;

enum UISTORE_STATE
{
    UISTS_FEATURES,                 // 0
    UISTS_CHAMPIONS,                // 1
    UISTS_ITEMS,                    // 2
    UISTS_CHESTS,                   // 3
    UISTS_ACCOUNT,                  // 4
    UISTS_MAX                       // 5
};

enum UISTORETAB_STATE
{
    UISTT_COLLECTIONS,              // 0
    UISTT_WEAPONS,                  // 1
    UISTT_SETS,                     // 2
    UISTT_HEADS,                    // 3
    UISTT_BODIES,                   // 4
    UISTT_EMOTES,                   // 5
    UISTT_VOICES,                   // 6
    UISTT_MVPPOSES,                 // 7
    UISTT_SPRAYS,                   // 8
    UISTT_MOUNTS,                   // 9
    UISTT_ANNOUNCERPACKS,           // 10
    UISTT_MAX                       // 11
};

enum EStoreSort
{
    SSORT_Default,                  // 0
    SSORT_Newest,                   // 1
    SSORT_Champion,                 // 2
    SSORT_RarityDescending,         // 3
    SSORT_RarityAscending,          // 4
    SSORT_Name,                     // 5
    SSORT_MAX                       // 6
};

enum EChampionFilter
{
    CFILTER_All,                    // 0
    CFILTER_Owned,                  // 1
    CFILTER_Individual,             // 2
    CFILTER_MAX                     // 3
};

struct native UIStoreFoundersPackPanel
{
    var GFxObject Obj;
    var GFxObject Title;
    var GFxObject SubTitle;
    var GFxObject BuyNow;
    var GFxObject Price;
    var GFxObject SaleBanner;

    structdefaultproperties
    {
        Obj=none
        Title=none
        SubTitle=none
        BuyNow=none
        Price=none
        SaleBanner=none
    }
};

struct native UISprayRentalData
{
    var int nSprayItemId;
    var int nSprayVendorId;
    var int nChestItemId;
    var int nLootId;
    var int nBundleVendorId;
    var int nBundleCount;
    var int nBundleItemIds[4];
    var int nBundleItemCounts[4];

    structdefaultproperties
    {
        nSprayItemId=0
        nSprayVendorId=0
        nChestItemId=0
        nLootId=0
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

struct native UIEnchantKeyPanel
{
    var GFxObject Container;
    var GFxObject PanelFrame;
    var GFxObject Icon;
    var GFxObject RarityText;
    var GFxObject Desc;
    var GFxObject Price;
    var GFxObject PriceTF;
    var GFxObject UnavailableTF;

    structdefaultproperties
    {
        Container=none
        PanelFrame=none
        Icon=none
        RarityText=none
        Desc=none
        Price=none
        PriceTF=none
        UnavailableTF=none
    }
};

struct native StoreFilter
{
    var UIStore.EStoreSort eCurrentSorting;
    var UIStore.EChampionFilter eCurrentChampionFilter;
    var int nIndividuallyFilteredBotId;
    var bool bAvailable;
    var bool bNotOwned;
    var int nRarityFilter[5];

    structdefaultproperties
    {
        eCurrentSorting=EStoreSort.SSORT_Default
        eCurrentChampionFilter=EChampionFilter.CFILTER_All
        nIndividuallyFilteredBotId=0
        bAvailable=false
        bNotOwned=false
        nRarityFilter[0]=0
        nRarityFilter[1]=0
        nRarityFilter[2]=0
        nRarityFilter[3]=0
        nRarityFilter[4]=0
    }
};

var bool m_bResetSkins;
var bool m_bResetChampions;
var bool m_bAnimatingItems;
var bool m_bAnimatingChampions;
var bool m_bRedeemCode;
var bool m_bEnchanting;
var bool m_bNameChange;
var bool m_bIsRenting;
var bool m_bUseCardIcon;
var bool m_bHovering;
var bool m_bRotating;
var bool m_bItemTotalsCalculated;
var bool m_bFilterEnabled;
var bool m_bDropdownOpen;
var bool m_bShowFounderAdd;
var int m_nRefocusNeeded;
var int m_nItemEmoteId;
var int m_nItemHeadId;
var int m_nItemSkinId;
var int m_nItemWeapon;
var int m_nItemVoiceId;
var int m_nWeaponDeviceId;
var int m_nItemMVPPose;
var int m_nItemSpray;
var int m_nItemMount;
var int m_nAnnouncerPack;
var int m_nActiveItem;
var int m_nActiveChampion;
var int m_nChestIndex;
var int m_nChestBundleIndex;
var int m_nItemScroll;
var int m_nChampionScroll;
var float m_fWaitTimer;
var byte m_eState;
var byte m_eTabState;
var float m_fGlowTimerA1;
var float m_fGlowTimerA2;
var float m_fGlowTimerA3;
var float m_fGlowTimerB1;
var float m_fGlowTimerB2;
var float m_fGlowTimerB3;
var int m_nChestIconFrame;
var int m_nSprayIconFrame;
var int m_nChestQuantity;
var int m_nSprayIconIndex;
var int m_nSprayRarityIndex;
var dword m_dwCrystalCost;
var dword m_dwGoldCost;
var dword m_dwOriginalCrystalCost;
var string m_sSprayName;
var string m_sChestName;
var int m_nOwnedItemCount;
var int m_nTotalItemCount;
var float m_fPreviousPosX;
var int m_nExclusiveCount;
var UIDataItem m_pExclusiveItems[10];
var array<UIDataItem> m_StoreItems;
var init array<init JsonFeatureData> m_FeatureData;
var int m_nItemCounts[11];
var int m_nItemTotals[11];
var GFxObject m_mcBack;
var GFxObject m_mcTitle;
var GFxObject m_mcHeader;
var GFxObject m_mcHeaderCrystals;
var GFxObject m_mcHeaderCrystalsConsole;
var GFxObject m_mcHeaderButton[5];
var GFxObject m_mcHeaderButtonShadow[5];
var GFxObject m_mcHeaderButtonSelected[5];
var GFxObject m_mcHeaderButtonHighlight[5];
var GFxObject m_mcHeaderButtonChestsCTA;
var GFxObject m_mcFeatures;
var UIInteractable_JsonPanel_Carousel m_CarouselPanel;
var UIInteractable_JsonPanel m_JsonPanel[7];
var TgGFxGroup m_grFeatures;
var GFxObject m_mcItems;
var GFxObject m_mcItemContainer;
var GFxObject m_mcItemScrollBar;
var GFxObject m_mcItemTab[11];
var GFxObject m_mcItemTabCount[11];
var GFxObject m_mcItemTabSelected[11];
var GFxObject m_mcRotator_Item;
var GFxObject m_mcExclusiveBanner;
var GFxObject m_mcExclusiveLabel;
var GFxObject m_mcExclusiveDescription;
var GFxObject m_mcNoItemResultsText;
var GFxObject m_mcItemRentalText;
var GFxObject m_mcItemRentalTextLabel;
var GFxObject m_mcItemRentalTextDuration;
var TgGFxGroup m_grItemTabs;
var TgGFxGroup m_grItems;
var GFxObject m_mcFilterBar;
var GFxObject m_mcButtonFilter;
var GFxObject m_mcFilterText;
var GFxObject m_mcClearFilterButton;
var GFxObject m_mcChampionFilterLabel;
var UIComponent_Dropdown m_ChampionFilterDropdown;
var GFxObject m_mcFilterGamepadPrompt;
var GFxObject m_mcFilterPopup;
var GFxObject m_mcFilterPopupMainPanel;
var GFxObject m_mcFilterPopupConfirmButton;
var GFxObject m_mcFilterPopupGamepadButtonLeft;
var GFxObject m_mcFilterPopupGamepadButtonRight;
var GFxObject m_mcFilterPopupCloseButton;
var GFxObject m_mcFilterPopupTitle;
var GFxObject m_mcFilterPopupSortOption;
var GFxObject m_mcFilterPopupSortOptionText;
var GFxObject m_mcFilterPopupSortOptionHighlight;
var GFxObject m_mcFilterPopupOptionCarouselLeftArrow;
var GFxObject m_mcFilterPopupOptionCarouselRightArrow;
var GFxObject m_mcFilterPopupItemNotOwnedOption;
var GFxObject m_mcFilterPopupItemNotOwnedOptionText;
var GFxObject m_mcFilterPopupItemNotOwnedOptionToggle;
var GFxObject m_mcFilterPopupAvailableOption;
var GFxObject m_mcFilterPopupAvailableOptionText;
var GFxObject m_mcFilterPopupAvailableOptionToggle;
var GFxObject m_mcFilterPopupRarity[5];
var GFxObject m_mcFilterPopupRarityToggle[5];
var GFxObject m_mcFilterPopupSortByText;
var GFxObject m_mcFilterPopupFilterText;
var GFxObject m_mcFilterPopupRarityText;
var TgGFxGroup m_grFilterPopup;
var GFxObject m_mcChampions;
var UIStoreFoundersPackPanel m_FoundersPack;
var GFxObject m_mcChampionContainer;
var GFxObject m_mcChampionScrollBar;
var GFxObject m_mcRotator_Champion;
var GFxObject m_mcChampionRentalText;
var GFxObject m_mcChampionRentalTextLabel;
var GFxObject m_mcChampionRentalTextDuration;
var TgGFxGroup m_grChampions;
var TgGFxGroup m_grpFounderPack;
var GFxObject m_mcChests;
var GFxObject m_mcChest[15];
var GFxObject m_mcChestGlowA[15];
var GFxObject m_mcChestGlowB[15];
var GFxObject m_mcChestArrows[2];
var GFxObject m_mcPrevChestPrompt;
var GFxObject m_mcNextChestPrompt;
var GFxObject m_mcChestName;
var GFxObject m_mcChestTime;
var GFxObject m_mcChestPanel;
var GFxObject m_mcChestPanelCTA;
var GFxObject m_mcChestPanelEnchantButton;
var GFxObject m_mcChestPanelEnchantButtonTF;
var GFxObject m_mcChestPanelIcon;
var GFxObject m_mcChestPanelName;
var GFxObject m_mcChestPanelType;
var GFxObject m_mcChestPanelDesc;
var GFxObject m_mcChestPanelCount;
var GFxObject m_mcChestPanelPriceContainer;
var GFxObject m_mcChestPanelDetails;
var GFxObject m_mcChestPanelPurchase;
var GFxObject m_mcChestPanelCursor;
var GFxObject m_mcChestSaleBanner;
var GFxObject m_mcChestSaleText;
var GFxObject m_mcChestCouponBanner;
var GFxObject m_mcChestCouponBannerText;
var GFxObject m_mcChestCouponBannerIcon;
var GFxObject m_mcChestPanelHidden;
var GFxObject m_mcChestPanelChestIcon;
var GFxObject m_mcChestPanelSprayIcon;
var GFxObject m_mcChestPanelSprayIconGfx;
var GFxObject m_mcChestPanelSprayIconCard;
var GFxObject m_mcChestPanelSprayIconRarity;
var GFxObject m_mcChestPanelRentalLabel;
var GFxObject m_mcChestPanelRentalTime;
var TgGFxGroup m_grRentSpray;
var GFxObject m_mcRentSprayPopup;
var GFxObject m_mcRentSprayPopupBlocker;
var GFxObject m_mcRentSprayPopupWindow;
var GFxObject m_mcRentSprayPopupWindowCursor;
var GFxObject m_mcRentSprayPopupWindowWait;
var GFxObject m_mcRentSprayPopupWindowSpinner;
var GFxObject m_mcRentSprayPopupName;
var GFxObject m_mcRentSprayPopupIcon;
var GFxObject m_mcRentSprayPopupIconGfx;
var GFxObject m_mcRentSprayPopupIconCard;
var GFxObject m_mcRentSprayPopupIconRarity;
var GFxObject m_mcRentSprayPopupTime;
var GFxObject m_mcRentSprayPopupChestIcon;
var GFxObject m_mcRentSprayPopupCancel;
var GFxObject m_mcRentSprayPopupOwnedCrystals;
var GFxObject m_mcRentSprayPopupOwnedGold;
var GFxObject m_mcRentSprayPopupOwnedEssence;
var GFxObject m_mcRentSprayPopupOption0;
var GFxObject m_mcRentSprayPopupOption0TF;
var GFxObject m_mcRentSprayPopupOption0CurrentCost;
var GFxObject m_mcRentSprayPopupOption0Purchase;
var GFxObject m_mcRentSprayPopupOption0PurchaseBG;
var GFxObject m_mcRentSprayPopupOption0PurchaseTF;
var GFxObject m_mcRentSprayPopupOption0PurchaseIcon;
var GFxObject m_mcRentSprayPopupOption1;
var GFxObject m_mcRentSprayPopupOption1TF;
var GFxObject m_mcRentSprayPopupOption1CurrentCost;
var GFxObject m_mcRentSprayPopupOption1Purchase;
var GFxObject m_mcRentSprayPopupOption1PurchaseBG;
var GFxObject m_mcRentSprayPopupOption1PurchaseTF;
var GFxObject m_mcRentSprayPopupOption1PurchaseIcon;
var GFxObject m_mcRentSprayPopupChestQuantity;
var GFxObject m_mcRentSprayPopupChestName;
var GFxObject m_mcRentSprayPopupPrice;
var GFxObject m_mcChestPanelQuantityDropdownToggle;
var GFxObject m_mcChestPanelQuantityDropdownPrompt;
var GFxObject m_mcChestPanelQuantityDropdownToggle_Inner;
var GFxObject m_mcChestPanelQuantityDropdownPrompt_Inner;
var GFxObject m_mcChestPanelPurchaseQuantity;
var GFxObject m_mcChestPanelDropdown;
var GFxObject m_mcChestPanelDropdownMask;
var GFxObject m_mcChestPanelDropdownFrame;
var GFxObject m_mcChestPanelDropdownOptions[5];
var TgGFxGroup m_grChestPanelDropdown;
var GFxObject m_mcChestDetails;
var GFxObject m_mcChestDetailName;
var GFxObject m_mcChestDetailRarity;
var GFxObject m_mcChestExclusives;
var GFxObject m_mcChestExclusivesFrame;
var GFxObject m_mcChestExclusivesTitle;
var GFxObject m_mcChestExclusivesSubtitle;
var GFxObject m_mcChestExclusiveLabel;
var GFxObject m_mcChestExclusive[10];
var GFxObject m_mcChestExclusiveIcon[10];
var GFxObject m_mcChestExclusiveLock[10];
var GFxObject m_mcChestExclusiveFrame[10];
var GFxObject m_mcChestExclusiveShadow[10];
var GFxObject m_mcChestExclusiveHighlight[10];
var TgGFxGroup m_grChests;
var TgGFxGroup m_grBundledChest;
var UIComponent_HoldPrompt m_uiRentHold;
var TgGFxGroup m_grEnchantChest;
var GFxObject m_mcEnchantPopup;
var GFxObject m_mcEnchantPopupBlocker;
var GFxObject m_mcEnchantPopupBG;
var GFxObject m_mcEnchantPopupTitle;
var GFxObject m_mcEnchantPopupSubtitle;
var GFxObject m_mcEnchantPopupCancelButton;
var GFxObject m_mcEnchantPopupCancelButtonTF;
var GFxObject m_mcEnchantPopupCancelButtonBG;
var UIEnchantKeyPanel m_EnchantedKeyPanels[2];
var string m_sEnchantedKeyNames[2];
var string m_sEnchantedKeyDescriptions[2];
var int m_nEnchantedKeyRarity[2];
var int m_nEnchantedKeyItemId[2];
var int m_nEnchantedKeyIconIndex[2];
var GFxObject m_mcAccount;
var GFxObject m_mcAccountCode;
var GFxObject m_mcAccountBoost;
var GFxObject m_mcAccountName;
var TgGFxGroup m_grAccount;
var GFxObject m_mcPopup;
var GFxObject m_mcPopupWait;
var GFxObject m_mcPopupError;
var GFxObject m_mcPopupInput;
var GFxObject m_mcPopupTitle;
var GFxObject m_mcPopupSubtitle;
var GFxObject m_mcPopupInputFrame;
var GFxObject m_mcPopupButton[3];
var GFxObject m_mcPopupButtonTitle[3];
var TgGFxGroup m_grPopup;
var array<UIITEM_CLIP> m_Items;
var array<GFxObject> m_ItemLinks;
var array<UIITEM_CLIP> m_Champions;
var array<UIITEM_CLIP> m_PvEChampions;
var array<GFxObject> m_ChampionLinks;
var native map{VOID,VOID} m_FeatureMap;
var() int m_nItemXOffset;
var() int m_nItemYOffset;
var() int m_nItemWidth;
var() int m_nItemHeight;
var int m_nItemButtonHeight;
var int m_nItemButtonWidth;
var int m_nItemsShown;
var int m_nItemsTotal;
var dword m_dwChestOpenDelay;
var dword m_dwChestNextOpenTime;
var string m_sCurrencyCode;
var string m_sFoundersPackTitle;
var string m_sFoundersPackSubtitle;
var int m_nChampionDropdownIndex;
var float m_nEmptyItemTabAlpha;
var StoreFilter m_DefaultStoreFilter;
var StoreFilter m_CurrentStoreFilter;
var StoreFilter m_InProgressStoreFilter;
var float m_fOriginalCollisionHeight;
var float m_fOriginalCollisionRadius;

// Export UUIStore::execOnTeamModelUpdated(FFrame&, void* const)
native function OnTeamModelUpdated();

defaultproperties
{
    m_sEnchantedKeyNames[0]="m_lsEnchantedKey"
    m_sEnchantedKeyNames[1]="m_lsLegendaryKey"
    m_sEnchantedKeyDescriptions[0]="m_lsEnchantedKeyDesc"
    m_sEnchantedKeyDescriptions[1]="m_lsLegendaryKeyDesc"
    m_nEnchantedKeyRarity[0]=2
    m_nEnchantedKeyRarity[1]=5
    m_nItemXOffset=120
    m_nItemYOffset=143
    m_nItemWidth=220
    m_nItemHeight=235
    m_nItemButtonHeight=32
    m_nItemButtonWidth=190
    m_nEmptyItemTabAlpha=35.0000000
    m_DefaultStoreFilter=(eCurrentSorting=EStoreSort.SSORT_Default,eCurrentChampionFilter=EChampionFilter.CFILTER_All,nIndividuallyFilteredBotId=2092,bAvailable=true,bNotOwned=true,nRarityFilter=1,nRarityFilter[1]=1,nRarityFilter[2]=1,nRarityFilter[3]=1,nRarityFilter[4]=1)
    m_CurrentStoreFilter=(eCurrentSorting=EStoreSort.SSORT_Default,eCurrentChampionFilter=EChampionFilter.CFILTER_All,nIndividuallyFilteredBotId=2092,bAvailable=true,bNotOwned=true,nRarityFilter=1,nRarityFilter[1]=1,nRarityFilter[2]=1,nRarityFilter[3]=1,nRarityFilter[4]=1)
    m_InProgressStoreFilter=(eCurrentSorting=EStoreSort.SSORT_Default,eCurrentChampionFilter=EChampionFilter.CFILTER_All,nIndividuallyFilteredBotId=2092,bAvailable=true,bNotOwned=true,nRarityFilter=1,nRarityFilter[1]=1,nRarityFilter[2]=1,nRarityFilter[3]=1,nRarityFilter[4]=1)
    m_UISceneClass=Class'TgClient.UIScene_UIStore'
    m_OptionList[0]=14
    m_OptionList[1]=4
    m_OptionList[2]=0
    m_OptionList[3]=0
    m_OptionList[4]=0
    m_OptionList[5]=0
    m_bBlur=true
    m_bBlurForeground=true
    m_bResetHeaderFocusOnShow=false
    m_bAllowMultipleOnStack=false
    m_Name="UIStore"
}