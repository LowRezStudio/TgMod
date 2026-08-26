class TmSpectatorController extends TgSpectatorController
    config(Game)
    hidecategories(Navigation)
    dependson(TgObject);

// Server-sampled ability state pushed every 0.15s (remote pawns don't simulate cooldowns)
struct transient TmAbilityState
{
    var int DeviceId;
    var int Ammo;
    var int AmmoMax;
    var int CooldownPct;  // 0-100 remaining fraction
    var int CooldownSecs; // whole seconds remaining (timer label)
    var int Status;       // 1=locked(red slash), 2=ready, 3=cooling, 4=firing(spinner)
};

var transient bool bClonedHUD;
var transient int LastClonedTickCount;
var transient int bBorderBuilt;

// Pawn currently forced into the client-side first person rig, if any.
var transient TgPawn m_NudgedFpPawn;
// Last known mounted state of the nudged pawn (edge detection for the manual mount presentation).
var transient bool m_bWasMounted;
// True while inside a mount/emote third person window.
var transient bool m_bWasWindow3P;
// If false, disable the server-side relevancy viewpoint override.
var config bool c_bTrackViewTargetForRelevancy;

var transient int LastUltPhase;  // previous tick's ult phase (1=charging, 2=full) for pulse edge detection
var transient float UltRingNext; // client TimeSeconds for the next recurring ready-ring flash

// Server-sampled ability state, replicated to the spec client
var repnotify TmAbilityState r_Abilities[5];
var repnotify int r_UltCharge;   // r_nUltimateCharge doesn't reliably replicate to spec clients
var transient int LastStatus[5]; // previous tick's status for ready-transition flash detection
var transient int LastIconFrame[5]; // last icon frame written per slot; skips redundant GotoAndStopI/FadeIn

// Cast bars (server-sampled), ms precision so the client can extrapolate like the native HUD
var repnotify int r_CastIds[3];      // device ids currently casting (0 = slot empty)
var repnotify int r_CastCurMs[3];    // elapsed cast time in ms per bar
var repnotify int r_CastRateMs[3];   // total cast time in ms per bar (0 = inactive)
var repnotify string r_CastNames[3]; // device display names, SetTextEx'd onto the bar clip
var transient int LastCastId[3];
var transient int LastCastCurMs[3];
var transient int CastShown[3];      // visibility latch per bar (US3 forbids bool arrays)
var transient float CastRecvTime[3]; // client TimeSeconds when each bar's CurMs last advanced
var transient float PredMs[3];       // chased fill position in ms (smoothing)
var transient float LastHudTick;     // client TimeSeconds of previous PostRender pass
var transient array<GFxObject> CastWidthCache; // [clip, full width] pairs for fill scaling
var transient array<float> CastWidths;

simulated function ForwardToSpectatingMatch()
{
    super.ForwardToSpectatingMatch();
    if (WorldInfo.NetMode != NM_DedicatedServer)
        SetSpectatorCameraMode(SpectatorCameraMode.SpecCam_FollowThirdPerson);
}

