class TgDeviceFire_WorldLOSOnly extends TgDeviceFire
    native(Devices);

// Export UTgDeviceFire_WorldLOSOnly::execIgnoreTargetForBlocking(FFrame&, void* const)
native function bool IgnoreTargetForBlocking(Actor Target);
