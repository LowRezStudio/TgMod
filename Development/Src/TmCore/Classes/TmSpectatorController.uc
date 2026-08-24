class TmSpectatorController extends TgSpectatorController
    config(Game)
    hidecategories(Navigation)
    dependson(TgObject);

struct transient BurnCard {
    var int DeviceID;
    var int Power; // Card level
};
var transient BurnCard BurnCards[4];

var transient bool bClonedHUD;
var transient int LastClonedTickCount;
var transient int bBorderBuilt;

// Pawn currently forced into the client-side first person rig, if any.
var transient TgPawn m_NudgedFpPawn;
// Last known mounted state of the nudged pawn (edge detection for the
// manual mount presentation).
var transient bool m_bWasMounted;
// True while inside a mount/emote third person window.
var transient bool m_bWasWindow3P;
// Throttle for diagnostic logging.
var transient float m_fNextDiagTime;
// Set false to silence the periodic first person diagnostics.
var config bool c_bFpDiagLogs;
// If false, disable the server-side relevancy viewpoint override.
var config bool c_bTrackViewTargetForRelevancy;

const ABILITY_SLOTS = 5;

simulated function ForwardToSpectatingMatch()
{
    super.ForwardToSpectatingMatch();
    if (WorldInfo.NetMode != NM_DedicatedServer)
        SetSpectatorCameraMode(SpectatorCameraMode.SpecCam_FollowThirdPerson);
}

