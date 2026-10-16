class TgDeviceFire_DeployablesOnly extends TgDeviceFire
    native(Devices)
    config(Engine);

native function bool IsValidTarget(Actor P, optional TgDeviceFire.DeviceTargeterType eTargeterType=0, optional bool bIgnoreHealth, optional bool bInvertTeam);  // Export UTgDeviceFire_DeployablesOnly::execIsValidTarget(FFrame&, void* const)
