class TgInventoryObject_Listen_ReduceInhandSelfDamage extends TgInventoryObject_Listen_ActiveWhileOffCooldown
    native(Inventory)
    config(Engine);

var float m_fCachedBaseDamage;
var float m_fCachedBaseKnockback;
