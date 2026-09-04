class TgGameplayCurvesSet_Simple extends TgGameplayCurvesSet
    abstract
    native(GameplayCurves)
    editinlinenew
    hidecategories(Object,Object);

var(CurveSet) RawDistributionFloat PrimaryCurve;
var const name PrimaryCurveTabName;
var const name PrimaryCurveName;

// Export UTgGameplayCurvesSet_Simple::execGetPrimaryDistributionValue(FFrame&, void* const)
native function bool GetPrimaryDistributionValue(float T, out float Value);

defaultproperties
{
    // Reference: DistributionFloatConstantCurve'TgGame.Default__TgGameplayCurvesSet_Simple.DistributionPrimaryCurve'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionPrimaryCurve'
    begin object name="DistributionPrimaryCurve" class=Engine.DistributionFloatConstantCurve
    end object
    PrimaryCurve=(Distribution=Distribution=DistributionPrimaryCurve,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    PrimaryCurveTabName="PrimaryCurve"
    PrimaryCurveName="PrimaryCurve"
}