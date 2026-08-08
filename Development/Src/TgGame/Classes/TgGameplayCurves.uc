class TgGameplayCurves extends Object
    native(GameplayCurves)
    editinlinenew
    config(Engine)
    dependson(TgGameplayCurvesSet);

var () noclear editinline array<TgGameplayCurvesSet> CurveSets;
var () noclear editinlineuse array<editinlineuse TgGameplayCurves> InheritedCurves;
var () editoronly transient bool bShowInheritedCurves;
var () editoronly transient bool bInheritedCurvesShareEditorTab;
var export InterpCurveEdSetup CurveEdSetup;

native function TgGameplayCurvesSet GetCurvesSetByType(TgGameplayCurvesSet.ECurveSetTypes curveType);  // Export UTgGameplayCurves::execGetCurvesSetByType(FFrame&, void* const)

native function bool GetPrimaryDistributionValueByType(TgGameplayCurvesSet.ECurveSetTypes curveType, float T, out float Value);  // Export UTgGameplayCurves::execGetPrimaryDistributionValueByType(FFrame&, void* const)