public function Class<HUD> GetHudClass(Class<HUD> pNewHudType)
{
    `LogInfo('TmSpectatorController', "GetHudClass: requested=" @ pNewHudType @ " -> returning TgClient.TgGameHUD");
    return Class'TgClient.TgGameHUD';
}

exec function SpecToggleFirstPerson()
{
    if (int(m_CameraMode) == int(SpectatorCameraMode.SpecCam_FollowFirstPerson))
        SetSpectatorCameraMode(SpectatorCameraMode.SpecCam_FollowThirdPerson);
    else
        SetSpectatorCameraMode(SpectatorCameraMode.SpecCam_FollowFirstPerson);
}

// Same bookkeeping as the stock mode 3 handler, but swaps in our own camera
// module so the POV is driven from script instead of the native gate.
exec function SetSpectatorCameraMode(TgSpectatorController.SpectatorCameraMode Mode, optional bool bCameraTween = false)
{
    if (int(Mode) != int(SpectatorCameraMode.SpecCam_FollowFirstPerson))
    {
        super.SetSpectatorCameraMode(Mode, bCameraTween);
        ClearFirstPersonNudge();
        return;
    }

    if (int(Mode) == int(m_CameraMode))
        return;

    m_CameraMode = Mode;
    m_bIsMapSquashed = false;
    if (bCameraTween)
        TgPlayerCamera(PlayerCamera).SwitchCameras(class'TmCore.TmCameraModule_SpectatorFirstPerson', 0.2);
    else
        TgPlayerCamera(PlayerCamera).SwitchCameras(class'TmCore.TmCameraModule_SpectatorFirstPerson');
}

// Opens the native first person gate (ATgPawn::ShouldBeFirstPersonThisTick,
// live path) for the followed pawn by assigning the local spectator
// controller to its Controller reference client-side. Pawn.Controller is
// owner-only replicated so the assignment never leaves this machine and the
// real owner keeps authoritative control server-side. Attaching a LOCAL
// controller is deliberate: many effect playback paths branch on
// IsLocallyControlled(), and the local branches are the ones that reliably
// play tracers/impacts/explosions for the spectated pawn (non-local stand-in
// controllers suppress them).
// Wants3P() returns false for us because our FP camera module does not derive
// from TgCameraModule_ThirdPerson and no 3P camera posture is latched, which
// opens the gate and makes the engine build the entire native first person
// rig (viewmodel, Camera_bn eye position) exactly like the followed player
// sees.
simulated function UpdateFirstPersonNudge()
{
    local TgPawn ViewPawn;
    local TgRepInfo_Player FollowedPRI;
    local bool bNativeFP;

    if (m_CameraMode != SpectatorCameraMode.SpecCam_FollowFirstPerson)
    {
        ClearFirstPersonNudge();
        return;
    }

    ViewPawn = TgPawn(GetViewTarget());
    // Never touch pawns we have authority over (listen server): the fake
    // Controller assignment is only safe on simulated proxies.
    if (ViewPawn == none || !ViewPawn.IsAliveAndWell() || ViewPawn.Role >= ROLE_Authority)
    {
        ClearFirstPersonNudge();
        return;
    }

    if (m_NudgedFpPawn != none && m_NudgedFpPawn != ViewPawn)
        ClearFirstPersonNudge();

    m_NudgedFpPawn = ViewPawn;
    ViewPawn.Controller = self;
    m_bBehindView = false;

    // Mounts have no native signal in a spectator context (their posture is
    // pushed on the owning player's controller only, and the gate's device
    // loop cannot see them), so detect them from replicated pawn state. The
    // native r_bIsMounted replication handler also refuses to build the horse
    // while the pawn looks locally controlled, so the mount presentation is
    // driven manually - strictly on transitions, otherwise the dismount
    // presentation would replay every frame.
    if (ViewPawn.r_bIsMounted != m_bWasMounted)
    {
        m_bWasMounted = ViewPawn.r_bIsMounted;
        if (ViewPawn.r_bIsMounted)
            ViewPawn.PlayMountingEffects(false, ViewPawn.r_bUseMountPosture);
        else
            ViewPawn.StopMountingEffects(true, ViewPawn.r_bUseMountPosture);
    }

    bNativeFP = !ViewPawn.r_bIsMounted
        && !IsForced3PAbilityDevice(ViewPawn)
        && ViewPawn.ShouldBeFirstPersonThisTick();
    m_bBehindView = !bNativeFP;

    SetRealModelHidden(ViewPawn, bNativeFP);
    SetRigVisible(ViewPawn, bNativeFP);
    SetForced3PPose(!bNativeFP);
}

// Some movement abilities never close the native gate: their third person
// window is driven by owning-client camera code rather than their form's
// force-3P bit (which is what the gate's device loop reads), and their brief
// fire state is easy to miss. Detect them explicitly while firing.
simulated function bool IsForced3PAbilityDevice(TgPawn ViewPawn)
{
    local int i, slot;
    local int EquipSlots[5];
    local TgDevice Dev;

    EquipSlots[0] = 1;
    EquipSlots[1] = 16;
    EquipSlots[2] = 3;
    EquipSlots[3] = 4;
    EquipSlots[4] = 2;

    for (i = 0; i < ABILITY_SLOTS; i++)
    {
        slot = EquipSlots[i];
        Dev = ViewPawn.GetDeviceByEqPoint(slot);
        if (Dev == none || !Dev.IsFiring())
            continue;

        if (Dev.IsA('TgDevice_HunterRoll')        // Cassie dodge roll
            || Dev.IsA('TgDevice_Flutter')        // Willo flutter
            || Dev.IsA('TgDevice_Thrust')
            || Dev.IsA('TgDevice_CombatSlide')
            || Dev.IsA('TgDevice_NetherStep')
            || Dev.IsA('TgDevice_Advance')
            || Dev.IsA('TgDevice_Withdraw')
            || Dev.IsA('TgDevice_Pounce')
            || Dev.IsA('TgDevice_Uppercut')
            || Dev.IsA('TgDevice_HeroicLeap')
            || Dev.IsA('TgDevice_KingBomb')
            || Dev.IsA('TgDevice_Reversal'))
            return true;
    }
    return false;
}

simulated function SetForced3PPose(bool bForced3P)
{
    local TmCameraModule_SpectatorFirstPerson CamMod;

    if (PlayerCamera == none)
        return;
    CamMod = TmCameraModule_SpectatorFirstPerson(TgPlayerCamera(PlayerCamera).CurrentCameraMod);
    if (CamMod != none)
        CamMod.SetForced3P(bForced3P);
}

// Hiding must be absolute and survive ATgPawn::TickSpecial, which re-asserts
// mesh visibility every tick via RecursiveSetVisibility (derived from
// bOwnerNoSee-style flags that cannot work here: Owner is not replicated to
// spectators, so the engine never considers the pawn's meshes owned by us).
// Setting the actor-level bHidden wins that race: rendering honors the owning
// actor's hidden flag regardless of per-component flips. The mount mesh is
// deliberately skipped: PlayMountingEffects/StopMountingEffects own its
// lifecycle, and blanket-unhiding would resurrect a stale horse during later
// third person ticks.
simulated function SetRealModelHidden(TgPawn ViewPawn, bool bHidden)
{
    local PrimitiveComponent Prim;

    ViewPawn.SetHidden(bHidden);
    foreach ViewPawn.ComponentList(class'PrimitiveComponent', Prim)
    {
        if (!bHidden && Prim == ViewPawn.m_MountMesh)
            continue;
        Prim.SetHidden(bHidden);
    }
}

// Park or restore the first person viewmodel for third person ticks. The
// native gate stays open there, so its per-tick toggles (OwnerNoSee based)
// keep flipping state; absolute SetHidden sticks instead. Overlay duplicates
// and particles attached to the rig are handled too, otherwise weapon glow
// effects keep rendering over a hidden mesh.
simulated function SetRigVisible(TgPawn ViewPawn, bool bVisible)
{
    local TgWeaponMeshActor WMA;
    local PrimitiveComponent Prim;
    local int i;

    WMA = ViewPawn.m_WeaponMesh;
    if (WMA == none)
        return;

    if (bVisible)
    {
        // Restore the first person pieces plus everything owned by the rig
        // (weapon glow particles live here); the 3P weapon is left to the
        // native owner-based visibility, which now applies to us.
        foreach WMA.AllOwnedComponents(class'PrimitiveComponent', Prim)
            Prim.SetHidden(false);
        if (WMA.m_WeaponMesh1P != none)
            WMA.m_WeaponMesh1P.FxActivateGroup('AlwaysOn', 0);
        if (WMA.m_HandsMesh != none)
            WMA.m_HandsMesh.FxActivateGroup('AlwaysOn', 0);
        if (WMA.m_HeadMesh1P != none)
            WMA.m_HeadMesh1P.FxActivateGroup('AlwaysOn', 0);
        SetRigOverlaysVisible(ViewPawn, true);
        return;
    }

    // Park everything weapon related for third person ticks.
    WMA.Set1PAttachState(2);
    if (WMA.m_WeaponMesh1P != none)
    {
        WMA.m_WeaponMesh1P.SetHidden(true);
        WMA.m_WeaponMesh1P.FxDeactivateGroup('AlwaysOn', 0);
    }
    if (WMA.m_HandsMesh != none)
    {
        WMA.m_HandsMesh.SetHidden(true);
        WMA.m_HandsMesh.FxDeactivateGroup('AlwaysOn', 0);
    }
    if (WMA.m_HeadMesh1P != none)
    {
        WMA.m_HeadMesh1P.SetHidden(true);
        WMA.m_HeadMesh1P.FxDeactivateGroup('AlwaysOn', 0);
    }
    if (WMA.m_WeaponMesh3P != none)
        WMA.m_WeaponMesh3P.SetHidden(true);

    // Particles parented to the rig render independently of their parent's
    // hidden flag, and they can live anywhere in the ownership chain (the
    // weapon glows do), so sweep everything the rig owns.
    foreach WMA.AllOwnedComponents(class'PrimitiveComponent', Prim)
        Prim.SetHidden(true);

    SetRigOverlaysVisible(ViewPawn, false);
}

// Hides/shows the overlay duplicate meshes parented to the first person
// pieces (skin/shield overlays render independently of their parent's flag).
simulated function SetRigOverlaysVisible(TgPawn ViewPawn, bool bVisible)
{
    local int i;
    local TgWeaponMeshActor WMA;

    WMA = ViewPawn.m_WeaponMesh;
    if (WMA == none)
        return;

    for (i = 0; i < ViewPawn.m_OverlayInfosBody.Length; i++)
    {
        if (ViewPawn.m_OverlayInfosBody[i].ParentMesh == WMA.m_HandsMesh
            || ViewPawn.m_OverlayInfosBody[i].ParentMesh == WMA.m_HeadMesh1P)
            ViewPawn.m_OverlayInfosBody[i].OverlayMesh.SetHidden(!bVisible);
    }
    for (i = 0; i < ViewPawn.m_OverlayInfosWeapon.Length; i++)
    {
        if (ViewPawn.m_OverlayInfosWeapon[i].ParentMesh == WMA.m_WeaponMesh1P)
            ViewPawn.m_OverlayInfosWeapon[i].OverlayMesh.SetHidden(!bVisible);
    }
}

simulated function ClearFirstPersonNudge()
{
    local TgPawn Nudged;

    if (m_NudgedFpPawn == none)
        return;

    Nudged = m_NudgedFpPawn;
    m_NudgedFpPawn = none;
    m_bWasMounted = false;

    SetRealModelHidden(Nudged, false);
    SetRigVisible(Nudged, true);
    SetForced3PPose(false);
    if (Nudged.Controller == self)
        Nudged.Controller = none;
    m_bBehindView = true;
}

exec function SpecToggleFirstPerson()
{
    if (int(m_CameraMode) == int(SpectatorCameraMode.SpecCam_FollowFirstPerson))
        SetSpectatorCameraMode(SpectatorCameraMode.SpecCam_FollowThirdPerson);
    else
        SetSpectatorCameraMode(SpectatorCameraMode.SpecCam_FollowFirstPerson);
}

// Same bookkeeping as the stock mode 3 handler, but swaps in our own camera
// module so the POV is driven from script instead of the native gate.
exec function SetSpectatorCameraMode(TgSpectatorController.SpectatorCameraMode Mode, optional bool bCameraTween = false)
{
    if (int(Mode) != int(SpectatorCameraMode.SpecCam_FollowFirstPerson))
    {
        super.SetSpectatorCameraMode(Mode, bCameraTween);
        ClearFirstPersonNudge();
        return;
    }

    if (int(Mode) == int(m_CameraMode))
        return;

    m_CameraMode = Mode;
    m_bIsMapSquashed = false;
    if (bCameraTween)
        TgPlayerCamera(PlayerCamera).SwitchCameras(class'TmCore.TmCameraModule_SpectatorFirstPerson', 0.2);
    else
        TgPlayerCamera(PlayerCamera).SwitchCameras(class'TmCore.TmCameraModule_SpectatorFirstPerson');
}

// Opens the native first person gate (ATgPawn::ShouldBeFirstPersonThisTick,
// live path) for the followed pawn by assigning the local spectator
// controller to its Controller reference client-side. Pawn.Controller is
// owner-only replicated so the assignment never leaves this machine and the
// real owner keeps authoritative control server-side. Attaching a LOCAL
// controller is deliberate: many effect playback paths branch on
// IsLocallyControlled(), and the local branches are the ones that reliably
// play tracers/impacts/explosions for the spectated pawn (non-local stand-in
// controllers suppress them).
// Wants3P() returns false for us because our FP camera module does not derive
// from TgCameraModule_ThirdPerson and no 3P camera posture is latched, which
// opens the gate and makes the engine build the entire native first person
// rig (viewmodel, Camera_bn eye position) exactly like the followed player
// sees.
simulated function UpdateFirstPersonNudge()
{
    local TgPawn ViewPawn;
    local TgRepInfo_Player FollowedPRI;
    local bool bNativeFP;

    if (m_CameraMode != SpectatorCameraMode.SpecCam_FollowFirstPerson)
    {
        ClearFirstPersonNudge();
        return;
    }

    ViewPawn = TgPawn(GetViewTarget());
    // Never touch pawns we have authority over (listen server): the fake
    // Controller assignment is only safe on simulated proxies.
    if (ViewPawn == none || !ViewPawn.IsAliveAndWell() || ViewPawn.Role >= ROLE_Authority)
    {
        ClearFirstPersonNudge();
        return;
    }

    if (m_NudgedFpPawn != none && m_NudgedFpPawn != ViewPawn)
        ClearFirstPersonNudge();

    m_NudgedFpPawn = ViewPawn;
    ViewPawn.Controller = self;
    m_bBehindView = false;

    // Mounts have no native signal in a spectator context (their posture is
    // pushed on the owning player's controller only, and the gate's device
    // loop cannot see them), so detect them from replicated pawn state. The
    // native r_bIsMounted replication handler also refuses to build the horse
    // while the pawn looks locally controlled, so the mount presentation is
    // driven manually - strictly on transitions, otherwise the dismount
    // presentation would replay every frame.
    if (ViewPawn.r_bIsMounted != m_bWasMounted)
    {
        m_bWasMounted = ViewPawn.r_bIsMounted;
        if (ViewPawn.r_bIsMounted)
            ViewPawn.PlayMountingEffects(false, ViewPawn.r_bUseMountPosture);
        else
            ViewPawn.StopMountingEffects(true, ViewPawn.r_bUseMountPosture);
    }

    bNativeFP = !ViewPawn.r_bIsMounted
        && !IsForced3PAbilityDevice(ViewPawn)
        && ViewPawn.ShouldBeFirstPersonThisTick();
    m_bBehindView = !bNativeFP;

    SetRealModelHidden(ViewPawn, bNativeFP);
    SetRigVisible(ViewPawn, bNativeFP);
    SetForced3PPose(!bNativeFP);
}

// Some movement abilities never close the native gate: their third person
// window is driven by owning-client camera code rather than their form's
// force-3P bit (which is what the gate's device loop reads), and their brief
// fire state is easy to miss. Detect them explicitly while firing.
simulated function bool IsForced3PAbilityDevice(TgPawn ViewPawn)
{
    local int i, slot;
    local int EquipSlots[5];
    local TgDevice Dev;

    EquipSlots[0] = 1;
    EquipSlots[1] = 16;
    EquipSlots[2] = 3;
    EquipSlots[3] = 4;
    EquipSlots[4] = 2;

    for (i = 0; i < ABILITY_SLOTS; i++)
    {
        slot = EquipSlots[i];
        Dev = ViewPawn.GetDeviceByEqPoint(slot);
        if (Dev == none || !Dev.IsFiring())
            continue;

        if (Dev.IsA('TgDevice_HunterRoll')        // Cassie dodge roll
            || Dev.IsA('TgDevice_Flutter')        // Willo flutter
            || Dev.IsA('TgDevice_Thrust')
            || Dev.IsA('TgDevice_CombatSlide')
            || Dev.IsA('TgDevice_NetherStep')
            || Dev.IsA('TgDevice_Advance')
            || Dev.IsA('TgDevice_Withdraw')
            || Dev.IsA('TgDevice_Pounce')
            || Dev.IsA('TgDevice_Uppercut')
            || Dev.IsA('TgDevice_HeroicLeap')
            || Dev.IsA('TgDevice_KingBomb')
            || Dev.IsA('TgDevice_Reversal'))
            return true;
    }
    return false;
}

simulated function SetForced3PPose(bool bForced3P)
{
    local TmCameraModule_SpectatorFirstPerson CamMod;

    if (PlayerCamera == none)
        return;
    CamMod = TmCameraModule_SpectatorFirstPerson(TgPlayerCamera(PlayerCamera).CurrentCameraMod);
    if (CamMod != none)
        CamMod.SetForced3P(bForced3P);
}

simulated function TickBurnsHud()
{
    local UIHudCards CardsHUD;
    local UIHudBurns BurnHUD;
    local TgPawn ViewPawn;
    local TgRepInfo_Player ViewPRI;
    local int DeviceIds[4], Powers[4], i;

    CardsHUD = UIHudCards(`UTILS.FindSceneByClassName(TgGameHUD(myHUD), 'UIHudCards'));
    if (CardsHUD == none)
    {
        `log("BurnHud: no UIHudCards",,'TmSpec');
        return;
    }
    BurnHUD = UIHudBurns(`UTILS.FindSceneByClassName(TgGameHUD(myHUD), 'UIHudBurns'));

    ViewPawn = TgPawn(GetViewTarget());
    if (ViewPawn != none)
        ViewPRI = TgRepInfo_Player(ViewPawn.PlayerReplicationInfo);
    if (ViewPRI == none)
        ViewPRI = TgRepInfo_Player(PlayerReplicationInfo);

    `UIUTILS.GetSpectatedBurnIds(ViewPRI, ViewPawn, DeviceIds, Powers);
    
    `UIUTILS.SyncBurnsToScene(CardsHUD, BurnHUD, DeviceIds, Powers);
}

