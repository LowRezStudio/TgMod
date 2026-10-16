class TgGameplayCurvesSet_RecoilSimple extends TgGameplayCurvesSet
    native(GameplayCurves)
    editinlinenew
    hidecategories(Object)
    config(Engine)
    dependson(TgGameplayCurvesSet_Recoil);

var (CurveSet) RawDistributionFloat HorizRecoil1;
var (CurveSet) RawDistributionFloat HorizRecoil2;
var (CurveSet) RawDistributionFloat VertRecoil1;
var (CurveSet) RawDistributionFloat VertRecoil2;
var (CurveSet) TgGameplayCurvesSet_Recoil.EPaladinsRecoilType RecoilType;

simulated function float GetHorizRecoilValue(float firingTime, float randInput) { }

simulated function float GetVertRecoilValue(float firingTime, float randInput) { }

defaultproperties
{}
