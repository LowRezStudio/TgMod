class UIDataItem extends UIDataObject
    native(UIData)
    config(Engine);

enum ItemType {
    CIT_Card,  // 0
    CIT_Head,  // 1
    CIT_Skin,  // 2
    CIT_Skill,  // 3
    CIT_Weapon,  // 4
    CIT_Emote,  // 5
    CIT_Spray,  // 6
    CIT_MVPPose,  // 7
    CIT_Voice,  // 8
    CIT_Set,  // 9
    CIT_Mount,  // 10
    CIT_BurnCard,  // 11
    CIT_Talent,  // 12
    CIT_Title,  // 13
    CIT_Collection,  // 14
    CIT_AnnouncerPack,  // 15
    CIT_Chest,  // 16
    CIT_MatchBooster,  // 17
};

enum AbilityModifiedByDevice {
    AMBD_Weapon,  // 0
    AMBD_AltFire,  // 1
    AMBD_Ability,  // 2
    AMBD_Movement,  // 3
};

enum ItemRarity {
    IRT_Default,  // 0
    IRT_Common,  // 1
    IRT_Uncommon,  // 2
    IRT_Rare,  // 3
    IRT_Epic,  // 4
    IRT_Legendary,  // 5
    IRT_Ancient,  // 6
};

enum SimplifiedItemObtainabilityValue {
    SIOV_Normal,  // 0
    SIOV_Limited,  // 1
    SIOV_Exclusive,  // 2
    SIOV_Mastery,  // 3
    SIOV_Quest,  // 4
};

enum StoreItemsSortingType {
    SIST_ByInGame,  // 0
    SIST_ByRarityDescending,  // 1
};

var UIDataItem.ItemType m_eItemType;
var byte m_eRarity;
var dword m_dwPlayerInventoryId;
var dword m_dwCharInventoryId;
var int m_nBotId;
var int m_nObtainability;
var int m_nVendor;
var int m_nId;
var int m_nIcon;
var int m_nInGameCredits;
var int m_nRank;
var int m_nUpgradeLevel;
var int m_nCooldown;
var bool m_bPurchasable;
var bool m_bQuestExclusive;
var bool m_bDefault;
var init string m_sName;
var init string m_sDesc;
var init string m_sIcon;
var int m_nHintId;
var int nIndex;
var int m_nEntitlementId;
var UIDataItem m_pOwnershipItem;
var array<UIDataItem> m_SubItems;
var array<UIDataPrice> m_PriceData;

native function OnTeamModelUpdated();  // Export UUIDataItem::execOnTeamModelUpdated(FFrame&, void* const)
