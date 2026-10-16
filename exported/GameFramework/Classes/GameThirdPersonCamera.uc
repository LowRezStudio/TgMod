class GameThirdPersonCamera extends GameCameraBase
    native(Camera);

struct native CamFocusPointParams
{
    var() Actor FocusActor;
    var() name FocusBoneName;
    var() Vector FocusWorldLoc;
    var() float CameraFOV;
    var() Vector2D InterpSpeedRange;
    var() Vector2D InFocusFOV;
    var() bool bAlwaysFocus;
    var() bool bAdjustCamera;
    var() bool bIgnoreTrace;
    var() float FocusPitchOffsetDeg;

    structdefaultproperties
    {
        FocusActor=none
        FocusBoneName="None"
        FocusWorldLoc=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        CameraFOV=0.0000000
        InterpSpeedRange=(X=0.0000000,Y=0.0000000)
        InFocusFOV=(X=0.0000000,Y=0.0000000)
        bAlwaysFocus=false
        bAdjustCamera=false
        bIgnoreTrace=false
        FocusPitchOffsetDeg=0.0000000
    }
};

struct native PenetrationAvoidanceFeeler
{
    var() Rotator AdjustmentRot;
    var() float WorldWeight;
    var() float PawnWeight;
    var() Vector Extent;
    var() int TraceInterval;
    var transient int FramesUntilNextTrace;

    structdefaultproperties
    {
        AdjustmentRot=(Pitch=0,Yaw=0,Roll=0)
        WorldWeight=0.0000000
        PawnWeight=0.0000000
        Extent=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        TraceInterval=0
        FramesUntilNextTrace=0
    }
};

var float WorstLocBlockedPct;
var() float WorstLocPenetrationExtentScale;
var() float PenetrationBlendOutTime;
var() float PenetrationBlendInTime;
var protected float PenetrationBlockedPct;
var() float PenetrationExtentScale;
var transient Vector LastActualOriginOffset;
var transient Vector LastActualCameraOrigin;
var transient Rotator LastActualCameraOriginRot;
var() float OriginOffsetInterpSpeed;
var transient Vector LastViewOffset;
var transient float LastCamFOV;
var transient Vector LastIdealCameraOrigin;
var transient Rotator LastIdealCameraOriginRot;
var() protected editinline GameThirdPersonCameraMode ThirdPersonCamDefault;
var() protected Class<GameThirdPersonCameraMode> ThirdPersonCamDefaultClass;
var() editinline transient GameThirdPersonCameraMode CurrentCamMode;
var transient float LastHeightAdjustment;
var transient float LastPitchAdjustment;
var transient float LastYawAdjustment;
var transient float LeftoverPitchAdjustment;
var(Focus) float Focus_BackOffStrength;
var(Focus) float Focus_StepHeightAdjustment;
var(Focus) int Focus_MaxTries;
var(Focus) float Focus_FastAdjustKickInTime;
var protected transient float LastFocusChangeTime;
var protected transient Vector ActualFocusPointWorldLoc;
var protected transient Vector LastFocusPointLoc;
var(Focus) CamFocusPointParams FocusPoint;
var bool bFocusPointSet;
var protected transient bool bFocusPointSuccessful;
var bool bDoingACameraTurn;
var protected bool bTurnAlignTargetWhenFinished;
var() bool bDrawDebug;
var transient bool bDoingDirectLook;
var(Debug) bool bDebugChangedCameraMode;
var transient bool bDoSeamlessPivotTransition;
var protected float TurnCurTime;
var protected int TurnStartAngle;
var protected int TurnEndAngle;
var protected float TurnTotalTime;
var protected float TurnDelay;
var protected transient int LastPostCamTurnYaw;
var transient int DirectLookYaw;
var() float DirectLookInterpSpeed;
var() float WorstLocInterpSpeed;
var transient Vector LastWorstLocationLocal;
var transient Vector LastWorstLocation;
var transient Vector LastPreModifierCameraLoc;
var transient Rotator LastPreModifierCameraRot;
var() array<PenetrationAvoidanceFeeler> PenetrationAvoidanceFeelers;
var protectedwrite transient Vector LastOffsetAdjustment;

protected function GameThirdPersonCameraMode CreateCameraMode(Class<GameThirdPersonCameraMode> ModeClass)
{
    local GameThirdPersonCameraMode NewMode;

    NewMode = new (self) ModeClass;
    NewMode.ThirdPersonCam = self;
    NewMode.Init();
    return NewMode;
    //return ReturnValue;    
}