// Hiding must be absolute and survive ATgPawn::TickSpecial, which re-asserts
// mesh visibility every tick via RecursiveSetVisibility (derived from
// bOwnerNoSee-style flags that cannot work here: Owner is not replicated to
// spectators, so the engine never considers the pawn's meshes owned by us).
// Setting the actor-level bHidden wins that race: rendering honors the owning
// actor's hidden flag regardless of per-component flips. The mount mesh is
// deliberately skipped: PlayMountingEffects/StopMountingEffects own its
// lifecycle, and blanket-unhiding would resurrect a stale horse during later
// third person ticks.
simulated function SetRealModelHidden(TgPawn ViewPawn, bool bHidden)
{
    local PrimitiveComponent Prim;

    ViewPawn.SetHidden(bHidden);
    foreach ViewPawn.ComponentList(class'PrimitiveComponent', Prim)
    {
        if (!bHidden && Prim == ViewPawn.m_MountMesh)
            continue;
        Prim.SetHidden(bHidden);
    }
}

// Park or restore the first person viewmodel for third person ticks. The
// native gate stays open there, so its per-tick toggles (OwnerNoSee based)
// keep flipping state; absolute SetHidden sticks instead. Overlay duplicates
// and particles attached to the rig are handled too, otherwise weapon glow
// effects keep rendering over a hidden mesh.
simulated function SetRigVisible(TgPawn ViewPawn, bool bVisible)
{
    local TgWeaponMeshActor WMA;
    local PrimitiveComponent Prim;
    local int i;

    WMA = ViewPawn.m_WeaponMesh;
    if (WMA == none)
        return;

    if (bVisible)
    {
        // Restore the first person pieces plus everything owned by the rig
        // (weapon glow particles live here); the 3P weapon is left to the
        // native owner-based visibility, which now applies to us.
        foreach WMA.AllOwnedComponents(class'PrimitiveComponent', Prim)
            Prim.SetHidden(false);
        if (WMA.m_WeaponMesh1P != none)
            WMA.m_WeaponMesh1P.FxActivateGroup('AlwaysOn', 0);
        if (WMA.m_HandsMesh != none)
            WMA.m_HandsMesh.FxActivateGroup('AlwaysOn', 0);
        if (WMA.m_HeadMesh1P != none)
            WMA.m_HeadMesh1P.FxActivateGroup('AlwaysOn', 0);
        SetRigOverlaysVisible(ViewPawn, true);
        return;
    }

    // Park everything weapon related for third person ticks.
    WMA.Set1PAttachState(2);
    if (WMA.m_WeaponMesh1P != none)
    {
        WMA.m_WeaponMesh1P.SetHidden(true);
        WMA.m_WeaponMesh1P.FxDeactivateGroup('AlwaysOn', 0);
    }
    if (WMA.m_HandsMesh != none)
    {
        WMA.m_HandsMesh.SetHidden(true);
        WMA.m_HandsMesh.FxDeactivateGroup('AlwaysOn', 0);
    }
    if (WMA.m_HeadMesh1P != none)
    {
        WMA.m_HeadMesh1P.SetHidden(true);
        WMA.m_HeadMesh1P.FxDeactivateGroup('AlwaysOn', 0);
    }
    if (WMA.m_WeaponMesh3P != none)
        WMA.m_WeaponMesh3P.SetHidden(true);

    // Particles parented to the rig render independently of their parent's
    // hidden flag, and they can live anywhere in the ownership chain (the
    // weapon glows do), so sweep everything the rig owns.
    foreach WMA.AllOwnedComponents(class'PrimitiveComponent', Prim)
        Prim.SetHidden(true);

    SetRigOverlaysVisible(ViewPawn, false);
}

