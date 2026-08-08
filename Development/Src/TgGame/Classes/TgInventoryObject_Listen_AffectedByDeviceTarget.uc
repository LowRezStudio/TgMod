class TgInventoryObject_Listen_AffectedByDeviceTarget extends TgInventoryObject_Listen_AffectedByDevice
    native(Inventory)
    config(Engine);

var bool m_bIsCardActive;
var array<Actor> m_HitActors;
