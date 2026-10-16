class TgDevice_Rattle extends TgDevice_ShieldMod
    native(Devices)
    hidecategories(Navigation)
    config(Engine);

native function ApplyTouchEffect(Actor Target);  // Export UTgDevice_Rattle::execApplyTouchEffect(FFrame&, void* const)
