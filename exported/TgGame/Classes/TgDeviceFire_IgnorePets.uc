class TgDeviceFire_IgnorePets extends TgDeviceFire
    native(Devices);

// Export UTgDeviceFire_IgnorePets::execIsValidTarget(FFrame&, void* const)
native function bool IsValidTarget(Actor P, optional TgDeviceFire.DeviceTargeterType eTargeterType = 0, optional bool bIgnoreHealth, optional bool bInvertTeam);
