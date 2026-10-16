class TgDeviceFire_TurretShot extends TgDeviceFire
    native(ChampBarik)
    config(Engine);

native function bool IsValidTarget(Actor P, optional TgDeviceFire.DeviceTargeterType eTargeterType=0, optional bool bIgnoreHealth, optional bool bInvertTeam);  // Export UTgDeviceFire_TurretShot::execIsValidTarget(FFrame&, void* const)
