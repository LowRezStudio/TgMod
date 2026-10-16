class TgPlayerInput extends PComPlayerInput within TgPlayerController
    transient
    native(Pawns)
    config(Input)
    hidecategories(Object,UIRoot);

struct native AimAssistTargetWeight
{
    var TgCombatActor Target;
    var float Weight;
    var float horizAssistVal;
    var float vertAssistVal;
    var float lastUpdateTimestamp;

    structdefaultproperties
    {
        Target=none
        Weight=0.0000000
        horizAssistVal=0.0000000
        vertAssistVal=0.0000000
        lastUpdateTimestamp=0.0000000
    }
};

struct native AimAssistTargetWeightVars
{
    var float CurrentTargetBonus;
    var float NotCurrentTargetPenalty;
    var float MinAccuracyBonus;
    var float MaxAccuracyBonus;
    var float MinInaccuracyPenalty;
    var float MaxInaccuracyPenalty;
    var float MaxWeight;

    structdefaultproperties
    {
        CurrentTargetBonus=0.0000000
        NotCurrentTargetPenalty=0.0000000
        MinAccuracyBonus=0.0000000
        MaxAccuracyBonus=0.0000000
        MinInaccuracyPenalty=0.0000000
        MaxInaccuracyPenalty=0.0000000
        MaxWeight=0.0000000
    }
};

struct native DebugAimAssist
{
    var Actor lastAimAssistTarget;
    var float targetDist;
    var float assistValX;
    var float assistValY;
    var name curveMin[7];
    var name curveMax[7];
    var float curveMinVal[7];
    var float curveMaxVal[7];
    var float curveInterpAmt[7];
    var float rawVal[7];
    var float boundsUsedX;
    var float boundsUsedY;
    var float trackingScaledStrengthFinalX;
    var float trackingScaledStrengthFinalY;

    structdefaultproperties
    {
        lastAimAssistTarget=none
        targetDist=0.0000000
        assistValX=0.0000000
        assistValY=0.0000000
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
        curveMinVal[0]=0.0000000
        curveMinVal[1]=0.0000000
        curveMinVal[2]=0.0000000
        curveMinVal[3]=0.0000000
        curveMinVal[4]=0.0000000
        curveMinVal[5]=0.0000000
        curveMinVal[6]=0.0000000
        curveMaxVal[0]=0.0000000
        curveMaxVal[1]=0.0000000
        curveMaxVal[2]=0.0000000
        curveMaxVal[3]=0.0000000
        curveMaxVal[4]=0.0000000
        curveMaxVal[5]=0.0000000
        curveMaxVal[6]=0.0000000
        curveInterpAmt[0]=0.0000000
        curveInterpAmt[1]=0.0000000
        curveInterpAmt[2]=0.0000000
        curveInterpAmt[3]=0.0000000
        curveInterpAmt[4]=0.0000000
        curveInterpAmt[5]=0.0000000
        curveInterpAmt[6]=0.0000000
        rawVal[0]=0.0000000
        rawVal[1]=0.0000000
        rawVal[2]=0.0000000
        rawVal[3]=0.0000000
        rawVal[4]=0.0000000
        rawVal[5]=0.0000000
        rawVal[6]=0.0000000
        boundsUsedX=0.0000000
        boundsUsedY=0.0000000
        trackingScaledStrengthFinalX=0.0000000
        trackingScaledStrengthFinalY=0.0000000
    }
};

var TgPlayerController c_TgPC;
var bool c_bASKeyCapture;
var bool c_bASSpecKeyCapture;
var bool c_bMiniMapPinging;
var bool c_bAutoRun;
var config bool bEnableAimAssist;
var transient bool bDebugAimAssist;
var globalconfig float GamepadSensitivityX;
var globalconfig float GamepadSensitivityY;
var globalconfig float fScopeSensitivity;
var float m_fMinScopeSensitivityMult;
var float m_fMaxScopeSensitivityMult;
var globalconfig int nAimAccelerationSet;
var globalconfig int nAimAccelerationBoost;
var transient float fTurnSpeedAccelAmt;
var transient float fLookUpSpeedAccelAmt;
var int nAimAccelerationAlgorithm;
var globalconfig int nInnerDeadZoneSize;
var globalconfig int nOuterDeadZoneSize;
var transient Actor BestAimAssistTarget;
var TgGameplayCurves m_AimAssistCurves;
var transient float aTurnFinalValue;
var transient float aLookUpFinalValue;
var transient array<AimAssistTargetWeight> m_AimAssistTargets;
var AimAssistTargetWeightVars TargetWeightVars;
var DebugAimAssist DebugAimAssistVals;
//var delegate<OnRawInputKey> __OnRawInputKey__Delegate;
//var delegate<OnInputAxis> __OnInputAxis__Delegate;
//var delegate<OnInputChar> __OnInputChar__Delegate;

delegate bool OnRawInputKey(int ControllerId, name Key, Object.EInputEvent Event, float AmountDepressed)
{
    //return ReturnValue;    
}

delegate bool OnInputAxis(int ControllerId, name Key, float Delta, float DeltaTime)
{
    //return ReturnValue;    
}

delegate bool OnInputChar(int ControllerId, string Unicode)
{
    //return ReturnValue;    
}

// Export UTgPlayerInput::execStoreMouseSettings(FFrame&, void* const)
native function StoreMouseSettings();

// Export UTgPlayerInput::execReadMouseSettings(FFrame&, void* const)
native function ReadMouseSettings();

// Export UTgPlayerInput::execResetKeysToDefault(FFrame&, void* const)
native function ResetKeysToDefault();

// Export UTgPlayerInput::execSetKeyCaptureState(FFrame&, void* const)
native exec function SetKeyCaptureState(bool bSpectator, bool bCaptureKey);

// Export UTgPlayerInput::execGenerateKeybindFromButton(FFrame&, void* const)
native function KeyBind GenerateKeybindFromButton(const name ButtonName);

