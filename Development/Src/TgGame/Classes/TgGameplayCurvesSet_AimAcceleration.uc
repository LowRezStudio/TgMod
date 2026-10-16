class TgGameplayCurvesSet_AimAcceleration extends TgGameplayCurvesSet
    native(GameplayCurves)
    editinlinenew
    hidecategories(Object)
    config(Engine);

var (CurveSet) noclear editinline array<TgAimAccelerationCurves> AimAccelerationCurves;

native simulated function UpdateAimAcceleration(out float TurnSpeedX, out float TurnSpeedY, out float aTurn, out float aLookUp, float DeltaTime, int CurveSetToUse, int AccelerationBoost, int Algorithm);  // Export UTgGameplayCurvesSet_AimAcceleration::execUpdateAimAcceleration(FFrame&, void* const)

defaultproperties
{
    CurveSetType=CST_AimAcceleration
}
