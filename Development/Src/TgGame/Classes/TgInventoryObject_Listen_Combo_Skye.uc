class TgInventoryObject_Listen_Combo_Skye extends TgInventoryObject_Listen_Combo
    native(Inventory)
    config(Engine);

var float m_fLastStealthTime;
var bool m_bComboActive;
var bool m_bCanTriggerCombo;
var int m_nHitStacks;