// Export UTgPlayerInput::execPreProcessJoystickInput(FFrame&, void* const)
native function PreProcessJoystickInput(float fDeltaTime);

event bool InputChar(int ControllerId, string Unicode)
{
    // End:0x2A
    if(OnInputChar(ControllerId, Unicode))
    {
        return true;
    }
    return false;
    //return ReturnValue;    
}

simulated exec function Duck()
{
    return;
    //return;    
}

function Actor.EDoubleClickDir CheckForDoubleClickMove(float DeltaTime)
{
    return 0;
    //return ReturnValue;    
}

function PreProcessInput(float DeltaTime)
{
    super(PlayerInput).PreProcessInput(DeltaTime);
    PreProcessJoystickInput(DeltaTime);
    //return;    
}

// Export UTgPlayerInput::execShouldUseAimAssist(FFrame&, void* const)
native final simulated function bool ShouldUseAimAssist();

simulated function float GetScopeSensitivity()
{
    // End:0x35
    if(fScopeSensitivity < float(0))
    {
        return Lerp(1.0000000, m_fMinScopeSensitivityMult, fScopeSensitivity * -0.1000000);        
    }
    else
    {
        // End:0x67
        if(fScopeSensitivity > float(0))
        {
            return Lerp(1.0000000, m_fMaxScopeSensitivityMult, fScopeSensitivity * 0.1000000);
        }
    }
    return 1.0000000;
    //return ReturnValue;    
}

function AdjustMouseSensitivity(float FOVScale)
{
    local TgPawn TgP;

    super(PlayerInput).AdjustMouseSensitivity(FOVScale);
    // End:0xA8
    if(c_TgPC != none)
    {
        TgP = c_TgPC.GetPlayerControlPawn();
        // End:0xA8
        if((TgP != none) && TgP.ShouldUseScopeSensitivity())
        {
            aMouseX *= (GetScopeSensitivity());
            aMouseY *= (GetScopeSensitivity());
        }
    }
    //return;    
}

event PlayerInput(float DeltaTime)
{
    local TgPawn TgP;
    local float fJoystickIntensity;

    // End:0x20
    if(aBaseY != float(0))
    {
        c_bAutoRun = false;        
    }
    else
    {
        // End:0x3C
        if(c_bAutoRun)
        {
            aBaseY = 1.0000000;
        }
    }
    super(PlayerInput).PlayerInput(DeltaTime);
    // End:0x3BF
    if(c_TgPC != none)
    {
        TgP = c_TgPC.GetPlayerControlPawn();
        // End:0x247
        if(bUsingGamepad)
        {
            aTurn *= (GamepadSensitivityX * 2.0000000);
            aLookUp *= (GamepadSensitivityY * 2.0000000);
            // End:0x127
            if((TgP != none) && TgP.ShouldUseScopeSensitivity())
            {
                aTurn *= (GetScopeSensitivity());
                aLookUp *= (GetScopeSensitivity());
            }
            // End:0x147
            if(ShouldUseAimAssist())
            {
                HandleAimAssist(DeltaTime);
            }
            fJoystickIntensity = FMin(1.0000000, FMin(1.0000000, Abs(RawJoyUp)) + FMin(1.0000000, Abs(RawJoyRight)));
            // End:0x1B5
            if(fJoystickIntensity > 0.8500000)
            {
                c_TgPC.m_byDesiredMoveSpeedReduction = 0;                
            }
            else
            {
                // End:0x1EC
                if(fJoystickIntensity > 0.6500000)
                {
                    c_TgPC.m_byDesiredMoveSpeedReduction = 1;                    
                }
                else
                {
                    // End:0x223
                    if(fJoystickIntensity > 0.3500000)
                    {
                        c_TgPC.m_byDesiredMoveSpeedReduction = 2;                        
                    }
                    else
                    {
                        c_TgPC.m_byDesiredMoveSpeedReduction = 3;
                    }
                }
            }            
        }
        else
        {
            c_TgPC.m_byDesiredMoveSpeedReduction = 0;
        }
        // End:0x297
        if(TgP != none)
        {
            TgP.AllowDeviceToModifyInput(self);
        }
        HandleMovementInput(aForward > 0.0000000, 0, aForward);
        HandleMovementInput(aForward < 0.0000000, 1, aForward);
        HandleMovementInput(aStrafe > 0.0000000, 2, aStrafe);
        HandleMovementInput(aStrafe < 0.0000000, 3, aStrafe);
        HandleMovementInput(aTurn > 0.0000000, 5, aTurn);
        HandleMovementInput(aTurn < 0.0000000, 4, aTurn);
        HandleMovementInput(aLookUp > 0.0000000, 6, aLookUp);
        HandleMovementInput(aLookUp < 0.0000000, 7, aLookUp);
    }
    //return;    
}

function HandleMovementInput(bool bIsMatchingInput, TgPlayerController.EPlayerInputType InputType, out float fAxisValue)
{
    // End:0x83
    if(bIsMatchingInput && c_TgPC != none)
    {
        // End:0x74
        if(c_TgPC.IsInputAllowed(InputType))
        {
            c_TgPC.InputReceived(InputType);            
        }
        else
        {
            fAxisValue = 0.0000000;
        }
    }
    //return;    
}

