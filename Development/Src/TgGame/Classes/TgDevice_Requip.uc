class TgDevice_Requip extends TgDevice
    native(ChampLex)
    hidecategories(Navigation)
    config(Engine);

var TgDevice m_InhandWeapon;

simulated event bool ShouldCooldownAfterFire() { }