function Reset()
{
    bResetCameraInterpolation = true;
    //return;    
}

function Init()
{
    // End:0x2C
    if(ThirdPersonCamDefault == none)
    {
        ThirdPersonCamDefault = CreateCameraMode(ThirdPersonCamDefaultClass);
    }
    //return;    
}

event float GetDesiredFOV(Pawn ViewedPawn)
{
    // End:0x61
    if((bFocusPointSet && FocusPoint.CameraFOV > 0.0000000) && bFocusPointSuccessful)
    {
        return FocusPoint.CameraFOV;
    }
    return CurrentCamMode.GetDesiredFOV(ViewedPawn);
    //return ReturnValue;    
}

function UpdateCamera(Pawn P, GamePlayerCamera CameraActor, float DeltaTime, out TViewTarget OutVT)
{
    // End:0x10A
    if((P == none) && OutVT.Target != none)
    {
        OutVT.Target.GetActorEyesViewPoint(OutVT.POV.Location, OutVT.POV.Rotation);
        PlayerCamera.ApplyCameraModifiers(DeltaTime, OutVT.POV);        
    }
    else
    {
        // End:0x21C
        if((P != none) && P.CalcCamera(DeltaTime, OutVT.POV.Location, OutVT.POV.Rotation, OutVT.POV.FOV))
        {
            PlayerCamera.ApplyCameraModifiers(DeltaTime, OutVT.POV);
            return;            
        }
        else
        {
            UpdateCameraMode(P);
            // End:0x2A0
            if(CurrentCamMode != none)
            {
                PlayerUpdateCamera(P, CameraActor, DeltaTime, OutVT);
                CurrentCamMode.UpdatePostProcess(OutVT, DeltaTime);                
            }
        }
    }
    bResetCameraInterpolation = false;
    //return;    
}

// Export UGameThirdPersonCamera::execPlayerUpdateCamera(FFrame&, void* const)
protected native function PlayerUpdateCamera(Pawn P, GamePlayerCamera CameraActor, float DeltaTime, out TViewTarget OutVT);

function BeginTurn(int StartAngle, int EndAngle, float TimeSec, optional float DelaySec, optional bool bAlignTargetWhenFinished)
{
    // End:0x61
    if(PlayerCamera.bUseClientSideCameraUpdates && !PlayerCamera.PCOwner.IsLocalPlayerController())
    {
        return;
    }
    bDoingACameraTurn = true;
    TurnTotalTime = TimeSec;
    TurnDelay = DelaySec;
    TurnCurTime = 0.0000000;
    TurnStartAngle = StartAngle;
    TurnEndAngle = EndAngle;
    bTurnAlignTargetWhenFinished = bAlignTargetWhenFinished;
    //return;    
}

// Export UGameThirdPersonCamera::execEndTurn(FFrame&, void* const)
native function EndTurn();

function AdjustTurn(int AngleOffset)
{
    TurnStartAngle += AngleOffset;
    TurnEndAngle += AngleOffset;
    //return;    
}

function SetFocusOnLoc(Vector FocusWorldLoc, Vector2D InterpSpeedRange, Vector2D InFocusFOV, optional float CameraFOV, optional bool bAlwaysFocus, optional bool bAdjustCamera, optional bool bIgnoreTrace, optional float FocusPitchOffsetDeg)
{
    // End:0x67
    if((((LastPitchAdjustment != float(0)) || LastYawAdjustment != float(0)) && !bAdjustCamera) && FocusPoint.bAdjustCamera)
    {
        ClearFocusPoint(true);
    }
    FocusPoint.FocusWorldLoc = FocusWorldLoc;
    FocusPoint.FocusActor = none;
    FocusPoint.FocusBoneName = 'None';
    FocusPoint.InterpSpeedRange = InterpSpeedRange;
    FocusPoint.InFocusFOV = InFocusFOV;
    FocusPoint.CameraFOV = CameraFOV;
    FocusPoint.bAlwaysFocus = bAlwaysFocus;
    FocusPoint.bAdjustCamera = bAdjustCamera;
    FocusPoint.bIgnoreTrace = bIgnoreTrace;
    FocusPoint.FocusPitchOffsetDeg = FocusPitchOffsetDeg;
    bFocusPointSet = true;
    LastFocusChangeTime = PlayerCamera.WorldInfo.TimeSeconds;
    LastFocusPointLoc = GetActualFocusLocation();
    bFocusPointSuccessful = false;
    //return;    
}

