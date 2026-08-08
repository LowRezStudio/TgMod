class TgDevice_Failsafe extends TgDevice
    native(ChampBarik)
    hidecategories(Navigation)
    config(Engine);

var TgDevice m_RocketBootsDevice;

simulated event StartFire(byte FireModeNum) { }

simulated event bool ShouldCooldownAfterFire() { }