// Hides/shows the overlay duplicate meshes parented to the first person
// pieces (skin/shield overlays render independently of their parent's flag).
simulated function SetRigOverlaysVisible(TgPawn ViewPawn, bool bVisible)
{
    local int i;
    local TgWeaponMeshActor WMA;

    WMA = ViewPawn.m_WeaponMesh;
    if (WMA == none)
        return;

    for (i = 0; i < ViewPawn.m_OverlayInfosBody.Length; i++)
    {
        if (ViewPawn.m_OverlayInfosBody[i].ParentMesh == WMA.m_HandsMesh
            || ViewPawn.m_OverlayInfosBody[i].ParentMesh == WMA.m_HeadMesh1P)
            ViewPawn.m_OverlayInfosBody[i].OverlayMesh.SetHidden(!bVisible);
    }
    for (i = 0; i < ViewPawn.m_OverlayInfosWeapon.Length; i++)
    {
        if (ViewPawn.m_OverlayInfosWeapon[i].ParentMesh == WMA.m_WeaponMesh1P)
            ViewPawn.m_OverlayInfosWeapon[i].OverlayMesh.SetHidden(!bVisible);
    }
}

simulated function ClearFirstPersonNudge()
{
    local TgPawn Nudged;

    if (m_NudgedFpPawn == none)
        return;

    Nudged = m_NudgedFpPawn;
    m_NudgedFpPawn = none;
    m_bWasMounted = false;

    SetRealModelHidden(Nudged, false);
    SetRigVisible(Nudged, true);
    SetForced3PPose(false);
    if (Nudged.Controller == self)
        Nudged.Controller = none;
    m_bBehindView = true;
}

