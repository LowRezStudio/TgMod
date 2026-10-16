class TgGameplayCurvesSet_DamageFalloffAOE extends TgGameplayCurvesSet
    native(GameplayCurves)
    editinlinenew
    hidecategories(Object)
    config(Engine);

var (CurveSet) RawDistributionFloat DamageFalloff;
var (CurveSet) bool bIsRangeNormalized;
var (CurveSet) bool bExcludeEffectiveRange;

defaultproperties
{}
