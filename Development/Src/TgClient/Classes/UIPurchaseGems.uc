class UIPurchaseGems extends TgGfxScene within GFxMoviePlayer
    native(GFxScene)
    config(Engine)
    dependson(UIDataObject);

const UIPURCHASEGEMS_DURABLEPACKS = 2;

const UIPURCHASEGEMS_CONSUMABLEPACKS = 7;

const UIPURCHASEGEMS_DURABLE_DETAILS = 5;

const UI_FOUNDERS_PACK_ID = 21371;

enum UIPG_DurablePacks {
    UIPG_Founders,  // 0
    UIPG_Realm,  // 1
};

struct UIDurablePack {
    var GFxObject Obj;
    var GFxObject Price;
    var GFxObject PurchaseButton;
    var GFxObject Highlight;
    var GFxObject Refund;
    var GFxObject SaleBanner;
    structdefaultproperties {}
};

struct UIConsumablePack {
    var GFxObject Obj;
    var GFxObject Title;
    var GFxObject Icon;
    var GFxObject Price;
    var GFxObject PurchaseButton;
    var GFxObject Highlight;
    var GFxObject SaleBanner;
    structdefaultproperties {}
};

var UIDurablePack m_DurablePack[2];
var UIConsumablePack m_ConsumablePack[7];
var GFxObject m_mcCancelButton;
var GFxObject m_mcOverlay;
var GFxObject m_mcFrame;
var GFxObject m_mcBlocker;
var array<ProductInfo> m_AllProducts;

event GetAvailableProducts(OnlineSubsystem.EMediaItemType MediaType, out array<MarketplaceProductDetails> AvailableProducts) { }

event GetInventoryItems(out array<MarketplaceInventoryItem> InventoryItems) { }

defaultproperties
{
    m_UISceneClass=Class'UIScene_SceneAsPopup'
    m_OptionList[0]=14
    m_OptionList[1]=4
    m_nBackground=1
    m_bBlur=true
    m_bIsPopup=true
    m_Name="UIPurchaseGems"
}
