class UIAcquisition extends TgGfxScene within GFxMoviePlayer
    native(GFxScene)
    config(Engine);

const UIACQUISITION_ITEMS = 4;

const UIACQUISITION_LINES = 6;

const UIACQUISITION_TABS = 2;

const UIACQUISITION_CURRENCIES = 3;

const UIACQUISITION_PURCHASE_OPTIONS = 2;

const UIACQUISITION_RENTAL_OPTIONS = 3;

enum UIPURCHASE_TYPE {
    UIPT_NONE,  // 0
    UIPT_ITEM,  // 1
    UIPT_CARD,  // 2
    UIPT_WEAP,  // 3
    UIPT_BUNDLE,  // 4
};

struct UIPurchaseScreen {
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
    structdefaultproperties {}
};

struct UIAcquiredItem {
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
    structdefaultproperties {}
};

struct UIAcquiredCoupon {
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
    structdefaultproperties {}
};

struct AcquiredItem {
    var int eItemType;
    var int nItemId;
    var int nQuantity;
    structdefaultproperties {}
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
    m_scAcquireStart=AkEvent'UI_Menu_CardCraft_Buildup_Play'
    m_scAcquireFinish=AkEvent'UI_Menu_CardCraft_Finish_Play'
    m_akPurchaseItem=AkEvent'UI_Menu_Purchase_Play'
    m_scUnlocked=SoundCue'A_CUE_ChestOpen_Medium_Ending_Explosion_5'
    m_UISceneClass=Class'UIScene_UIAcquisition'
    m_OptionList[0]=14
    m_OptionList[1]=4
    m_nBackground=1
    m_bBlur=true
    m_bResetFocusOnShow=true
    m_bIsPopup=true
    m_bPushesSceneFromSubscenes=true
    m_Name="UIAcquisition"
}
