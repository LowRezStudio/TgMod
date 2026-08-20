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
var transient bool bBorderBuilt;

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

function SpectatorSetViewTarget(Actor VT, optional ViewTargetTransitionParams TransitionParams)
{
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
    local GFxObject SpectatorName, Frame, TeamName, TF;
    local GFxObject HealthBarTickContainer;
    local GFxObject Now, Max, Tip, Icon;
    local UIComponent_HealthBar OgHealthBar;
    local UIComponent_HealthBar_Player OgHealthBarPlayer;
    local UIComponent_HealthBarDamageOverlay OgDamageOverlay;
    local int TaskForce;
    local string TFName;

      local string Url;
      local array<ASValue> Args;
      local ASValue V;



    HUD = UIHudPlayer(`UTILS.FindSceneByClassName(TgGameHUD(myHUD), 'UIHudPlayer'));
    if (HUD == none) return;

    SPRI = TgRepInfo_Player(PlayerReplicationInfo);
    if (SPRI == none) return;

    ViewPawn = TgPawn(GetViewTarget());
    if (ViewPawn == none) return;

    PRI = TgRepInfo_Player(ViewPawn.PlayerReplicationInfo);
    if (PRI == none) return;

    TaskForce = PRI.GetTaskForceNumber();
    TFName = (TaskForce == 1) ? "Blue Team" : "Red Team";

    if (!bClonedHUD)
    {
        Group = HUD.AttachMovie("UIHudPlayer", "TmUIHudPlayer", 50).GetObject("Group");
        bClonedHUD = true;
    }
    else
        Group = HUD.GetObject("TmUIHudPlayer").GetObject("Group");

    OgGroup = HUD.GetObject("Group");
    OgGroup.SetAlpha(0.0);
    OgGroup.SetVisible(false);

    OgHealthBarPlayer = HUD.m_HealthBar;
    OgDamageOverlay = OgHealthBarPlayer.m_DamageOverlay;
    OgHealthBar = OgDamageOverlay.m_HealthbarOwner;

    Group.GotoAndStopI(TaskForce);
    SpectatorName = Group.GetObject("SpectatorName");
    Frame = SpectatorName.GetObject("Frame");
    TeamName = SpectatorName.GetObject("TeamName");
    TF = SpectatorName.GetObject("TF");
    TeamName.GotoAndStopI(TaskForce);
    Frame.GotoAndStopI(TaskForce);
    TeamName.GetObject("TF").SetText(TFName);
    TF.SetText(PRI.PlayerName);

    MirrorClip(Group, OgGroup, "HealthDamageOverlay");
    MirrorClip(Group, OgGroup, "HealthDamageOverlayNormal");
    MirrorClip(Group, OgGroup, "HealthBarTickContainer");
    MirrorClip(Group, OgGroup, "HealthBorderTickMask");
    MirrorClip(Group, OgGroup, "HealthBorderTickContainer");
    MirrorClip(Group, OgGroup, "ShieldBorderTickMask");
    MirrorClip(Group, OgGroup, "ShieldBorderTickContainer");
    MirrorClip(Group, OgGroup, "ShadowBorderTickMask");
    MirrorClip(Group, OgGroup, "ShadowBorderTickContainer");

    HealthBarTickContainer = Group.GetObject("HealthBarTickContainer");

    Now = Group.GetObject("Now");
    Max = Group.GetObject("Max");
    Tip = Group.GetObject("Tip");
    Now.SetText(OgGroup.GetObject("Now").GetText());
    Max.SetText(OgGroup.GetObject("Max").GetText());
    Tip.SetDisplayInfo(OgGroup.GetObject("Tip").GetDisplayInfo());

    Group.GetObject("Streak").GetObject("Title").SetText("+67");
    Group.GetObject("Streak").GetObject("Subtitle").SetText("AURA");

    BuildFillTicks(OgHealthBar, HealthBarTickContainer, TaskForce);
    BuildBorderTicks(OgHealthBar, Group, TaskForce);
    MirrorBarMasks(OgHealthBar, OgGroup, Group);
    RecolorHealthTicks(OgHealthBar, HealthBarTickContainer, TaskForce);

    SPRI.r_nProfileId = PRI.r_nProfileId;

    Icon = Group.GetObject("Icon");
    if (Icon == none || HUD.m_mcIcon == none) return;

    if (PRI.r_nProfileId <= 0) return;

    Url = HUD.m_mcIcon.GetString("initialSource");
    if (Url == "" || Url == "undefined") return;

    if (Icon.GetString("_source") != Url)
    {
        Icon.SetString("_source", "");
        Icon.SetString("source", Url);
        V.Type = AS_String;
        V.S = Url;
        Args.AddItem(V);
        Icon.Invoke("load", Args);
    }
    Icon.SetVisible(true);
    Icon.SetBool("_visible", true);
    Icon.SetBool("visible", true);
    Icon.SetFloat("_alpha", 100.0);
    Icon.SetAlpha(100.0);
    if (Icon.GetObject("contentHolder") != none)
    {
        Icon.GetObject("contentHolder").SetVisible(true);
        Icon.GetObject("contentHolder").SetAlpha(100.0);
    }
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

private simulated function MirrorClip(GFxObject DstParent, GFxObject SrcParent, string Name)
{
    local GFxObject Src, Dst;
    Src = SrcParent.GetObject(Name);
    Dst = DstParent.GetObject(Name);
    if (Src == none || Dst == none) return;
    Dst.SetDisplayInfo(Src.GetDisplayInfo());
    Dst.SetWidth(Src.GetWidth());
    Dst.SetHeight(Src.GetHeight());
}

private simulated function BuildFillTicks(UIComponent_HealthBar OgHealthBar, GFxObject HealthBarTickContainer, int TaskForce)
{
    local GFxObject HealthTick;
    local int i;

    if (LastClonedTickCount == OgHealthBar.m_mcHealthBarTicks.Length) return;

    for (i = 0; i < 40; i++)
    {
        HealthTick = HealthBarTickContainer.GetObject("HealthTick" $ i);
        if (HealthTick != none) HealthTick.RemoveMovieClip("");
    }
    for (i = 0; i < OgHealthBar.m_mcHealthBarTicks.Length; i++)
    {
        HealthTick = HealthBarTickContainer.AttachMovie("HealthTick", "HealthTick" $ i);
        HealthTick.SetDisplayInfo(OgHealthBar.m_mcHealthBarTicks[i].GetDisplayInfo());
        HealthTick.SetWidth(OgHealthBar.m_mcHealthBarTicks[i].GetWidth());
        HealthTick.SetHeight(OgHealthBar.m_mcHealthBarTicks[i].GetHeight());
        HealthTick.SetX(OgHealthBar.m_mcHealthBarTicks[i].GetX());
        HealthTick.GotoAndStopI(TaskForce);
    }
    LastClonedTickCount = OgHealthBar.m_mcHealthBarTicks.Length;
}

private simulated function BuildBorderTicks(UIComponent_HealthBar OgHealthBar, GFxObject Group, int TaskForce)
{
    local BarTickTypes BT;
    local int i;

    if (bBorderBuilt) return;

    for (i = 0; i < OgHealthBar.m_BarTickTypes.Length; i++)
    {
        BT = OgHealthBar.m_BarTickTypes[i];
        if (BT.eBorderTickType == EHTT_Damage) continue;
        if (i != 0 && BT.mcLeftBorderTick != none)
            CreateBorderTick(Group, BT, BT.mcLeftBorderTick, "BorderTickL" $ i, 0, TaskForce);
        if (i != OgHealthBar.m_BarTickTypes.Length - 1 && BT.mcRightBorderTick != none)
            CreateBorderTick(Group, BT, BT.mcRightBorderTick, "BorderTickR" $ i, 1, TaskForce);
    }
    bBorderBuilt = true;
}

private simulated function MirrorBarMasks(UIComponent_HealthBar OgHealthBar, GFxObject OgGroup, GFxObject Group)
{
    local BarTickTypes BT;
    local GFxObject OgMask, CloneMask;
    local int i;

    for (i = 0; i < OgHealthBar.m_BarTickTypes.Length; i++)
    {
        BT = OgHealthBar.m_BarTickTypes[i];
        OgMask = OgGroup.GetObject(BT.sMaskName);
        CloneMask = Group.GetObject(BT.sMaskName);
        if (OgMask != none && CloneMask != none)
        {
            CloneMask.SetX(OgMask.GetX());
            CloneMask.SetWidth(OgMask.GetWidth());
            CloneMask.SetVisible(OgMask.GetBool("_visible"));
        }
    }
}

private simulated function RecolorHealthTicks(UIComponent_HealthBar OgHealthBar, GFxObject HealthBarTickContainer, int TaskForce)
{
    local int NumTicks, HealthN, ShieldN, k;
    local float fH, fS;
    local GFxObject Tick;
    local BarTickTypes BT2;

    NumTicks = OgHealthBar.m_mcHealthBarTicks.Length;
    if (NumTicks <= 0) return;

    fH = 0.0;
    fS = 0.0;
    for (k = 0; k < OgHealthBar.m_BarTickTypes.Length; k++)
    {
        BT2 = OgHealthBar.m_BarTickTypes[k];
        if (BT2.eBorderTickType == EHTT_Health) fH = BT2.fWidth;
        else if (BT2.eBorderTickType == EHTT_Shield) fS = BT2.fWidth;
    }

    HealthN = FCeil(fH * float(NumTicks));
    ShieldN = FCeil(fS * float(NumTicks));
    if (HealthN < 0) HealthN = 0;
    if (ShieldN < 0) ShieldN = 0;
    if (HealthN > NumTicks) HealthN = NumTicks;
    if (HealthN + ShieldN > NumTicks) ShieldN = NumTicks - HealthN;

    for (k = 0; k < NumTicks; k++)
    {
        Tick = HealthBarTickContainer.GetObject("HealthTick" $ k);
        if (Tick == none) continue;
        if (k < HealthN) Tick.GotoAndStopI(TaskForce);
        else if (k < HealthN + ShieldN) Tick.GotoAndStopI(5);
        else Tick.GotoAndStopI(6);
        Tick.SetVisible(true);
    }
}

private simulated function CreateBorderTick(GFxObject Group, BarTickTypes BT, GFxObject Src, string Name, int Depth, int TaskForce)
{
    local GFxObject BorderTick;
    local int FrameTo;

    BorderTick = Group.GetObject(BT.sContainerName).AttachMovie("HealthTick", Name, Depth);
    if (BorderTick == none) return;

    BorderTick.SetDisplayInfo(Src.GetDisplayInfo());
    BorderTick.SetWidth(Src.GetWidth());
    BorderTick.SetHeight(Src.GetHeight());

    if (BT.eBorderTickType == EHTT_Health) FrameTo = TaskForce;
    else if (BT.eBorderTickType == EHTT_Shield) FrameTo = 5;
    else FrameTo = 6;
    BorderTick.GotoAndStopI(FrameTo);
    BorderTick.SetVisible(true);
}
