class TgDevice_ShellShieldMod extends TgDevice
    native(Devices)
    hidecategories(Navigation)
    config(Engine);

native function ApplyTouchEffect(Actor Target);  // Export UTgDevice_ShellShieldMod::execApplyTouchEffect(FFrame&, void* const)

native function int ApplyDamageTakenEffect(int totalDamage);  // Export UTgDevice_ShellShieldMod::execApplyDamageTakenEffect(FFrame&, void* const)
