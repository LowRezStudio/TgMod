class TgDevice_EmitterMod extends TgDevice
    native(Devices)
    hidecategories(Navigation)
    config(Engine);

var bool m_bIsOnOthers;
var bool m_bIsOnOwner;

native function ApplyTouchEffect(Actor Target, TgDevice_Emitter Emitter);  // Export UTgDevice_EmitterMod::execApplyTouchEffect(FFrame&, void* const)

native function RemoveTouchEffect(Actor Target, TgDevice_Emitter Emitter);  // Export UTgDevice_EmitterMod::execRemoveTouchEffect(FFrame&, void* const)
