class TmCameraModule_SpectatorFirstPerson extends TgCameraModule
    config(Game);

// True while the native gate reports a third person tick (ability, mount...).
// We keep this module active and pose the camera ourselves.
var bool m_bForced3P;

// Pose transition state, mirroring TgCameraModule_SpectatorThirdPerson.
var transient TPOV OldViewpoint;
var transient float RemainingBlendTime;
var transient float TotalBlendTime;

// Called by the spectator controller whenever the native gate flips between
// first and third person; kicks off a smooth pose blend instead of snapping.
function SetForced3P(bool bNewForced3P)
{
    if (m_bForced3P == bNewForced3P)
        return;

    m_bForced3P = bNewForced3P;
    if (PlayerCamera != none)
    {
        OldViewpoint = PlayerCamera.CameraCache.POV;
        RemainingBlendTime = 0.25;
        TotalBlendTime = 0.25;
    }
}

function UpdateCamera(Pawn P, TgPlayerCamera CameraActor, float DeltaTime, out TViewTarget OutVT)
{
    local Vector camOrigin, boneLoc, Offset;
    local Rotator CamRot;
    local TPOV TargetPOV;
    local float DurationPct, BlendPct;
    local TgPawn TgP;
    local TgWeaponMeshActor WMA;

    if (CameraActor == none || CameraActor.PlayerOwner == none)
        return;

    TgP = TgPawn(OutVT.Target);
    if (TgP != none)
        WMA = TgP.m_WeaponMesh;

    CamRot = CameraActor.PlayerOwner.Rotation;
    if (TgP != none)
    {
        CamRot = TgP.Rotation;
        CamRot.Pitch = TgP.m_nSmoothedRemoteViewPitch;
    }

    TargetPOV.Rotation = CamRot;

    if (m_bForced3P && TgP != none)
    {
        // Behind-view pose mirroring the stock spectator third person module,
        // anchored to a stable location instead of animating bones: skeleton
        // anchors make the camera bob violently with mount/riding animations.
        camOrigin = TgP.Location;
        if (int(TgP.c_LocalPolymorph) == 0)
            camOrigin.Z += TgP.EyeHeight;
        else
            camOrigin.Z += 20.0;
        Offset.X = -142.0;
        Offset.Z = 25.0;
        TargetPOV.Location = camOrigin + (Offset >> CamRot);
    }
    else if (TgP != none)
    {
        // Prefer the rig's camera bone (same source as the native first person
        // path), but only trust it when the rig was built near the pawn.
        boneLoc = vect(0.0, 0.0, 0.0);
        if (WMA != none && WMA.m_bUseSocketForCameraAttach && WMA.CanUseCameraBone() && WMA.m_WeaponMesh1P != none)
            boneLoc = WMA.m_WeaponMesh1P.GetBoneLocation('Camera_bn');

        if (VSizeSq(boneLoc - TgP.Location) < 90000.0)
        {
            TargetPOV.Location = boneLoc;
            TargetPOV.Rotation = OrthoRotation(
                WMA.m_WeaponMesh1P.GetBoneAxis('Camera_bn', 4) * -1.0,
                WMA.m_WeaponMesh1P.GetBoneAxis('Camera_bn', 1),
                WMA.m_WeaponMesh1P.GetBoneAxis('Camera_bn', 2) * -1.0);
        }
        else
        {
            TargetPOV.Location = GetBodyAttachPoint(TgP) + TgP.WalkBob;
        }
    }
    else if (OutVT.Target != none)
    {
        TargetPOV.Location = OutVT.Target.Location;
    }

    // Keep the pipeline's FOV; only pose blends below.
    TargetPOV.FOV = OutVT.POV.FOV;

    // Smooth pose transition, same math as TgCameraModule_SpectatorThirdPerson:
    // blend from the frozen previous POV toward the moving target with a cubic
    // ease while a flip is in flight, then track the target directly.
    if (RemainingBlendTime > 0.0)
    {
        RemainingBlendTime -= DeltaTime;
        if (RemainingBlendTime < 0.0)
            RemainingBlendTime = 0.0;
        DurationPct = (TotalBlendTime - RemainingBlendTime) / TotalBlendTime;
        BlendPct = FCubicInterp(0.0, 0.0, 1.0, 0.0, DurationPct);
        OutVT.POV.Location = VLerp(OldViewpoint.Location, TargetPOV.Location, BlendPct);
        OutVT.POV.Rotation = RLerp(OldViewpoint.Rotation, TargetPOV.Rotation, BlendPct, true);
        OutVT.POV.FOV = Lerp(OldViewpoint.FOV, TargetPOV.FOV, BlendPct);
    }
    else
    {
        OutVT.POV = TargetPOV;
    }
}

// Same anchor math as TgCameraModule_ThirdPerson.GetCamAttachPoint's fallback.
simulated function Vector GetBodyAttachPoint(TgPawn TgP)
{
    local Vector NewCameraLoc;

    NewCameraLoc = TgP.Location;
    if (TgP.Mesh != none)
    {
        if (TgP.Mesh.MatchRefBone('EffectsSocket') != -1)
        {
            NewCameraLoc = TgP.Mesh.GetBoneLocation('EffectsSocket');
            NewCameraLoc.Z += TgP.GetCollisionHeight();
        }
        else if (TgP.Mesh.MatchRefBone('Root') != -1)
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
    if (int(TgP.c_LocalPolymorph) == 0)
        NewCameraLoc.Z += TgP.EyeHeight;
    else
        NewCameraLoc.Z += 20.0;
    return NewCameraLoc;
}
