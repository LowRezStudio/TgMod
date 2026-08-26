class TmGameViewportClient extends TgGameViewportClient within Engine
    config(TmConfig);

var TgPlayerController PC;
var TmProxyActor PA;

var float StartTime;
var bool bHasStarted;

function PostRender(Canvas Canvas)
{
    super.PostRender(Canvas);

    PC = TgPlayerController(self.GetPlayerOwner(0).Actor);
    if (PC == none || PC.WorldInfo == none)
        return;

    if (!bHasStarted)
    {
        StartTime = PC.WorldInfo.TimeSeconds;
        bHasStarted = true;
    }

    if (`TimeSinceEx(PC, StartTime) < 20)
    {
        Canvas.SetDrawColor(0, 255, 0, 255);
        Canvas.SetPos(49, 50);
        Canvas.DrawText("TEMPEST LAUNCHER");
        Canvas.SetPos(50, 65);
        Canvas.DrawText("F1: ENTER SHOOTING RANGE");
        Canvas.SetPos(50, 80);
        Canvas.DrawText("F2: OPEN CONSOLE");
    }

    findPCAndAttachCM();

    if (TmSpectatorController(PC) != none)
    {
        TmSpectatorController(PC).UpdateFirstPersonNudge();
        TmSpectatorController(PC).TickSpectatorPlayerHUD();
        TmSpectatorController(PC).TickSpectatorTeamHUD();
        TmSpectatorController(PC).TickBurnsHud();
        TmSpectatorController(PC).TickAbilitiesHud();
    }
}

event bool Init(out string OutError)
{
    ViewportConsole = new(Self) class'Engine.Console';
    if (InsertInteraction(ViewportConsole) == -1)
    {
        OutError = "Failed to add interaction to GlobalInteractions array:" @ ViewportConsole;
        return false;
    }
    SetConsoleTarget(0);
    return super.Init(OutError);
}

exec function SetConsoleTarget(int PlayerIndex)
{
    if (ViewportConsole != none)
    {
        if (PlayerIndex >= 0 && PlayerIndex < GamePlayers.Length)
            ViewportConsole.ConsoleTargetPlayer = GamePlayers[PlayerIndex];
        else
            ViewportConsole.ConsoleTargetPlayer = none;
    }
}

public function findPCAndAttachCM()
{
    PC = TgPlayerController(self.GetPlayerOwner(0).Actor);
    if (PC.CheatManager == none)
    {
        PA = `UTILS.SetupProxy(PC);
        PC.CheatClass = class'TmCheatManager';
        PC.CheatManager = new(PC) class'TmCheatManager';
        if (PC.CheatManager != none)
        {
            PC.CheatManager.InitCheatManager();
            PC.ConsoleCommand("changetaskforce 1");
        }
        else
            `LogError('TmGameViewport', "Failed to create CheatManager!");
    }
}
