class TgDevice_SmokeScreenMod extends TgDevice
    native(Devices)
    hidecategories(Navigation);

var array<Actor> m_ImmuneTargets;
var array<float> m_ImmuneTimes;

// Export UTgDevice_SmokeScreenMod::execApplyOnTouchEffect(FFrame&, void* const)
native function ApplyOnTouchEffect(Actor Target);

// Export UTgDevice_SmokeScreenMod::execApplyOwnerTouchEffect(FFrame&, void* const)
native function ApplyOwnerTouchEffect(Actor Target);

// Export UTgDevice_SmokeScreenMod::execApplyEffect(FFrame&, void* const)
native function ApplyEffect(TgDeploy_SmokeScreen smokeScreen, Actor Target);

// Export UTgDevice_SmokeScreenMod::execRemoveEffect(FFrame&, void* const)
native function RemoveEffect(TgDeploy_SmokeScreen smokeScreen, Actor Target);
