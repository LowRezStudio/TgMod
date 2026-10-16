class TgInvListener_SoulChargesConsumed extends TgInventoryObject_Listen_AbilityProcBase
    native(Inventory)
    config(Engine);

var bool m_bIsListenerActive;
var int m_nNumSoulCharges;