simulated function DisplayDebug(HUD HUD, out float out_YL, out float out_YPos)
{
    // End:0x934
    if(HUD.ShouldDisplayDebug('ControllerInput'))
    {
        // End:0x49
        if(!bDebugAimAssist)
        {
            bDebugAimAssist = true;            
        }
        else
        {
            HUD.Canvas.DrawText("AIM ASSIST");
            out_YPos += out_YL;
            HUD.Canvas.SetPos(4.0000000, out_YPos);
            HUD.Canvas.DrawText("AimAssistTarget: " @ string(DebugAimAssistVals.lastAimAssistTarget));
            out_YPos += out_YL;
            HUD.Canvas.SetPos(4.0000000, out_YPos);
            HUD.Canvas.DrawText((("Bounds: " @ string(DebugAimAssistVals.boundsUsedX)) @ ",  ") @ string(DebugAimAssistVals.boundsUsedY));
            out_YPos += out_YL;
            HUD.Canvas.SetPos(4.0000000, out_YPos);
            // End:0x5C1
            if(DebugAimAssistVals.lastAimAssistTarget != none)
            {
                HUD.Canvas.DrawText((((("TargetDist: " @ string(DebugAimAssistVals.targetDist)) @ ",  AssistVal: ") @ string(DebugAimAssistVals.assistValX)) @ ", ") @ string(DebugAimAssistVals.assistValY));
                out_YPos += out_YL;
                DrawAimAssistVals("MagnetX", 0, out_YPos, out_YL, HUD);
                DrawAimAssistVals("MagnetY", 1, out_YPos, out_YL, HUD);
                DrawAimAssistVals("Friction", 2, out_YPos, out_YL, HUD);
                DrawAimAssistVals("TrackAccX", 3, out_YPos, out_YL, HUD);
                DrawAimAssistVals("TrackAngleX", 4, out_YPos, out_YL, HUD);
                DrawAimAssistVals("TrackAccY", 5, out_YPos, out_YL, HUD);
                DrawAimAssistVals("TrackAngleY", 6, out_YPos, out_YL, HUD);
                out_YPos += out_YL;
                HUD.Canvas.SetPos(4.0000000, out_YPos);
                HUD.Canvas.DrawText((("Tracking: Final:" @ string(DebugAimAssistVals.trackingScaledStrengthFinalX)) @ ", ") @ string(DebugAimAssistVals.trackingScaledStrengthFinalY));
            }
            out_YPos += out_YL;
            HUD.Canvas.SetPos(4.0000000, out_YPos);
            HUD.Canvas.DrawText((((((("aTurn: " @ string(RawJoyLookRight)) @ "(raw) *") @ string(fTurnSpeedAccelAmt)) @ "(accel) =") @ string(aTurnFinalValue)) @ "(final) / DeltaTime =") @ string(aTurnFinalValue / Outer.WorldInfo.DeltaSeconds));
            out_YPos += out_YL;
            HUD.Canvas.SetPos(4.0000000, out_YPos);
            HUD.Canvas.DrawText((((((("aLookUp: " @ string(RawJoyLookUp)) @ "(raw) *") @ string(fLookUpSpeedAccelAmt)) @ "(accel) =") @ string(aLookUpFinalValue)) @ "(final) / DeltaTime =") @ string(aLookUpFinalValue / Outer.WorldInfo.DeltaSeconds));
            out_YPos += out_YL;
            HUD.Canvas.SetPos(4.0000000, out_YPos);
            HUD.Canvas.DrawText((((((("Sensitivity X:" @ string(GamepadSensitivityX)) @ "  Sensitivity Y:") @ string(GamepadSensitivityY)) @ "  Aim Accel:") @ string(nAimAccelerationSet)) @ "  Aim Boost:") @ string(nAimAccelerationBoost));
        }        
    }
    else
    {
        bDebugAimAssist = false;
    }
    //return;    
}

simulated function DrawAimAssistVals(string assistName, int Index, out float YPos, float YL, HUD HUD)
{
    HUD.Canvas.SetPos(4.0000000, YPos);
    HUD.Canvas.DrawText((((((assistName @ ": Raw: ") @ string(DebugAimAssistVals.rawVal[Index])) @ ",  MinCurve: ") @ string(DebugAimAssistVals.curveMin[Index])) @ ",  MaxCurve: ") @ string(DebugAimAssistVals.curveMax[Index]));
    YPos += YL;
    HUD.Canvas.SetPos(4.0000000, YPos);
    HUD.Canvas.DrawText((((((assistName @ ": MinVal: ") @ string(DebugAimAssistVals.curveMinVal[Index])) @ ",  MaxVal: ") @ string(DebugAimAssistVals.curveMaxVal[Index])) @ ",  InterpAmt: ") @ string(DebugAimAssistVals.curveInterpAmt[Index]));
    YPos += YL;
    //return;    
}

