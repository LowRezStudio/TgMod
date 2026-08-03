class TgGameplayCurvesSet_TargetAimTracking extends TgGameplayCurvesSet
    native(GameplayCurves)
    editinlinenew
    hidecategories(Object);

struct native TargetAimTrackingDebugVals
{
    var int DebugState;
    var name trackingCurveSetName;
    var float strengthMultiplier[2];
    var float strengthByAccuracy[2];
    var float strengthByDesiredAngle[2];
    var float strengthFinal[2];
    var float rawDesiredTurnAmt[2];
    var float rawDesiredTurnAmtPerSec[2];

    structdefaultproperties
    {
        DebugState=0
        trackingCurveSetName="None"
        strengthMultiplier[0]=0.0000000
        strengthMultiplier[1]=0.0000000
        strengthByAccuracy[0]=0.0000000
        strengthByAccuracy[1]=0.0000000
        strengthByDesiredAngle[0]=0.0000000
        strengthByDesiredAngle[1]=0.0000000
        strengthFinal[0]=0.0000000
        strengthFinal[1]=0.0000000
        rawDesiredTurnAmt[0]=0.0000000
        rawDesiredTurnAmt[1]=0.0000000
        rawDesiredTurnAmtPerSec[0]=0.0000000
        rawDesiredTurnAmtPerSec[1]=0.0000000
    }
};

var(CurveSet) noclear editinline array<editinline TgTargetAimTrackingCurves> TargetTrackingCurves;
var transient TargetAimTrackingDebugVals DebugVals;
var transient bool bSaveDebugVals;

simulated function float GetTargetTrackingPercX(float HorizAssistAmt, float DesiredTurnAmt, int CurveSetToUse, int TargetTrackingStrength, float DeltaTime)
{
    local TgTargetAimTrackingCurves AimTrackingCurvesToUse;

    // End:0x40
    if(((CurveSetToUse < 0) || CurveSetToUse >= TargetTrackingCurves.Length) || TargetTrackingStrength <= 0)
    {
        return 0.0000000;
    }
    AimTrackingCurvesToUse = TargetTrackingCurves[CurveSetToUse];
    // End:0x72
    if(AimTrackingCurvesToUse == none)
    {
        return 0.0000000;
    }
    return GetTargetTrackingStrength(HorizAssistAmt, (0.0000959 * DesiredTurnAmt) / DeltaTime, AimTrackingCurvesToUse.StrengthByAccuracyX, AimTrackingCurvesToUse.StrengthByDesiredAngleX, TargetTrackingStrength);
    //return ReturnValue;    
}

simulated function float GetTargetTrackingPercY(float VertAssistAmt, float DesiredTurnAmt, int CurveSetToUse, int TargetTrackingStrength, float DeltaTime)
{
    local TgTargetAimTrackingCurves AimTrackingCurvesToUse;

    // End:0x40
    if(((CurveSetToUse < 0) || CurveSetToUse >= TargetTrackingCurves.Length) || TargetTrackingStrength <= 0)
    {
        return 0.0000000;
    }
    AimTrackingCurvesToUse = TargetTrackingCurves[CurveSetToUse];
    // End:0x72
    if(AimTrackingCurvesToUse == none)
    {
        return 0.0000000;
    }
    return GetTargetTrackingStrength(VertAssistAmt, (0.0000959 * DesiredTurnAmt) / DeltaTime, AimTrackingCurvesToUse.StrengthByAccuracyY, AimTrackingCurvesToUse.StrengthByDesiredAngleY, TargetTrackingStrength);
    //return ReturnValue;    
}

simulated function float GetTargetTrackingStrength(float AssistAmt, float DesiredTurnAmtPerSec, const out RawDistributionFloat StrengthByAccuracyCurve, const out RawDistributionFloat StrengthByDesiredAngleCurve, int TargetTrackingStrength)
{
    local float strengthMultiplier, StrengyByAccuracy, StrengthByAngle;

    strengthMultiplier = FClamp(float(TargetTrackingStrength) / 10.0000000, 0.0000000, 1.0000000);
    StrengyByAccuracy = GetDistributionValue(StrengthByAccuracyCurve, Abs(AssistAmt));
    StrengthByAngle = GetDistributionValue(StrengthByDesiredAngleCurve, Abs(DesiredTurnAmtPerSec));
    return (StrengyByAccuracy * StrengthByAngle) * strengthMultiplier;
    //return ReturnValue;    
}

simulated function SaveDebugInfo(bool bShouldSave)
{
    //return;    
}

defaultproperties
{
    CurveSetType=ECurveSetTypes.CST_TargetTracking
}