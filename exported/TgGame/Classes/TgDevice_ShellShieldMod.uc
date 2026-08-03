class TgDevice_ShellShieldMod extends TgDevice
    native(Devices)
    hidecategories(Navigation);

// Export UTgDevice_ShellShieldMod::execApplyTouchEffect(FFrame&, void* const)
native function ApplyTouchEffect(Actor Target);

// Export UTgDevice_ShellShieldMod::execApplyDamageTakenEffect(FFrame&, void* const)
native function int ApplyDamageTakenEffect(int totalDamage);