function HandleAimAssist(float DeltaTime)
{
    local Rotator PawnRotator;
    local Matrix PawnRotationMatrix;
    local Vector PawnFwd, PawnRight, PawnUp;
    local TgPawn TgP;
    local TgDevice AimAssistDevice;
    local TgPawn Target;
    local float PawnToTargetValue, BestPawnToTargetValue, BestHorizontalAssistAmount, BestVerticalAssistAmount, HorizontalAssistAmount, VerticalAssistAmount,
	    DistanceToBestTarget;

    local int I;
    local bool bUpdatedAimTarget;

    TgP = TgPawn(Outer.Pawn);
    // End:0x77
    if(((TgP == none) || TgP.r_bIsMounted) || c_TgPC == none)
    {
        return;
    }
    AimAssistDevice = TgP.GetDeviceForAimAssist();
    // End:0xB1
    if(AimAssistDevice == none)
    {
        return;
    }
    BestPawnToTargetValue = -1.0000000;
    BestHorizontalAssistAmount = 1.0000000;
    BestVerticalAssistAmount = 1.0000000;
    BestAimAssistTarget = none;
    PawnRotator = c_TgPC.Rotation;
    PawnRotator.Yaw += int(aTurn);
    PawnRotator.Pitch += int(aLookUp);
    PawnRotationMatrix = MakeRotationMatrix(PawnRotator);
    PawnFwd = MatrixGetAxis(PawnRotationMatrix, 1);
    PawnRight = MatrixGetAxis(PawnRotationMatrix, 2);
    PawnUp = MatrixGetAxis(PawnRotationMatrix, 4);
    // End:0x707
    foreach Outer.WorldInfo.AllPawns(Class'TgGame.TgPawn', Target)
    {
        // End:0x706
        if((((Target.bCanBeFrictionedTo && Target.Health > 0) && c_TgPC.IsEnemy(Target)) && Target.CanApplyAimAssist(c_TgPC, TgP)) && HandleAimAssistForTarget(TgCombatActor(Target), DeltaTime, PawnFwd, PawnRight, PawnUp, HorizontalAssistAmount, VerticalAssistAmount))
        {
            bUpdatedAimTarget = false;
            I = 0;
            J0x341:

            // End:0x475 [Loop If]
            if(I < m_AimAssistTargets.Length)
            {
                // End:0x467
                if(EqualEqual_InterfaceInterface(m_AimAssistTargets[I].Target, TgCombatActor(Target)))
                {
                    m_AimAssistTargets[I].lastUpdateTimestamp = Outer.WorldInfo.TimeSeconds;
                    m_AimAssistTargets[I].horizAssistVal = HorizontalAssistAmount;
                    m_AimAssistTargets[I].vertAssistVal = VerticalAssistAmount;
                    bUpdatedAimTarget = true;
                    // [Explicit Break]
                    goto J0x475;
                }
                I++;
                // [Loop Continue]
                goto J0x341;
            }
            J0x475:

            // End:0x706
            if(((HorizontalAssistAmount > -1.0000000) && HorizontalAssistAmount < 1.0000000) || (VerticalAssistAmount > -1.0000000) && VerticalAssistAmount < 1.0000000)
            {
                // End:0x60B
                if(!bUpdatedAimTarget)
                {
                    I = m_AimAssistTargets.Add(1);
                    m_AimAssistTargets[I].lastUpdateTimestamp = Outer.WorldInfo.TimeSeconds;
                    m_AimAssistTargets[I].Weight = 0.0000000;
                    m_AimAssistTargets[I].Target = TgCombatActor(Target);
                    m_AimAssistTargets[I].horizAssistVal = HorizontalAssistAmount;
                    m_AimAssistTargets[I].vertAssistVal = VerticalAssistAmount;
                }
                PawnToTargetValue = Normal(Target.Location - Outer.Pawn.Location) Dot PawnFwd;
                // End:0x706
                if((PawnToTargetValue > BestPawnToTargetValue) && (Abs(HorizontalAssistAmount) <= 0.9900000) || Abs(VerticalAssistAmount) <= 0.9900000)
                {
                    BestAimAssistTarget = Target;
                    BestPawnToTargetValue = PawnToTargetValue;
                    BestHorizontalAssistAmount = HorizontalAssistAmount;
                    BestVerticalAssistAmount = VerticalAssistAmount;
                }
            }
        }        
    }    
    UpdateAimAssistTargetWeights(DeltaTime);
    SelectBestAimAssistTargetViaWeights(BestHorizontalAssistAmount, BestVerticalAssistAmount);
    // End:0x7DB
    if(((((AimAssistDevice.RequireLookForAimAssist() && Abs(aTurn) <= 0.0010000) && Abs(aLookUp) <= 0.0010000) && AimAssistDevice.RequireMovementForAimAssist()) && Abs(aBaseY) <= 0.0010000) && Abs(aStrafe) <= 0.0010000)
    {
        return;
    }
    // End:0x9D1
    if(BestAimAssistTarget != none)
    {
        DistanceToBestTarget = VSize(BestAimAssistTarget.Location - Outer.Pawn.Location);
        ApplyAimFrictionAndMagnet(DeltaTime, BestHorizontalAssistAmount, BestVerticalAssistAmount, DistanceToBestTarget, AimAssistDevice.m_AimAssistKeyframesMagnetHoriz, AimAssistDevice.m_AimAssistKeyframesMagnetVert, AimAssistDevice.m_AimAssistKeyframesFriction, AimAssistDevice.m_AimAssistMagnetScale, AimAssistDevice.m_AimAssistFrictionScale);
        ApplyAimTracking(DeltaTime, BestHorizontalAssistAmount, BestVerticalAssistAmount, DistanceToBestTarget, AimAssistDevice.m_AimAssistKeyframesTrackingAccHoriz, AimAssistDevice.m_AimAssistKeyframesTrackingAngleHoriz, AimAssistDevice.m_AimAssistKeyframesTrackingAccVert, AimAssistDevice.m_AimAssistKeyframesTrackingAngleVert, AimAssistDevice.m_AimAssistTrackingScale);
    }
    //return;    
}

function SelectBestAimAssistTargetViaWeights(out float BestHorizontalAssistAmount, out float BestVerticalAssistAmount)
{
    local int I;
    local float fBestTargetWeight;

    fBestTargetWeight = 0.0000000;
    I = m_AimAssistTargets.Length - 1;
    J0x26:

    // End:0x25B [Loop If]
    if(I >= 0)
    {
        // End:0x24D
        if((Abs(m_AimAssistTargets[I].horizAssistVal) <= 0.9900000) || Abs(m_AimAssistTargets[I].vertAssistVal) <= 0.9900000)
        {
            // End:0x24D
            if((m_AimAssistTargets[I].Weight > fBestTargetWeight) || (m_AimAssistTargets[I].Weight == fBestTargetWeight) && (Abs(m_AimAssistTargets[I].horizAssistVal) + Abs(m_AimAssistTargets[I].vertAssistVal)) < (Abs(BestHorizontalAssistAmount) + Abs(BestVerticalAssistAmount)))
            {
                fBestTargetWeight = m_AimAssistTargets[I].Weight;
                BestHorizontalAssistAmount = m_AimAssistTargets[I].horizAssistVal;
                BestVerticalAssistAmount = m_AimAssistTargets[I].vertAssistVal;
                BestAimAssistTarget = m_AimAssistTargets[I].Target.GetActorFromCombatActor();
            }
        }
        I--;
        // [Loop Continue]
        goto J0x26;
    }
    //return;    
}

