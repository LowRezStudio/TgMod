class TgDevice_BarricadeMod extends TgDevice
    native(Devices)
    hidecategories(Navigation);

// Export UTgDevice_BarricadeMod::execApplyTouchEffect(FFrame&, void* const)
native function ApplyTouchEffect(Actor Target);
