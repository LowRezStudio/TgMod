class UIDataChampion extends UIDataItem
    native(UIData)
    config(Engine)
    dependson(UIDataObject);

const ALL_CHAMPIONS = 0;

const OWNED_CHAMPIONS = -1;

enum EArchetypes {
    ARCHETYPE_TANK,  // 0
    ARCHETYPE_DAMAGE,  // 1
    ARCHETYPE_SUPPORT,  // 2
    ARCHETYPE_FLANK,  // 3
};

enum SimplifiedCardType {
    SCT_Card,  // 0
    SCT_BurnCard,  // 1
    SCT_Talent,  // 2
};

struct MasteryRewards {
    var int nLevel;
    var Pointer pItemInfo;
    var int nCurrency;
    var int nCurrencyType;
    var int nChests;
    var bool bEntitlement;
    structdefaultproperties {}
};

var int m_nLevel;
var int m_nItemId;
var int m_nArchetype;
var int m_nItemsTotal;
var int m_nItemsOwned;
var int m_nXPProgress;
var int m_nXPRequired;
var int m_nActiveSet;
var int m_nActiveTalent;
var int m_nActiveDeck;
var int m_nActiveSkin;
var int m_nActiveHead;
var int m_nActiveEmote;
var int m_nActiveVoice;
var int m_nActiveWeapon;
var int m_nActiveSpray;
var int m_nActiveMVPPose;
var bool m_bCanUseMount;
var bool m_bIsOnRotation;
var float m_fIconOffsetX;
var float m_fIconOffsetY;
var float m_fXPPercent;
var float m_fItemsPercent;
var string m_sLore;
var string m_sDamage;
var string m_sSpecial;
var array<UIDataItem> m_Sets;
var array<UIDataItem> m_Cards;
var array<UIDataItem> m_Heads;
var array<UIDataItem> m_Skins;
var array<UIDataItem> m_Skills;
var array<UIDataItem> m_Weapons;
var array<UIDataItem> m_Emotes;
var array<UIDataItem> m_Sprays;
var array<UIDataItem> m_MVPPoses;
var array<UIDataItem> m_Voices;
var array<ItemGroup> m_Groups;
var array<UIDataDeck> m_Decks;