function UpdateAimAssistTargetWeights(float DeltaTime)
{
    local int I;
    local float fAvgAssistAmt, fWeightChange;

    I = m_AimAssistTargets.Length - 1;
    J0x17:

    // End:0x3B6 [Loop If]
    if(I >= 0)
    {
        // End:0xDB
        if(EqualEqual_InterfaceInterface(m_AimAssistTargets[I].Target, TgCombatActor(none)) || m_AimAssistTargets[I].lastUpdateTimestamp != Outer.WorldInfo.TimeSeconds)
        {
            m_AimAssistTargets.Remove(I, 1);            
        }
        else
        {
            fWeightChange = 0.0000000;
            fWeightChange += ((m_AimAssistTargets[I].Target.GetActorFromCombatActor() == BestAimAssistTarget) ? TargetWeightVars.CurrentTargetBonus : TargetWeightVars.NotCurrentTargetPenalty);
            fAvgAssistAmt = (Abs(m_AimAssistTargets[I].horizAssistVal) + Abs(m_AimAssistTargets[I].vertAssistVal)) / 2.0000000;
            // End:0x241
            if(fAvgAssistAmt < 1.0000000)
            {
                fWeightChange += Lerp(TargetWeightVars.MaxAccuracyBonus, TargetWeightVars.MinAccuracyBonus, fAvgAssistAmt);                
            }
            else
            {
                fWeightChange -= Lerp(TargetWeightVars.MinInaccuracyPenalty, TargetWeightVars.MaxInaccuracyPenalty, (fAvgAssistAmt - 1.0000000) / 5.0000000);
            }
            m_AimAssistTargets[I].Weight = FClamp(m_AimAssistTargets[I].Weight + (fWeightChange * DeltaTime), 0.0000000, TargetWeightVars.MaxWeight * m_AimAssistTargets[I].Target.GetMaxAimAssistStacks());
            // End:0x3A8
            if(m_AimAssistTargets[I].Weight <= float(0))
            {
                m_AimAssistTargets.Remove(I, 1);                
            }
        }
        I--;
        // [Loop Continue]
        goto J0x17;
    }
    //return;    
}

function ApplyAimTracking(float DeltaTime, float HorizontalAssistAmount, float VerticalAssistAmount, float DistanceToTarget, const out array<AimAssistKeyframeData> TrackingAccHorizKeyframeData, const out array<AimAssistKeyframeData> TrackingAngleHorizKeyframeData, const out array<AimAssistKeyframeData> TrackingAccVertKeyframeData, const out array<AimAssistKeyframeData> TrackingAngleVertKeyframeData, const out Vector2D AimAssistTrackingScale)
{
    local TgGameplayCurvesSet_AimAssistKeyframes AimAssistCurvePool;
    local float TrackingX, TrackingY, TrackingInterpX, TrackingInterpY;

    // End:0x43
    if(m_AimAssistCurves != none)
    {
        AimAssistCurvePool = TgGameplayCurvesSet_AimAssistKeyframes(m_AimAssistCurves.GetCurvesSetByType(13));
    }
    // End:0x54
    if(AimAssistCurvePool == none)
    {
        return;
    }
    GetDesiredTrackingAim(TrackingX, TrackingY, DeltaTime);
    TrackingInterpX = ((Abs(HorizontalAssistAmount) < 0.9900000) ? AimAssistCurvePool.GetHorizTrackingValue(HorizontalAssistAmount, (0.0000959 * TrackingX) / DeltaTime, DistanceToTarget, TrackingAccHorizKeyframeData, TrackingAngleHorizKeyframeData) : 0.0000000);
    TrackingInterpY = ((Abs(VerticalAssistAmount) < 0.9900000) ? AimAssistCurvePool.GetVertTrackingValue(VerticalAssistAmount, (0.0000959 * TrackingY) / DeltaTime, DistanceToTarget, TrackingAccVertKeyframeData, TrackingAngleVertKeyframeData) : 0.0000000);
    aTurn = Lerp(aTurn, TrackingX, TrackingInterpX);
    aLookUp = Lerp(aLookUp, TrackingY, TrackingInterpY);
    //return;    
}

function ApplyAimFrictionAndMagnet(float DeltaTime, float HorizontalAssistAmount, float VerticalAssistAmount, float DistanceToTarget, const out array<AimAssistKeyframeData> MagnetHorizKeyframeData, const out array<AimAssistKeyframeData> MagnetVertKeyframeData, const out array<AimAssistKeyframeData> FrictionKeyframeData, const out Vector2D AimAssistMagnetScale, const out Vector2D AimAssistFrictionScale)
{
    local float rawFrictionX, rawFrictionY, rawMagnetX, rawMagnetY, ScaledMagnetAmountX, ScaledMagnetAmountY,
	    ScaledFrictionAmountX, ScaledFrictionAmountY;

    local TgGameplayCurvesSet_AimAssistKeyframes AimAssistCurvePool;

    // End:0x36
    if(((MagnetHorizKeyframeData.Length == 0) || MagnetVertKeyframeData.Length == 0) || FrictionKeyframeData.Length == 0)
    {
        return;
    }
    // End:0x79
    if(m_AimAssistCurves != none)
    {
        AimAssistCurvePool = TgGameplayCurvesSet_AimAssistKeyframes(m_AimAssistCurves.GetCurvesSetByType(13));
    }
    // End:0x8A
    if(AimAssistCurvePool == none)
    {
        return;
    }
    rawFrictionX = ((Abs(HorizontalAssistAmount) < 0.9900000) ? AimAssistCurvePool.GetFrictionValue(HorizontalAssistAmount, DistanceToTarget, FrictionKeyframeData) : 0.0000000);
    rawFrictionY = ((Abs(VerticalAssistAmount) < 0.9900000) ? AimAssistCurvePool.GetFrictionValue(VerticalAssistAmount, DistanceToTarget, FrictionKeyframeData) : 0.0000000);
    rawMagnetX = ((Abs(HorizontalAssistAmount) < 0.9900000) ? AimAssistCurvePool.GetHorizMagnetValue(HorizontalAssistAmount, DistanceToTarget, MagnetHorizKeyframeData) : 0.0000000);
    rawMagnetY = ((Abs(VerticalAssistAmount) < 0.9900000) ? AimAssistCurvePool.GetVertMagnetValue(VerticalAssistAmount, DistanceToTarget, MagnetVertKeyframeData) : 0.0000000);
    ScaledFrictionAmountX = rawFrictionX * AimAssistFrictionScale.X;
    ScaledFrictionAmountY = rawFrictionY * AimAssistFrictionScale.Y;
    aTurn *= (1.0000000 - ScaledFrictionAmountX);
    aLookUp *= (1.0000000 - ScaledFrictionAmountY);
    ScaledMagnetAmountX = ((rawMagnetX * LookRightScale) * (100.0000000 * DeltaTime)) * AimAssistMagnetScale.X;
    // End:0x313
    if(HorizontalAssistAmount < float(0))
    {
        ScaledMagnetAmountX *= float(-1);
    }
    aTurn += ScaledMagnetAmountX;
    ScaledMagnetAmountY = ((rawMagnetY * LookUpScale) * (100.0000000 * DeltaTime)) * AimAssistMagnetScale.Y;
    aLookUp += ScaledMagnetAmountY;
    //return;    
}

