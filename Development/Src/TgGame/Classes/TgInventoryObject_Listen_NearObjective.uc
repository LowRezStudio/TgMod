class TgInventoryObject_Listen_NearObjective extends TgInvListener
    native(Inventory)
    config(Engine);

var bool m_bIsActive;
var TgPawn_Character m_CachedCharacterPawn;
