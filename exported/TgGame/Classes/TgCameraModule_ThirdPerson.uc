class TgCameraModule_ThirdPerson extends TgCameraModule
    native(View);

struct native ServerCorrectionSmoothingParams
{
    var float fServerCorrectSnapDist;
    var float fMinBaseSpeed;
    var float fMaxBaseSpeed;
    var float fBaseSpeedMultiplier;
    var float fNewInfoWeight;
    var float fMinCorrectionModifier;
    var float fMaxCorrectionModifier;
    var float fCorrectionModifierMultiplier;

    structdefaultproperties
    {
        fServerCorrectSnapDist=0.0000000
        fMinBaseSpeed=0.0000000
        fMaxBaseSpeed=0.0000000
        fBaseSpeedMultiplier=0.0000000
        fNewInfoWeight=0.0000000
        fMinCorrectionModifier=0.0000000
        fMaxCorrectionModifier=0.0000000
        fCorrectionModifierMultiplier=0.0000000
    }
};

var Vector CameraOffset;
var float fZoomFactorInterp;
var float fZoomFactor;
var float fZoomStep;
var float fZoomMax;
var float fMountZoomMax;
var float fZoomMin;
var Vector2D fZoom3pPercentFromTo;
var float fZoomDuration;
var float fZoomDurationOverride;
var transient float fZoomUsedTime;
var Vector vCachedCameraAttachPoint;
var float f3pViewPaddingRemainingTime;
var float f3pViewPaddingTime;
var bool bForce3PView;
var Vector vServerCorrectionDelta;
var Vector vAvgServerCorrectionDelta;
var Vector vLastDesiredLocation;
var ServerCorrectionSmoothingParams CorrectionSmoothing;

function OnBecomeActive(TgCameraModule OldCamera)
{
    local TgCameraModule_ThirdPerson OldThirdPersonCam;

    super.OnBecomeActive(OldCamera);
    OldThirdPersonCam = TgCameraModule_ThirdPerson(OldCamera);
    // End:0x8E
    if(OldThirdPersonCam != none)
    {
        fZoomFactor = OldThirdPersonCam.fZoomFactor;
        fZoomFactorInterp = OldThirdPersonCam.fZoomFactorInterp;
    }
    //return;    
}

function OnTweenOutEnd()
{
    super.OnTweenOutEnd();
    // End:0x38
    if(PlayerCamera != none)
    {
        PlayerCamera.ClearPenetrationList();
    }
    //return;    
}

function Vector GetCamLocationOffset(Rotator PawnRot, Actor ViewTarget)
{
    local Vector X, Y, Z, Offset;
    local TgPawn TgP;

    Offset = CameraOffset;
    TgP = TgPawn(ViewTarget);
    // End:0x70
    if(TgP != none)
    {
        Offset = TgP.GetCameraOffsetOverride(Offset);
    }
    // End:0x10C
    if(TgP != none)
    {
        // End:0x10C
        if((TgP.Mesh != none) && int(TgP.c_LocalPolymorph) == int(0))
        {
            Offset *= TgP.Mesh.Scale;
        }
    }
    GetAxes(PawnRot, X, Y, Z);
    return (fZoomFactorInterp * ((Offset.X * X) + (Offset.Z * Z))) + (Offset.Y * Y);
    //return ReturnValue;    
}

function Vector GetCamAttachPoint(Actor ViewTarget)
{
    local Vector NewCameraLoc;
    local TgPawn TgP;

    NewCameraLoc = ViewTarget.Location;
    TgP = TgPawn(ViewTarget);
    // End:0x1A8
    if(((((TgP != none) && TgP.ShouldBeFirstPersonThisTick()) && TgP.m_WeaponMesh != none) && TgP.m_WeaponMesh.m_bUseSocketForCameraAttach) && TgP.m_WeaponMesh.CanUseCameraBone())
    {
        // End:0x1A5
        if(TgP.m_WeaponMesh.m_WeaponMesh1P != none)
        {
            NewCameraLoc = TgP.m_WeaponMesh.m_WeaponMesh1P.GetBoneLocation('Camera_bn');
        }        
    }
    else
    {
        // End:0x525
        if(TgP != none)
        {
            // End:0x228
            if(TgP.ShouldBeFirstPersonThisTick() && TgP.IsLocallyControlled())
            {
                NewCameraLoc = TgP.Location;                
            }
            else
            {
                // End:0x49B
                if(TgP.Mesh != none)
                {
                    // End:0x31B
                    if(TgP.Mesh.MatchRefBone('EffectsSocket') != -1)
                    {
                        NewCameraLoc = TgP.Mesh.GetBoneLocation('EffectsSocket');
                        NewCameraLoc.Z += TgP.GetCollisionHeight();                        
                    }
                    else
                    {
                        // End:0x3EA
                        if(TgP.Mesh.MatchRefBone('Root') != -1)
                        {
                            NewCameraLoc = TgP.Mesh.GetBoneLocation('Root');
                            NewCameraLoc.Z += TgP.GetCollisionHeight();                            
                        }
                        else
                        {
                            NewCameraLoc = TgP.Mesh.GetBoneLocation(TgP.Mesh.GetBoneName(0));
                            NewCameraLoc.Z += TgP.GetCollisionHeight();
                        }
                    }
                }
            }
            // End:0x503
            if(int(TgP.c_LocalPolymorph) == int(0))
            {
                NewCameraLoc.Z += TgP.EyeHeight;                
            }
            else
            {
                NewCameraLoc.Z += float(20);
            }
        }
    }
    return NewCameraLoc;
    //return ReturnValue;    
}

