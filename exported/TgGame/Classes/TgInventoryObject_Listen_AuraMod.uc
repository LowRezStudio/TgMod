class TgInventoryObject_Listen_AuraMod extends TgInvListener
    native(Inventory);

var array<Actor> m_AffectedActors;
var bool m_bAuraIsActive;
var TgDevice_Aura m_CachedAuraDevice;
