class TmCameraModule_SpectatorFirstPerson extends TgCameraModule
    config(Game);

// True while the native gate reports a third person tick (ability, mount...).
// We keep this module active and pose the camera behind-view ourselves: ever
// switching to a TgCameraModule_ThirdPerson-derived module would make
// ATgPlayerController::Wants3P() return true and lock the native first person
// gate closed after the ability ends.
var bool m_bForced3P;

function UpdateCamera(Pawn P, TgPlayerCamera CameraActor, float DeltaTime, out TViewTarget OutVT)
{
    local Vector camOrigin, boneLoc, Offset;
    local Rotator CamRot;
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

    OutVT.POV.Rotation = CamRot;

    if (m_bForced3P && TgP != none)
    {
        // Behind-view pose mirroring the stock spectator third person module.
        camOrigin = GetBodyAttachPoint(TgP);
        Offset.X = -142.0;
        Offset.Z = 25.0;
        OutVT.POV.Location = camOrigin + (Offset >> CamRot) + TgP.WalkBob;
        return;
    }

    // Prefer the rig's camera bone (same source as the native first person path),
    // but only trust it when the rig was actually built near the pawn this frame.
    if (TgP != none && WMA != none && WMA.m_bUseSocketForCameraAttach && WMA.CanUseCameraBone() && WMA.m_WeaponMesh1P != none)
    {
        boneLoc = WMA.m_WeaponMesh1P.GetBoneLocation('Camera_bn');
        if (VSizeSq(boneLoc - TgP.Location) < 90000.0)
        {
            OutVT.POV.Location = boneLoc;
            OutVT.POV.Rotation = OrthoRotation(
                WMA.m_WeaponMesh1P.GetBoneAxis('Camera_bn', 4) * -1.0,
                WMA.m_WeaponMesh1P.GetBoneAxis('Camera_bn', 1),
                WMA.m_WeaponMesh1P.GetBoneAxis('Camera_bn', 2) * -1.0);
            return;
        }
    }

    if (TgP != none)
    {
        camOrigin = GetBodyAttachPoint(TgP);
        OutVT.POV.Location = camOrigin + TgP.WalkBob;
    }
    else if (OutVT.Target != none)
    {
        OutVT.POV.Location = OutVT.Target.Location;
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
