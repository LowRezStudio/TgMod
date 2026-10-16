class UIAcquisition extends TgGfxScene within GFxMoviePlayer
    native(GFxScene);

const UIACQUISITION_ITEMS = 4;
const UIACQUISITION_LINES = 6;
const UIACQUISITION_TABS = 2;
const UIACQUISITION_CURRENCIES = 3;
const UIACQUISITION_PURCHASE_OPTIONS = 2;
const UIACQUISITION_RENTAL_OPTIONS = 3;

enum UIPURCHASE_TYPE
{
    UIPT_NONE,                      // 0
    UIPT_ITEM,                      // 1
    UIPT_CARD,                      // 2
    UIPT_WEAP,                      // 3
    UIPT_BUNDLE,                    // 4
    UIPT_MAX                        // 5
};

struct native UIPurchaseScreen
{
    var GFxObject mcScreen;
    var GFxObject mcWait;
    var GFxObject mcTitle;
    var GFxObject mcCursor;
    var GFxObject mcCancel;
    var GFxObject mcDivider;
    var GFxObject mcSpinner;
    var GFxObject mcSubtitle;
    var GFxObject mcOption[3];
    var GFxObject mcButton[3];
    var GFxObject mcCurrency[3];
    var GFxObject mcCurrencyIcon[3];
    var GFxObject mcControllerCost[3];
    var GFxObject mcControllerCurrencyIcon[3];
    var GFxObject mcControllerButton[3];
    var GFxObject mcPreviousCost[3];
    var GFxObject mcPreviousCostStrikethrough[3];
    var GFxObject mcTab[2];
    var GFxObject mcTabSelected[2];
    var GFxObject mcTabHighlight[2];
    var GFxObject mcRentalDivider0;
    var GFxObject mcRentalDivider1;
    var GFxObject mcRentalOption[3];
    var GFxObject mcRentalButton[3];
    var GFxObject mcRentalCurrencyIcon[3];
    var GFxObject mcRentalControllerCost[3];
    var GFxObject mcRentalControllerCurrencyIcon[3];
    var GFxObject mcRentalControllerButton[3];
    var GFxObject mcRentalPreviousCost[3];
    var GFxObject mcRentalPreviousCostStrikethrough[3];
    var GFxObject mcCouponSelect;
    var GFxObject mcCouponSelectArrow0;
    var GFxObject mcCouponSelectArrow1;
    var GFxObject mcCouponSelectIcon;
    var GFxObject mcCouponSelectTF;
    var GFxObject mcCouponSelectHighlight;
    var UIComponent_HoldPrompt Hold;
    var TgGFxGroup grScreen;
    var TgGFxGroup grRentalScreen;

