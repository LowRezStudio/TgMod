class TgGameplayCurvesSet_AimAssistBounds extends TgGameplayCurvesSet
    native(GameplayCurves)
    editinlinenew
    hidecategories(Object)
    config(Engine);

var (CurveSet) RawDistributionFloat BoundsScaleHorizByDistance;
var (CurveSet) RawDistributionFloat BoundsScaleVertByDistance;
var (CurveSet) bool bUseHorizCurveForVert;
var (CurveSet) float fBaseHorizMultiplier;
var (CurveSet) float fBaseVertMultiplier;

simulated function GetBoundsScale(float fDistance, out float fHorizBoundsScale, out float fVertBoundsScale) { }

defaultproperties
{}
