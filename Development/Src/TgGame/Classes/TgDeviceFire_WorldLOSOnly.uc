class TgDeviceFire_WorldLOSOnly extends TgDeviceFire
    native(Devices)
    config(Engine);

native function bool IgnoreTargetForBlocking(Actor Target);  // Export UTgDeviceFire_WorldLOSOnly::execIgnoreTargetForBlocking(FFrame&, void* const)
