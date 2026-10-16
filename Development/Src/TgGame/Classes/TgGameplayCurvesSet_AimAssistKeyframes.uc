class TgGameplayCurvesSet_AimAssistKeyframes extends TgGameplayCurvesSet
    native(GameplayCurves)
    editinlinenew
    hidecategories(Object)
    config(Engine)
    dependson(TgAimAssistKeyframe);

struct AimAssistKeyframeDebugVals {
    var int DebugState;
    var name curveMin[7];
    var name curveMax[7];
    var float valMin[7];
    var float valMax[7];
    var float valInterp[7];
    var float valFinal[7];
    structdefaultproperties {}
};

var transient AimAssistKeyframeDebugVals DebugVals;
var transient bool bSaveDebugVals;
var (CurveSet) noclear editinline array<TgAimAssistKeyframe> HorizMagnetKeyframes;
var (CurveSet) noclear editinline array<TgAimAssistKeyframe> VertMagnetKeyframes;
var (CurveSet) noclear editinline array<TgAimAssistKeyframe> FrictionKeyframes;
var (CurveSet) noclear editinline array<TgAimAssistKeyframe> TrackingByAccuracyKeyframes;
var (CurveSet) noclear editinline array<TgAimAssistKeyframe> TrackingByAngleKeyframes;

simulated function float GetHorizMagnetValue(float assistValue, float Distance, const out array<AimAssistKeyframeData> MagnetHorizKeyframeData) { }

simulated function float GetVertMagnetValue(float assistValue, float Distance, const out array<AimAssistKeyframeData> MagnetVertKeyframeData) { }

simulated function float GetFrictionValue(float assistValue, float Distance, const out array<AimAssistKeyframeData> FrictionKeyframeData) { }

simulated function float GetHorizTrackingValue(float assistValue, float DesiredTurnAmtPerSec, float Distance, const out array<AimAssistKeyframeData> HorizTrackingByAccuracyKeyframeData, const out array<AimAssistKeyframeData> HorizTrackingByAngleKeyframeData) { }

simulated function float GetVertTrackingValue(float assistValue, float DesiredTurnAmtPerSec, float Distance, const out array<AimAssistKeyframeData> VertTrackingByAccuracyKeyframeData, const out array<AimAssistKeyframeData> VertTrackingByAngleKeyframeData) { }

simulated function SaveDebugInfo(bool bShouldSave) { }

simulated function float GetAimAssistValue(float assistValue, float Distance, const out array<AimAssistKeyframeData> keyframeData, const out array<TgAimAssistKeyframe> keyframesToCheck) { }

simulated function float GetKeyframeDistributionValue(const out TgAimAssistKeyframe keyframe, float T) { }

simulated function bool GetKeyframesToUse(float Distance, const out array<AimAssistKeyframeData> keyframeData, const out array<TgAimAssistKeyframe> keyframesToCheck, out TgAimAssistKeyframe keyframe1, out TgAimAssistKeyframe keyframe2, out float keyframe1Dist, out float keyframe2Dist) { }

simulated function bool GetKeyframeByName(name KeyframeName, const out array<TgAimAssistKeyframe> keyframesToCheck, out TgAimAssistKeyframe outKeyframe) { }

simulated function float GetInterpValBetweenFrames(float Time, float inKeyTime, float outKeyTime) { }

defaultproperties
{
    CurveSetType=CST_AimAssistKeyframes
}
