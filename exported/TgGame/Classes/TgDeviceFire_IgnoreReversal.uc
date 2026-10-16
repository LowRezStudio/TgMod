class TgDeviceFire_IgnoreReversal extends TgDeviceFire
    native(Devices);

// Export UTgDeviceFire_IgnoreReversal::execIgnoreTargetForBlocking(FFrame&, void* const)
native function bool IgnoreTargetForBlocking(Actor Target);
