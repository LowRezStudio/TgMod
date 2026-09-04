class TgDevice_Projector extends TgDevice_EmitterMod
    native(Devices)
    hidecategories(Navigation)
    config(Engine);

native function ApplyTouchEffect(Actor Target, TgDevice_Emitter Emitter);  // Export UTgDevice_Projector::execApplyTouchEffect(FFrame&, void* const)

native function RemoveTouchEffect(Actor Target, TgDevice_Emitter Emitter);  // Export UTgDevice_Projector::execRemoveTouchEffect(FFrame&, void* const)
