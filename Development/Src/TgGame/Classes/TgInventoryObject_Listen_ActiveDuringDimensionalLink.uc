class TgInventoryObject_Listen_ActiveDuringDimensionalLink extends TgInvListener
    native(Inventory)
    config(Engine);

var TgDevice_DimensionalLink m_CachedLinkDevice;
var bool m_bCardIsActive;