    structdefaultproperties
    {
        mcScreen=none
        mcWait=none
        mcTitle=none
        mcCursor=none
        mcCancel=none
        mcDivider=none
        mcSpinner=none
        mcSubtitle=none
        mcOption[0]=none
        mcOption[1]=none
        mcOption[2]=none
        mcButton[0]=none
        mcButton[1]=none
        mcButton[2]=none
        mcCurrency[0]=none
        mcCurrency[1]=none
        mcCurrency[2]=none
        mcCurrencyIcon[0]=none
        mcCurrencyIcon[1]=none
        mcCurrencyIcon[2]=none
        mcControllerCost[0]=none
        mcControllerCost[1]=none
        mcControllerCost[2]=none
        mcControllerCurrencyIcon[0]=none
        mcControllerCurrencyIcon[1]=none
        mcControllerCurrencyIcon[2]=none
        mcControllerButton[0]=none
        mcControllerButton[1]=none
        mcControllerButton[2]=none
        mcPreviousCost[0]=none
        mcPreviousCost[1]=none
        mcPreviousCost[2]=none
        mcPreviousCostStrikethrough[0]=none
        mcPreviousCostStrikethrough[1]=none
        mcPreviousCostStrikethrough[2]=none
        mcTab[0]=none
        mcTab[1]=none
        mcTabSelected[0]=none
        mcTabSelected[1]=none
        mcTabHighlight[0]=none
        mcTabHighlight[1]=none
        mcRentalDivider0=none
        mcRentalDivider1=none
        mcRentalOption[0]=none
        mcRentalOption[1]=none
        mcRentalOption[2]=none
        mcRentalButton[0]=none
        mcRentalButton[1]=none
        mcRentalButton[2]=none
        mcRentalCurrencyIcon[0]=none
        mcRentalCurrencyIcon[1]=none
        mcRentalCurrencyIcon[2]=none
        mcRentalControllerCost[0]=none
        mcRentalControllerCost[1]=none
        mcRentalControllerCost[2]=none
        mcRentalControllerCurrencyIcon[0]=none
        mcRentalControllerCurrencyIcon[1]=none
        mcRentalControllerCurrencyIcon[2]=none
        mcRentalControllerButton[0]=none
        mcRentalControllerButton[1]=none
        mcRentalControllerButton[2]=none
        mcRentalPreviousCost[0]=none
        mcRentalPreviousCost[1]=none
        mcRentalPreviousCost[2]=none
        mcRentalPreviousCostStrikethrough[0]=none
        mcRentalPreviousCostStrikethrough[1]=none
        mcRentalPreviousCostStrikethrough[2]=none
        mcCouponSelect=none
        mcCouponSelectArrow0=none
        mcCouponSelectArrow1=none
        mcCouponSelectIcon=none
        mcCouponSelectTF=none
        mcCouponSelectHighlight=none
        Hold=none
        grScreen=none
        grRentalScreen=none
    }
};

struct native UIAcquiredItem
{
    var UIInteractable_Item Card;
    var GFxObject mcEquipButton;
    var GFxObject mcEquippedText;
    var GFxObject mcEquipPrompt;
    var GFxObject mcStoreItemContainer;
    var GFxObject mcItemContainer;
    var GFxObject mcBoostContainer;
    var GFxObject mcChestContainer;
    var GFxObject mcChampionIcon;
    var GFxObject mcChampionImage;
    var GFxObject mcChampionTitle;
    var GFxObject mcItemIcon;
    var GFxObject mcCardIcon;
    var GFxObject mcCurrency;
    var GFxObject mcRarityFrame;
    var GFxObject mcRarityText;
    var GFxObject mcItemTitle;
    var GFxObject mcItemAudio;
    var GFxObject mcItemChampion;
    var GFxObject mcItemChampionIcon;
    var GFxObject mcOwnedText;
    var GFxObject mcOwnedCheckmark;

    structdefaultproperties
    {
        Card=none
        mcEquipButton=none
        mcEquippedText=none
        mcEquipPrompt=none
        mcStoreItemContainer=none
        mcItemContainer=none
        mcBoostContainer=none
        mcChestContainer=none
        mcChampionIcon=none
        mcChampionImage=none
        mcChampionTitle=none
        mcItemIcon=none
        mcCardIcon=none
        mcCurrency=none
        mcRarityFrame=none
        mcRarityText=none
        mcItemTitle=none
        mcItemAudio=none
        mcItemChampion=none
        mcItemChampionIcon=none
        mcOwnedText=none
        mcOwnedCheckmark=none
    }
};

struct native UIAcquiredCoupon
{
    var GFxObject mcRoot;
    var GFxObject mcAnimTitle;
    var GFxObject mcTitle;
    var GFxObject mcCouponDescrition;
    var GFxObject mcCostPrev;
    var GFxObject mcCostPrevIcon;
    var GFxObject mcCostPrevStrikethrough;
    var GFxObject mcCostCurrent;
    var GFxObject mcCostCurrentIcon;
    var GFxObject mcCouponExpires;
    var GFxObject mcButton0;
    var GFxObject mcButton1;
    var GFxObject mcPrompt0;
    var GFxObject mcPrompt1;
    var GFxObject mcFrame;
    var GFxObject mcFrameLine;
    var GFxObject mcRarityFrame;
    var GFxObject mcItemImageStack;
    var GFxObject mcCardImageStack;
    var GFxObject mcChestImageStack;
    var GFxObject mcTexture;

