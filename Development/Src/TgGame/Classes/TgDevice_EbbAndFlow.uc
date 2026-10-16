class TgDevice_EbbAndFlow extends TgDevice
    native(ChampMakoa)
    hidecategories(Navigation)
    config(Engine);

var TgDevice m_ShellSpinDevice;

simulated event StartFire(byte FireModeNum) { }

simulated event bool ShouldCooldownAfterFire() { }
