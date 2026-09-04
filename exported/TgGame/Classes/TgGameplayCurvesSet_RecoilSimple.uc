class TgGameplayCurvesSet_RecoilSimple extends TgGameplayCurvesSet
    native(GameplayCurves)
    editinlinenew
    hidecategories(Object);

var(CurveSet) RawDistributionFloat HorizRecoil1;
var(CurveSet) RawDistributionFloat HorizRecoil2;
var(CurveSet) RawDistributionFloat VertRecoil1;
var(CurveSet) RawDistributionFloat VertRecoil2;
var(CurveSet) TgGameplayCurvesSet_Recoil.EPaladinsRecoilType RecoilType;

simulated function float GetHorizRecoilValue(float firingTime, float randInput)
{
    return Lerp(GetDistributionValue(HorizRecoil1, firingTime), GetDistributionValue(HorizRecoil2, firingTime), randInput);
    //return ReturnValue;    
}

simulated function float GetVertRecoilValue(float firingTime, float randInput)
{
    return Lerp(GetDistributionValue(VertRecoil1, firingTime), GetDistributionValue(VertRecoil2, firingTime), randInput);
    //return ReturnValue;    
}

defaultproperties
{
    // Reference: DistributionFloatConstantCurve'TgGame.Default__TgGameplayCurvesSet_RecoilSimple.DistributionHorizRecoil1'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionHorizRecoil1'
    begin object name="DistributionHorizRecoil1" class=Engine.DistributionFloatConstantCurve
    end object
    // Reference: DistributionFloatConstantCurve'TgGame.Default__TgGameplayCurvesSet_RecoilSimple.DistributionHorizRecoil2'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionHorizRecoil2'
    begin object name="DistributionHorizRecoil2" class=Engine.DistributionFloatConstantCurve
    end object
    // Reference: DistributionFloatConstantCurve'TgGame.Default__TgGameplayCurvesSet_RecoilSimple.DistributionVertRecoil1'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionVertRecoil1'
    begin object name="DistributionVertRecoil1" class=Engine.DistributionFloatConstantCurve
    end object
    // Reference: DistributionFloatConstantCurve'TgGame.Default__TgGameplayCurvesSet_RecoilSimple.DistributionVertRecoil2'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionVertRecoil2'
    begin object name="DistributionVertRecoil2" class=Engine.DistributionFloatConstantCurve
    end object
    HorizRecoil1=(Distribution=Distribution=DistributionHorizRecoil1,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    HorizRecoil2=(Distribution=Distribution=DistributionHorizRecoil2,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    VertRecoil1=(Distribution=Distribution=DistributionVertRecoil1,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    VertRecoil2=(Distribution=Distribution=DistributionVertRecoil2,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    CurveSetType=ECurveSetTypes.CST_RecoilSimple
}