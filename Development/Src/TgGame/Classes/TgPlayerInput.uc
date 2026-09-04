class TgPlayerInput extends PComPlayerInput within TgPlayerController
    transient
    native(Pawns)
    config(Input)
    hidecategories(Object,UIRoot)
    dependson(TgAimAssistKeyframe, TgPlayerController);

struct AimAssistTargetWeight {
    var TgCombatActor Target;
    var float Weight;
    var float horizAssistVal;
    var float vertAssistVal;
    var float lastUpdateTimestamp;
    structdefaultproperties {}
};

struct AimAssistTargetWeightVars {
    var float CurrentTargetBonus;
    var float NotCurrentTargetPenalty;
    var float MinAccuracyBonus;
    var float MaxAccuracyBonus;
    var float MinInaccuracyPenalty;
    var float MaxInaccuracyPenalty;
    var float MaxWeight;
    structdefaultproperties {}
};

struct DebugAimAssist {
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
    structdefaultproperties {}
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

delegate bool OnRawInputKey(int ControllerId, name Key, Object.EInputEvent Event, float AmountDepressed);

delegate bool OnInputAxis(int ControllerId, name Key, float Delta, float DeltaTime);

delegate bool OnInputChar(int ControllerId, string Unicode);

native function StoreMouseSettings();  // Export UTgPlayerInput::execStoreMouseSettings(FFrame&, void* const)

native function ReadMouseSettings();  // Export UTgPlayerInput::execReadMouseSettings(FFrame&, void* const)

native function ResetKeysToDefault();  // Export UTgPlayerInput::execResetKeysToDefault(FFrame&, void* const)

native exec function SetKeyCaptureState(bool bSpectator, bool bCaptureKey);  // Export UTgPlayerInput::execSetKeyCaptureState(FFrame&, void* const)

native function KeyBind GenerateKeybindFromButton(const name ButtonName);  // Export UTgPlayerInput::execGenerateKeybindFromButton(FFrame&, void* const)

native function PreProcessJoystickInput(float fDeltaTime);  // Export UTgPlayerInput::execPreProcessJoystickInput(FFrame&, void* const)

event bool InputChar(int ControllerId, string Unicode) { }

simulated exec function Duck() { }

function Actor.EDoubleClickDir CheckForDoubleClickMove(float DeltaTime) { }

function PreProcessInput(float DeltaTime) { }

native simulated function bool ShouldUseAimAssist();  // Export UTgPlayerInput::execShouldUseAimAssist(FFrame&, void* const)

simulated function float GetScopeSensitivity() { }

function AdjustMouseSensitivity(float FOVScale) { }

event PlayerInput(float DeltaTime) { }

function HandleMovementInput(bool bIsMatchingInput, TgPlayerController.EPlayerInputType InputType, out float fAxisValue) { }

simulated function DisplayDebug(HUD HUD, out float out_YL, out float out_YPos) { }

simulated function DrawAimAssistVals(string assistName, int Index, out float YPos, float YL, HUD HUD) { }

function HandleAimAssist(float DeltaTime) { }

function SelectBestAimAssistTargetViaWeights(out float BestHorizontalAssistAmount, out float BestVerticalAssistAmount) { }

function UpdateAimAssistTargetWeights(float DeltaTime) { }

function ApplyAimTracking(float DeltaTime, float HorizontalAssistAmount, float VerticalAssistAmount, float DistanceToTarget, const out array<AimAssistKeyframeData> TrackingAccHorizKeyframeData, const out array<AimAssistKeyframeData> TrackingAngleHorizKeyframeData, const out array<AimAssistKeyframeData> TrackingAccVertKeyframeData, const out array<AimAssistKeyframeData> TrackingAngleVertKeyframeData, const out Vector2D AimAssistTrackingScale) { }

function ApplyAimFrictionAndMagnet(float DeltaTime, float HorizontalAssistAmount, float VerticalAssistAmount, float DistanceToTarget, const out array<AimAssistKeyframeData> MagnetHorizKeyframeData, const out array<AimAssistKeyframeData> MagnetVertKeyframeData, const out array<AimAssistKeyframeData> FrictionKeyframeData, const out Vector2D AimAssistMagnetScale, const out Vector2D AimAssistFrictionScale) { }

function float Sign(float InValue) { }

function GetDesiredTrackingAim(out float TrackingX, out float TrackingY, float DeltaTime) { }

function bool HandleAimAssistForTarget(TgCombatActor InTarget, float DeltaTime, const out Vector InPawnFwd, const out Vector InPawnRight, const out Vector InPawnUp, out float HorizontalAssistAmount, out float VerticalAssistAmount) { }

function float DetermineAimAssistCurveTime(Vector InPawnFwd, Vector InTargetCenter, Vector InMaxBoundsExtent, Vector InProjectPlaneA, Vector InProjectPlaneB, Vector InDetermineAssistDirectionVector) { }

simulated function Rotator ApplyAimVectorModification(TgDevice InDevice, Rotator InRotation) { }

simulated function float DetermineAimVectorAssistAngleDegrees(Actor InTarget, Vector InPawnFwd, Vector InTargetCenter, Vector InRealBoundsExtent, Vector InMaxBoundsExtent, Vector InProjectPlaneA, Vector InProjectPlaneB, Vector InDetermineAssistDirectionVector, float MaxAssistanceAngleToUse, bool bIsVertical) { }

exec function SetAimAccelerationAlgorithm(int Algorithm) { }

exec function SetAimAccelerationSet(int AimSet) { }

exec function ToggleAutoRun() { }

function CancelAutoRun() { }

exec function SetGamepadSensitivity(float fAxisX, float fAxisY) { }

exec function SetMouseInput(bool bInvert, bool bSmooth, float fSensitivity) { }

function SetBindExtended(const string ExtendedBinding, string Command) { }

function SetCommandBind(string Command, int nAlternate, const string ExtendedBinding) { }

exec function UnbindCommandAll(string Command) { }

exec function UnbindCommand(string Command, optional int nAlternate=0) { }

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
    m_AimAssistCurves=TgGameplayCurves'AimAssistCurvePool'
    TargetWeightVars=(CurrentTargetBonus=5.0000000,NotCurrentTargetPenalty=-5.0000000,MinAccuracyBonus=2.0000000,MaxAccuracyBonus=7.0000000,MinInaccuracyPenalty=0.0000000,MaxInaccuracyPenalty=20.0000000,MaxWeight=10.0000000)
    Bindings=/* Array type was not detected. */
}
