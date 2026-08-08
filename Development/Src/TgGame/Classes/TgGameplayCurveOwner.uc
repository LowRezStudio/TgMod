interface TgGameplayCurveOwner extends Interface
    dependson(TgGameplayCurvesSet);

function TgGameplayCurvesSet GetCurrentGameplayCurveSet(TgGameplayCurvesSet.ECurveSetTypes Type);  // Export UTgGameplayCurveOwner::execGetCurrentGameplayCurveSet(FFrame&, void* const)

function bool UseRangeFalloffCurve();  // Export UTgGameplayCurveOwner::execUseRangeFalloffCurve(FFrame&, void* const)
