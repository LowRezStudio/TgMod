interface TgGameplayCurveOwner extends Interface
    abstract
    native(GameplayCurves);

// Export UTgGameplayCurveOwner::execGetCurrentGameplayCurveSet(FFrame&, void* const)
native function TgGameplayCurvesSet GetCurrentGameplayCurveSet(TgGameplayCurvesSet.ECurveSetTypes Type);

// Export UTgGameplayCurveOwner::execUseRangeFalloffCurve(FFrame&, void* const)
native function bool UseRangeFalloffCurve();
