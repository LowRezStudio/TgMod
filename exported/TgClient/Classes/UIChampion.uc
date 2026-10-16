class UIChampion extends TgGfxScene within GFxMoviePlayer
    native(GFxScene);

const UICHAMPION_SLOTS = 8;
const UICHAMPION_ITEMS = 9;
const UICHAMPION_CARDS = 5;
const UICHAMPION_EQUIPS = 4;
const UICHAMPION_SKILLS = 5;
const UICHAMPION_ARROWS = 2;
const UICHAMPION_HEADERS = 5;
const UICHAMPION_TITLES = 4;
const UICHAMPION_CHOICES = 16;
const UICHAMPION_OPTIONS = 5;
const UICHAMPION_ITEMTABS = 6;
const UICHAMPION_LOADOUTS = 6;
const UICHAMPION_SEARCHES = 3;
const UICHAMPION_LIST_SIZE = 6;

enum UIITEMTAB_STATE
{
    UIIT_HEADS,                     // 0
    UIIT_BODY,                      // 1
    UIIT_WEAPONS,                   // 2
    UIIT_EMOTES,                    // 3
    UIIT_VOICES,                    // 4
    UIIT_MVPPOSES,                  // 5
    UIIT_SPRAYS,                    // 6
    UIIT_MAX                        // 7
};

enum UISEARCH_STATE
{
    UISS_NONE,                      // 0
    UISS_TYPE,                      // 1
    UISS_NAME,                      // 2
    UISS_LIST,                      // 3
    UISS_MAX                        // 4
};

struct native UICustomItemData
{
    var GFxObject pButton;
    var bool bUnlockable;
    var bool bChest;
    var bool bCollection;

    structdefaultproperties
    {
        pButton=none
        bUnlockable=false
        bChest=false
        bCollection=false
    }
};

struct native SearchListEntry
{
    var string PlayerName;
    var UniqueNetId PlayerNetId;

    structdefaultproperties
    {
        PlayerName=""
        PlayerNetId=(Uid=())
    }
};

