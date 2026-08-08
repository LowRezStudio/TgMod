class TgGameplayCurvesSet_Simple extends TgGameplayCurvesSet
    abstract
    native(GameplayCurves)
    editinlinenew
    hidecategories(Object,Object)
    config(Engine);

var (CurveSet) RawDistributionFloat PrimaryCurve;
var const name PrimaryCurveTabName;
var const name PrimaryCurveName;

native function bool GetPrimaryDistributionValue(float T, out float Value);  // Export UTgGameplayCurvesSet_Simple::execGetPrimaryDistributionValue(FFrame&, void* const)

defaultproperties
{}
