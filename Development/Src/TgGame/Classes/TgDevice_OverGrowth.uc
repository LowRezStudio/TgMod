class TgDevice_OverGrowth extends TgDevice
    native(ChampGrover)
    hidecategories(Navigation)
    config(Engine);

var TgDevice m_VineDevice;

simulated event StartFire(byte FireModeNum) { }

simulated event bool ShouldCooldownAfterFire() { }