function Rotator GetWorldRotation(TgPlayerCamera CameraActor)
{
    local TgPawn TgP;
    local TgWeaponMeshActor parentWeaponMeshActor;

    // End:0x2D1
    if((PlayerCamera != none) && PlayerCamera.PlayerOwner != none)
    {
        TgP = TgPawn(PlayerCamera.PlayerOwner.Pawn);
        // End:0x2D1
        if((TgP != none) && TgP.ShouldBeFirstPersonThisTick())
        {
            parentWeaponMeshActor = TgP.m_WeaponMesh;
            // End:0x27E
            if(((parentWeaponMeshActor != none) && parentWeaponMeshActor.m_bUseSocketForCameraAttach) && TgP.m_WeaponMesh.CanUseCameraBone())
            {
                // End:0x27B
                if(parentWeaponMeshActor.m_WeaponMesh1P != none)
                {
                    return OrthoRotation(TgP.m_WeaponMesh.m_WeaponMesh1P.GetBoneAxis('Camera_bn', 4) * -1.0000000, TgP.m_WeaponMesh.m_WeaponMesh1P.GetBoneAxis('Camera_bn', 1), TgP.m_WeaponMesh.m_WeaponMesh1P.GetBoneAxis('Camera_bn', 2) * -1.0000000);
                }                
            }
            else
            {
                return TgP.ApplyCameraRotationModifier(CameraActor.PlayerOwner.Rotation);
            }
        }
    }
    return CameraActor.PlayerOwner.Rotation;
    //return ReturnValue;    
}

function float GetCurrent3pPercent()
{
    // End:0x61
    if((fZoomFactorInterp == fZoom3pPercentFromTo.Y) || fZoomUsedTime > (GetZoomDuration()))
    {
        return fZoom3pPercentFromTo.Y;
    }
    return Lerp(fZoom3pPercentFromTo.X, fZoom3pPercentFromTo.Y, fZoomUsedTime / (GetZoomDuration()));
    //return ReturnValue;    
}

function float GetZoomDuration()
{
    return ((fZoomDurationOverride == 0.0000000) ? fZoomDuration : fZoomDurationOverride);
    //return ReturnValue;    
}

function UpdateCameraZoom(TgPawn TgP, float DeltaTime)
{
    local float DesiredZoomPercent, CurrentZoomPercent;

    DesiredZoomPercent = ((int(PlayerCamera.PlayerOwner.bRun) == int(1)) ? fMountZoomMax : fZoomFactor);
    // End:0x9C
    if(TgP != none)
    {
        TgP.GetCameraZoomOverride(DesiredZoomPercent, fZoomDurationOverride);
    }
    // End:0xDD
    if(DesiredZoomPercent ~= fZoom3pPercentFromTo.Y)
    {
        fZoomUsedTime += DeltaTime;        
    }
    else
    {
        fZoom3pPercentFromTo = vect2d(fZoomFactorInterp, DesiredZoomPercent);
        CurrentZoomPercent = GetCurrent3pPercent();
        // End:0x14C
        if(CurrentZoomPercent < 0.5000000)
        {
            fZoomUsedTime = CurrentZoomPercent * (GetZoomDuration());            
        }
        else
        {
            fZoomUsedTime = float(Max(int((DesiredZoomPercent - CurrentZoomPercent) * (GetZoomDuration())), 0));
        }
    }
    fZoomUsedTime = FClamp(fZoomUsedTime, 0.0000000, GetZoomDuration());
    fZoomFactorInterp = GetCurrent3pPercent();
    //return;    
}