function float Sign(float InValue)
{
    // End:0x1C
    if(InValue > 0.0000000)
    {
        return 1.0000000;        
    }
    else
    {
        // End:0x35
        if(InValue < 0.0000000)
        {
            return -1.0000000;
        }
    }
    return 0.0000000;
    //return ReturnValue;    
}

function GetDesiredTrackingAim(out float TrackingX, out float TrackingY, float DeltaTime)
{
    local Vector PawnToTarget;
    local Rotator PawnToTargetRotator;
    local float PawnToTargetHeading, CurrentDifferenceX, CurrentDifferenceY, PredictedDifferenceX, PredictedDifferenceY;

    PawnToTarget = Normal(BestAimAssistTarget.Location - Outer.Pawn.Location);
    PawnToTargetRotator = Rotator(PawnToTarget);
    PawnToTargetHeading = UnwindHeading(float(PawnToTargetRotator.Yaw) * 0.0000959);
    CurrentDifferenceX = FindDeltaAngle(UnwindHeading(float(c_TgPC.Rotation.Yaw) * 0.0000959), PawnToTargetHeading);
    PawnToTargetHeading = UnwindHeading(float(PawnToTargetRotator.Pitch) * 0.0000959);
    CurrentDifferenceY = FindDeltaAngle(UnwindHeading(float(c_TgPC.Rotation.Pitch) * 0.0000959), PawnToTargetHeading);
    PawnToTarget = Normal((BestAimAssistTarget.Location + (BestAimAssistTarget.Velocity * DeltaTime)) - (Outer.Pawn.Location + (Outer.Pawn.Velocity * DeltaTime)));
    PawnToTargetRotator = Rotator(PawnToTarget);
    PawnToTargetHeading = UnwindHeading(float(PawnToTargetRotator.Yaw) * 0.0000959);
    PredictedDifferenceX = FindDeltaAngle(UnwindHeading(float(c_TgPC.Rotation.Yaw) * 0.0000959), PawnToTargetHeading);
    PawnToTargetHeading = UnwindHeading(float(PawnToTargetRotator.Pitch) * 0.0000959);
    PredictedDifferenceY = FindDeltaAngle(UnwindHeading(float(c_TgPC.Rotation.Pitch) * 0.0000959), PawnToTargetHeading);
    TrackingX = (PredictedDifferenceX - CurrentDifferenceX) * 10430.3800000;
    TrackingY = (PredictedDifferenceY - CurrentDifferenceY) * 10430.3800000;
    //return;    
}

function bool HandleAimAssistForTarget(TgCombatActor InTarget, float DeltaTime, const out Vector InPawnFwd, const out Vector InPawnRight, const out Vector InPawnUp, out float HorizontalAssistAmount, out float VerticalAssistAmount)
{
    local float AimWidth, AimHeight;
    local Vector AimCenter;
    local float fFOVScale;

    // End:0x51
    if(!InTarget.LocalPlayerHasLOS() || InTarget.GetMaxAimAssistStacks() <= float(0))
    {
        return false;
    }
    InTarget.GetAimAssistBounds(Outer.Pawn.Location, AimWidth, AimHeight, AimCenter);
    // End:0x133
    if(m_AimAssistCurves.GetPrimaryDistributionValueByType(26, Outer.GetFOVAngle(), fFOVScale))
    {
        AimWidth *= fFOVScale;
        AimHeight *= fFOVScale;
    }
    AimCenter += (ProjectOnTo(Outer.WorldInfo.DeltaSeconds * InTarget.GetActorFromCombatActor().Velocity, InPawnRight) * 2.0000000);
    HorizontalAssistAmount = DetermineAimAssistCurveTime(InPawnFwd, AimCenter, InPawnRight * AimWidth, InPawnFwd, InPawnRight, InPawnRight);
    VerticalAssistAmount = DetermineAimAssistCurveTime(InPawnFwd, AimCenter, InPawnUp * AimHeight, InPawnUp, InPawnFwd, -InPawnUp);
    // End:0x2BA
    if((Abs(HorizontalAssistAmount) > 1.0000000) && Abs(VerticalAssistAmount) < 1.0000000)
    {
        VerticalAssistAmount = ((VerticalAssistAmount >= float(0)) ? 1.0000000 : -1.0000000);
    }
    // End:0x30D
    if((Abs(VerticalAssistAmount) > 1.0000000) && Abs(HorizontalAssistAmount) < 1.0000000)
    {
        HorizontalAssistAmount = ((HorizontalAssistAmount >= float(0)) ? 1.0000000 : -1.0000000);
    }
    return true;
    //return ReturnValue;    
}

