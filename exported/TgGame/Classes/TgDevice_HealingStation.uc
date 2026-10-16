class TgDevice_HealingStation extends TgDevice_TurretMod
    native(Devices)
    hidecategories(Navigation);

var float m_fFireTimer;
var TgPawn m_CachedPawnOwner;
