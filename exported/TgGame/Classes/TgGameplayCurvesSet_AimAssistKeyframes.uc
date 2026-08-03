class TgGameplayCurvesSet_AimAssistKeyframes extends TgGameplayCurvesSet
    native(GameplayCurves)
    editinlinenew
    hidecategories(Object);

struct native AimAssistKeyframeDebugVals
{
    var int DebugState;
    var name curveMin[7];
    var name curveMax[7];
    var float valMin[7];
    var float valMax[7];
    var float valInterp[7];
    var float valFinal[7];

    structdefaultproperties
    {
        DebugState=0
        curveMin[0]="None"
        curveMin[1]="None"
        curveMin[2]="None"
        curveMin[3]="None"
        curveMin[4]="None"
        curveMin[5]="None"
        curveMin[6]="None"
        curveMax[0]="None"
        curveMax[1]="None"
        curveMax[2]="None"
        curveMax[3]="None"
        curveMax[4]="None"
        curveMax[5]="None"
        curveMax[6]="None"
        valMin[0]=0.0000000
        valMin[1]=0.0000000
        valMin[2]=0.0000000
        valMin[3]=0.0000000
        valMin[4]=0.0000000
        valMin[5]=0.0000000
        valMin[6]=0.0000000
        valMax[0]=0.0000000
        valMax[1]=0.0000000
        valMax[2]=0.0000000
        valMax[3]=0.0000000
        valMax[4]=0.0000000
        valMax[5]=0.0000000
        valMax[6]=0.0000000
        valInterp[0]=0.0000000
        valInterp[1]=0.0000000
        valInterp[2]=0.0000000
        valInterp[3]=0.0000000
        valInterp[4]=0.0000000
        valInterp[5]=0.0000000
        valInterp[6]=0.0000000
        valFinal[0]=0.0000000
        valFinal[1]=0.0000000
        valFinal[2]=0.0000000
        valFinal[3]=0.0000000
        valFinal[4]=0.0000000
        valFinal[5]=0.0000000
        valFinal[6]=0.0000000
    }
};

var transient AimAssistKeyframeDebugVals DebugVals;
var transient bool bSaveDebugVals;
var(CurveSet) noclear editinline array<editinline TgAimAssistKeyframe> HorizMagnetKeyframes;
var(CurveSet) noclear editinline array<editinline TgAimAssistKeyframe> VertMagnetKeyframes;
var(CurveSet) noclear editinline array<editinline TgAimAssistKeyframe> FrictionKeyframes;
var(CurveSet) noclear editinline array<editinline TgAimAssistKeyframe> TrackingByAccuracyKeyframes;
var(CurveSet) noclear editinline array<editinline TgAimAssistKeyframe> TrackingByAngleKeyframes;

simulated function float GetHorizMagnetValue(float assistValue, float Distance, const out array<AimAssistKeyframeData> MagnetHorizKeyframeData)
{
    return GetAimAssistValue(assistValue, Distance, MagnetHorizKeyframeData, HorizMagnetKeyframes);
    //return ReturnValue;    
}

simulated function float GetVertMagnetValue(float assistValue, float Distance, const out array<AimAssistKeyframeData> MagnetVertKeyframeData)
{
    return GetAimAssistValue(assistValue, Distance, MagnetVertKeyframeData, VertMagnetKeyframes);
    //return ReturnValue;    
}

simulated function float GetFrictionValue(float assistValue, float Distance, const out array<AimAssistKeyframeData> FrictionKeyframeData)
{
    return GetAimAssistValue(assistValue, Distance, FrictionKeyframeData, FrictionKeyframes);
    //return ReturnValue;    
}

simulated function float GetHorizTrackingValue(float assistValue, float DesiredTurnAmtPerSec, float Distance, const out array<AimAssistKeyframeData> HorizTrackingByAccuracyKeyframeData, const out array<AimAssistKeyframeData> HorizTrackingByAngleKeyframeData)
{
    local float fAccuracyTrackingAmt, fAngleTrackingAmt;

    fAccuracyTrackingAmt = GetAimAssistValue(assistValue, Distance, HorizTrackingByAccuracyKeyframeData, TrackingByAccuracyKeyframes);
    fAngleTrackingAmt = GetAimAssistValue(DesiredTurnAmtPerSec, Distance, HorizTrackingByAngleKeyframeData, TrackingByAngleKeyframes);
    return fAccuracyTrackingAmt * fAngleTrackingAmt;
    //return ReturnValue;    
}