function float DetermineAimAssistCurveTime(Vector InPawnFwd, Vector InTargetCenter, Vector InMaxBoundsExtent, Vector InProjectPlaneA, Vector InProjectPlaneB, Vector InDetermineAssistDirectionVector)
{
    local Vector ProjectedPawnFwd, ZeroVector, PawnToTarget, MaxAllowedBounds;
    local float PawnFwdDotTarget, MaxAllowedBoundsDotTarget, AssistAmount;

    ProjectedPawnFwd = PointProjectToPlane(InPawnFwd, ZeroVector, InProjectPlaneA, InProjectPlaneB);
    ProjectedPawnFwd = Normal(ProjectedPawnFwd);
    PawnToTarget = InTargetCenter - Outer.Pawn.Location;
    PawnToTarget = PointProjectToPlane(PawnToTarget, ZeroVector, InProjectPlaneA, InProjectPlaneB);
    PawnToTarget = Normal(PawnToTarget);
    // End:0x112
    if((PawnToTarget Dot InDetermineAssistDirectionVector) > 0.0000000)
    {
        AssistAmount = 1.0000000;        
    }
    else
    {
        AssistAmount = -1.0000000;
    }
    MaxAllowedBounds = (InTargetCenter + (InMaxBoundsExtent * AssistAmount)) - Outer.Pawn.Location;
    MaxAllowedBounds = PointProjectToPlane(MaxAllowedBounds, ZeroVector, InProjectPlaneA, InProjectPlaneB);
    MaxAllowedBounds = Normal(MaxAllowedBounds);
    PawnFwdDotTarget = ProjectedPawnFwd Dot PawnToTarget;
    MaxAllowedBoundsDotTarget = MaxAllowedBounds Dot PawnToTarget;
    // End:0x26C
    if(PawnFwdDotTarget > MaxAllowedBoundsDotTarget)
    {
        AssistAmount *= GetMappedRangeValue(vect2d(MaxAllowedBoundsDotTarget, 1.0000000), vect2d(1.0000000, 0.0000000), PawnFwdDotTarget);        
    }
    else
    {
        AssistAmount *= GetMappedRangeValue(vect2d(0.0000000, MaxAllowedBoundsDotTarget), vect2d(10.0000000, 1.0000000), PawnFwdDotTarget);
    }
    return AssistAmount;
    //return ReturnValue;    
}

simulated function Rotator ApplyAimVectorModification(TgDevice InDevice, Rotator InRotation)
{
    local Matrix StartingRotationMatrix;
    local Vector StartingFwd, StartingRight, StartingUp;
    local Rotator AdjustedAim;
    local float AimWidth, AimHeight;
    local Vector AimCenter;
    local Vector2D AllowedBoundsToUse, MaxAssistanceAngleToUse;
    local float HorizontalAssistance, VerticalAssistance;

    AdjustedAim = InRotation;
    // End:0x3DF
    if((bUsingGamepad && ShouldUseAimAssist()) && BestAimAssistTarget != none)
    {
        BestAimAssistTarget.GetAimFrictionExtent(AimWidth, AimHeight, AimCenter);
        StartingRotationMatrix = MakeRotationMatrix(InRotation);
        StartingFwd = MatrixGetAxis(StartingRotationMatrix, 1);
        StartingRight = MatrixGetAxis(StartingRotationMatrix, 2);
        StartingUp = MatrixGetAxis(StartingRotationMatrix, 4);
        AimCenter += (ProjectOnTo(Outer.WorldInfo.DeltaSeconds * BestAimAssistTarget.Velocity, StartingRight) * 2.0000000);
        // End:0x1C7
        if(InDevice != none)
        {
            AllowedBoundsToUse = InDevice.m_AimVectorAssistMaxBoundsScale;
            MaxAssistanceAngleToUse = InDevice.m_AimVectorAssistMaxAssistanceDegrees;            
        }
        else
        {
            AllowedBoundsToUse = Class'TgGame.TgDevice'.default.m_AimVectorAssistMaxBoundsScale;
            MaxAssistanceAngleToUse = Class'TgGame.TgDevice'.default.m_AimVectorAssistMaxAssistanceDegrees;
        }
        HorizontalAssistance = DetermineAimVectorAssistAngleDegrees(BestAimAssistTarget, StartingFwd, AimCenter, (StartingRight * AimWidth) * 0.7500000, (StartingRight * AimWidth) * AllowedBoundsToUse.X, StartingFwd, StartingRight, StartingRight, MaxAssistanceAngleToUse.X, false);
        AdjustedAim.Yaw += int(HorizontalAssistance * 182.0444000);
        VerticalAssistance = DetermineAimVectorAssistAngleDegrees(BestAimAssistTarget, StartingFwd, AimCenter, (StartingUp * AimHeight) * 0.7500000, (StartingUp * AimHeight) * AllowedBoundsToUse.Y, StartingUp, StartingFwd, StartingUp, MaxAssistanceAngleToUse.Y, true);
        AdjustedAim.Pitch += int(VerticalAssistance * 182.0444000);
    }
    return AdjustedAim;
    //return ReturnValue;    
}

