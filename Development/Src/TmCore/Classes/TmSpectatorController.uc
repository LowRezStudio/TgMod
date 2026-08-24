class TmSpectatorController extends TgSpectatorController
    config(Game)
    hidecategories(Navigation)
    dependson(TgObject);

struct transient SpecAbility {
    var string DeviceName;
    var float CooldownPct;
    var float CooldownRemain;
    var int CurrentAmmo;
    var int MaxAmmo;
};
var transient SpecAbility Abilities[5];
var transient bool bTimerOn;

var transient bool bClonedHUD;
var transient int LastClonedTickCount;
var transient int bBorderBuilt;

// Pawn currently forced into the client-side first person rig, if any.
var transient TgPawn m_NudgedFpPawn;

const ABILITY_SLOTS = 5;

simulated function ForwardToSpectatingMatch()
{
    super.ForwardToSpectatingMatch();
    if (WorldInfo.NetMode != NM_DedicatedServer)
        SetSpectatorCameraMode(SpectatorCameraMode.SpecCam_FollowThirdPerson);
}

simulated function SpecAbility GetAbility(int i)
{
    if (i >= 0 && i < ABILITY_SLOTS)
        return Abilities[i];
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
// live path) for the followed pawn. The gate requires:
//   Controller != none, IsA(TgPlayerController) and !Controller->Wants3P()
// A spectated pawn normally fails the first test because other players'
// controllers are never replicated to us. Assigning ourselves client-side is
// safe: Pawn.Controller is owner-only replicated so it never leaves this
// machine, and the real owner keeps authoritative control server-side.
// Wants3P() returns true when the current camera module derives from
// TgCameraModule_ThirdPerson (with zoom applied) or when a 3P camera posture
// is pushed, which is why our FP camera module must NOT derive from any
// ThirdPerson module and why we keep the posture cleared. With the gate open,
// the engine builds the entire native first person rig (viewmodel, Camera_bn
// eye position) and its device loop adapts FP<->3P during abilities/mounts
// exactly like the followed player sees. The spectated pawn's world model is
// hidden absolutely (bOwnerNoSee cannot work: Owner never replicates to us).
simulated function UpdateFirstPersonNudge()
{
    local TgPawn ViewPawn;
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

    // Single source of truth: ask the engine whether this pawn is first person
    // this tick. The native device loop already accounts for abilities, mounts
    // and emotes; our camera module just flips between the eye pose and the
    // behind-view pose without ever leaving its class.
    bNativeFP = ViewPawn.ShouldBeFirstPersonThisTick();
    m_bBehindView = !bNativeFP;

    SetRealModelHidden(ViewPawn, bNativeFP);
    SetForced3PPose(!bNativeFP);

    // Wants3P() folds in the posture stack; make sure nothing 3P is latched.
    if (int(c_eCameraPosture) != 0)
        c_eCameraPosture = TG_CAMERAPOSTURE_None;
}

simulated function SetForced3PPose(bool bForced3P)
{
    local TmCameraModule_SpectatorFirstPerson CamMod;

    if (PlayerCamera == none)
        return;
    CamMod = TmCameraModule_SpectatorFirstPerson(TgPlayerCamera(PlayerCamera).CurrentCameraMod);
    if (CamMod != none)
        CamMod.m_bForced3P = bForced3P;
}

// Hiding must be absolute: the pawn's Mesh uses bOwnerNoSee semantics against
// an Owner that is never replicated to spectators.
simulated function SetRealModelHidden(TgPawn ViewPawn, bool bHidden)
{
    if (ViewPawn.Mesh != none)
        ViewPawn.Mesh.SetHidden(bHidden);
    if (ViewPawn.m_WeaponMesh != none && ViewPawn.m_WeaponMesh.m_WeaponMesh3P != none)
        ViewPawn.m_WeaponMesh.m_WeaponMesh3P.SetHidden(bHidden);
}

simulated function ClearFirstPersonNudge()
{
    local TgPawn Nudged;

    if (m_NudgedFpPawn == none)
        return;

    Nudged = m_NudgedFpPawn;
    m_NudgedFpPawn = none;
    SetRealModelHidden(Nudged, false);
    SetForced3PPose(false);
    if (Nudged.Controller == self)
        Nudged.Controller = none;
    m_bBehindView = true;
}

function SpectatorSetViewTarget(Actor VT, optional ViewTargetTransitionParams TransitionParams)
{
    ClearFirstPersonNudge();
    super.SpectatorSetViewTarget(VT, TransitionParams);
    if (Role == ROLE_Authority && !bTimerOn)
    {
        ClearTimer('TickFollowAbilities');
        SetTimer(0.15, true, 'TickFollowAbilities');
        bTimerOn = true;
    }
}

simulated function TickFollowAbilities()
{
    local int i, slot;
    local int EquipSlots[5];
    local TgPawn FollowPawn;
    local TgDevice Dev;
    local TgTimerManager TM;
    local float remain, total;
    local SpecAbility A;

    EquipSlots[0] = 1;
    EquipSlots[1] = 16;
    EquipSlots[2] = 3;
    EquipSlots[3] = 4;
    EquipSlots[4] = 2;

    FollowPawn = TgPawn(GetViewTarget());
    if (FollowPawn == none || FollowPawn.Controller == none || !FollowPawn.IsAliveAndWell())
    {
        for (i = 0; i < ABILITY_SLOTS; i++)
        {
            Abilities[i].DeviceName = "";
            Abilities[i].CooldownPct = -1;
            Abilities[i].CooldownRemain = 0;
            Abilities[i].CurrentAmmo = 0;
            Abilities[i].MaxAmmo = 0;
        }
        ClientUpdateAbilities(Abilities);
        return;
    }

    for (i = 0; i < ABILITY_SLOTS; i++)
    {
        slot = EquipSlots[i];
        A.DeviceName = "";
        A.CooldownPct = -1;
        A.CooldownRemain = 0;
        A.CurrentAmmo = 0;
        A.MaxAmmo = 0;
        Dev = FollowPawn.GetDeviceByEqPoint(slot);
        if (Dev != none)
        {
            A.DeviceName = Dev.GetDeviceName();
            if (Dev.r_nMaxAmmoClipCount > 0)
            {
                A.CurrentAmmo = Dev.GetCurrentAmmoAmount();
                A.MaxAmmo = Dev.r_nMaxAmmoClipCount;
            }
            TM = Dev.GetCooldownTimerManager();
            if (TM != none)
            {
                remain = Dev.GetCooldownRemaining();
                total = TM.GetTimeInitial(0);
                if (total > 0.0001)
                {
                    A.CooldownPct = FClamp(remain / total, 0.0, 1.0);
                    A.CooldownRemain = remain;
                }
            }
        }
        Abilities[i] = A;
    }
    ClientUpdateAbilities(Abilities);
}

reliable client function ClientUpdateAbilities(SpecAbility NewAbilities[5])
{
    local int i;
    for (i = 0; i < ABILITY_SLOTS; i++)
        Abilities[i] = NewAbilities[i];
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

    `UIUTILS.SetGameText(Group.GetObject("Streak").GetObject("Title"), "+67");
    `UIUTILS.SetGameText(Group.GetObject("Streak").GetObject("Subtitle"), "AURA");

    `UIUTILS.BuildFillTicks(OgHealthBar, HealthBarTickContainer, TaskForce, LastClonedTickCount);
    `UIUTILS.BuildBorderTicks(OgHealthBar, Group, TaskForce, bBorderBuilt);
    `UIUTILS.MirrorBarMasks(OgHealthBar, OgGroup, Group);
    `UIUTILS.RecolorHealthTicks(OgHealthBar, HealthBarTickContainer, TaskForce);

    `UIUTILS.SyncShieldText(OgGroup, Group);
    `UIUTILS.SyncCombat(OgGroup, Group);
    `UIUTILS.SyncHealFeedContainer(OgGroup, Group);

    SPRI.r_nProfileId = PRI.r_nProfileId;

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
