class TgInventoryObject_Listen_ActiveWhileDeployableActive extends TgInventoryObject_Listen_ActiveWhileOffCooldown
    native(Inventory)
    config(Engine);

var int m_nActiveDeployableCount;