simulated function float DetermineAimVectorAssistAngleDegrees(Actor InTarget, Vector InPawnFwd, Vector InTargetCenter, Vector InRealBoundsExtent, Vector InMaxBoundsExtent, Vector InProjectPlaneA, Vector InProjectPlaneB, Vector InDetermineAssistDirectionVector, float MaxAssistanceAngleToUse, bool bIsVertical)
{
    local Vector ProjectedPawnFwd, ZeroVector, PawnToTarget, RealBounds, MaxAllowedBounds;

    local float PawnFwdDotTarget, RealBoundsDotTarget, MaxAllowedBoundsDotTarget, AssistAmount;
    local Rotator PawnFwdRotator;
    local float PawnFwdAngle;
    local Rotator BoundsRotator;
    local float BoundsAngle;

    ProjectedPawnFwd = PointProjectToPlane(InPawnFwd, ZeroVector, InProjectPlaneA, InProjectPlaneB);
    ProjectedPawnFwd = Normal(ProjectedPawnFwd);
    PawnToTarget = InTargetCenter - Outer.Pawn.Location;
    PawnToTarget = PointProjectToPlane(PawnToTarget, ZeroVector, InProjectPlaneA, InProjectPlaneB);
    PawnToTarget = Normal(PawnToTarget);
    // End:0x112
    if((PawnToTarget Dot InDetermineAssistDirectionVector) > 0.0000000)
    {
        AssistAmount = -1.0000000;        
    }
    else
    {
        AssistAmount = 1.0000000;
    }
    RealBounds = (InTargetCenter + (InRealBoundsExtent * AssistAmount)) - Outer.Pawn.Location;
    RealBounds = PointProjectToPlane(RealBounds, ZeroVector, InProjectPlaneA, InProjectPlaneB);
    RealBounds = Normal(RealBounds);
    MaxAllowedBounds = (InTargetCenter + (InMaxBoundsExtent * AssistAmount)) - Outer.Pawn.Location;
    MaxAllowedBounds = PointProjectToPlane(MaxAllowedBounds, ZeroVector, InProjectPlaneA, InProjectPlaneB);
    MaxAllowedBounds = Normal(MaxAllowedBounds);
    PawnFwdDotTarget = ProjectedPawnFwd Dot PawnToTarget;
    RealBoundsDotTarget = RealBounds Dot PawnToTarget;
    MaxAllowedBoundsDotTarget = MaxAllowedBounds Dot PawnToTarget;
    // End:0x307
    if((PawnFwdDotTarget > RealBoundsDotTarget) || MaxAllowedBoundsDotTarget > PawnFwdDotTarget)
    {
        return 0.0000000;
    }
    PawnFwdRotator = Rotator(ProjectedPawnFwd);
    PawnFwdAngle = float(((bIsVertical) ? PawnFwdRotator.Pitch : PawnFwdRotator.Yaw));
    PawnFwdAngle *= 0.0000959;
    PawnFwdAngle = UnwindHeading(PawnFwdAngle);
    BoundsRotator = Rotator(RealBounds);
    BoundsAngle = float(((bIsVertical) ? BoundsRotator.Pitch : BoundsRotator.Yaw));
    BoundsAngle *= 0.0000959;
    BoundsAngle = UnwindHeading(BoundsAngle);
    AssistAmount = FindDeltaAngle(PawnFwdAngle, BoundsAngle) * 57.2957800;
    return float(Clamp(int(AssistAmount), int(-MaxAssistanceAngleToUse), int(MaxAssistanceAngleToUse)));
    //return ReturnValue;    
}

exec function SetAimAccelerationAlgorithm(int Algorithm)
{
    nAimAccelerationAlgorithm = Algorithm;
    //return;    
}

exec function SetAimAccelerationSet(int AimSet)
{
    nAimAccelerationSet = AimSet;
    //return;    
}

exec function ToggleAutoRun()
{
    c_bAutoRun = !c_bAutoRun;
    // End:0x4F
    if(c_bAutoRun)
    {
        Outer.SetTimer(60.0000000, false, 'CancelAutoRun', self);        
    }
    else
    {
        Outer.ClearTimer('CancelAutoRun', self);
    }
    //return;    
}

function CancelAutoRun()
{
    c_bAutoRun = false;
    //return;    
}

exec function SetGamepadSensitivity(float fAxisX, float fAxisY)
{
    GamepadSensitivityX = fAxisX / float(100);
    GamepadSensitivityY = fAxisY / float(100);
    // End:0x60
    if(c_TgPC != none)
    {
        c_TgPC.UpdateKeybindsUI();
    }
    //return;    
}

exec function SetMouseInput(bool bInvert, bool bSmooth, float fSensitivity)
{
    super.SetMouseInput(bInvert, bSmooth, fSensitivity);
    // End:0x55
    if(c_TgPC != none)
    {
        c_TgPC.UpdateKeybindsUI();
    }
    //return;    
}

function SetBindExtended(const string ExtendedBinding, string Command)
{
    super.SetBindExtended(ExtendedBinding, Command);
    // End:0x4A
    if(c_TgPC != none)
    {
        c_TgPC.UpdateKeybindsUI();
    }
    //return;    
}

function SetCommandBind(string Command, int nAlternate, const string ExtendedBinding)
{
    super.SetCommandBind(Command, nAlternate, ExtendedBinding);
    // End:0x53
    if(c_TgPC != none)
    {
        c_TgPC.UpdateKeybindsUI();
    }
    //return;    
}

exec function UnbindCommandAll(string Command)
{
    super.UnbindCommandAll(Command);
    // End:0x41
    if(c_TgPC != none)
    {
        c_TgPC.UpdateKeybindsUI();
    }
    //return;    
}

exec function UnbindCommand(string Command, optional int nAlternate = 0)
{
    super.UnbindCommand(Command, nAlternate);
    // End:0x4F
    if(c_TgPC != none)
    {
        c_TgPC.UpdateKeybindsUI();
    }
    //return;    
}

defaultproperties
{
    GamepadSensitivityX=0.5000000
    GamepadSensitivityY=0.5000000
    m_fMinScopeSensitivityMult=0.5000000
    m_fMaxScopeSensitivityMult=2.0000000
    nAimAccelerationSet=1
    nAimAccelerationBoost=7
    nInnerDeadZoneSize=2
    nOuterDeadZoneSize=1
    m_AimAssistCurves=TgGameplayCurves'GP_AimAssist.AimAssistCurvePool'
    TargetWeightVars=(CurrentTargetBonus=5.0000000,NotCurrentTargetPenalty=-5.0000000,MinAccuracyBonus=2.0000000,MaxAccuracyBonus=7.0000000,MinInaccuracyPenalty=0.0000000,MaxInaccuracyPenalty=20.0000000,MaxWeight=10.0000000)
    Bindings=/* Array type was not detected. */
}