class TmSpectatorController extends TgSpectatorController
    config(Game)
    hidecategories(Navigation)
    dependson(TgObject);


simulated event PostBeginPlay()
{
    super.PostBeginPlay();
    `LogInfo('TmSpectatorController', "PostBeginPlay: NetMode=" @ WorldInfo.NetMode @ "Player=" @ Player @ "Role=" @ Role);
    SetTimer(0.5, false, 'InitSpectatorHud');
}

function InitSpectatorHud()
{
    local TgSpectatorHUD SHUD;

    `LogInfo('TmSpectatorController', "InitSpectatorHud: myHUD=" @ myHUD @ "myHUDClass=" @ (myHUD != none ? string(myHUD.Class) : "none") @ "GetViewTarget=" @ GetViewTarget());

    self.ClientSetHUD(Class'TgClient.TgSpectatorHUD');

    SHUD = TgSpectatorHUD(myHUD);
    if (SHUD != none)
    {
        `LogInfo('TmSpectatorController', "InitSpectatorHud: calling SetSpectatorSkillsMode...");
        SHUD.SetSpectatorSkillsMode(0);   // 0=Skills, 1=Items, 2=Cards
        SHUD.SetSpectatorStatsMode(0);
        SHUD.SetSpectatorTeamMode(1);
        SHUD.UpdateSpectatorViewTarget(GetViewTarget());
        `LogInfo('TmSpectatorController', "Spectator HUD initialized");
    }
    else
    {
        `LogInfo('TmSpectatorController', "No TgSpectatorHUD yet, retrying");
        SetTimer(1.0, false, 'InitSpectatorHud');
    }
}