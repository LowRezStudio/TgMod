class UIComponent_AcquisitionCarousel extends UIComponent_Interactable
    native(UIComponent)
    config(Engine)
    dependson(UIAcquisition);

struct AcquisitionCarouselItem {
    var GFxObject mcPurchaseItem;
    var GFxObject mcPurchaseChest;
    var UIInteractable_Item mcPurchaseCard;
    var GFxObject mcPurchaseItemDisplay;
    var GFxObject mcPurchaseItemIcon;
    var GFxObject mcPurchaseItemCardIcon;
    var GFxObject mcPurchaseItemCurrency;
    var GFxObject mcPurchaseItemRarityFrame;
    var GFxObject mcPurchaseItemRarityText;
    var GFxObject mcPurchaseItemTypeIcon;
    var GFxObject mcPurchaseItemTitle;
    var GFxObject mcPurchaseItemSubtitle;
    var GFxObject mcPurchaseItemChampion;
    var GFxObject mcPurchaseItemChampionIcon;
    var GFxObject mcPurchaseItemChampionLarge;
    var GFxObject mcPurchaseItemChampionTitle;
    var GFxObject mcPurchaseItemChampionImage;
    var GFxObject mcPurchaseItemAudio;
    structdefaultproperties {}
};

var UIInteractable_Button m_mcLeftArrow;
var UIInteractable_Button m_mcRightArrow;
var GFxObject m_mcLeftButtonPrompt;
var GFxObject m_mcRightButtonPrompt;
var array<UIAcquiredItem> m_CarouselItems;
var array<GFxObject> m_mcNavDots;
var int m_nIndex;
var float m_fNavDotCenter;
var init array<init int> m_ItemIdList;
var float m_fDotPlacementX;
var float m_fDotWidth;
var float m_fDotPadding;
