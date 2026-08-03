class TgInventoryObject_Listen_Combo_Ruckus extends TgInventoryObject_Listen_Combo
    native(Inventory);

var TgPawn_Ruckus m_CachedRuckusOwner;
var int m_nDamageReductionStacks;
var int m_nBonusDamageStacks;
var float m_fDamageReductionStackTime;
var float m_fBonusDamageStackTime;
var bool m_bEmitterActive;
var bool m_bComboEffectsOn;
var float m_fComboBonusTime;
