class TgDevice_Rattle extends TgDevice_ShieldMod
    native(Devices)
    hidecategories(Navigation);

// Export UTgDevice_Rattle::execApplyTouchEffect(FFrame&, void* const)
native function ApplyTouchEffect(Actor Target);
