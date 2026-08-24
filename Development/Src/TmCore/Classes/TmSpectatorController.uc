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

function SpectatorSetViewTarget(Actor VT, optional ViewTargetTransitionParams TransitionParams)
{
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