simulated function float GetVertTrackingValue(float assistValue, float DesiredTurnAmtPerSec, float Distance, const out array<AimAssistKeyframeData> VertTrackingByAccuracyKeyframeData, const out array<AimAssistKeyframeData> VertTrackingByAngleKeyframeData)
{
    local float fAccuracyTrackingAmt, fAngleTrackingAmt;

    fAccuracyTrackingAmt = GetAimAssistValue(assistValue, Distance, VertTrackingByAccuracyKeyframeData, TrackingByAccuracyKeyframes);
    fAngleTrackingAmt = GetAimAssistValue(DesiredTurnAmtPerSec, Distance, VertTrackingByAngleKeyframeData, TrackingByAngleKeyframes);
    return fAccuracyTrackingAmt * fAngleTrackingAmt;
    //return ReturnValue;    
}

simulated function SaveDebugInfo(bool bShouldSave)
{
    //return;    
}

private final simulated function float GetAimAssistValue(float assistValue, float Distance, const out array<AimAssistKeyframeData> keyframeData, const out array<TgAimAssistKeyframe> keyframesToCheck)
{
    local float interpAmt, keyframe1Dist, keyframe2Dist, keyframe1Val, keyframe2Val;

    local TgAimAssistKeyframe keyframe1, keyframe2;

    // End:0x28
    if((keyframeData.Length == 0) || keyframesToCheck.Length == 0)
    {
        return 0.0000000;
    }
    // End:0x7C
    if(!GetKeyframesToUse(Distance, keyframeData, keyframesToCheck, keyframe1, keyframe2, keyframe1Dist, keyframe2Dist))
    {
        return 0.0000000;
    }
    interpAmt = GetInterpValBetweenFrames(Distance, keyframe1Dist, keyframe2Dist);
    keyframe1Val = GetKeyframeDistributionValue(keyframe1, assistValue);
    keyframe2Val = GetKeyframeDistributionValue(keyframe2, assistValue);
    return Lerp(keyframe1Val, keyframe2Val, interpAmt);
    //return ReturnValue;    
}

private final simulated function float GetKeyframeDistributionValue(const out TgAimAssistKeyframe keyframe, float T)
{
    // End:0x37
    if(keyframe.bMirrored)
    {
        T = Abs(T);
    }
    return GetDistributionValue(keyframe.AimAssistCurve, T);
    //return ReturnValue;    
}

private final simulated function bool GetKeyframesToUse(float Distance, const out array<AimAssistKeyframeData> keyframeData, const out array<TgAimAssistKeyframe> keyframesToCheck, out TgAimAssistKeyframe keyframe1, out TgAimAssistKeyframe keyframe2, out float keyframe1Dist, out float keyframe2Dist)
{
    local int I;

    keyframe1 = none;
    keyframe2 = none;
    keyframe1Dist = 0.0000000;
    keyframe2Dist = 0.0000000;
    // End:0x58
    if((keyframesToCheck.Length == 0) || keyframeData.Length == 0)
    {
        return false;
    }
    I = 0;
    J0x63:

    // End:0x218 [Loop If]
    if(I < keyframeData.Length)
    {
        // End:0x15E
        if((keyframeData[I].Distance <= Distance) || keyframe1 == none)
        {
            // End:0x15B
            if(GetKeyframeByName(keyframeData[I].KeyframeName, keyframesToCheck, keyframe1))
            {
                keyframe2 = keyframe1;
                keyframe1Dist = keyframeData[I].Distance;
                keyframe2Dist = keyframe1Dist;
            }            
        }
        else
        {
            // End:0x20A
            if(GetKeyframeByName(keyframeData[I].KeyframeName, keyframesToCheck, keyframe2))
            {
                keyframe2Dist = keyframeData[I].Distance;
                // End:0x208
                if(keyframe1 == none)
                {
                    keyframe1 = keyframe2;
                    keyframe1Dist = keyframe2Dist;
                }
                return true;
            }
        }
        I++;
        // [Loop Continue]
        goto J0x63;
    }
    return (keyframe1 != none) && keyframe2 != none;
    //return ReturnValue;    
}

private final simulated function bool GetKeyframeByName(name KeyframeName, const out array<TgAimAssistKeyframe> keyframesToCheck, out TgAimAssistKeyframe outKeyframe)
{
    local int I;

    I = 0;
    J0x0B:

    // End:0x86 [Loop If]
    if(I < keyframesToCheck.Length)
    {
        // End:0x78
        if(keyframesToCheck[I].KeyframeName == KeyframeName)
        {
            outKeyframe = keyframesToCheck[I];
            return true;
        }
        I++;
        // [Loop Continue]
        goto J0x0B;
    }
    return false;
    //return ReturnValue;    
}

private final simulated function float GetInterpValBetweenFrames(float Time, float inKeyTime, float outKeyTime)
{
    // End:0x1D
    if(inKeyTime >= outKeyTime)
    {
        return 0.0000000;
    }
    return FClamp(FPctByRange(Time, inKeyTime, outKeyTime), 0.0000000, 1.0000000);
    //return ReturnValue;    
}

defaultproperties
{
    CurveSetType=ECurveSetTypes.CST_AimAssistKeyframes
}