function SetFocusOnActor(Actor FocusActor, name FocusBoneName, Vector2D InterpSpeedRange, Vector2D InFocusFOV, optional float CameraFOV, optional bool bAlwaysFocus, optional bool bAdjustCamera, optional bool bIgnoreTrace, optional float FocusPitchOffsetDeg)
{
    // End:0x67
    if((((LastPitchAdjustment != float(0)) || LastYawAdjustment != float(0)) && !bAdjustCamera) && FocusPoint.bAdjustCamera)
    {
        ClearFocusPoint(true);
    }
    FocusPoint.FocusActor = FocusActor;
    FocusPoint.FocusBoneName = FocusBoneName;
    FocusPoint.InterpSpeedRange = InterpSpeedRange;
    FocusPoint.InFocusFOV = InFocusFOV;
    FocusPoint.CameraFOV = CameraFOV;
    FocusPoint.bAlwaysFocus = bAlwaysFocus;
    FocusPoint.bAdjustCamera = bAdjustCamera;
    FocusPoint.bIgnoreTrace = bIgnoreTrace;
    FocusPoint.FocusPitchOffsetDeg = FocusPitchOffsetDeg;
    bFocusPointSet = true;
    LastFocusChangeTime = PlayerCamera.WorldInfo.TimeSeconds;
    LastFocusPointLoc = GetActualFocusLocation();
    bFocusPointSuccessful = false;
    //return;    
}

function Actor GetFocusActor()
{
    return ((bFocusPointSet) ? FocusPoint.FocusActor : none);
    //return ReturnValue;    
}

function ClearFocusPoint(optional bool bLeaveCameraRotation)
{
    bFocusPointSet = false;
    // End:0xC3
    if(bLeaveCameraRotation && FocusPoint.bAdjustCamera)
    {
        LastPitchAdjustment = 0.0000000;
        LastYawAdjustment = 0.0000000;
        LeftoverPitchAdjustment = 0.0000000;
        // End:0xC3
        if(PlayerCamera.PCOwner != none)
        {
            PlayerCamera.PCOwner.SetRotation(LastPreModifierCameraRot);
        }
    }
    //return;    
}

protected event UpdateFocusPoint(Pawn P)
{
    // End:0x1B
    if(bDoingACameraTurn)
    {
        ClearFocusPoint();        
    }
    else
    {
        // End:0x65
        if((CurrentCamMode == none) || CurrentCamMode.SetFocusPoint(P) == false)
        {
            ClearFocusPoint();
        }
    }
    // End:0x99
    if(bFocusPointSet)
    {
        LastFocusPointLoc = ActualFocusPointWorldLoc;
        ActualFocusPointWorldLoc = GetActualFocusLocation();
    }
    //return;    
}

protected function Vector GetActualFocusLocation()
{
    local Vector FocusLoc;
    local editinline SkeletalMeshComponent ComponentIt;

    // End:0x161
    if(FocusPoint.FocusActor != none)
    {
        FocusLoc = FocusPoint.FocusActor.Location;
        // End:0x15E
        if(FocusPoint.FocusBoneName != 'None')
        {
            // End:0x15D
            foreach FocusPoint.FocusActor.ComponentList(Class'Engine.SkeletalMeshComponent', ComponentIt)
            {
                // End:0x15C
                if(ComponentIt.MatchRefBone(FocusPoint.FocusBoneName) != -1)
                {
                    FocusLoc = ComponentIt.GetBoneLocation(FocusPoint.FocusBoneName);
                    // End:0x15D
                    break;
                }                
            }            
        }        
    }
    else
    {
        FocusLoc = FocusPoint.FocusWorldLoc;
    }
    return FocusLoc;
    //return ReturnValue;    
}

function AdjustFocusPointInterpolation(Rotator Delta)
{
    // End:0x9E
    if(bFocusPointSet && FocusPoint.bAdjustCamera)
    {
        Delta = Normalize(Delta);
        LastYawAdjustment -= float(Delta.Yaw);
        LastPitchAdjustment -= float(Delta.Pitch);
    }
    //return;    
}

function GameThirdPersonCameraMode FindBestCameraMode(Pawn P)
{
    // End:0x19
    if(P != none)
    {
        return ThirdPersonCamDefault;
    }
    return none;
    //return ReturnValue;    
}

protected final function UpdateCameraMode(Pawn P)
{
    local GameThirdPersonCameraMode NewCamMode;

    NewCamMode = FindBestCameraMode(P);
    // End:0xC7
    if(NewCamMode != CurrentCamMode)
    {
        // End:0x74
        if(CurrentCamMode != none)
        {
            CurrentCamMode.OnBecomeInActive(P, NewCamMode);
        }
        // End:0xB4
        if(NewCamMode != none)
        {
            NewCamMode.OnBecomeActive(P, CurrentCamMode);
        }
        CurrentCamMode = NewCamMode;
    }
    //return;    
}

