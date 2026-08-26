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

function SpectatorSetViewTarget(Actor VT, optional ViewTargetTransitionParams TransitionParams)
{
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