function UpdateCamera(Pawn P, TgPlayerCamera CameraActor, float DeltaTime, out TViewTarget OutVT)
{
    local Vector CamLocation, camOrigin, HitLocation, HitNormal;
    local Rotator SpecCamRotation;
    local Actor Target;
    local float CameraCheckRadius;
    local TgPawn TgP;

    // End:0x37
    if((CameraActor == none) || CameraActor.PlayerOwner == none)
    {
        return;
    }
    TgP = TgPawn(P);
    // End:0x11F
    if((TgP != none) && TgP.WorldInfo.IsPlayingDemo())
    {
        SpecCamRotation = TgP.Rotation;
        SpecCamRotation.Pitch = TgP.m_nSmoothedRemoteViewPitch;
        CameraActor.SetRotation(SpecCamRotation);
    }
    UpdateCameraZoom(TgP, DeltaTime);
    Target = OutVT.Target;
    OutVT.POV.Rotation = GetWorldRotation(CameraActor);
    camOrigin = GetCamAttachPoint(Target);
    vCachedCameraAttachPoint = camOrigin;
    CamLocation = camOrigin + (GetCamLocationOffset(OutVT.POV.Rotation, Target));
    CamLocation += (SmoothServerCorrection(TgP, CamLocation, DeltaTime));
    // End:0x293
    if(TgP != none)
    {
        CamLocation += TgP.WalkBob;
    }
    // End:0x337
    if(camOrigin != CamLocation)
    {
        CameraActor.CameraTrace(HitLocation, HitNormal, CamLocation, camOrigin, OutVT.Target);
        // End:0x337
        if(HitLocation != vect(0.0000000, 0.0000000, 0.0000000))
        {
            CamLocation = HitLocation;
        }
    }
    CameraCheckRadius = 15.0000000;
    // End:0x389
    if((TgP != none) && TgP.r_bIsMounted)
    {
        CameraCheckRadius *= 3.2500000;
    }
    CameraActor.CheckPenetration(CamLocation, CameraCheckRadius);
    OutVT.POV.Location = CamLocation;
    // End:0x41A
    if(f3pViewPaddingRemainingTime > 0.0000000)
    {
        f3pViewPaddingRemainingTime -= DeltaTime;
    }
    // End:0x5AD
    if((PlayerCamera.CameraStyle == 'Freeze') && PlayerCamera.PlayerOwner.CheatManager != none)
    {
        OutVT.POV.Location = GameCheatManager(PlayerCamera.PlayerOwner.CheatManager).DebugCameraControllerRef.Location;
        OutVT.POV.Rotation = GameCheatManager(PlayerCamera.PlayerOwner.CheatManager).DebugCameraControllerRef.Rotation;
    }
    // End:0x647
    if(CameraActor.PCOwner.bIsInTimelapse)
    {
        OutVT.POV.Rotation = OutVT.Target.Rotation;
        return;
    }
    //return;    
}

simulated function Vector SmoothServerCorrection(TgPawn TgP, Vector DesiredLocation, float DeltaTime)
{
    local float fAvgCorrectionSize, fCorrectionSize, fSpeed;

    // End:0x71
    if((TgP != none) && !TgP.ShouldBeFirstPersonThisTick())
    {
        vServerCorrectionDelta = vect(0.0000000, 0.0000000, 0.0000000);
        vAvgServerCorrectionDelta = vect(0.0000000, 0.0000000, 0.0000000);
        return vect(0.0000000, 0.0000000, 0.0000000);
    }
    UpdateServerCorrectionFromMovement(DesiredLocation);
    UpdateAverageServerCorrection(DeltaTime);
    // End:0xB4
    if(IsZero(vServerCorrectionDelta))
    {
        return vect(0.0000000, 0.0000000, 0.0000000);
    }
    fAvgCorrectionSize = VSize(vAvgServerCorrectionDelta);
    fCorrectionSize = VSize(vServerCorrectionDelta);
    // End:0x170
    if((fAvgCorrectionSize > CorrectionSmoothing.fServerCorrectSnapDist) && fCorrectionSize > CorrectionSmoothing.fServerCorrectSnapDist)
    {
        vServerCorrectionDelta = vect(0.0000000, 0.0000000, 0.0000000);
        vAvgServerCorrectionDelta = vect(0.0000000, 0.0000000, 0.0000000);
        return vect(0.0000000, 0.0000000, 0.0000000);
    }
    fSpeed = Lerp(CorrectionSmoothing.fMinBaseSpeed, CorrectionSmoothing.fMaxBaseSpeed, fCorrectionSize * CorrectionSmoothing.fBaseSpeedMultiplier);
    fSpeed *= Lerp(CorrectionSmoothing.fMinCorrectionModifier, CorrectionSmoothing.fMaxCorrectionModifier, fAvgCorrectionSize * CorrectionSmoothing.fCorrectionModifierMultiplier);
    fSpeed = FMin(fSpeed * DeltaTime, fCorrectionSize);
    vServerCorrectionDelta -= (Normal(vServerCorrectionDelta) * fSpeed);
    return -vServerCorrectionDelta;
    //return ReturnValue;    
}

