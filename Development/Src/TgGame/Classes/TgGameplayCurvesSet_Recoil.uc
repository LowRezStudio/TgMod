class TgGameplayCurvesSet_Recoil extends TgGameplayCurvesSet
    native(GameplayCurves)
    editinlinenew
    hidecategories(Object)
    config(Engine);

enum EPaladinsRecoilType {
    PRT_Normal,  // 0
    PRT_AimDownSights,  // 1
    PRT_StimActive,  // 2
};

var (CurveSet) noclear editinline array<TgRecoilKeyframe> HorizRecoil;
var (CurveSet) noclear editinline array<TgRecoilKeyframe> VertRecoil;
var (CurveSet) TgGameplayCurvesSet_Recoil.EPaladinsRecoilType RecoilType;

simulated function bool GetHorizRecoilValue(float firingTime, float randInput, out float recoilAmt) { }

simulated function bool GetVertRecoilValue(float firingTime, float randInput, out float recoilAmt) { }

simulated function bool GetRecoilValue(float firingTime, float randInput, out float recoilAmt, const out array<TgRecoilKeyframe> keyframesToCheck) { }

simulated function float GetInterpValBetweenFrames(float Time, float inKeyTime, float outKeyTime) { }

defaultproperties
{
    CurveSetType=CST_Recoil
}
