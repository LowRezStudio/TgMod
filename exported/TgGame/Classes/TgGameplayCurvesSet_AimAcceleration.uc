class TgGameplayCurvesSet_AimAcceleration extends TgGameplayCurvesSet
    native(GameplayCurves)
    editinlinenew
    hidecategories(Object);

var(CurveSet) noclear editinline array<editinline TgAimAccelerationCurves> AimAccelerationCurves;

// Export UTgGameplayCurvesSet_AimAcceleration::execUpdateAimAcceleration(FFrame&, void* const)
native simulated function UpdateAimAcceleration(out float TurnSpeedX, out float TurnSpeedY, out float aTurn, out float aLookUp, float DeltaTime, int CurveSetToUse, int AccelerationBoost, int Algorithm);

defaultproperties
{
    CurveSetType=ECurveSetTypes.CST_AimAcceleration
}