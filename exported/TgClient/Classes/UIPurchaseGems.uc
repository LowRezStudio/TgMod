class UIPurchaseGems extends TgGfxScene within GFxMoviePlayer
    native(GFxScene);

const UIPURCHASEGEMS_DURABLEPACKS = 2;
const UIPURCHASEGEMS_CONSUMABLEPACKS = 7;
const UIPURCHASEGEMS_DURABLE_DETAILS = 5;
const UI_FOUNDERS_PACK_ID = 21371;

enum UIPG_DurablePacks
{
    UIPG_Founders,                  // 0
    UIPG_Realm,                     // 1
    UIPG_MAX                        // 2
};

struct native UIDurablePack
{
    var GFxObject Obj;
    var GFxObject Price;
    var GFxObject PurchaseButton;
    var GFxObject Highlight;
    var GFxObject Refund;
    var GFxObject SaleBanner;

    structdefaultproperties
    {
        Obj=none
        Price=none
        PurchaseButton=none
        Highlight=none
        Refund=none
        SaleBanner=none
    }
};

struct native UIConsumablePack
{
    var GFxObject Obj;
    var GFxObject Title;
    var GFxObject Icon;
    var GFxObject Price;
    var GFxObject PurchaseButton;
    var GFxObject Highlight;
    var GFxObject SaleBanner;

    structdefaultproperties
    {
        Obj=none
        Title=none
        Icon=none
        Price=none
        PurchaseButton=none
        Highlight=none
        SaleBanner=none
    }
};

var UIDurablePack m_DurablePack[2];
var UIConsumablePack m_ConsumablePack[7];
var GFxObject m_mcCancelButton;
var GFxObject m_mcOverlay;
var GFxObject m_mcFrame;
var GFxObject m_mcBlocker;
var array<ProductInfo> m_AllProducts;

event GetAvailableProducts(OnlineSubsystem.EMediaItemType MediaType, out array<MarketplaceProductDetails> AvailableProducts)
{
    // End:0xB2
    if(NotEqual_InterfaceInterface(m_pMovie.MarketplaceInterface, OnlineMarketplaceInterface(none)))
    {
        m_pMovie.MarketplaceInterface.GetAvailableProducts(byte(m_pMovie.GetLP().ControllerId), MediaType, AvailableProducts);
    }
    //return;    
}

static event GetInventoryItems(out array<MarketplaceInventoryItem> InventoryItems)
{
    local OnlineSubsystem OnlineSub;
    local PlayerController PC;
    local LocalPlayer LP;

    PC = Class'Engine.WorldInfo'.static.GetWorldInfo().GetALocalPlayerController();
    // End:0x15B
    if(PC != none)
    {
        LP = LocalPlayer(PC.Player);
        // End:0x15B
        if(LP != none)
        {
            OnlineSub = Class'Engine.GameEngine'.static.GetOnlineSubsystem();
            // End:0x15B
            if((OnlineSub != none) && NotEqual_InterfaceInterface(OnlineSub.MarketplaceInterface, OnlineMarketplaceInterface(none)))
            {
                OnlineSub.MarketplaceInterface.GetInventoryItems(byte(LP.ControllerId), InventoryItems);
            }
        }
    }
    //return;    
}

defaultproperties
{
    m_UISceneClass=Class'TgClient.UIScene_SceneAsPopup'
    m_OptionList[0]=14
    m_OptionList[1]=4
    m_nBackground=1
    m_bBlur=true
    m_bIsPopup=true
    m_Name="UIPurchaseGems"
}