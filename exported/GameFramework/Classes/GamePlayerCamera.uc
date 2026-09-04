class GamePlayerCamera extends Camera
    transient
    native(Camera)
    hidecategories(Navigation);

var(Camera) editinline transient GameCameraBase ThirdPersonCam;
var(Camera) protected const Class<GameCameraBase> ThirdPersonCameraClass;
var(Camera) editinline transient GameCameraBase FixedCam;
var(Camera) protected const Class<GameCameraBase> FixedCameraClass;
var(Camera) editinline transient GameCameraBase CurrentCamera;
var transient bool bUseForcedCamFOV;
var transient bool bInterpolateCamChanges;
var private transient bool bResetInterp;
var transient float ForcedCamFOV;
var private transient Actor LastViewTarget;
var() protected const float SplitScreenShakeScale;
var protected transient Actor LastTargetBase;
var protected transient Matrix LastTargetBaseTM;

protected function GameCameraBase CreateCamera(Class<GameCameraBase> CameraClass)
{
    local GameCameraBase NewCam;

    NewCam = new (Outer) CameraClass;
    NewCam.PlayerCamera = self;
    NewCam.Init();
    return NewCam;
    //return ReturnValue;    
}

// Export UGamePlayerCamera::execCacheLastTargetBaseInfo(FFrame&, void* const)
protected native function CacheLastTargetBaseInfo(Actor TargetBase);

function PostBeginPlay()
{
    super.PostBeginPlay();
    // End:0x47
    if((ThirdPersonCam == none) && ThirdPersonCameraClass != none)
    {
        ThirdPersonCam = CreateCamera(ThirdPersonCameraClass);
    }
    // End:0x84
    if((FixedCam == none) && FixedCameraClass != none)
    {
        FixedCam = CreateCamera(FixedCameraClass);
    }
    //return;    
}

function Reset()
{
    bUseForcedCamFOV = false;
    //return;    
}

protected function GameCameraBase FindBestCameraType(Actor CameraTarget)
{
    local GameCameraBase BestCam;

    // End:0x58
    if(CameraStyle == 'Default')
    {
        // End:0x45
        if(CameraActor(CameraTarget) != none)
        {
            BestCam = FixedCam;            
        }
        else
        {
            BestCam = ThirdPersonCam;
        }
    }
    return BestCam;
    //return ReturnValue;    
}

function bool ShouldConstrainAspectRatio()
{
    return false;
    //return ReturnValue;    
}

function UpdateViewTarget(out TViewTarget OutVT, float DeltaTime)
{
    local Pawn P;
    local GameCameraBase NewCamera;
    local CameraActor CamActor;

    // End:0x66
    if(((PendingViewTarget.Target != none) && OutVT == ViewTarget) && BlendParams.bLockOutgoing)
    {
        return;
    }
    // End:0x8A
    if(OutVT.Target == none)
    {
        return;
    }
    P = Pawn(OutVT.Target);
    NewCamera = FindBestCameraType(OutVT.Target);
    // End:0x181
    if(CurrentCamera != NewCamera)
    {
        // End:0x137
        if(CurrentCamera != none)
        {
            CurrentCamera.OnBecomeInActive(NewCamera);
        }
        // End:0x16E
        if(NewCamera != none)
        {
            NewCamera.OnBecomeActive(CurrentCamera);
        }
        CurrentCamera = NewCamera;
    }
    // End:0x3A5
    if(CurrentCamera != none)
    {
        // End:0x1CD
        if(bResetInterp && !bInterpolateCamChanges)
        {
            CurrentCamera.ResetInterpolation();
        }
        CamActor = CameraActor(OutVT.Target);
        // End:0x334
        if(CamActor != none)
        {
            CamActor.GetCameraView(DeltaTime, OutVT.POV);
            // End:0x2D1
            if((CurrentCamera == FixedCam) && CamActor.bConstrainAspectRatio)
            {
                bConstrainAspectRatio = true;
                OutVT.AspectRatio = CamActor.AspectRatio;
            }
            CamOverridePostProcessAlpha = CamActor.CamOverridePostProcessAlpha;
            // End:0x334
            if(CamOverridePostProcessAlpha > 0.0000000)
            {
                CamPostProcessSettings = CamActor.CamOverridePostProcess;
            }
        }
        CurrentCamera.UpdateCamera(P, self, DeltaTime, OutVT);
        // End:0x3A2
        if(CameraStyle == 'FreeCam_Default')
        {
            super.UpdateViewTarget(OutVT, DeltaTime);
        }        
    }
    else
    {
        super.UpdateViewTarget(OutVT, DeltaTime);
    }
    // End:0x407
    if(bUseForcedCamFOV)
    {
        OutVT.POV.FOV = ForcedCamFOV;
    }
    OutVT.POV.FOV = AdjustFOVForViewport(OutVT.POV.FOV, P);
    SetRotation(OutVT.POV.Rotation);
    SetLocation(OutVT.POV.Location);
    UpdateCameraLensEffects(OutVT);
    CacheLastTargetBaseInfo(OutVT.Target.Base);
    bResetInterp = false;
    //return;    
}

simulated function UpdateCameraLensEffects(const out TViewTarget OutVT)
{
    local int Idx;

    Idx = 0;
    J0x0B:

    // End:0x100 [Loop If]
    if(Idx < CameraLensEffects.Length)
    {
        // End:0xF2
        if(CameraLensEffects[Idx] != none)
        {
            CameraLensEffects[Idx].UpdateLocation(OutVT.POV.Location, OutVT.POV.Rotation, OutVT.POV.FOV);
        }
        ++Idx;
        // [Loop Continue]
        goto J0x0B;
    }
    //return;    
}

simulated function DisplayDebug(HUD HUD, out float out_YL, out float out_YPos)
{
    local Canvas Canvas;

    super.DisplayDebug(HUD, out_YL, out_YPos);
    Canvas = HUD.Canvas;
    Canvas.SetDrawColor(255, 255, 255);
    Canvas.DrawText((("  " @ "CurrentCamera:'") $ string(CurrentCamera)) $ "'");
    out_YPos += out_YL;
    Canvas.SetPos(4.0000000, out_YPos);
    // End:0x14B
    if(CurrentCamera != none)
    {
        CurrentCamera.DisplayDebug(HUD, out_YL, out_YPos);
    }
    //return;    
}

simulated function SetColorScale(Vector NewColorScale)
{
    // End:0x3B
    if(bEnableColorScaling == true)
    {
        bEnableColorScaling = true;
        ColorScale = NewColorScale;
        bEnableColorScaleInterp = false;
    }
    //return;    
}

simulated function ResetInterpolation()
{
    bResetInterp = true;
    //return;    
}

function ProcessViewRotation(float DeltaTime, out Rotator out_ViewRotation, out Rotator out_DeltaRot)
{
    // End:0x65
    if(CurrentCamera != none)
    {
        CurrentCamera.ProcessViewRotation(DeltaTime, ViewTarget.Target, out_ViewRotation, out_DeltaRot);
    }
    //return;    
}

// Export UGamePlayerCamera::execAdjustFOVForViewport(FFrame&, void* const)
protected native final function float AdjustFOVForViewport(float inHorizFOV, Pawn CameraTargetPawn);

defaultproperties
{
    ThirdPersonCameraClass=Class'GameFramework.GameThirdPersonCamera'
    FixedCameraClass=Class'GameFramework.GameFixedCamera'
    CameraStyle="Default"
    DefaultFOV=70.0000000
}