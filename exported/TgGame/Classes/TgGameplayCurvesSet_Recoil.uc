class TgGameplayCurvesSet_Recoil extends TgGameplayCurvesSet
    native(GameplayCurves)
    editinlinenew
    hidecategories(Object);

enum EPaladinsRecoilType
{
    PRT_Normal,                     // 0
    PRT_AimDownSights,              // 1
    PRT_StimActive,                 // 2
    PRT_MAX                         // 3
};

var(CurveSet) noclear editinline array<editinline TgRecoilKeyframe> HorizRecoil;
var(CurveSet) noclear editinline array<editinline TgRecoilKeyframe> VertRecoil;
var(CurveSet) TgGameplayCurvesSet_Recoil.EPaladinsRecoilType RecoilType;

simulated function bool GetHorizRecoilValue(float firingTime, float randInput, out float recoilAmt)
{
    return GetRecoilValue(firingTime, randInput, recoilAmt, HorizRecoil);
    //return ReturnValue;    
}

simulated function bool GetVertRecoilValue(float firingTime, float randInput, out float recoilAmt)
{
    return GetRecoilValue(firingTime, randInput, recoilAmt, VertRecoil);
    //return ReturnValue;    
}

private final simulated function bool GetRecoilValue(float firingTime, float randInput, out float recoilAmt, const out array<TgRecoilKeyframe> keyframesToCheck)
{
    local int I, inKeyIndex, outKeyIndex;
    local float interpAmt;

    // End:0x12
    if(keyframesToCheck.Length == 0)
    {
        return false;
    }
    inKeyIndex = -1;
    outKeyIndex = -1;
    I = 0;
    J0x3B:

    // End:0x107 [Loop If]
    if(I < keyframesToCheck.Length)
    {
        // End:0xB2
        if(keyframesToCheck[I].firingTime <= firingTime)
        {
            inKeyIndex = I;
            outKeyIndex = I;            
        }
        else
        {
            inKeyIndex = ((inKeyIndex == -1) ? outKeyIndex : inKeyIndex);
            outKeyIndex = I;
            // [Explicit Break]
            goto J0x107;
        }
        I++;
        // [Loop Continue]
        goto J0x3B;
    }
    J0x107:

    interpAmt = GetInterpValBetweenFrames(firingTime, keyframesToCheck[inKeyIndex].firingTime, keyframesToCheck[outKeyIndex].firingTime);
    randInput = FClamp(randInput, 0.0000000, 1.0000000);
    recoilAmt = Lerp(GetDistributionValue(keyframesToCheck[inKeyIndex].RecoilPerShot, randInput), GetDistributionValue(keyframesToCheck[outKeyIndex].RecoilPerShot, randInput), interpAmt);
    return true;
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
    CurveSetType=ECurveSetTypes.CST_Recoil
}