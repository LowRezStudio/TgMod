class TgDevice_SleightOfHand extends TgDevice
    native(ChampAndroxus)
    hidecategories(Navigation)
    config(Engine);

var TgDevice m_InhandWeapon;

simulated event bool ShouldCooldownAfterFire() { }