function SpectatorSetViewTarget(Actor VT, optional ViewTargetTransitionParams TransitionParams)
{
    ClearFirstPersonNudge();
    super.SpectatorSetViewTarget(VT, TransitionParams);
}

simulated function TickBurnsHud()
{
    local UIHudCards CardsHUD;
    local UIHudBurns BurnHUD;
    local TgPawn ViewPawn;
    local TgRepInfo_Player ViewPRI;
    local int DeviceIds[4], Powers[4], i;

    CardsHUD = UIHudCards(`UTILS.FindSceneByClassName(TgGameHUD(myHUD), 'UIHudCards'));
    if (CardsHUD == none)
    {
        `log("BurnHud: no UIHudCards",,'TmSpec');
        return;
    }
    BurnHUD = UIHudBurns(`UTILS.FindSceneByClassName(TgGameHUD(myHUD), 'UIHudBurns'));

    ViewPawn = TgPawn(GetViewTarget());
    if (ViewPawn != none)
        ViewPRI = TgRepInfo_Player(ViewPawn.PlayerReplicationInfo);
    if (ViewPRI == none)
        ViewPRI = TgRepInfo_Player(PlayerReplicationInfo);

    `UIUTILS.GetSpectatedBurnIds(ViewPRI, ViewPawn, DeviceIds, Powers);
    
    `UIUTILS.SyncBurnsToScene(CardsHUD, BurnHUD, DeviceIds, Powers);
}

simulated function TickSpectatorPlayerHUD()
{
    local UIHudPlayer HUD;
    local TgPawn ViewPawn;
    local TgRepInfo_Player PRI, SPRI;
    local GFxObject Group, OgGroup;
    local GFxObject HealthBarTickContainer;
    local UIComponent_HealthBar OgHealthBar;
    local int TaskForce;

    HUD = UIHudPlayer(`UTILS.FindSceneByClassName(TgGameHUD(myHUD), 'UIHudPlayer'));
    if (HUD == none) return;

    if (!bClonedHUD)
    {
        Group = HUD.AttachMovie("UIHudPlayer", "TmUIHudPlayer", 50).GetObject("Group");
        bClonedHUD = true;
    }
    else
        Group = HUD.GetObject("TmUIHudPlayer").GetObject("Group");

    SPRI = TgRepInfo_Player(PlayerReplicationInfo);
    if (SPRI == none) return;

    ViewPawn = TgPawn(GetViewTarget());
    if (ViewPawn == none)
    {
        Group.SetVisible(false);
        return;
    }

    PRI = TgRepInfo_Player(ViewPawn.PlayerReplicationInfo);
    if (PRI == none) return;

    TaskForce = PRI.GetTaskForceNumber();

    OgGroup = HUD.GetObject("Group");
    OgGroup.SetAlpha(0.0);
    OgGroup.SetVisible(false);

    OgHealthBar = HUD.m_HealthBar.m_DamageOverlay.m_HealthbarOwner;

    Group.SetVisible(true);
    Group.GotoAndStopI(TaskForce);
    `UIUTILS.SetGameText(Group.GetObject("SpectatorName").GetObject("TF"), PRI.PlayerName);
    `UIUTILS.SetGameText(Group.GetObject("SpectatorName").GetObject("TeamName").GetObject("TF"), TaskForce == 1 ? "Blue Team" : "Red Team");
    Group.GetObject("SpectatorName").GetObject("TeamName").GotoAndStopI(TaskForce);
    Group.GetObject("SpectatorName").GetObject("Frame").GotoAndStopI(TaskForce);

    `UIUTILS.MirrorClip(Group, OgGroup, "HealthDamageOverlay");
    `UIUTILS.MirrorClip(Group, OgGroup, "HealthDamageOverlayNormal");
    `UIUTILS.MirrorClip(Group, OgGroup, "HealthBarTickContainer");
    `UIUTILS.MirrorClip(Group, OgGroup, "HealthBorderTickMask");
    `UIUTILS.MirrorClip(Group, OgGroup, "HealthBorderTickContainer");
    `UIUTILS.MirrorClip(Group, OgGroup, "ShieldBorderTickMask");
    `UIUTILS.MirrorClip(Group, OgGroup, "ShieldBorderTickContainer");
    `UIUTILS.MirrorClip(Group, OgGroup, "ShadowBorderTickMask");
    `UIUTILS.MirrorClip(Group, OgGroup, "ShadowBorderTickContainer");

    HealthBarTickContainer = Group.GetObject("HealthBarTickContainer");

    `UIUTILS.MirrorText(Group.GetObject("Now"), OgGroup.GetObject("Now"));
    `UIUTILS.MirrorText(Group.GetObject("Max"), OgGroup.GetObject("Max"));
    if (Group.GetObject("Tip") != none && OgGroup.GetObject("Tip") != none)
        Group.GetObject("Tip").SetDisplayInfo(OgGroup.GetObject("Tip").GetDisplayInfo());

    Group.GetObject("Streak").SetVisible(`UTILS.ToInt(Group.GetObject("Streak").GetText()) > 0 ? true : false);

    `UIUTILS.SetGameText(Group.GetObject("Streak").GetObject("Title"), PRI.r_nKillstreak);
    `UIUTILS.SetGameText(Group.GetObject("Streak").GetObject("Subtitle"), "STREAK");

    `UIUTILS.BuildFillTicks(OgHealthBar, HealthBarTickContainer, TaskForce, LastClonedTickCount);
    `UIUTILS.BuildBorderTicks(OgHealthBar, Group, TaskForce, bBorderBuilt);
    `UIUTILS.MirrorBarMasks(OgHealthBar, OgGroup, Group);
    `UIUTILS.RecolorHealthTicks(OgHealthBar, HealthBarTickContainer, TaskForce);

    `UIUTILS.SyncShieldText(OgGroup, Group);
    `UIUTILS.SyncCombat(OgGroup, Group);
    `UIUTILS.SyncHealFeedContainer(OgGroup, Group);

    SPRI.r_nProfileId = PRI.r_nProfileId;
    SPRI.r_nCredits = PRI.r_nCredits;
    SPRI.r_nEarnedCredits = PRI.r_nEarnedCredits;

    if (PRI.r_nProfileId > 0)
        `UIUTILS.SyncIcon(Group.GetObject("Icon"), HUD.m_mcIcon);
}

