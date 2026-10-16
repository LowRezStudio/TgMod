class TgDeviceFire_IgnoreReversal extends TgDeviceFire
    native(Devices)
    config(Engine);

native function bool IgnoreTargetForBlocking(Actor Target);  // Export UTgDeviceFire_IgnoreReversal::execIgnoreTargetForBlocking(FFrame&, void* const)