simulated function UpdateServerCorrectionFromMovement(Vector DesiredLocation)
{
    local Vector vMovementSinceLastFrame;

    // End:0x24
    if(IsZero(vLastDesiredLocation))
    {
        vLastDesiredLocation = DesiredLocation;
        return;
    }
    vMovementSinceLastFrame = DesiredLocation - vLastDesiredLocation;
    // End:0x124
    if((vMovementSinceLastFrame.X * vServerCorrectionDelta.X) < float(0))
    {
        // End:0xEA
        if(Abs(vMovementSinceLastFrame.X) > Abs(vServerCorrectionDelta.X))
        {
            vServerCorrectionDelta.X = 0.0000000;            
        }
        else
        {
            vServerCorrectionDelta.X += vMovementSinceLastFrame.X;
        }
    }
    // End:0x206
    if((vMovementSinceLastFrame.Y * vServerCorrectionDelta.Y) < float(0))
    {
        // End:0x1CC
        if(Abs(vMovementSinceLastFrame.Y) > Abs(vServerCorrectionDelta.Y))
        {
            vServerCorrectionDelta.Y = 0.0000000;            
        }
        else
        {
            vServerCorrectionDelta.Y += vMovementSinceLastFrame.Y;
        }
    }
    // End:0x2E8
    if((vMovementSinceLastFrame.Z * vServerCorrectionDelta.Z) < float(0))
    {
        // End:0x2AE
        if(Abs(vMovementSinceLastFrame.Z) > Abs(vServerCorrectionDelta.Z))
        {
            vServerCorrectionDelta.Z = 0.0000000;            
        }
        else
        {
            vServerCorrectionDelta.Z += vMovementSinceLastFrame.Z;
        }
    }
    vLastDesiredLocation = DesiredLocation;
    //return;    
}

simulated function UpdateAverageServerCorrection(float DeltaTime)
{
    local float Weight;

    Weight = FMin(1.0000000, CorrectionSmoothing.fNewInfoWeight * DeltaTime);
    vAvgServerCorrectionDelta = ((float(1) - Weight) * vAvgServerCorrectionDelta) + (Weight * vServerCorrectionDelta);
    //return;    
}

simulated function BecomeViewTarget(TgPlayerController PC)
{
    // End:0x6B
    if(LocalPlayer(PC.Player) != none)
    {
        TgPawn(PC.Pawn).SetMeshVisibility(true);
    }
    //return;    
}

function zoomIn()
{
    fZoomFactor = FClamp(fZoomFactor - fZoomStep, fZoomMin, ((int(PlayerCamera.PlayerOwner.bRun) == int(1)) ? fMountZoomMax : fZoomMax));
    //return;    
}

function ZoomOut()
{
    fZoomFactor = FClamp(fZoomFactor + fZoomStep, fZoomMin, ((int(PlayerCamera.PlayerOwner.bRun) == int(1)) ? fMountZoomMax : fZoomMax));
    //return;    
}

defaultproperties
{
    CameraOffset=(X=-142.0000000,Y=0.0000000,Z=25.0000000)
    fZoomFactor=1.0000000
    fZoomStep=0.1000000
    fZoomMax=1.0000000
    fMountZoomMax=1.0000000
    fZoomMin=0.7500000
    fZoomDuration=0.2000000
    f3pViewPaddingTime=0.0100000
    CorrectionSmoothing=(fServerCorrectSnapDist=640.0000000,fMinBaseSpeed=16.0000000,fMaxBaseSpeed=320.0000000,fBaseSpeedMultiplier=0.0008000,fNewInfoWeight=1.0000000,fMinCorrectionModifier=0.5000000,fMaxCorrectionModifier=12.0000000,fCorrectionModifierMultiplier=0.0050000)
}