simulated function TickSpectatorTeamHUD()
{
    local UIHudTeam HUD;
    local TgPawn ViewPawn;
    local TgRepInfo_Player PRI, SPRI;
    local array<TgRepInfo_Player> Players;
    local GFxObject RedPlayer, Health, HealthBG, HealthTip;
    local int i;

    TgRepInfo_Game(WorldInfo.GRI).GetTaskForce(2).GetPlayers(Players);
    HUD = UIHudTeam(`UTILS.FindSceneByClassName(TgGameHUD(myHUD), 'UIHudTeam'));
    if (HUD == none) return;
    SPRI = TgRepInfo_Player(PlayerReplicationInfo);
    if (SPRI == none) return;
    ViewPawn = TgPawn(GetViewTarget());
    if (ViewPawn == none) return;
    PRI = TgRepInfo_Player(ViewPawn.PlayerReplicationInfo);
    if (PRI == none) return;
    for (i = 0; i < Players.Length; i++)
    {
        RedPlayer = HUD.m_mcPlayers.GetObject("Red" $ i);
        Health = RedPlayer.GetObject("Health");
        HealthBG = RedPlayer.GetObject("HealthBG");
        HealthTip = RedPlayer.GetObject("HealthTip");
        HealthBG.SetVisible(true);
        HealthBG.SetAlpha(85.0);
        Health.SetVisible(true);
        HUD.Animate(Health, 0.2, UIANIM_WIDTH, (float(Players[i].r_nHealthCurrent) / float(Players[i].r_nHealthMaximum)) * 78);
        Health.SetAlpha(100.0);
        HealthTip.SetVisible(true);
        HUD.Animate(HealthTip, 0.2, UIANIM_X, ((float(Players[i].r_nHealthCurrent) / float(Players[i].r_nHealthMaximum)) * 78) - 39);
        HealthTip.SetAlpha(100.0);
    }
}

defaultproperties
{
    c_bFpDiagLogs=true
    c_bTrackViewTargetForRelevancy=true
}