    structdefaultproperties
    {
        mcRoot=none
        mcAnimTitle=none
        mcTitle=none
        mcCouponDescrition=none
        mcCostPrev=none
        mcCostPrevIcon=none
        mcCostPrevStrikethrough=none
        mcCostCurrent=none
        mcCostCurrentIcon=none
        mcCouponExpires=none
        mcButton0=none
        mcButton1=none
        mcPrompt0=none
        mcPrompt1=none
        mcFrame=none
        mcFrameLine=none
        mcRarityFrame=none
        mcItemImageStack=none
        mcCardImageStack=none
        mcChestImageStack=none
        mcTexture=none
    }
};

struct native AcquiredItem
{
    var int eItemType;
    var int nItemId;
    var int nQuantity;

    structdefaultproperties
    {
        eItemType=0
        nItemId=0
        nQuantity=0
    }
};

var int m_nPurchaseBot;
var int m_nPurchaseItem;
var int m_nPurchaseType;
var int m_nPurchaseBundle;
var int m_nPurchaseVendor;
var int m_nPurchaseLootItem;
var int m_eCurrencyUsed;
var int m_nMultiItemIndex;
var int m_nCurrentItemId;
var int m_nCurrentTab;
var int m_nCurrentCoupon;
var bool m_bBoost;
var bool m_bPurchasing;
var bool m_bDisplayCard;
var bool m_bUseMultiItemDisplay;
var bool m_bAcquiredCard;
var float m_fRotation;
var float m_fAnimTimer;
var float m_fLineTimer;
var float m_fLockTimer;
var float m_fPurchaseTimer;
var GFxObject m_mcFrame;
var GFxObject m_mcFrameLine;
var GFxObject m_mcFrameGlow;
var GFxObject m_mcBlocker;
var UIComponent_AcquisitionCarousel m_Carousel;
var UIPurchaseScreen m_PurchaseScreen;
var UIPurchaseScreen m_BoostScreen;
var GFxObject m_mcAcquired;
var UIInteractable_Item m_mcAcquiredCard;
var GFxObject m_mcAcquiredGlow;
var GFxObject m_mcAcquiredItem;
var GFxObject m_mcAcquiredTitle;
var GFxObject m_mcAcquiredTitleTF;
var GFxObject m_mcAcquiredAnimTitle;
var GFxObject m_mcAcquiredAnimTitleTF;
var GFxObject m_mcAcquiredButtonOk;
var GFxObject m_mcAcquiredButtonMultiOk;
var GFxObject m_mcAcquiredButtonDismiss;
var GFxObject m_mcAcquiredPrompt;
var GFxObject m_mcAcquiredPromptDismiss;
var GFxObject m_mcAcquiredSubtitle;
var GFxObject m_mcAcquiredSubtitleTF;
var GFxObject m_mcAcquiredCountTF;
var GFxObject m_mcAcquiredButtonEquipAll;
var array<AcquiredItem> m_Items;
var array<UIDataPrice> m_PurchaseOptions;
var array<UIAcquiredItem> m_PurchaseItems;
var UIAcquiredItem m_AcquiredItem;
var UIAcquiredCoupon m_AcquiredCoupon;
var AkBaseSoundObject m_scAcquireStart;
var AkBaseSoundObject m_scAcquireFinish;
var AkEvent m_akPurchaseItem;
var SoundCue m_scUnlocked;

defaultproperties
{
    m_scAcquireStart=AkEvent'WW_UI_Default.UI_Menu_CardCraft_Buildup_Play'
    m_scAcquireFinish=AkEvent'WW_UI_Default.UI_Menu_CardCraft_Finish_Play'
    m_akPurchaseItem=AkEvent'WW_UI_Default.UI_Menu_Purchase_Play'
    m_scUnlocked=SoundCue'AUD_UI_Chest.A_CUE_ChestOpen_Medium_Ending_Explosion_5'
    m_UISceneClass=Class'TgClient.UIScene_UIAcquisition'
    m_OptionList[0]=14
    m_OptionList[1]=4
    m_nBackground=1
    m_bBlur=true
    m_bResetFocusOnShow=true
    m_bIsPopup=true
    m_bPushesSceneFromSubscenes=true
    m_Name="UIAcquisition"
}