class TgDevice_Restock extends TgDevice
    native(ChampLex)
    hidecategories(Navigation)
    config(Engine);

var TgDevice m_InhandWeapon;

simulated event bool ShouldCooldownAfterFire() { }