public function Class<HUD> GetHudClass(Class<HUD> pNewHudType)
{
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

//TODO Cinnamon: Find a better way to do this

// Some movement abilities never close the native gate, and DEVICE OBJECTS do
// not replicate to spectators at all (GetDeviceByEqPoint resolves to none on
// this connection - verified by diagnostics). What does replicate is the form
// STATE NAME per equip point plus the pawn class itself, so third person
// windows are driven by a per-champion slot table.
//
// Champion internal class names: Cassie=TgPawn_Cassie, Lian=TgPawn_Princess,
// Ash=TgPawn_Juggernaut(unverified), Barik=TgPawn_Barik,
// Fernando=TgPawn_Fernando, Makoa=TgPawn_Makoa, Androxus=TgPawn_Androxus,
// Evie=TgPawn_Evie, Zhin=TgPawn_Darklord, Grohk=TgPawn_Grohk,
// Maeve=TgPawn_Blades, Willo=TgPawn_Fairy, Sha Lin=TgPawn_Longbow,
// Seris/Torvald=TgPawn_Oracle(?).
simulated function bool IsForced3PAbilityDevice(TgPawn ViewPawn)
{
    local int Mask;

    //Cinnamon: 7 = emote. Handle emotes before anything else.
    if (ViewPawn.c_EquipFormState[7] == 'DeviceFiring' || ViewPawn.c_EquipFormState[7] == 'DeviceBuilding') 
        return true;

    // Bit 16 = RMB ability, bit 4 = F ability, bit 3 = Q ability, bit 2 = E ability.
    Mask = GetForce3PSlotMask(ViewPawn) | GetForce3PUltSlotMask(ViewPawn);
    if (Mask == 0)
        return false;
    
    if ((Mask & (1 << 16)) != 0 && (ViewPawn.c_EquipFormState[16] == 'DeviceFiring' || ViewPawn.c_EquipFormState[16] == 'DeviceBuilding'))
        return true;
    if ((Mask & (1 << 4)) != 0 && (ViewPawn.c_EquipFormState[4] == 'DeviceFiring' || ViewPawn.c_EquipFormState[4] == 'DeviceBuilding'))
        return true;
    if ((Mask & (1 << 3)) != 0 && (ViewPawn.c_EquipFormState[3] == 'DeviceFiring' || ViewPawn.c_EquipFormState[3] == 'DeviceBuilding'))
        return true;
    if ((Mask & (1 << 2)) != 0 && (ViewPawn.c_EquipFormState[2] == 'DeviceFiring' || ViewPawn.c_EquipFormState[2] == 'DeviceBuilding'))
        return true;
    return false;
}

//TODO Cinnamon: Find a better way to do this

// Ultimates (equip point 2) that play out in third person. Jenos' Through
// Time and Space already closes the gate natively and needs no entry.
simulated function int GetForce3PUltSlotMask(TgPawn ViewPawn)
{
    if (ViewPawn.IsA('TgPawn_Princess')       // Lian
        || ViewPawn.IsA('TgPawn_Flak')        // Ash
        || ViewPawn.IsA('TgPawn_Knight')      // Fernando
        || ViewPawn.IsA('TgPawn_Darklord')    // Zhin
        || ViewPawn.IsA('TgPawn_Shaman')      // Grohk
        || ViewPawn.IsA('TgPawn_BombKing')    // Bomb King
        || ViewPawn.IsA('TgPawn_Drogoz')      // Drogoz
        || ViewPawn.IsA('TgPawn_BarrierTank') // Inara
        || ViewPawn.IsA('TgPawn_Druid'))      // Grover
        return 1 << 2;

    return 0;
}


//TODO Cinnamon: Find a better way to do this
simulated function int GetForce3PSlotMask(TgPawn ViewPawn)
{
    // Champion internal class names (runtime): Cassie=Huntress,
    // Fernando=Knight, Barik=Engineer, Grohk=Shaman, Evie=Mage,
    // Lian=Princess, Ash=Flak, Makoa=Makoa, Androxus=Androxus,
    // Zhin=Darklord, Maeve=Blades, Willo=Fairy, Sha Lin=Longbow,
    // Seris=Oracle, Strix=Owl, Inara=BarrierTank, Terminus=Lazarus,
    // Tyra=Salty, Viktor=BRmale/Robosarge, Pip=Alchemist, Vivian=Churchill,
    // Moji=Rider, Lex=Lawman, Grover=Druid, Atlas=TimeTraveler,
    // Koga=Ninja, Furia=Angel, Dredge=Pirate, Ying=Illusionist,
    // Khan=Vanguard. Old export aliases kept as fallbacks where they exist.

    // Zhin forces third person on both F and Q.
    if (ViewPawn.IsA('TgPawn_Darklord'))
        return (1 << 4) | (1 << 3);

    // Fernando forces it on F and RMB
    if(ViewPawn.IsA('TgPawn_Fernando') || ViewPawn.IsA('TgPawn_Knight'))
        return (1 << 4) | (1 << 16);

    // Androxus forces it on Q only.
    if (ViewPawn.IsA('TgPawn_Androxus'))
        return (1 << 3);

    // Everyone else with a forcing ability uses F only.
    if (ViewPawn.IsA('TgPawn_Huntress')        // Cassie dodge roll
        || ViewPawn.IsA('TgPawn_Cassie')       // (old alias)
        || ViewPawn.IsA('TgPawn_Princess')     // Lian
        || ViewPawn.IsA('TgPawn_Flak')         // Ash
        || ViewPawn.IsA('TgPawn_Engineer')     // Barik
        || ViewPawn.IsA('TgPawn_Barik')        // (old alias)
        || ViewPawn.IsA('TgPawn_Makoa')        // Makoa
        || ViewPawn.IsA('TgPawn_Shaman')       // Grohk
        || ViewPawn.IsA('TgPawn_Grohk')        // (old alias)
        || ViewPawn.IsA('TgPawn_Mage')         // Evie
        || ViewPawn.IsA('TgPawn_Evie')         // (old alias)
        || ViewPawn.IsA('TgPawn_Fairy'))       // Willo
        return (1 << 4);

    // Tyra, Viktor, Sha Lin, Bomb King, Drogoz, Kinessa, Inara, Ruckus,
    // Torvald, Buck, Lex, Maeve, Skye, Grover, Seris, Ying, Strix: none.
    return 0;
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

// Server-side actor relevancy (projectiles, deployables, sounds...) is computed
// from each controller's GetPlayerViewPoint. Flag-gated override that tracks
// the view target; kept off the hot path when disabled.
simulated event GetPlayerViewPoint(out Vector out_Location, out Rotator out_Rotation)
{
    local Actor VT;

    if (c_bTrackViewTargetForRelevancy && Role == ROLE_Authority && WorldInfo.NetMode != NM_Client)
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

function SpectatorSetViewTarget(Actor VT, optional ViewTargetTransitionParams TransitionParams)
{
    ClearFirstPersonNudge();
    super.SpectatorSetViewTarget(VT, TransitionParams);
    if (Role == ROLE_Authority)
        SetTimer(0.15, true, 'TickFollowAbilities');
}

function TickFollowAbilities()
{
    local TgPawn ViewPawn;
    local TgDevice Dev;
    local TmAbilityState S[5];
    local int i, eq;
    local float Remaining, Initial;

    if (Role != ROLE_Authority)
    {
        ClearTimer('TickFollowAbilities');
        return;
    }
    ViewPawn = TgPawn(GetViewTarget());
    if (ViewPawn == none)
        return;

    for (i = 0; i < 5; i++)
    {
        eq = `UIUTILS.GetSkillEqPoint(i);
        S[i].DeviceId = 0;
        S[i].Ammo = 0;
        S[i].AmmoMax = 0;
        S[i].CooldownPct = 0;
        S[i].CooldownSecs = 0;
        S[i].Status = 2; // ready default

        // PRI r_PlayerDevices is only a fallback (horse pre-mount has no live device)
        Dev = ViewPawn.GetDeviceByEqPoint(eq);
        if (Dev != none)
            S[i].DeviceId = Dev.r_nDeviceId;
        if (S[i].DeviceId == 0 && ViewPawn.PlayerReplicationInfo != none)
            S[i].DeviceId = TgRepInfo_Player(ViewPawn.PlayerReplicationInfo).r_PlayerDevices[eq].CurrentDeviceId;

        if (Dev != none)
        {
            if (Dev.NativeIsFiring() || Dev.IsFiring())
            {
                S[i].Status = 4; // active -> icon spinner
            }
            else if (Dev.IsDeviceCoolingDown())
            {
                S[i].Status = 3; // cooling
                Remaining = Dev.GetCooldownRemaining();
                Initial = Dev.GetCooldownTimerManager().GetTimeInitial(0);
                if (Initial > 0.0)
                {
                    S[i].CooldownPct = int(FClamp(Remaining / Initial, 0.0, 1.0) * 100.0);
                    S[i].CooldownSecs = int(Remaining) + 1;
                }
            }
            else if (Dev.IsDeviceFiringLockedForUI())
            {
                S[i].Status = 1; // locked -> red slash overlay
            }
            else
            {
                S[i].Status = 2; // ready
            }

            if (Dev.r_nMaxAmmoClipCount > 0)
            {
                S[i].Ammo = Dev.GetCurrentAmmoAmount();
                S[i].AmmoMax = Dev.r_nMaxAmmoClipCount;
            }
        }
        else if (S[i].DeviceId != 0)
        {
            S[i].Status = 1; // id known but no live device (horse pre-mount etc.) -> locked look
        }
        if (S[i] != r_Abilities[i])
            r_Abilities[i] = S[i];
    }

    if (ViewPawn.PlayerReplicationInfo != none)
        r_UltCharge = TgRepInfo_Player(ViewPawn.PlayerReplicationInfo).r_nUltimateCharge;

    UpdateCastBars(ViewPawn);
}

// Server mirror of GetTimerBarInfo: up to 3 cast bars, ms precision for client-side fill
function UpdateCastBars(TgPawn ViewPawn)
{
    local int i, eq, NumBars;
    local TgDevice Dev;
    local float Cur, Rate;
    local int Ids[3], CurMs[3], RateMs[3];
    local string Names[3];

    for (i = 0; i < 5 && NumBars < 3; i++)
    {
        eq = `UIUTILS.GetSkillEqPoint(i);
        Dev = ViewPawn.GetDeviceByEqPoint(eq);
        if (Dev == none || !Dev.IsAbility())
            continue;

        Cur = 0.0;
        Rate = 0.0;

        switch (Dev.m_DeviceTimerBarType)
        {
            case 1: // DTBT_PreHit
            case 2: // DTBT_PostHit
            case 3: // DTBT_PersistTime
            case 4: // DTBT_RefireTime
                Rate = Dev.GetTimerRate(GetTimerBarName(Dev.m_DeviceTimerBarType));
                Cur = Rate - Dev.GetTimerCount(GetTimerBarName(Dev.m_DeviceTimerBarType));
                break;
            case 5: // DTBT_FireHold
                Cur = Dev.GetFireHoldPct();
                Rate = 1.0;
                break;
            case 6: // DTBT_Custom
                Cur = Dev.GetCustomTimerBarCurrentTime();
                Rate = Dev.GetCustomTimerBarMaxTime();
                break;
        }

        // elapsed = rate - count (GetTimerCount returns remaining); Rate==0 keeps idle bars off
        if (Rate <= 0.0)
            continue;

        Ids[NumBars] = Dev.r_nDeviceId;
        CurMs[NumBars] = FClamp(Cur / Rate, 0.0, 1.0) * Rate * 1000.0;
        RateMs[NumBars] = Rate * 1000.0;
        Names[NumBars] = Dev.GetDeviceName();
        NumBars++;
    }

    for (i = 0; i < 3; i++)
    {
        if (i < NumBars)
        {
            if (r_CastIds[i] != Ids[i] || r_CastCurMs[i] != CurMs[i] || r_CastNames[i] != Names[i])
            {
                r_CastIds[i] = Ids[i];
                r_CastCurMs[i] = CurMs[i];
                r_CastRateMs[i] = RateMs[i];
                r_CastNames[i] = Names[i];
            }
        }
        else if (r_CastIds[i] != 0)
        {
            r_CastIds[i] = 0;
            r_CastCurMs[i] = 0;
            r_CastRateMs[i] = 0;
            r_CastNames[i] = "";
        }
    }
}

// int literals: enum constants not visible cross-package
function name GetTimerBarName(int BarType)
{
    switch (BarType)
    {
        case 1: return 'FirePreHitDelay';   // DTBT_PreHit
        case 2: return 'FirePostHitDelay';  // DTBT_PostHit
        case 3: return 'PersistTimer';      // DTBT_PersistTime
        case 4: return 'RefireTimer';       // DTBT_RefireTime
    }
    return '';
}

replication
{
    if (bNetDirty)
        r_Abilities, r_UltCharge, r_CastIds, r_CastCurMs, r_CastRateMs, r_CastNames;
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

simulated function TickBurnsHud()
{
    local UIHudCards CardsHUD;
    local UIHudBurns BurnHUD;
    local TgPawn ViewPawn;
    local TgRepInfo_Player ViewPRI;
    local int DeviceIds[4], Powers[4];

    CardsHUD = UIHudCards(`UTILS.FindSceneByClassName(TgGameHUD(myHUD), 'UIHudCards'));
    if (CardsHUD == none)
        return;
    BurnHUD = UIHudBurns(`UTILS.FindSceneByClassName(TgGameHUD(myHUD), 'UIHudBurns'));

    ViewPawn = TgPawn(GetViewTarget());
    if (ViewPawn != none)
        ViewPRI = TgRepInfo_Player(ViewPawn.PlayerReplicationInfo);
    if (ViewPRI == none)
        ViewPRI = TgRepInfo_Player(PlayerReplicationInfo);

    `UIUTILS.GetSpectatedBurnIds(ViewPRI, ViewPawn, DeviceIds, Powers);
    
    `UIUTILS.SyncBurnsToScene(CardsHUD, BurnHUD, DeviceIds, Powers);
}

simulated function TickAbilitiesHud()
{
    local UIHudSkills SkillsHUD;
    local TgPawn ViewPawn;
    local int i;
    local int StateIds[5], StateAmmo[5], StateAmmoMax[5], StateCDPct[5], StateCDSecs[5], StateStatus[5], StatePrevStatus[5], UltCharge;

    SkillsHUD = UIHudSkills(`UTILS.FindSceneByClassName(TgGameHUD(myHUD), 'UIHudSkills'));
    if (SkillsHUD == none)
        return;

    ViewPawn = TgPawn(GetViewTarget());
    if (ViewPawn == none && PlayerCamera != none)
        ViewPawn = TgPawn(PlayerCamera.PendingViewTarget.Target); // mid-transition lock
    if (ViewPawn == none)
    {
        // No target: blank slots, reset latches so next target gets fresh icons
        for (i = 0; i < 5; i++)
            LastIconFrame[i] = 0;
        LastUltPhase = 0;
        UltRingNext = 0.0;
        for (i = 0; i < 3; i++)
            CastShown[i] = 0;
        `UIUTILS.BlankSkillsScene(SkillsHUD);
        return;
    }

    UnpackAbilityState(StateIds, StateAmmo, StateAmmoMax, StateCDPct, StateCDSecs, StateStatus, StatePrevStatus, UltCharge);

    // The game hides the ability bar for spectators up the clip chain - force it visible every tick.
    `UIUTILS.ForceSkillsVisible(SkillsHUD);

    `UIUTILS.SyncSkillsToScene(SkillsHUD, ViewPawn,
        StateIds, StateAmmo, StateAmmoMax, StateCDPct, StateCDSecs, StateStatus, StatePrevStatus,
        UltCharge, r_CastIds, r_CastCurMs, r_CastRateMs, r_CastNames,
        LastCastId, LastCastCurMs, CastShown, CastRecvTime, PredMs,
        LastHudTick, LastIconFrame, UltRingNext, CastWidthCache, CastWidths);
}

// Unpack r_Abilities for the UIUtils sync; StatePrevStatus[2] holds the previous ult phase (1=charging, 2=full)
simulated function UnpackAbilityState(out int StateIds[5], out int StateAmmo[5], out int StateAmmoMax[5], out int StateCDPct[5], out int StateCDSecs[5], out int StateStatus[5], out int StatePrevStatus[5], out int UltCharge)
{
    local int i, Phase;

    for (i = 0; i < 5; i++)
    {
        StateIds[i] = r_Abilities[i].DeviceId;
        StateAmmo[i] = r_Abilities[i].Ammo;
        StateAmmoMax[i] = r_Abilities[i].AmmoMax;
        StateCDPct[i] = r_Abilities[i].CooldownPct;
        StateCDSecs[i] = r_Abilities[i].CooldownSecs;
        StatePrevStatus[i] = LastStatus[i];
        StateStatus[i] = r_Abilities[i].Status;
        LastStatus[i] = StateStatus[i];
    }
    // Server-sampled r_UltCharge is authoritative; PRI value only as fallback.
    if (r_UltCharge > 0)
        UltCharge = r_UltCharge;
    else if (ViewPawnPRI() != none)
        UltCharge = ViewPawnPRI().r_nUltimateCharge;
    else
        UltCharge = 0;

    StatePrevStatus[2] = LastUltPhase;
    LastUltPhase = UltCharge >= 100 ? 2 : 1;
}

simulated function TgRepInfo_Player ViewPawnPRI()
{
    local TgPawn ViewPawn;
    ViewPawn = TgPawn(GetViewTarget());
    if (ViewPawn != none)
        return TgRepInfo_Player(ViewPawn.PlayerReplicationInfo);
    return TgRepInfo_Player(PlayerReplicationInfo);
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

    Group.GetObject("Streak").SetVisible(`UTILS.ToInt(Group.GetObject("Streak").GetObject("Title").GetText()) > 0 ? true : false);

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
    c_bTrackViewTargetForRelevancy=true
}