function ProcessViewRotation(float DeltaTime, Actor ViewTarget, out Rotator out_ViewRotation, out Rotator out_DeltaRot)
{
    // End:0x52
    if(CurrentCamMode != none)
    {
        CurrentCamMode.ProcessViewRotation(DeltaTime, ViewTarget, out_ViewRotation, out_DeltaRot);
    }
    //return;    
}

function OnBecomeActive(GameCameraBase OldCamera)
{
    // End:0x2E
    if(!PlayerCamera.bInterpolateCamChanges)
    {
        Reset();
    }
    super.OnBecomeActive(OldCamera);
    //return;    
}

event ModifyPostProcessSettings(out PostProcessSettings PP)
{
    // End:0x37
    if(CurrentCamMode != none)
    {
        CurrentCamMode.ModifyPostProcessSettings(PP);
    }
    //return;    
}

function ResetInterpolation()
{
    super.ResetInterpolation();
    LastHeightAdjustment = 0.0000000;
    LastYawAdjustment = 0.0000000;
    LastPitchAdjustment = 0.0000000;
    LeftoverPitchAdjustment = 0.0000000;
    //return;    
}

defaultproperties
{
    WorstLocPenetrationExtentScale=1.0000000
    PenetrationBlendOutTime=0.1500000
    PenetrationBlendInTime=0.1000000
    PenetrationBlockedPct=1.0000000
    PenetrationExtentScale=1.0000000
    OriginOffsetInterpSpeed=8.0000000
    ThirdPersonCamDefaultClass=Class'GameFramework.GameThirdPersonCameraMode_Default'
    Focus_BackOffStrength=0.3300000
    Focus_StepHeightAdjustment=64.0000000
    Focus_MaxTries=4
    Focus_FastAdjustKickInTime=0.5000000
    DirectLookInterpSpeed=6.0000000
    WorstLocInterpSpeed=8.0000000
    PenetrationAvoidanceFeelers[0]=(AdjustmentRot=(Pitch=0,Yaw=0,Roll=0),WorldWeight=1.0000000,PawnWeight=1.0000000,Extent=(X=14.0000000,Y=14.0000000,Z=14.0000000),TraceInterval=0,FramesUntilNextTrace=0)
    PenetrationAvoidanceFeelers[1]=(AdjustmentRot=(Pitch=0,Yaw=3072,Roll=0),WorldWeight=0.7500000,PawnWeight=0.7500000,Extent=(X=0.0000000,Y=0.0000000,Z=0.0000000),TraceInterval=3,FramesUntilNextTrace=0)
    PenetrationAvoidanceFeelers[2]=(AdjustmentRot=(Pitch=0,Yaw=-3072,Roll=0),WorldWeight=0.7500000,PawnWeight=0.7500000,Extent=(X=0.0000000,Y=0.0000000,Z=0.0000000),TraceInterval=3,FramesUntilNextTrace=0)
    PenetrationAvoidanceFeelers[3]=(AdjustmentRot=(Pitch=0,Yaw=6144,Roll=0),WorldWeight=0.5000000,PawnWeight=0.5000000,Extent=(X=0.0000000,Y=0.0000000,Z=0.0000000),TraceInterval=5,FramesUntilNextTrace=0)
    PenetrationAvoidanceFeelers[4]=(AdjustmentRot=(Pitch=0,Yaw=-6144,Roll=0),WorldWeight=0.5000000,PawnWeight=0.5000000,Extent=(X=0.0000000,Y=0.0000000,Z=0.0000000),TraceInterval=5,FramesUntilNextTrace=0)
    PenetrationAvoidanceFeelers[5]=(AdjustmentRot=(Pitch=3640,Yaw=0,Roll=0),WorldWeight=1.0000000,PawnWeight=1.0000000,Extent=(X=0.0000000,Y=0.0000000,Z=0.0000000),TraceInterval=4,FramesUntilNextTrace=0)
    PenetrationAvoidanceFeelers[6]=(AdjustmentRot=(Pitch=-3640,Yaw=0,Roll=0),WorldWeight=0.5000000,PawnWeight=0.5000000,Extent=(X=0.0000000,Y=0.0000000,Z=0.0000000),TraceInterval=4,FramesUntilNextTrace=0)
    bResetCameraInterpolation=true
}