class TgGameplayCurvesSet_TargetAimTracking extends TgGameplayCurvesSet
    native(GameplayCurves)
    editinlinenew
    hidecategories(Object)
    config(Engine);

struct TargetAimTrackingDebugVals {
    var int DebugState;
    var name trackingCurveSetName;
    var float strengthMultiplier[2];
    var float strengthByAccuracy[2];
    var float strengthByDesiredAngle[2];
    var float strengthFinal[2];
    var float rawDesiredTurnAmt[2];
    var float rawDesiredTurnAmtPerSec[2];
    structdefaultproperties {}
};

var (CurveSet) noclear editinline array<TgTargetAimTrackingCurves> TargetTrackingCurves;
var transient TargetAimTrackingDebugVals DebugVals;
var transient bool bSaveDebugVals;

simulated function float GetTargetTrackingPercX(float HorizAssistAmt, float DesiredTurnAmt, int CurveSetToUse, int TargetTrackingStrength, float DeltaTime) { }

simulated function float GetTargetTrackingPercY(float VertAssistAmt, float DesiredTurnAmt, int CurveSetToUse, int TargetTrackingStrength, float DeltaTime) { }

simulated function float GetTargetTrackingStrength(float AssistAmt, float DesiredTurnAmtPerSec, const out RawDistributionFloat StrengthByAccuracyCurve, const out RawDistributionFloat StrengthByDesiredAngleCurve, int TargetTrackingStrength) { }

simulated function SaveDebugInfo(bool bShouldSave) { }

defaultproperties
{
    CurveSetType=CST_TargetTracking
}
