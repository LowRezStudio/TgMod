class TgInventoryObject_Listen_Combo_Grohk extends TgInventoryObject_Listen_Combo
    native(Inventory)
    config(Engine);

var float m_fFirstHitThisTickTimestamp;
var int m_nHitsThisChain;
var bool m_bBonusActive;
