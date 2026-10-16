class TgInventoryObject_Listen_TagForLifesteal extends TgInventoryObject_Listen_AbilityProcBase
    native(Inventory);

var array<Actor> m_TagActors;
var array<float> m_TagTimes;
var TgDeviceFire_MirrorDamageToHeal m_CachedFiremode;
