class UINotificationCenter extends TgGfxScene within GFxMoviePlayer
    native(GFxScene)
    config(Engine)
    dependson(TgData_Notifications);

const MAX_TABS = 8;

const MAX_ENTRIES = 6;

const MAX_COUPON_ENTRIES = 4;

struct Tab {
    var GFxObject mcRoot;
    var GFxObject mcTf;
    var GFxObject mcSelected;
    var GFxObject mcNewIcon;
    var GFxObject mcNewCountTf;
    var init string sUrl;
    var int nCTACount;
    structdefaultproperties {}
};

struct Entry {
    var GFxObject mcRoot;
    var GFxObject mcRootButton;
    var GFxObject mcTitleTf;
    var GFxObject mcDescTf;
    var GFxObject mcTimestampTf;
    var GFxObject mcCategoryTf;
    var GFxObject mcClose;
    var GFxObject mcButton;
    var GFxObject mcNewIcon;
    var GFxObject mcNewTf;
    var GFxObject mcItemImageStack;
    var GFxObject mcCardImageStack;
    var GFxObject mcChestImageStack;
    var GFxObject mcTexture;
    structdefaultproperties {}
};

struct CouponEntry {
    var GFxObject mcRoot;
    var GFxObject mcRootButton;
    var GFxObject mcTitle;
    var GFxObject mcExpiration;
    var GFxObject mcCostCurrent;
    var GFxObject mcCostCurrentIcon;
    var GFxObject mcCostPrev;
    var GFxObject mcCostPrevIcon;
    var GFxObject mcCostPrevStrike;
    var GFxObject mcCTA;
    var GFxObject mcCTAText;
    var GFxObject mcButton;
    var GFxObject mcItemImageStack;
    var GFxObject mcCardImageStack;
    var GFxObject mcChestImageStack;
    var GFxObject mcTexture;
    structdefaultproperties {}
};

var array<Tab> m_Tabs;
var array<string> m_TabLabels;
var array<Entry> m_Entries;
var array<CouponEntry> m_CouponEntries;
var int m_nCurrentTab;
var int m_nLastTab;
var int m_nScrollPos;
var GFxObject m_mcCloseButton;
var GFxObject m_mcClearButton;
var GFxObject m_mcRoot;
var GFxObject m_mcNotificationCenterPanel;
var GFxObject m_mcWebPanel;
var GFxObject m_mcScrollBar;
var GFxObject m_mcCouponPanel;
var GFxObject m_mcCouponTitle;
var GFxObject m_mcCouponScrollbar;
var TgData_Notifications.NotificationType m_eFilterByType;
var UIComponent_Dropdown m_FilterDropdown;
var init native array<init Pointer> m_DropdownOptions;
var UIComponent_DailyRewards m_DailyRewards;
var TgGFxGroup m_grpTabs;
var TgGFxGroup m_grpEntries;
var TgGFxGroup m_grpCouponEntries;
var bool m_bInCouponPurchase;

defaultproperties
{
    m_TabLabels[0]="m_lsTabNotifications"
    m_TabLabels[1]="m_lsTabDailyRewards"
    m_TabLabels[2]="m_lsTabCoupons"
    m_nLastTab=-1
    m_UISceneClass=Class'UIScene_UINotificationCenter'
    m_OptionList[0]=14
    m_OptionList[1]=4
    m_bBlur=true
    m_bIsPopup=true
    m_bAllowMultipleOnStack=false
    m_Name="UINotificationCenter"
}
