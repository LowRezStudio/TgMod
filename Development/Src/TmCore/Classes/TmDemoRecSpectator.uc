class TmDemoRecSpectator extends TgDemoRecSpectator
    config(Game)
    hidecategories(Navigation)
    dependson(TgObject);

// Mirrored into the demo file so playback can restore the exact POV.
// ViewTarget is not a replicated property in UE3 and m_CameraMode is
// transient, so without this the replayed demo spectator sits at world
// origin in free-fly mode. This is also why the first person rig never
// builds on playback: TgPawn.IsFirstPerson() requires the local spectator
// controller to have GetViewTarget() == pawn && m_CameraMode == SpecCam_FollowFirstPerson.
var repnotify Actor m_rDemoViewTarget;
var repnotify byte m_rDemoCameraMode;

var transient bool m_bPendingViewTarget;
var transient bool m_bPendingCameraMode;

simulated event PostBeginPlay()
{
    // Intentionally skipping TgDemoRecSpectator.PostBeginPlay():
    // it registers engine callbacks, starts the MCTS spectator master/slave
    // sync and the auto combat log. None of that can work on a bare dedicated
    // server and the master/slave sync stalls normal client replication while
    // a recording is active. Everything else in the chain still runs.
    super(TgSpectatorController).PostBeginPlay();

    if (Role == ROLE_Authority && WorldInfo.NetMode != NM_Client)
    {
        SetTimer(0.5, true, 'TmRecordTick');
    }
    else if (WorldInfo.IsRecordingDemo())
    {
        // Client-side recording: mirror what the human spectator is watching.
        SetTimer(0.25, true, 'TmMirrorLocalSpectator');
    }
    else if (WorldInfo.IsPlayingDemo())
    {
        SetTimer(0.25, true, 'TmApplyRecordedState');
    }
}

// Client-side recording variant: copy the local player's spectator state
// into the replicated mirror so playback restores the same POV.
function TmMirrorLocalSpectator()
{
    local TgSpectatorController Spec;
    local Actor VT;

    if (!WorldInfo.IsRecordingDemo())
        return;

    Spec = TgSpectatorController(GetALocalPlayerController());
    if (Spec == none || Spec == self)
        return;

    VT = Spec.GetViewTarget();
    if (VT != none && VT != m_rDemoViewTarget)
        m_rDemoViewTarget = VT;

    if (Spec.m_CameraMode != m_rDemoCameraMode)
        m_rDemoCameraMode = Spec.m_CameraMode;
}

// Recording side housekeeping: flag PRIs so tracked projectile data gets
// replicated into the stream, keep an alive viewtarget, and mirror the
// current POV state into the replicated properties.
function TmRecordTick()
{
    local TgRepInfo_Player PRI;
    local TgPawn_Character P;
    local Actor VT;
    local bool bFound;

    if (!WorldInfo.IsRecordingDemo())
        return;

    foreach WorldInfo.AllActors(Class'TgGame.TgRepInfo_Player', PRI)
    {
        if (!PRI.bDemoOwner)
            PRI.bDemoOwner = true;
    }

    VT = GetViewTarget();
    if (VT == none || TgPawn(VT) == none || !TgPawn(VT).IsAliveAndWell() || VT.IsInState('Dying'))
    {
        foreach WorldInfo.AllPawns(Class'TgGame.TgPawn_Character', P)
        {
            if (P.IsAliveAndWell() && !P.IsInState('Dying'))
            {
                SpectatorSetViewTarget(P);
                SetSpectatorCameraMode(SpectatorCameraMode.SpecCam_FollowThirdPerson);
                bFound = true;
                break;
            }
        }
        if (!bFound)
            return;
    }

    VT = GetViewTarget();
    if (VT != none && VT != m_rDemoViewTarget)
        m_rDemoViewTarget = VT;

    if (m_CameraMode != m_rDemoCameraMode)
        m_rDemoCameraMode = m_CameraMode;
}

simulated event ReplicatedEvent(name VarName)
{
    if (VarName == 'm_rDemoViewTarget')
    {
        m_bPendingViewTarget = m_rDemoViewTarget != none;
        return;
    }

    if (VarName == 'm_rDemoCameraMode')
    {
        m_bPendingCameraMode = true;
        return;
    }

    super.ReplicatedEvent(VarName);
}

// Playback side: restore what was being watched. Uses the native
// SetViewTarget/SetSpectatorCameraMode directly instead of
// SpectatorSetViewTarget to avoid firing server RPCs into the void.
simulated function TmApplyRecordedState()
{
    if (!WorldInfo.IsPlayingDemo())
    {
        ClearTimer('TmApplyRecordedState');
        return;
    }

    if (m_bPendingViewTarget && m_rDemoViewTarget != none && GetViewTarget() != m_rDemoViewTarget)
    {
        SetViewTarget(m_rDemoViewTarget);
        m_bPendingViewTarget = false;
    }

    if (m_bPendingCameraMode && PlayerCamera != none && int(m_CameraMode) != int(m_rDemoCameraMode))
    {
        //SetSpectatorCameraMode(m_rDemoCameraMode, false);
        m_bPendingCameraMode = false;
    }
}

// While recording, make the server-side viewpoint track the followed pawn.
// The stock implementation spawns PlayerCamera whose cache is never updated
// outside of rendering, so every viewer query (FNetViewer, relevancy traces,
// viewer-dependent replication conditions) reads world origin.
simulated event GetPlayerViewPoint(out Vector out_Location, out Rotator out_Rotation)
{
    local Actor VT;

    if (Role == ROLE_Authority && WorldInfo.NetMode != NM_Client)
    {
        VT = GetViewTarget();
        if (VT != none)
        {
            out_Location = VT.Location;
            out_Rotation = VT.Rotation;
            return;
        }
    }
    super.GetPlayerViewPoint(out_Location, out_Rotation);
}

defaultproperties
{
    RemoteRole=ROLE_AutonomousProxy
    bDemoOwner=true
    bAlwaysTick=true
}
