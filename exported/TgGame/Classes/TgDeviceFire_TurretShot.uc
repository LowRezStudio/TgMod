class TgDeviceFire_TurretShot extends TgDeviceFire
    native(ChampBarik);

// Export UTgDeviceFire_TurretShot::execIsValidTarget(FFrame&, void* const)
native function bool IsValidTarget(Actor P, optional TgDeviceFire.DeviceTargeterType eTargeterType = 0, optional bool bIgnoreHealth, optional bool bInvertTeam);
