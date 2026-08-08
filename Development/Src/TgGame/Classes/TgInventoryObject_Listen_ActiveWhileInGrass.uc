class TgInventoryObject_Listen_ActiveWhileInGrass extends TgInvListener
    native(Inventory)
    config(Engine);

var bool m_bCachedIsInGrass;
var float s_fExitTimestamp;
