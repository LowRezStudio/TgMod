class UIDataCommon extends UIDataObject
    native(UIData)
    config(Engine);

const DEFAULT_ANNOUNCER_PACK = 18647;

var int m_nLevel;
var int m_nItemsTotal;
var int m_nItemsOwned;
var int m_nXPProgress;
var int m_nXPRequired;
var int m_nActiveMount;
var float m_fXPPercent;
var float m_fItemsPercent;
var array<UIDataItem> m_BurnAll;
var array<UIDataItem> m_BurnA;
var array<UIDataItem> m_BurnB;
var array<UIDataItem> m_BurnC;
var array<UIDataItem> m_BurnD;
var array<UIDataItem> m_Mounts;
var array<UIDataItem> m_EquipableTitles;
var array<UIDataItem> m_AnnouncerPacks;
var array<UIDataItem> m_Chests;
var array<UIDataItem> m_MatchBoosters;

defaultproperties
{
    m_nActiveMount=11512
}