var int m_nCardIndex;
var int m_nLoadoutIndex;
var int m_nTempHeadId;
var int m_nTempSkinId;
var int m_nTempEmoteId;
var int m_nTempVoiceId;
var int m_nTempWeaponId;
var int m_nTempMVPPose;
var int m_nTempSpray;
var int m_nScrollIndex;
var int m_nSearchIndex;
var int m_nCollectionIndex;
var int m_nImportIndex;
var int m_nNavigateType;
var int m_nNavigateIndex;
var bool m_bScrolling;
var bool m_bImporting;
var bool m_bHovering;
var bool m_bRotating;
var bool m_bRenaming;
var bool m_bCardSelect;
var bool m_bErrorPopup;
var bool m_bPurchasing;
var bool m_bEditLoadout;
var bool m_bPromptRename;
var bool m_bResetCollection;
var bool m_bAllImportOwned;
var bool m_bIsMasteryRewards;
var float m_fPreviousPosX;
var float m_fUltimateTimeout;
var float m_fSearchTimeout;
var float m_fSlotLockFadeIn;
var float m_fSlotLockFadeOut;
var string m_sSearchName;
var array<int> m_nCardChoices;
var array<int> m_nIndexMappings;
var array<SearchListEntry> m_SearchList;
var UIScene_UIChampion.UICHAMPION_STATE m_eState;
var UIChampion.UIITEMTAB_STATE m_eTabState;
var UIChampion.UISEARCH_STATE m_eSearchState;
var GFxObject m_mcBack;
var GFxObject m_mcTitle;
var GFxObject m_mcSubtitle;
var GFxObject m_mcHeader;
var GFxObject m_mcHeaderFrame;
var GFxObject m_mcRotator;
var GFxObject m_mcScrollBar;
var GFxObject m_mcHeaderButton[5];
var GFxObject m_mcHeaderButtonCTA[5];
var GFxObject m_mcHeaderButtonLine[5];
var GFxObject m_mcHeaderButtonGlow[5];
var GFxObject m_mcHeaderButtonBounds[5];
var GFxObject m_mcHeaderButtonShadow[5];
var GFxObject m_mcHeaderButtonSelected[5];
var GFxObject m_mcHeaderButtonHighlight[5];
var GFxObject m_mcSkills;
var GFxObject m_mcSkill[5];
var GFxObject m_mcSkillKey[5];
var GFxObject m_mcSkillBase[5];
var GFxObject m_mcSkillIcon[5];
var GFxObject m_mcSkillTitle[5];
var GFxObject m_mcSkillDamage[5];
var GFxObject m_mcSkillSubtitle[5];
var GFxObject m_mcSkillCooldown[5];
var GFxObject m_mcSkillCooldownTF[5];
var GFxObject m_mcError;
var GFxObject m_mcErrorTitle;
var GFxObject m_mcErrorButton;
var GFxObject m_mcErrorSubtitle;
var TgGFxGroup m_grError;
var GFxObject m_mcSearch;
var GFxObject m_mcSearchFrame;
var GFxObject m_mcSearchBlocker;
var GFxObject m_mcSearchType;
var GFxObject m_mcSearchTypeButton[3];
var GFxObject m_mcSearchTypeClose;
var GFxObject m_mcSearchTypeTitle;
var GFxObject m_mcSearchList;
var GFxObject m_mcSearchListError;
var GFxObject m_mcSearchListTitle;
var GFxObject m_mcSearchListClose;
var GFxObject m_mcSearchListScrollBar;
var GFxObject m_mcSearchListRow[6];
var GFxObject m_mcSearchListRowName[6];
var GFxObject m_mcSearchListRowRank[6];
var GFxObject m_mcSearchListRowImport[6];
var GFxObject m_mcSearchName;
var GFxObject m_mcSearchNameDone;
var GFxObject m_mcSearchNameClose;
var GFxObject m_mcSearchNameError;
var GFxObject m_mcSearchNameInput;
var TgGFxGroup m_grSearch;
var TgGFxGroup m_grSearchName;
var TgGFxGroup m_grSearchList;
var GFxObject m_mcImport;
var GFxObject m_mcImportDone;
var GFxObject m_mcImportPage;
var GFxObject m_mcImportTitle;
var GFxObject m_mcImportClose;
var GFxObject m_mcImportError;
var GFxObject m_mcImportBumper[2];
var GFxObject m_mcImportCard[5];
var GFxObject m_mcImportCardInfo[5];
var GFxObject m_mcImportCardPrice[5];
var GFxObject m_mcImportArrow[2];
var TgGFxGroup m_grImport;
var GFxObject m_mcRename;
var GFxObject m_mcRenameDone;
var GFxObject m_mcRenameDoneTF;
var GFxObject m_mcRenameTitle;
var GFxObject m_mcRenameInput;
var GFxObject m_mcRenameCancel;
var GFxObject m_mcRenameCancelTF;
var TgGFxGroup m_grRename;
var GFxObject m_mcCards;
var UIInteractable_Item m_mcCard[16];
var GFxObject m_mcCardTitles[4];
var GFxObject m_mcCardTitleIcons[4];
var TgGFxGroup m_grCard;
var GFxObject m_mcSound;
var GFxObject m_mcCollection;
var UIComponent_Dropdown m_CollectionViewDropdown;
var UIComponent_Dropdown m_CollectionSortDropdown;
var GFxObject m_mcCollectionProgressOwned;
var GFxObject m_mcCollectionProgressTotal;
var GFxObject m_mcCollectionProgressMask;
var UIComponentPool m_CollectionPool;
var GFxObject m_mcCollectionScrollBar;
var array<UIDataItem> m_CollectionCards;
var float m_fCollectionCardWidth;
var float m_fCollectionCardHeight;
var float m_fCollectionCardXSpacing;
var float m_fCollectionCardYSpacing;
var float m_fCollectionXOffset;
var float m_fCollectionYOffset;
var UIDataItem m_CollectionDetailItem;
var GFxObject m_mcCollectionDetails;
var GFxObject m_mcCollectionDetailsTitle;
var GFxObject m_mcCollectionDetailsRarity;
var UIInteractable_Item m_CollectionDetailsCard;
var GFxObject m_mcCollectionDetailsCraftButton;
var GFxObject m_mcCollectionCraftPrompt;
var GFxObject m_mcCollectionDetailsDisenchantText;
var GFxObject m_mcCollectionDetailsDisenchantButton;
var GFxObject m_mcCollectionDisenchantPrompt;
var GFxObject m_mcCollectionDisenchantPromptCurrency;
var GFxObject m_mcCollectionDisenchantPromptText;
var TgGFxGroup m_grCollection;
var GFxObject m_mcLoadouts;
var GFxObject m_mcLoadoutImport;
var GFxObject m_mcLoadoutImportTitle;
var GFxObject m_mcLoadout[6];
var GFxObject m_mcLoadoutTitle[6];
var GFxObject m_mcLoadoutSubtitle[6];
var UIInteractable_Button m_LoadoutEditButton[6];
var UIInteractable_Button m_LoadoutDeleteButton[6];
var TgGFxGroup m_grLoadouts;
var GFxObject m_mcEdit;
var UIComponent_AbilityPointsPool m_EditAbilityPointsPool;
var GFxObject m_mcEditTitle;
var GFxObject m_mcEditSubtitle;
var GFxObject m_mcEditPoints;
var GFxObject m_mcEditPointsTitle;
var GFxObject m_mcEditPointsProgress;
var GFxObject m_mcEditCard[5];
var GFxObject m_mcEditInfo[5];
var GFxObject m_mcEditSlot[5];
var GFxObject m_mcEditPowerUp[5];
var GFxObject m_mcEditPowerDown[5];
var GFxObject m_mcEditSlotTitle[5];
var GFxObject m_mcEditOption[5];
var GFxObject m_mcEditOptionTitle[5];
var TgGFxGroup m_grEdit;
var TgGFxGroup m_grEditButtons;
var GFxObject m_mcSlots;
var GFxObject m_mcSlot[8];
var GFxObject m_mcSlotBack[8];
var GFxObject m_mcSlotLock[8];
var GFxObject m_mcSlotType[8];
var GFxObject m_mcSlotIcon[8];
var GFxObject m_mcSlotName[8];
var GFxObject m_mcSlotFade[8];
var GFxObject m_mcSlotChest[8];
var GFxObject m_mcSlotEmpty[8];
var GFxObject m_mcSlotFrame[8];
var GFxObject m_mcSlotIcon_Icon[8];
var GFxObject m_mcSlotIcon_CardIcon[8];
var GFxObject m_mcSlotLocked[8];
var GFxObject m_mcSlotPriceA[8];
var GFxObject m_mcSlotPriceB[8];
var GFxObject m_mcSlotRarity[8];
var GFxObject m_mcSlotUnlock[8];
var GFxObject m_mcSlotOptions[8];
var GFxObject m_mcSlotIconFrame[8];
var GFxObject m_mcSlotOwnership[8];
var GFxObject m_mcSlotCTA[8];
var TgGFxGroup m_grSlots;
var GFxObject m_mcItems;
var GFxObject m_mcItemHeader;
var GFxObject m_mcItemHeaderBack;
var GFxObject m_mcItemHeaderType;
var GFxObject m_mcItemHeaderName;
var GFxObject m_mcItemHeaderOwned;
var GFxObject m_mcItemHeaderTotal;
var GFxObject m_mcItemHeaderUnlocks;
var GFxObject m_mcItemHeaderProgress;
var GFxObject m_mcItemContainer;
var GFxObject m_mcItemScrollBar;
var GFxObject m_mcItemRentalText;
var GFxObject m_mcItemRentalTextLabel;
var GFxObject m_mcItemRentalTextDuration;
var TgGFxGroup m_grItems;
var GFxObject m_mcExclusiveBanner;
var GFxObject m_mcExclusiveLabel;
var GFxObject m_mcExclusiveDescription;
var GFxObject m_mcExclusiveIconQuests;
var array<UIITEM_CLIP> m_Items;
var array<UICustomItemData> m_ItemData;
var init array<init int> m_CTACosmeticIds;
var init array<init int> m_CTACardIds;
var() int m_nItemXOffset;
var() int m_nItemYOffset;
var() int m_nItemWidth;
var() int m_nItemHeight;
var int m_nItemButtonHeight;
var int m_nItemButtonWidth;
var float m_fOriginalCollisionHeight;
var float m_fOriginalCollisionRadius;

defaultproperties
{
    m_nNavigateType=-1
    m_fCollectionCardWidth=312.0000000
    m_fCollectionCardHeight=512.0000000
    m_fCollectionXOffset=120.0000000
    m_fCollectionYOffset=100.0000000
    m_nItemXOffset=120
    m_nItemYOffset=102
    m_nItemWidth=220
    m_nItemHeight=235
    m_nItemButtonHeight=32
    m_nItemButtonWidth=190
    m_UISceneClass=Class'TgClient.UIScene_UIChampion'
    m_OptionList[0]=14
    m_OptionList[1]=4
    m_nBackground=2
    m_bBlur=true
    m_bResetFocusOnShow=true
    m_bResetHeaderFocusOnShow=false
    m_Name="UIChampion"
}