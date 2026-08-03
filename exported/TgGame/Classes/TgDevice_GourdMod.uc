class TgDevice_GourdMod extends TgDevice
    native(ChampMalDamba)
    hidecategories(Navigation);

var array<Actor> m_ImmuneTargets;
var array<float> m_ImmuneTimes;

// Export UTgDevice_GourdMod::execApplyOnTouchEffect(FFrame&, void* const)
native function ApplyOnTouchEffect(Actor Target);

// Export UTgDevice_GourdMod::execApplyEffect(FFrame&, void* const)
native function ApplyEffect(TgDeploy_Gourd gourd, Actor Target);

// Export UTgDevice_GourdMod::execRemoveEffect(FFrame&, void* const)
native function RemoveEffect(TgDeploy_Gourd gourd, Actor Target);
