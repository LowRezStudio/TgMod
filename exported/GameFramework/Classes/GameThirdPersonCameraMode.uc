class GameThirdPersonCameraMode extends Object
    native(Camera)
    config(Camera);

enum ECameraViewportTypes
{
    CVT_16to9_Full,                 // 0
    CVT_16to9_VertSplit,            // 1
    CVT_16to9_HorizSplit,           // 2
    CVT_4to3_Full,                  // 3
    CVT_4to3_HorizSplit,            // 4
    CVT_4to3_VertSplit,             // 5
    CVT_MAX                         // 6
};

struct native ViewOffsetData
{
    var() Vector OffsetHigh;
    var() Vector OffsetMid;
    var() Vector OffsetLow;

    structdefaultproperties
    {
        OffsetHigh=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        OffsetMid=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        OffsetLow=(X=0.0000000,Y=0.0000000,Z=0.0000000)
    }
};

var transient GameThirdPersonCamera ThirdPersonCam;
var() const config float FOVAngle;
var() float BlendTime;
var() protected const bool bLockedToViewTarget;
var() protected const bool bDirectLook;
var() protected const bool bFollowTarget;
var() bool bInterpLocation;
var() protected bool bUsePerAxisOriginLocInterp;
var() bool bInterpRotation;
var() bool bRotInterpSpeedConstant;
var() const bool bDoPredictiveAvoidance;
var() const bool bValidateWorstLoc;
var() bool bSkipCameraCollision;
var() protected const bool bSmoothViewOffsetPitchChanges;
var() bool bApplyDeltaViewOffset;
var(DepthOfField) protected const bool bAdjustDOF;
var protected transient bool bDOFUpdated;
var bool bNoFOVPostProcess;
var() bool bInterpViewOffsetOnlyForCamTransition;
var() protected const float FollowingInterpSpeed_Pitch;
var() protected const float FollowingInterpSpeed_Yaw;
var() protected const float FollowingInterpSpeed_Roll;
var() protected const float FollowingCameraVelThreshold;
var() protected float OriginLocInterpSpeed;
var() protected Vector PerAxisOriginLocInterpSpeed;
var() protected float OriginRotInterpSpeed;
var() protected const Vector StrafeLeftAdjustment;
var() protected const Vector StrafeRightAdjustment;
var() protected const float StrafeOffsetScalingThreshold;
var() protected const float StrafeOffsetInterpSpeedIn;
var() protected const float StrafeOffsetInterpSpeedOut;
var protected transient Vector LastStrafeOffset;
var() protected const Vector RunFwdAdjustment;
var() protected const Vector RunBackAdjustment;
var() protected const float RunOffsetScalingThreshold;
var() protected const float RunOffsetInterpSpeedIn;
var() protected const float RunOffsetInterpSpeedOut;
var protected transient Vector LastRunOffset;
var() protected Vector WorstLocOffset;
var() protected const Vector TargetRelativeCameraOriginOffset;
var() protected const ViewOffsetData ViewOffset;
var() protected const ViewOffsetData ViewOffset_ViewportAdjustments[ECameraViewportTypes];
var(DepthOfField) protected const float DOF_FalloffExponent;
var(DepthOfField) protected const float DOF_BlurKernelSize;
var(DepthOfField) protected const float DOF_FocusInnerRadius;
var(DepthOfField) protected const float DOF_MaxNearBlurAmount;
var(DepthOfField) protected const float DOF_MaxFarBlurAmount;
var protected transient float LastDOFRadius;
var protected transient float LastDOFDistance;
var(DepthOfField) protected const float DOFDistanceInterpSpeed;
var(DepthOfField) protected const Vector DOFTraceExtent;
var(DepthOfField) protected const float DOF_RadiusFalloff;
var(DepthOfField) protected const Vector2D DOF_RadiusRange;
var(DepthOfField) protected const Vector2D DOF_RadiusDistRange;
var float ViewOffsetInterp;
var() protected float OffsetAdjustmentInterpSpeed;
var protected transient GameThirdPersonCameraMode.ECameraViewportTypes CurrentViewportType;

function Init()
{
    //return;    
}

function OnBecomeActive(Pawn TargetPawn, GameThirdPersonCameraMode PrevMode)
{
    // End:0x30
    if(BlendTime > 0.0000000)
    {
        ViewOffsetInterp = 1.0000000 / BlendTime;        
    }
    else
    {
        ViewOffsetInterp = 0.0000000;
    }
    //return;    
}

function OnBecomeInActive(Pawn TargetPawn, GameThirdPersonCameraMode NewMode)
{
    //return;    
}

event Vector AdjustViewOffset(Pawn P, Vector Offset)
{
    return Offset;
    //return ReturnValue;    
}

function float GetDesiredFOV(Pawn ViewedPawn)
{
    return FOVAngle;
    //return ReturnValue;    
}

simulated event Vector GetCameraWorstCaseLoc(Pawn TargetPawn, TViewTarget CurrentViewTarget)
{
    return TargetPawn.Location + (WorstLocOffset >> TargetPawn.Rotation);
    //return ReturnValue;    
}

