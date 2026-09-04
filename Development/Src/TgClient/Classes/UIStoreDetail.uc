class UIStoreDetail extends TgGfxScene within GFxMoviePlayer
    native(GFxScene)
    config(Engine);

const UISTOREDETAIL_COUNT = 6;

var int m_nItemId;
var int m_nVendorId;
var int m_nScrollIndex;
var UIDataItem m_pCollection;
var bool m_bHovering;
var bool m_bRotating;
var float m_fPreviousPosX;
var GFxObject m_mcBack;
var GFxObject m_mcIcon;
var GFxObject m_mcChest;
var GFxObject m_mcTitle;
var GFxObject m_mcHeader;
var GFxObject m_mcSubtitle;
var GFxObject m_mcScrollBar;
var GFxObject m_mcDescriptionA;
var GFxObject m_mcDescriptionB;
var GFxObject m_mcDescriptionC;
var GFxObject m_mcRotator;
var GFxObject m_mcExclusiveBanner;
var GFxObject m_mcExclusiveLabel;
var GFxObject m_mcExclusiveDescription;
var GFxObject m_mcExclusiveIconQuests;
var GFxObject m_mcSlot[6];
var GFxObject m_mcSlotBack[6];
var GFxObject m_mcSlotLock[6];
var GFxObject m_mcSlotOwnedText[6];
var GFxObject m_mcSlotOwnedCheckmark[6];
var GFxObject m_mcSlotQuestLock[6];
var GFxObject m_mcSlotLockProgress[6];
var GFxObject m_mcSlotLockProgressMask[6];
var GFxObject m_mcSlotType[6];
var GFxObject m_mcSlotIcon[6];
var GFxObject m_mcSlotCardIcon[6];
var GFxObject m_mcSlotName[6];
var GFxObject m_mcSlotFade[6];
var GFxObject m_mcSlotChest[6];
var GFxObject m_mcSlotFrame[6];
var GFxObject m_mcSlotIcon_Image[6];
var GFxObject m_mcSlotCardIcon_Image[6];
var GFxObject m_mcSlotPriceA[6];
var GFxObject m_mcSlotPriceB[6];
var GFxObject m_mcSlotRarity[6];
var GFxObject m_mcSlotUnlock[6];
var GFxObject m_mcSlotSelected[6];
var GFxObject m_mcSlotExclusive[6];
var UIComponent_ItemObtainabilityBanner m_pSlotBanner[6];
var GFxObject m_mcSlotIconFrame[6];
var GFxObject m_mcPurchaseCollection;
var GFxObject m_mcPurchaseCollectionTitle;
var GFxObject m_mcPurchaseCollectionPrice;
var GFxObject m_mcPurchaseCollectionPriceStrikethrough;
var GFxObject m_mcPurchaseCollectionNewPrice;
var GFxObject m_mcPurchaseCollectionPriceGold;
var GFxObject m_mcPurchaseCollectionPriceGoldStrikethrough;
var GFxObject m_mcPurchaseCollectionNewPriceGold;
var GFxObject m_mcPurchaseCollectionFrame;
var GFxObject m_mcPurchaseCollectionCouponBanner;
var UIInteractable_Button m_PurchaseCollectionButton;
var TgGFxGroup m_grStoreDetail;
var array<UIDataItem> m_Items;
var array<int> m_ChestExclusiveItems;
var int m_nPreviewHeadId;
var int m_nPreviewSkinId;
var int m_nPreviewWeapon;
var int m_nPreviewWeaponId;
var int m_nPreviewVoice;
var int m_nPreviewEmote;
var int m_nPreviewMVPPose;
var int m_nPreviewSpray;
var int m_nPreviewMount;

native function OnTeamModelUpdated();  // Export UUIStoreDetail::execOnTeamModelUpdated(FFrame&, void* const)

defaultproperties
{
    m_OptionList[0]=14
    m_OptionList[1]=4
    m_OptionList[2]=0
    m_bBlur=true
    m_Name="UIStoreDetail"
}
