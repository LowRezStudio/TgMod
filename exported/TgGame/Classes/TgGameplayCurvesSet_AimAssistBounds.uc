class TgGameplayCurvesSet_AimAssistBounds extends TgGameplayCurvesSet
    native(GameplayCurves)
    editinlinenew
    hidecategories(Object);

var(CurveSet) RawDistributionFloat BoundsScaleHorizByDistance;
var(CurveSet) RawDistributionFloat BoundsScaleVertByDistance;
var(CurveSet) bool bUseHorizCurveForVert;
var(CurveSet) float fBaseHorizMultiplier;
var(CurveSet) float fBaseVertMultiplier;

simulated function GetBoundsScale(float fDistance, out float fHorizBoundsScale, out float fVertBoundsScale)
{
    fHorizBoundsScale = GetDistributionValue(BoundsScaleHorizByDistance, fDistance / 16.0000000);
    fVertBoundsScale = ((bUseHorizCurveForVert) ? fHorizBoundsScale : GetDistributionValue(BoundsScaleVertByDistance, fDistance / 16.0000000));
    fHorizBoundsScale *= fBaseHorizMultiplier;
    fVertBoundsScale *= fBaseVertMultiplier;
    //return;    
}

defaultproperties
{
    // Reference: DistributionFloatConstantCurve'TgGame.Default__TgGameplayCurvesSet_AimAssistBounds.DistributionBoundsScaleHorizByDistance'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionBoundsScaleHorizByDistance'
    begin object name="DistributionBoundsScaleHorizByDistance" class=Engine.DistributionFloatConstantCurve
    end object
    // Reference: DistributionFloatConstantCurve'TgGame.Default__TgGameplayCurvesSet_AimAssistBounds.DistributionBoundsScaleVertByDistance'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionBoundsScaleVertByDistance'
    begin object name="DistributionBoundsScaleVertByDistance" class=Engine.DistributionFloatConstantCurve
    end object
    BoundsScaleHorizByDistance=(Distribution=Distribution=DistributionBoundsScaleHorizByDistance,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    BoundsScaleVertByDistance=(Distribution=Distribution=DistributionBoundsScaleVertByDistance,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    fBaseHorizMultiplier=1.0000000
    fBaseVertMultiplier=1.0000000
    CurveSetType=ECurveSetTypes.CST_AimAssistBoundsScale
}