class TgGameplayCurves extends Object
    native(GameplayCurves)
    editinlinenew;

var() noclear editinline array<editinline TgGameplayCurvesSet> CurveSets;
var() noclear editinlineuse array<editinlineuse TgGameplayCurves> InheritedCurves;
var() editoronly transient bool bShowInheritedCurves;
var() editoronly transient bool bInheritedCurvesShareEditorTab;
var export InterpCurveEdSetup CurveEdSetup;

// Export UTgGameplayCurves::execGetCurvesSetByType(FFrame&, void* const)
native function TgGameplayCurvesSet GetCurvesSetByType(TgGameplayCurvesSet.ECurveSetTypes curveType);

// Export UTgGameplayCurves::execGetPrimaryDistributionValueByType(FFrame&, void* const)
native function bool GetPrimaryDistributionValueByType(TgGameplayCurvesSet.ECurveSetTypes curveType, float T, out float Value);
