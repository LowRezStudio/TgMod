class TgDevice_Survival extends TgDevice
    native(ChampDrogoz)
    hidecategories(Navigation)
    config(Engine);

var TgDevice m_ThrustDevice;

simulated event StartFire(byte FireModeNum) { }

simulated event bool ShouldCooldownAfterFire() { }
