class TgDevice_Somersault extends TgDevice
    native(ChampCassie)
    hidecategories(Navigation)
    config(Engine);

var TgDevice m_DodgeRollDevice;

simulated event StartFire(byte FireModeNum) { }

simulated event bool ShouldCooldownAfterFire() { }