simulated function bool SetFocusPoint(Pawn ViewedPawn)
{
    return false;
    //return ReturnValue;    
}

simulated function ProcessViewRotation(float DeltaTime, Actor ViewTarget, out Rotator out_ViewRotation, out Rotator out_DeltaRot)
{
    //return;    
}

protected simulated function Vector GetDOFFocusLoc(Actor TraceOwner, Vector StartTrace, Vector EndTrace)
{
    return DOFTrace(TraceOwner, StartTrace, EndTrace);
    //return ReturnValue;    
}

protected simulated function Vector DOFTrace(Actor TraceOwner, Vector StartTrace, Vector EndTrace)
{
    local Vector HitLocation, HitNormal;
    local Actor HitActor;

    HitActor = TraceOwner.Trace(HitLocation, HitNormal, EndTrace, StartTrace, true, DOFTraceExtent,, TraceOwner.1);
    // End:0x89
    if(HitActor == none)
    {
        HitLocation = EndTrace;
    }
    // End:0x177
    if(HitActor != none)
    {
        // End:0x177
        if(!HitActor.bBlockActors && HitActor.IsA('Trigger') || HitActor.IsA('TriggerVolume'))
        {
            HitActor.bProjTarget = false;
            HitLocation = DOFTrace(TraceOwner, HitLocation, EndTrace);
            HitActor.bProjTarget = true;
        }
    }
    return HitLocation;
    //return ReturnValue;    
}

simulated function UpdatePostProcess(const out TViewTarget VT, float DeltaTime)
{
    local Vector FocusLoc, StartTrace, EndTrace, CamDir;
    local float FocusDist, SubjectDist, Pct;

    bDOFUpdated = false;
    // End:0x21B
    if(bAdjustDOF)
    {
        CamDir = Vector(VT.POV.Rotation);
        StartTrace = VT.POV.Location + (CamDir * float(10));
        EndTrace = StartTrace + (CamDir * float(50000));
        FocusLoc = GetDOFFocusLoc(VT.Target, StartTrace, EndTrace);
        SubjectDist = VSize(FocusLoc - StartTrace);
        // End:0x186
        if(!ThirdPersonCam.bResetCameraInterpolation)
        {
            FocusDist = FInterpTo(LastDOFDistance, SubjectDist, DeltaTime, DOFDistanceInterpSpeed);            
        }
        else
        {
            FocusDist = SubjectDist;
        }
        LastDOFDistance = FocusDist;
        Pct = GetRangePctByValue(DOF_RadiusDistRange, FocusDist);
        LastDOFRadius = GetRangeValueByPct(DOF_RadiusRange, FClamp(Pct, 0.0000000, 1.0000000) ** DOF_RadiusFalloff);
        bDOFUpdated = true;
    }
    //return;    
}

simulated function ModifyPostProcessSettings(out PostProcessSettings PP)
{
    // End:0x161
    if(bDOFUpdated)
    {
        PP.bEnableDOF = true;
        PP.DOF_FalloffExponent = DOF_FalloffExponent;
        PP.DOF_BlurKernelSize = DOF_BlurKernelSize;
        PP.DOF_MaxNearBlurAmount = DOF_MaxNearBlurAmount;
        PP.DOF_MaxFarBlurAmount = DOF_MaxFarBlurAmount;
        PP.DOF_FocusType = 0;
        PP.DOF_FocusInnerRadius = DOF_FocusInnerRadius;
        PP.DOF_FocusDistance = LastDOFDistance;
        PP.DOF_FocusInnerRadius = LastDOFRadius;
        bDOFUpdated = false;
    }
    //return;    
}

// Export UGameThirdPersonCameraMode::execSetViewOffset(FFrame&, void* const)
native final function SetViewOffset(const out ViewOffsetData NewViewOffset);

defaultproperties
{
    BlendTime=0.6700000
    bLockedToViewTarget=true
    bInterpLocation=true
    bDoPredictiveAvoidance=true
    bValidateWorstLoc=true
    bInterpViewOffsetOnlyForCamTransition=true
    OriginLocInterpSpeed=8.0000000
    StrafeOffsetInterpSpeedIn=12.0000000
    StrafeOffsetInterpSpeedOut=20.0000000
    RunOffsetInterpSpeedIn=6.0000000
    RunOffsetInterpSpeedOut=12.0000000
    WorstLocOffset=(X=-8.0000000,Y=1.0000000,Z=90.0000000)
    DOF_FalloffExponent=1.0000000
    DOF_BlurKernelSize=3.0000000
    DOF_MaxNearBlurAmount=0.6000000
    DOF_MaxFarBlurAmount=1.0000000
    DOFDistanceInterpSpeed=10.0000000
    DOF_RadiusFalloff=1.0000000
    DOF_RadiusRange=(X=2500.0000000,Y=60000.0000000)
    DOF_RadiusDistRange=(X=1000.0000000,Y=50000.0000000)
    OffsetAdjustmentInterpSpeed=12.0000000
}