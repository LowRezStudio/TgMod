class TgGameplayCurvesSet_DamageFalloff extends TgGameplayCurvesSet
    native(GameplayCurves)
    editinlinenew
    hidecategories(Object);

var(CurveSet) RawDistributionFloat DamageFalloff;
var(CurveSet) bool bIsRangeNormalized;
var(CurveSet) bool bExcludeEffectiveRange;

defaultproperties
{
    // Reference: DistributionFloatConstantCurve'TgGame.Default__TgGameplayCurvesSet_DamageFalloff.DistributionDamageFalloff'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionDamageFalloff'
    begin object name="DistributionDamageFalloff" class=Engine.DistributionFloatConstantCurve
    end object
    DamageFalloff=(Distribution=Distribution=DistributionDamageFalloff,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    CurveSetType=ECurveSetTypes.CST_DamageFalloff
}